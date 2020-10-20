Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799CDC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 05:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF532224D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 05:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLXZjE/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF532224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUk3I-0003s6-Nn
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 01:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUk20-0001IS-PW
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 01:17:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34661)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUk1r-0007rK-Ng
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 01:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603171061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GqYSPvul/pWqwP8afr3OTe+oLEfvwSMPDaQ5M0tn++M=;
 b=ZLXZjE/Kv3tq/eqguo8pRZ3c7f2Z+7iX8F1xvBJLXxB+TmPXG2XVexMaTi7VXUzWPETAmW
 ZeyY4l7iCIddAKXzEVXjrdKcctsfWJ01T36uwLa06xzHwb2p6BDOWmH210j2NL1vlKorwx
 31wOLsP7cBPwdcn5XADWBv+QuHMyl/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-wr_u5ipcNDO84l-1OpenXQ-1; Tue, 20 Oct 2020 01:17:39 -0400
X-MC-Unique: wr_u5ipcNDO84l-1OpenXQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85AE610066FB;
 Tue, 20 Oct 2020 05:17:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4697E19D6C;
 Tue, 20 Oct 2020 05:17:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C26741132A08; Tue, 20 Oct 2020 07:17:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v6 04/10] block: allow specifying name of block device
 for vmstate storage
References: <20201008155001.3357288-1-berrange@redhat.com>
 <20201008155001.3357288-5-berrange@redhat.com>
 <38d75f57-e3b4-60c4-086f-5e1d9e9f4862@redhat.com>
Date: Tue, 20 Oct 2020 07:17:36 +0200
In-Reply-To: <38d75f57-e3b4-60c4-086f-5e1d9e9f4862@redhat.com> (Eric Blake's
 message of "Mon, 19 Oct 2020 16:32:00 -0500")
Message-ID: <87blgx1nnz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
>> Currently the vmstate will be stored in the first block device that
>> supports snapshots. Historically this would have usually been the
>> root device, but with UEFI it might be the variable store. There
>> needs to be a way to override the choice of block device to store
>> the state in.
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>
>> @@ -83,7 +83,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
>>   (qemu) savevm snap0
>>   Error: Device 'file' is writable but does not support snapshots
>>   (qemu) info snapshots
>> -No block device supports snapshots
>> +no block device can store vmstate for snapshot
>
> We're inconsistent on whether error messages start with a Capital.

Pervasive issue.

Starting with lower case plays more nicely with error_prepend().

> But our split-brain behavior is not made any worse by this patch.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>


