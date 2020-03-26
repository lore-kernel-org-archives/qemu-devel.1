Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875DFC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5293320774
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXOJpzCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5293320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSht-0006T4-Gf
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jHSfE-0001pR-VF
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jHSfD-0007xZ-RV
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:35:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41361)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jHSfD-0007xP-MO
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585229715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vaMw7pHDV/LgjAMiNpfA9ib9zFVYFib/+sxqgRozAOA=;
 b=iXOJpzCGEXYYM/cEuN+YPDVuxlwKot+NfII6VUyb1skNqYpywYNKhG5pPa7SptPmSiwlKZ
 TQB1BrNPouALKn9EZ2tqTCOvUR0GVVeGQo9CZUbZF97MpFzlmas8DBdzKuvYJ3X+Ta9efa
 I8/h/sjWksk1+CicYUCrqS7CLbu2V0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-fuFPMXdXPEyeNSxTnYLrfQ-1; Thu, 26 Mar 2020 09:35:14 -0400
X-MC-Unique: fuFPMXdXPEyeNSxTnYLrfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0EA9800D5C;
 Thu, 26 Mar 2020 13:35:04 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 739F860BF7;
 Thu, 26 Mar 2020 13:35:03 +0000 (UTC)
Subject: Re: [PATCH 2/2] block: trickle down the fallback image creation
 function use to the block drivers
To: Kevin Wolf <kwolf@redhat.com>
References: <20200326011218.29230-1-mlevitsk@redhat.com>
 <20200326011218.29230-3-mlevitsk@redhat.com>
 <922a6eb5-cb33-d2e4-ba0b-15078d1a6c59@redhat.com>
 <20200326132828.GC7391@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9004829c-45a4-584e-99b4-1dcf70950381@redhat.com>
Date: Thu, 26 Mar 2020 08:35:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326132828.GC7391@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, integration@gluster.org,
 sheepdog@lists.wpkg.org, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Liu Yuan <namei.unix@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Jason Dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/26/20 8:28 AM, Kevin Wolf wrote:
> Am 26.03.2020 um 14:20 hat Eric Blake geschrieben:
>>> +++ b/block/file-posix.c
>>> @@ -3513,6 +3513,8 @@ static BlockDriver bdrv_host_device = {
>>>        .bdrv_reopen_prepare = raw_reopen_prepare,
>>>        .bdrv_reopen_commit  = raw_reopen_commit,
>>>        .bdrv_reopen_abort   = raw_reopen_abort,
>>> +    .bdrv_co_create_opts = bdrv_co_create_opts_simple,
>>> +    .create_opts         = &bdrv_create_opts_simple,
>>
>> I'd drop the leading & for consistency with the rest of this struct
>> initializer.
> 
> This one isn't a function pointer, so I think the & is necessary.

Ah, right. Visual pattern-matching failed me, since I didn't read the 
actual types in the .h file.

Hmm - is it possible to write the patch in such a way that .create_opts 
can be left NULL when .bdrv_co_create_opts is bdrv_co_create_opts_simple?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


