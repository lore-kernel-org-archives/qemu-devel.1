Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D66C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 06:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E10C3206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 06:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvTmuaJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10C3206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrFcq-0006Dd-4G
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 02:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jrFc8-0005Jd-Cc
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 02:56:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37448
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jrFc5-0000LH-Tm
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 02:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593759357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fImahHfw6p0LFILgo2k4OQ4Jp2fixqBHNx6Bq+T2Rvw=;
 b=GvTmuaJbEsbfGuZU0K2qWffeKwf/faTzDnyatngxpLHNK7uYcOMfM582639oQ0P4tMrI11
 Ym2+0eyoiAmKEL8Q8WmbYrAjngBxogjLayIzaTgXahPctEnXVQLi5TFvDVHJ5ktp1pqCyG
 oZYL7/DGOX8+pV3eftnZdU8GiBNTZ9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-p46eey0AM1KqlxYAWAcE3A-1; Fri, 03 Jul 2020 02:55:55 -0400
X-MC-Unique: p46eey0AM1KqlxYAWAcE3A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E57E1005513;
 Fri,  3 Jul 2020 06:55:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 49B8379231;
 Fri,  3 Jul 2020 06:55:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BB5151138648; Fri,  3 Jul 2020 08:55:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 34/44] error: Eliminate error_propagate() with
 Coccinelle, part 1
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-35-armbru@redhat.com>
 <051702cf-dbc9-67ca-2ff2-3cf8d9eb9ed3@redhat.com>
Date: Fri, 03 Jul 2020 08:55:52 +0200
In-Reply-To: <051702cf-dbc9-67ca-2ff2-3cf8d9eb9ed3@redhat.com> (Eric Blake's
 message of "Thu, 2 Jul 2020 13:02:13 -0500")
Message-ID: <87fta9xf2f.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 7/2/20 10:49 AM, Markus Armbruster wrote:
>> When all we do with an Error we receive into a local variable is
>> propagating to somewhere else, we can just as well receive it there
>> right away.  Convert
>>
>>      if (!foo(..., &err)) {
>>          ...
>>          error_propagate(errp, err);
>>          ...
>>          return ...
>>      }
>>
>> to
>>
>>      if (!foo(..., errp)) {
>>          ...
>>          ...
>>          return ...
>>      }
>>
>
>>
>> Not exactly elegant, I'm afraid.
>
> True, but it is still reasonable enough to use.
>
>>
>> The "when != goto lbl;" is necessary to avoid transforming
>
> spelled "when != lbl:" above in rule1 and rule2

Perils of editing old explanations to fit new code...

>>
>>           if (fun(args, &err)) {
>>               goto out
>>           }
>>           ...
>>       out:
>>           error_propagate(errp, err);
>>
>> even though other paths to label out still need the error_propagate().
>> For an actual example, see sclp_realize().
>>
>> Without the "when strict", Coccinelle transforms vfio_msix_setup(),
>> incorrectly.  I don't know what exactly "when strict" does, only that
>> it helps here.
>>
>> The match of return is narrower than what I want, but I can't figure
>> out how to express "return where the operand doesn't use @err".  For
>> an example where it's too narrow, see vfio_intx_enable().
>>
>> Silently fails to convert hw/arm/armsse.c, because Coccinelle gets
>> confused by ARMSSE being used both as typedef and function-like macro
>> there.  Converted manually.
>>
>> Line breaks tidied up manually.  One nested declaration of @local_err
>> deleted manually.  Preexisting unwanted blank line dropped in
>> hw/riscv/sifive_e.c.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>>   114 files changed, 376 insertions(+), 884 deletions(-)
>
> Big, but sane.  Picks up the spots I noticed in 33/44, and then some ;)

Right :)

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


