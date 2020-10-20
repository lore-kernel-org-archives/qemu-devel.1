Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502C8C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 05:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5AB42224D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 05:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eoxkofdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5AB42224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUk2L-0001Wz-DZ
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 01:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUk0S-0008Ai-Un
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 01:16:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUk0R-0007PF-8K
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 01:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603170978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C9B/XP8NWDN6tVBGyrkZ6qmawcIQC9nVaOa7eSO9aYU=;
 b=Eoxkofdjy+goA8Ezc4j2nBUqJ8s3wOJAUkZkTYMNRqAEWI7+YTSx3hrQJ2fqGFTG1hHa/N
 czxFpket34xcUAg5QlABEVFNFgDDM+owMd1cFOcSblRGdy8HqNYjoakTAdmCdVgCgHYjGD
 Afqd885zKEXjP9nZcNVl8+L/4XVp2A4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-1axDuLvwPiKLt_jP7Evb3w-1; Tue, 20 Oct 2020 01:16:14 -0400
X-MC-Unique: 1axDuLvwPiKLt_jP7Evb3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81E591006C85;
 Tue, 20 Oct 2020 05:16:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BA2F6EF72;
 Tue, 20 Oct 2020 05:16:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5685A1132A08; Tue, 20 Oct 2020 07:16:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v6 02/10] migration: stop returning errno from
 load_snapshot()
References: <20201008155001.3357288-1-berrange@redhat.com>
 <20201008155001.3357288-3-berrange@redhat.com>
 <c10eff2e-e1b5-812c-1b4c-894f96aee494@redhat.com>
Date: Tue, 20 Oct 2020 07:16:11 +0200
In-Reply-To: <c10eff2e-e1b5-812c-1b4c-894f96aee494@redhat.com> (Eric Blake's
 message of "Mon, 19 Oct 2020 16:15:08 -0500")
Message-ID: <87ft691nqc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, "Denis V.
 Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 10/8/20 10:49 AM, Daniel P. Berrang=C3=A9 wrote:
>> None of the callers care about the errno value since there is a full
>> Error object populated. This gives consistency with save_snapshot()
>> which already just returns -1.
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>>   migration/savevm.c | 15 +++++++--------
>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>=20
>
>> @@ -2892,11 +2892,11 @@ int load_snapshot(const char *name, Error **errp=
)
>>       ret =3D bdrv_snapshot_find(bs_vm_state, &sn, name);
>>       aio_context_release(aio_context);
>>       if (ret < 0) {
>> -        return ret;
>> +        return -1;
>>       } else if (sn.vm_state_size =3D=3D 0) {
>>           error_setg(errp, "This is a disk-only snapshot. Revert to it "
>>                      " offline using qemu-img");
>
> While you are here, let's fix the double space in the error message.

The message should be rephrased, because

 * The resulting message should be a single phrase, with no newline or
 * trailing punctuation.

This is from error_setg()'s contract.

Two obvious ways:

1. Use error_append_hint() for the "what you should do" part.

2. Replace '.' by ';' and call it a day.


