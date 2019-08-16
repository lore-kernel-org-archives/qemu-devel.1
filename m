Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896A8C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 12:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5251421655
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 12:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="D2bkvkko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5251421655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hybZ3-0000Rv-IH
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 08:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1hybXw-0008GX-Jx
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1hybXv-0006h7-F8
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:41:32 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:55733)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1hybXu-0006gH-UQ; Fri, 16 Aug 2019 08:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=viASoozm0OV2QV3VGv+4xThUSfDIYqyqKdZie61vA7E=; 
 b=D2bkvkko1C8GpixWwmjrF0FdvUU27XNStU/GxaUMFZ49CppWsaE0OWjqEImozax/4VSEwj/1PpD7ctNq9c2mCTRdV2TYC+i6FNn73zE2gz5eTQ9HsLkfhJu+7+nu80lstoEkfReW9Bo1DzoIl6ULxaY4qZAN0qj5929sieXBTeS8jmJRPNegVwymEIzjRQNSDxkiC9WdxpXWOMuodW/3OoTrnA3yU5CuAH8sj8fZqRj4tFg2KUDLSQw1wzsTgRPvm2gFXI/Q2c4yYLxBbX7QHouZNR4p5cxkQTNgCMpJ8gXRtP43xBB6YatAZHJXPN5VgSoSltbX/9/OHtvT5QJ+gg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1hybXr-00088n-TU; Fri, 16 Aug 2019 14:41:27 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1hybXr-0006gF-RA; Fri, 16 Aug 2019 14:41:27 +0200
Date: Fri, 16 Aug 2019 14:41:27 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Message-ID: <20190816124127.GA20917@igalia.com>
References: <20190816121742.29607-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816121742.29607-1-berto@igalia.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH] qcow2: Fix the calculation of the maximum
 L2 cache size
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
Cc: Kevin Wolf <kwolf@redhat.com>, Leonid Bloch <lbloch@janustech.com>,
 qemu-stable@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc qemu-stable

This bug means that under certain conditions it's impossible to
create a cache large enough for the image, resulting in reduced I/O
performance.

On Fri, Aug 16, 2019 at 03:17:42PM +0300, Alberto Garcia wrote:
> The size of the qcow2 L2 cache defaults to 32 MB, which can be easily
> larger than the maximum amount of L2 metadata that the image can have.
> For example: with 64 KB clusters the user would need a qcow2 image
> with a virtual size of 256 GB in order to have 32 MB of L2 metadata.
> 
> Because of that, since commit b749562d9822d14ef69c9eaa5f85903010b86c30
> we forbid the L2 cache to become larger than the maximum amount of L2
> metadata for the image, calculated using this formula:
> 
>     uint64_t max_l2_cache = virtual_disk_size / (s->cluster_size / 8);
> 
> The problem with this formula is that the result should be rounded up
> to the cluster size because an L2 table on disk always takes one full
> cluster.
> 
> For example, a 1280 MB qcow2 image with 64 KB clusters needs exactly
> 160 KB of L2 metadata, but we need 192 KB on disk (3 clusters) even if
> the last 32 KB of those are not going to be used.
> 
> However QEMU rounds the numbers down and only creates 2 cache tables
> (128 KB), which is not enough for the image.
> 
> A quick test doing 4KB random writes on a 1280 MB image gives me
> around 500 IOPS, while with the correct cache size I get 16K IOPS.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 039bdc2f7e..865839682c 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -826,7 +826,11 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
>      bool l2_cache_entry_size_set;
>      int min_refcount_cache = MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;
>      uint64_t virtual_disk_size = bs->total_sectors * BDRV_SECTOR_SIZE;
> -    uint64_t max_l2_cache = virtual_disk_size / (s->cluster_size / 8);
> +    uint64_t max_l2_entries = DIV_ROUND_UP(virtual_disk_size, s->cluster_size);
> +    /* An L2 table is always one cluster in size so the max cache size
> +     * should be a multiple of the cluster size. */
> +    uint64_t max_l2_cache = ROUND_UP(max_l2_entries * sizeof(uint64_t),
> +                                     s->cluster_size);
>  
>      combined_cache_size_set = qemu_opt_get(opts, QCOW2_OPT_CACHE_SIZE);
>      l2_cache_size_set = qemu_opt_get(opts, QCOW2_OPT_L2_CACHE_SIZE);
> -- 
> 2.20.1

