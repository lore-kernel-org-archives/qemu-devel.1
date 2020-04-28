Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8040EC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BC4206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RR+GmBP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BC4206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTRBK-0000sT-D2
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTR91-0005q3-2w
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTR8z-0004I8-Hk
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:23:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47691
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTQiI-0001yp-81
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588082153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7YZME1PskhfnYknR4bThREwS8GT89oerKy9MNd/+miM=;
 b=RR+GmBP77aOiAkTLuuaIKiugXM9NhQwIh1wybONY8tzCQI1v0VgqBePDn++cmxBrRrcRrd
 LOT1tFdjhAXSU6GTSnwRAULpVPOX/d8qy4itN/mcrcyASlEFbNCR7xkYWKHuThWhdcX4oL
 bQVZfJ5A2moqKqGNI3dM2SDzjaWZtq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-BBZfMvwvNnaT85CMAKhRbw-1; Tue, 28 Apr 2020 09:55:51 -0400
X-MC-Unique: BBZfMvwvNnaT85CMAKhRbw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88653835B40;
 Tue, 28 Apr 2020 13:55:50 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 554DA1002395;
 Tue, 28 Apr 2020 13:55:49 +0000 (UTC)
Subject: Re: [PATCH 3/4] block: Add blk_make_empty()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200428132629.796753-1-mreitz@redhat.com>
 <20200428132629.796753-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d4cab7f2-2a64-82fb-5eed-1345ebc3367a@redhat.com>
Date: Tue, 28 Apr 2020 08:55:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428132629.796753-4-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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

On 4/28/20 8:26 AM, Max Reitz wrote:
> Two callers of BlockDriver.bdrv_make_empty() remain that should not call
> this method directly.  Both do not have access to a BdrvChild, but they
> can use a BlockBackend, so we add this function that lets them use it.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/sysemu/block-backend.h | 2 ++
>   block/block-backend.c          | 5 +++++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
> index d37c1244dd..14338b76dc 100644
> --- a/include/sysemu/block-backend.h
> +++ b/include/sysemu/block-backend.h
> @@ -266,4 +266,6 @@ int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
>   
>   const BdrvChild *blk_root(BlockBackend *blk);
>   
> +int blk_make_empty(BlockBackend *blk, Error **errp);
> +

Again, a flag parameter to allow use of BDRV_REQ_NO_FALLBACK would be nice.

>   #endif
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 3592066b42..5d36efd32f 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -2402,3 +2402,8 @@ const BdrvChild *blk_root(BlockBackend *blk)
>   {
>       return blk->root;
>   }
> +
> +int blk_make_empty(BlockBackend *blk, Error **errp)
> +{
> +    return bdrv_make_empty(blk->root, errp);
> +}
> 

Otherwise looks fine.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


