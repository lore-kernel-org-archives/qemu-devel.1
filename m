Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53140C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4432074E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1DCJktR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4432074E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCrXA-00017S-6T
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 17:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jCrWZ-0000cg-PR
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jCrWX-00076c-Ol
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:07:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50275
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jCrWX-00075a-IK
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584133636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=obMUTDdvE19684E2P9L7tPR40QzciiuH+t6H9NT6rzg=;
 b=a1DCJktRa8vlPzCEYS5t8/779K6nGJWGPDNWCXklQmLa3V7QQqanGlD2GzVBJdcrVnr7Rz
 kRs9BQSejd4tQe/OvJuju0L/s7gEO5D2+mk1lSb0huezCTS6LflZYtR2fY7ZqU+miLj8Fh
 Ne013eIFLNkhAjLeDLlBdhfV+K2JK84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-ef4qhN3pM4yHgkqjQjNK-Q-1; Fri, 13 Mar 2020 17:07:09 -0400
X-MC-Unique: ef4qhN3pM4yHgkqjQjNK-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E114F8017CC;
 Fri, 13 Mar 2020 21:07:07 +0000 (UTC)
Received: from [10.3.118.63] (ovpn-118-63.phx2.redhat.com [10.3.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B5769051B;
 Fri, 13 Mar 2020 21:07:03 +0000 (UTC)
Subject: Re: [PATCH 3/5] block: add max_pwrite_zeroes_no_fallback to
 BlockLimits
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200302100537.29058-1-vsementsov@virtuozzo.com>
 <20200302100537.29058-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <422e0c60-4423-b474-0836-3ea8997c90da@redhat.com>
Date: Fri, 13 Mar 2020 16:07:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302100537.29058-4-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 4:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> NBD spec is updated, so that max_block doesn't relate to

Maybe: The NBD spec was recently updated to clarify that max_block...

> NBD_CMD_WRITE_ZEROES with NBD_CMD_FLAG_FAST_ZERO (which mirrors Qemu
> flag BDRV_REQ_NO_FALLBACK). To drop the restriction we need new
> max_pwrite_zeroes_no_fallback.

It feels odd to have two different pwrite_zeroes limits in the block 
layer, but I can live with it if other block layer gurus are also okay 
with it.

> 
> Default value of new max_pwrite_zeroes_no_fallback is zero and it means
> no-restriction, so we are automatically done by this commit. Note that

Why not have the default value be set to the existing value of the 
normal pwrite_zeroes limit, rather than 0?

> nbd and blkdebug are the only drivers which in the same time define
> max_pwrite_zeroes limit and support BDRV_REQ_NO_FALLBACK, so we need to
> update only blkdebug.

Grammar:

The default value for the new max_pwrite_zeroes_no_fallback is zero, 
meaning no restriction, which covers all drivers not touched by this 
commit.  Note that nbd and blkdebug are the only drivers which have a 
max_pwrite_zeroes limit while supporting BDRV_REQ_NO_FALLBACK, so we 
only need to update blkdebug.

Except that I think there IS still a limit in current NBD: you can't 
request anything larger than 32 bits (whereas some other drivers may 
allow a full 63-bit request, as well as future NBD usage when we finally 
add 64-bit extensions to the protocol).  So I think this patch is 
incomplete; it should be updating the nbd code to set the proper limit.

(I still need to post v2 of my patches for bdrv_co_make_zero support, 
which is a case where knowing if there is a 32-bit limit when using 
BDRV_REQ_NO_FALLBACK for fast zeroing is important).

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/block_int.h | 8 ++++++++
>   block/blkdebug.c          | 7 ++++++-
>   block/io.c                | 4 +++-
>   3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 6f9fd5e20e..c167e887c6 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -618,6 +618,14 @@ typedef struct BlockLimits {
>        * pwrite_zeroes_alignment. May be 0 if no inherent 32-bit limit */
>       int32_t max_pwrite_zeroes;
>   
> +    /*
> +     * Maximum number of bytes that can zeroized at once if flag

zeroed

> +     * BDRV_REQ_NO_FALLBACK specified (since it is signed, it must be < 2G, if
> +     * set).

Why must it be a signed 32-bit number?  Why not let it be a 64-bit number?

> Must be multiple of pwrite_zeroes_alignment. May be 0 if no
> +     * inherent 32-bit limit.
> +     */
> +    int32_t max_pwrite_zeroes_no_fallback;
> +
>       /* Optimal alignment for write zeroes requests in bytes. A power
>        * of 2 is best but not mandatory.  Must be a multiple of
>        * bl.request_alignment, and must be less than max_pwrite_zeroes
> diff --git a/block/blkdebug.c b/block/blkdebug.c
> index af44aa973f..7627fbcb3b 100644
> --- a/block/blkdebug.c
> +++ b/block/blkdebug.c
> @@ -692,7 +692,11 @@ static int coroutine_fn blkdebug_co_pwrite_zeroes(BlockDriverState *bs,
>       }
>       assert(QEMU_IS_ALIGNED(offset, align));
>       assert(QEMU_IS_ALIGNED(bytes, align));
> -    if (bs->bl.max_pwrite_zeroes) {
> +    if ((flags & BDRV_REQ_NO_FALLBACK) &&
> +        bs->bl.max_pwrite_zeroes_no_fallback)
> +    {
> +        assert(bytes <= bs->bl.max_pwrite_zeroes_no_fallback);
> +    } else if (bs->bl.max_pwrite_zeroes) {
>           assert(bytes <= bs->bl.max_pwrite_zeroes);
>       }
>   
> @@ -977,6 +981,7 @@ static void blkdebug_refresh_limits(BlockDriverState *bs, Error **errp)
>       }
>       if (s->max_write_zero) {
>           bs->bl.max_pwrite_zeroes = s->max_write_zero;
> +        bs->bl.max_pwrite_zeroes_no_fallback = s->max_write_zero;

Ah, so you DO default it to max_pwwrite_zeroes instead of to 0; the 
commit message does not quite match the code.

>       }
>       if (s->opt_discard) {
>           bs->bl.pdiscard_alignment = s->opt_discard;
> diff --git a/block/io.c b/block/io.c
> index 7e4cb74cf4..75fd5600c2 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1752,7 +1752,9 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
>       int head = 0;
>       int tail = 0;
>   
> -    int max_write_zeroes = MIN_NON_ZERO(bs->bl.max_pwrite_zeroes, INT_MAX);
> +    int max_write_zeroes = MIN_NON_ZERO((flags & BDRV_REQ_NO_FALLBACK) ?
> +                                        bs->bl.max_pwrite_zeroes_no_fallback :
> +                                        bs->bl.max_pwrite_zeroes, INT_MAX);

I'd still like to get rid of this INT_MAX clamping.  If we can blank the 
entire image in one call, even when it is larger than 4G, then it is 
worth making that exposed to the user.  (Even in NBD, we might decide to 
add an extension that allows NBD_CMD_WRITE_ZEROES with a new flag and 
with offset/length == 0/0, as an official way to make the entire image 
zero, whereas it is now currently unspecified to pass a length of 0).

>       int alignment = MAX(bs->bl.pwrite_zeroes_alignment,
>                           bs->bl.request_alignment);
>       int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer, MAX_BOUNCE_BUFFER);
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


