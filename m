Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE96C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D72F02073E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdDX8HNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72F02073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSSF-0004ex-0t
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jHSRP-00045l-N4
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jHSRO-0001ur-Hn
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:20:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32512)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jHSRO-0001uh-EX
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585228858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UUEmSXJROCKWzJf/yWemfgMJ1Isg+va5UAkXLWE6FD8=;
 b=cdDX8HNlJ/bIHoxVlfwxLP/rljij2TMo38NqTjpx442/vymQ7sMGOFQSGIOdfy3Pn8Oil6
 nsjLwKHpGf1HL3a51mA89Ijp9npHrWRxEKc2pBgSsjdpJ3CPkkQ7PTHfP1rk0/swzgToxy
 3a2HI4cdG/crekqS8uHmQCDcb7FB/Cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-I1cys1HkNDWcgnmU0AXVBQ-1; Thu, 26 Mar 2020 09:20:54 -0400
X-MC-Unique: I1cys1HkNDWcgnmU0AXVBQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D0578010F4;
 Thu, 26 Mar 2020 13:20:52 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 917F310002A5;
 Thu, 26 Mar 2020 13:20:41 +0000 (UTC)
Subject: Re: [PATCH 2/2] block: trickle down the fallback image creation
 function use to the block drivers
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200326011218.29230-1-mlevitsk@redhat.com>
 <20200326011218.29230-3-mlevitsk@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <922a6eb5-cb33-d2e4-ba0b-15078d1a6c59@redhat.com>
Date: Thu, 26 Mar 2020 08:20:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326011218.29230-3-mlevitsk@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 integration@gluster.org, sheepdog@lists.wpkg.org,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Liu Yuan <namei.unix@gmail.com>,
 Jason Dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/25/20 8:12 PM, Maxim Levitsky wrote:
> Instead of checking the .bdrv_co_create_opts to see if we need the failback,

fallback

> just implement the .bdrv_co_create_opts in the drivers that need it.
> 
> This way we don't break various places that need to know if the underlying
> protocol/format really supports image creation, and this way we still
> allow some drivers to not support image creation.
> 
> Fixes: fd17146cd93d1704cd96d7c2757b325fc7aac6fd
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1816007
> 
> Note that technically this driver reverts the image creation failback

fallback

> for the vxhs driver since I don't have a means to test it,
> and IMHO it is better to leave it not supported as it was prior to
> generic image creation patches.
> 
> Also drop iscsi_create_opts which was left accidently

accidentally

> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
> +++ b/block/file-posix.c
> @@ -3513,6 +3513,8 @@ static BlockDriver bdrv_host_device = {
>       .bdrv_reopen_prepare = raw_reopen_prepare,
>       .bdrv_reopen_commit  = raw_reopen_commit,
>       .bdrv_reopen_abort   = raw_reopen_abort,
> +    .bdrv_co_create_opts = bdrv_co_create_opts_simple,
> +    .create_opts         = &bdrv_create_opts_simple,

I'd drop the leading & for consistency with the rest of this struct 
initializer.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


