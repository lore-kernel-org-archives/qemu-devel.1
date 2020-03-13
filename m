Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7ACC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E95682074E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnwZbMb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95682074E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCsJG-0001OF-51
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 17:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jCsIK-0000SJ-CK
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jCsII-0003Jo-L5
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:56:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49354
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jCsIH-0003Gs-W2
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584136596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UE8q8jm2InBIGi9nrTkQ6TPQgR/9LnZNNUSLfordzQQ=;
 b=QnwZbMb+K2wETjtWoeqEj4vjpY7pzeaGY5iYQk4eq3+odGEd5WTdXXkFoyPQ6lqupIGeo1
 playWB7Xm7kjUVRbYKyt3wWUSzZXry1ENal1CH6RrW4ObFsBGNsCiYAxiVdco8Tb/9lqJx
 jvc+XlZLBG66nieGAiSI7r0TwASDVYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-t2N4Gg6-N32WAZGhE8d4IA-1; Fri, 13 Mar 2020 17:56:34 -0400
X-MC-Unique: t2N4Gg6-N32WAZGhE8d4IA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49DE418A5500;
 Fri, 13 Mar 2020 21:56:33 +0000 (UTC)
Received: from [10.3.118.63] (ovpn-118-63.phx2.redhat.com [10.3.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04F005DA2C;
 Fri, 13 Mar 2020 21:56:29 +0000 (UTC)
Subject: Re: [PATCH 5/5] block/io: auto-no-fallback for write-zeroes
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200302100537.29058-1-vsementsov@virtuozzo.com>
 <20200302100537.29058-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5e7f5649-c349-7d8e-f2a0-203cc53aa8cb@redhat.com>
Date: Fri, 13 Mar 2020 16:56:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302100537.29058-6-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 4:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> NBD driver may has max_pwrite_zeroes but doesn't has
> max_pwrite_zeroes_no_fallback limit. This means, that (when
> BDRV_REQ_NO_FALLBACK is supported) it is beneficial to try send request
> with BDRV_REQ_NO_FALLBACK instead of splitting the request accordingly
> to max_pwrite_zeroes.
> 
> If failed, fallback to old behavior.

Grammar:

When BDRV_REQ_NO_FALLBACK is supported, the NBD driver supports a larger 
request size.  Add code to try large zero requests with a NO_FALLBACK 
request prior to having to split a request into chunks according to 
max_pwrite_zeroes.

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/io.c | 30 ++++++++++++++++++++++++++----
>   1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index c64566b4cf..48d71b0883 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1752,17 +1752,28 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
>       int head = 0;
>       int tail = 0;
>   
> -    int max_write_zeroes = MIN_NON_ZERO((flags & BDRV_REQ_NO_FALLBACK) ?
> -                                        bs->bl.max_pwrite_zeroes_no_fallback :
> -                                        bs->bl.max_pwrite_zeroes, INT_MAX);
> +    int max_write_zeroes;
>       int alignment = MAX(bs->bl.pwrite_zeroes_alignment,
>                           bs->bl.request_alignment);
>       int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer, MAX_BOUNCE_BUFFER);
> +    bool auto_no_fallback;
>   
>       if (!drv) {
>           return -ENOMEDIUM;
>       }
>   
> +    if (!(flags & BDRV_REQ_NO_FALLBACK) &&
> +        (bs->supported_zero_flags & BDRV_REQ_NO_FALLBACK) &&
> +        bs->bl.max_pwrite_zeroes &&
> +        bs->bl.max_pwrite_zeroes < bytes &&
> +        (bs->bl.max_pwrite_zeroes < bs->bl.max_pwrite_zeroes_no_fallback ||
> +         bs->bl.max_pwrite_zeroes_no_fallback == 0))

Why are we letting max_pwrite_zeroes_no_fallback ever be 0?  It might be 
more convenient if it is always guaranteed to be >= max_pwrite_zeroes by 
the block layer.

> +    {
> +        assert(drv->bdrv_co_pwrite_zeroes);
> +        flags |= BDRV_REQ_NO_FALLBACK;
> +        auto_no_fallback = true;
> +    }
> +
>       if ((flags & ~bs->supported_zero_flags) & BDRV_REQ_NO_FALLBACK) {
>           return -ENOTSUP;
>       }
> @@ -1770,7 +1781,11 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
>       assert(alignment % bs->bl.request_alignment == 0);
>       head = offset % alignment;
>       tail = (offset + bytes) % alignment;
> -    max_write_zeroes = QEMU_ALIGN_DOWN(max_write_zeroes, alignment);
> +    max_write_zeroes =
> +        QEMU_ALIGN_DOWN(MIN_NON_ZERO((flags & BDRV_REQ_NO_FALLBACK) ?
> +                                     bs->bl.max_pwrite_zeroes_no_fallback :
> +                                     bs->bl.max_pwrite_zeroes, INT_MAX),
> +                        alignment);
>       assert(max_write_zeroes >= bs->bl.request_alignment);
>   
>       while (bytes > 0 && !ret) {
> @@ -1801,6 +1816,13 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
>           if (drv->bdrv_co_pwrite_zeroes) {
>               ret = drv->bdrv_co_pwrite_zeroes(bs, offset, num,
>                                                flags & bs->supported_zero_flags);
> +            if (ret == -ENOTSUP && auto_no_fallback) {
> +                flags &= ~BDRV_REQ_NO_FALLBACK;
> +                max_write_zeroes =
> +                    QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_pwrite_zeroes,
> +                                                 INT_MAX), alignment);
> +                continue;
> +            }
>               if (ret != -ENOTSUP && (flags & BDRV_REQ_FUA) &&
>                   !(bs->supported_zero_flags & BDRV_REQ_FUA)) {
>                   need_flush = true;
> 

Otherwise makes sense.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


