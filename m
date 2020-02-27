Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFC7C35E17
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2324C246A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNUPjaOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2324C246A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7NpX-0000Nm-BS
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 13:24:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j7NoK-0007XJ-6Y
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:23:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j7NoJ-000757-2O
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:23:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43999
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j7NoI-00074g-V0
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582827778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZbFioMg+RWKeN5tQxkG3Dg97KV0b4a/4fQhywvTH/ik=;
 b=YNUPjaOOUPXADYxSdoTs1I4doyBt1sFjhHrkrDMQgf+1n7XIlYxkmtAzzLMdiUCC0xQ57i
 JR/DruA0ShQa5eACY/OabAVJx/MDYHJ/opWzoplKhvNmfEr48JTr2b5tZdgoOof7j75ubC
 /YBoTYULxG5AfsO07W8h/0w+sil8/M8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-HzbJjmt_MB2X37eSC1Iffw-1; Thu, 27 Feb 2020 13:22:50 -0500
X-MC-Unique: HzbJjmt_MB2X37eSC1Iffw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B86F6108838C;
 Thu, 27 Feb 2020 18:22:49 +0000 (UTC)
Received: from [10.3.116.57] (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47E121001B2B;
 Thu, 27 Feb 2020 18:22:49 +0000 (UTC)
Subject: Re: [PATCH 1/3] qemu-img: Fix check's leak/corruption fix report
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200227170251.86113-1-mreitz@redhat.com>
 <20200227170251.86113-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <480e9a58-52fe-3948-eb78-a62149fa0e8c@redhat.com>
Date: Thu, 27 Feb 2020 12:22:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227170251.86113-2-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 11:02 AM, Max Reitz wrote:
> There are two problems with qemu-img check's report on how many leaks
> and/or corruptions have been fixed:
> 
> (1) ImageCheck.has_leaks_fixed and ImageCheck.has_corruptions_fixed are
> only true when ImageCheck.leaks or ImageCheck.corruptions (respectively)
> are non-zero.  qcow2's check implementation will set the latter to zero
> after it has fixed leaks and corruptions, though, so leaks-fixed and
> corruptions-fixed are actually never reported after successful repairs.
> We should always report them when they are non-zero, just like all the
> other fields of ImageCheck.
> 
> (2) After something has been fixed and we run the check a second time,
> leaks_fixed and corruptions_fixed are taken from the first run; but
> has_leaks_fixed and has_corruptions_fixed are not.  The second run
> actually cannot fix anything, so with (1) fixed, has_leaks_fixed and
> has_corruptions_fixed will always be false here.  (With (1) unfixed,
> they will at least be false on successful runs, because then the number
> of leaks and corruptions found in the second run should be 0.)
> We should save has_leaks_fixed and has_corruptions_fixed just like we
> save leaks_fixed and corruptions_fixed.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qemu-img.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


