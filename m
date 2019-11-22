Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7B9C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:46:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB5020674
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BIAs3mvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB5020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYD0E-0005UI-69
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 12:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iYC6q-0005xJ-FL
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iYC6m-0004EB-N8
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36989
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iYC6l-0004BU-8B
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574441308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTyN9r1y5h6r2KcytOa2Df/E/FkzuNyag6Y+U/1rnpc=;
 b=BIAs3mvMnWRFF0OMcAbHluiliOLmRjXUhboNz6njg8gqYtF27hhIAOUfMqEw1ONxRoGPeY
 nbJeDD6/5vrI68A5DkM5k6OuI0zJ943YBIaa3obOU9OeqBPPbY4EFNZh3Tt74XBY99HB8L
 obRetvwrSE3lPTWslrit7n6O38dNC7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-TBwgD-qSPbSGGoJUlQ_yUg-1; Fri, 22 Nov 2019 11:48:25 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BD9718C35AB;
 Fri, 22 Nov 2019 16:48:24 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9DA463BC9;
 Fri, 22 Nov 2019 16:48:20 +0000 (UTC)
Subject: Re: [PATCH v3 2/8] block: Add no_fallback parameter to
 bdrv_co_truncate()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191122160511.8377-1-kwolf@redhat.com>
 <20191122160511.8377-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <eef2c246-fd82-e66e-c757-00fe4eee4607@redhat.com>
Date: Fri, 22 Nov 2019 10:48:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191122160511.8377-3-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: TBwgD-qSPbSGGoJUlQ_yUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 10:05 AM, Kevin Wolf wrote:
> This adds a no_fallback parameter to bdrv_co_truncate(), bdrv_truncate()
> and blk_truncate() in preparation for a fix that potentially needs to
> zero-write the new area. no_fallback will use BDRV_REQ_NO_FALLBACK for
> this operation and lets the truncate fail if an efficient zero write
> isn't possible.
> 
> Only qmp_block_resize() passes true for this parameter because it is a
> blocking monitor command, so we don't want to add more potentially slow
> I/O operations to it than we already have.
> 
> All other users will accept even a slow fallback to avoid failure.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> +++ b/include/block/block.h
> @@ -347,9 +347,10 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
>   void bdrv_refresh_filename(BlockDriverState *bs);
>   
>   int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
> -                                  PreallocMode prealloc, Error **errp);
> +                                  PreallocMode prealloc, bool no_fallback,
> +                                  Error **errp);
>   int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
> -                  PreallocMode prealloc, Error **errp);
> +                  PreallocMode prealloc, bool no_fallback, Error **errp);
>   

New signature, most of the changes are mechanical to pass the new 
parameter...

> +++ b/block/io.c
> @@ -3313,9 +3313,15 @@ static void bdrv_parent_cb_resize(BlockDriverState *bs)
>    * If 'exact' is true, the file must be resized to exactly the given
>    * 'offset'.  Otherwise, it is sufficient for the node to be at least
>    * 'offset' bytes in length.
> + *
> + * If 'no_fallback' is true, a possibly needed writte_zeroes operation to avoid

write

> + * making a longer backing file visible will use BDRV_REQ_NO_FALLBACK. If the
> + * zero write is necessary and this flag is set, bdrv_co_truncate() will fail
> + * if efficient zero writes cannot be provided.
>    */

> +++ b/qemu-img.c
> @@ -3836,7 +3836,7 @@ static int img_resize(int argc, char **argv)
>        * resizing, so pass @exact=true.  It is of no use to report
>        * success when the image has not actually been resized.
>        */
> -    ret = blk_truncate(blk, total_size, true, prealloc, &err);
> +    ret = blk_truncate(blk, total_size, true, prealloc, false, &err);
>       if (!ret) {
>           qprintf(quiet, "Image resized.\n");
>       } else {

Hmm - thought for a future patch (not this one): are there situations 
where it may be faster to perform bulk pre-zeroing of the tail of a file 
by performing two truncates (smaller and then larger) because we know 
that just-added bytes from a truncate will read as zero?  This may be 
true for some file systems (but is not true for block devices, nor for 
things like NBD that lack resize).  Anyway, unrelated to this patch.

With the typo fixed,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


