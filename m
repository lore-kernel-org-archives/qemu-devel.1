Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EABC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 14:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE1D2077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 14:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Z86KmHEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE1D2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47639 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK1U6-0006vh-B3
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 10:05:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hK1Qe-0004JS-8L
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hK1Qd-0005zF-3H
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:02:16 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:36727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hK1Qb-0005tW-5X; Fri, 26 Apr 2019 10:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=+UT9vU8X7HjVLOtLnXZb6llZRbFkOd2m9+VZ8hdu1qI=; 
	b=Z86KmHEdCbAcGl8raf0JaDKOfH8LSZlLppiLdgiZFl01vMPLgJx3SWUKoWkuWR6BFsPCjSwZTbEZ/zczdxHl1f8irVhi1PsW14wIHZ5Eplx4pPzkvIssfsmUYQyQlVuejiGbRTLS6rg4FD/bXhU42AKLS7N56nxR0/dsDBV+fgqXlM/Q4SWYrZzrb+9ILsc/ME9RBqR0AQdj8KnPBp+5NLnFKt5Pyb9UHAORWuLeksxt5ijYPAOCnEOyURFt+efleOCeTL2FFwZfuAEaUm/a0lHpu+VD8+et+cNL7IcFbtaxL200tkEZT1PKoVVTY7PP5rCvxrbZyWLwSPV5Hr4Oyw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hK1QW-00062D-LZ; Fri, 26 Apr 2019 16:02:08 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hK1QW-0000jV-J0; Fri, 26 Apr 2019 16:02:08 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
In-Reply-To: <20190331111747.14685-1-berto@igalia.com>
References: <20190331111747.14685-1-berto@igalia.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Fri, 26 Apr 2019 16:02:08 +0200
Message-ID: <w51v9z0g90f.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH for-4.1] block: Use bdrv_unref_child() for
 all children in bdrv_close()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426140208.8mrTcF2CVpbUUuXxDTdX0KS2i-9_BGQMRKjB7AQjZfc@z>

ping

On Sun 31 Mar 2019 01:17:47 PM CEST, Alberto Garcia wrote:
> bdrv_unref_child() does the following things:
>
>   - Updates the child->bs->inherits_from pointer.
>   - Calls bdrv_detach_child() to remove the BdrvChild from bs->children.
>   - Calls bdrv_unref() to unref the child BlockDriverState.
>
> When bdrv_unref_child() was introduced in commit 33a604075c it was not
> used in bdrv_close() because the drivers that had additional children
> (like quorum or blkverify) had already called bdrv_unref() on their
> children during their own close functions.
>
> This was changed later (in 0bd6e91a7e for quorum, in 3e586be0b2 for
> blkverify) so there's no reason not to use bdrv_unref_child() in
> bdrv_close() anymore.
>
> After this there's also no need to remove bs->backing and bs->file
> separately from the rest of the children, so bdrv_close() can be
> simplified.
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/block.c b/block.c
> index 0a93ee9ac8..3b7c12d68e 100644
> --- a/block.c
> +++ b/block.c
> @@ -3842,22 +3842,12 @@ static void bdrv_close(BlockDriverState *bs)
>          bs->drv = NULL;
>      }
>  
> -    bdrv_set_backing_hd(bs, NULL, &error_abort);
> -
> -    if (bs->file != NULL) {
> -        bdrv_unref_child(bs, bs->file);
> -        bs->file = NULL;
> -    }
> -
>      QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
> -        /* TODO Remove bdrv_unref() from drivers' close function and use
> -         * bdrv_unref_child() here */
> -        if (child->bs->inherits_from == bs) {
> -            child->bs->inherits_from = NULL;
> -        }
> -        bdrv_detach_child(child);
> +        bdrv_unref_child(bs, child);
>      }
>  
> +    bs->backing = NULL;
> +    bs->file = NULL;
>      g_free(bs->opaque);
>      bs->opaque = NULL;
>      atomic_set(&bs->copy_on_read, 0);
> -- 
> 2.11.0

