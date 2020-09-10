Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5EEC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 12:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54ECC206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 12:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBDLI7R+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54ECC206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGLKZ-0006WI-9f
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 08:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kGLJo-0005dv-TJ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 08:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kGLJm-0006Ul-Iy
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 08:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599739485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=meiT6AhQU7c4Ozw13lROTf8ZpdAgZ2uaHzCkTSnEy68=;
 b=YBDLI7R+Y3zYkwwxYk+DAOPdvc29xe/NTEkD78vj847J7+wVvxf6qSzPAtVTryE5Hky6FP
 Fh8HIPOdW773IjqJC+Nah2+O+ok7q36bBI2XqJZNFfCbqjx1TDXl/Jh5eipEiwLULafk0z
 RMhSV98Jam9O7Myth2RH3KuCebaXSOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-rvIeZP7gNOKwLFUSFQXDuw-1; Thu, 10 Sep 2020 08:04:44 -0400
X-MC-Unique: rvIeZP7gNOKwLFUSFQXDuw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB5918018A3;
 Thu, 10 Sep 2020 12:04:41 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-29.ams2.redhat.com [10.36.112.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 94ED027BD8;
 Thu, 10 Sep 2020 12:04:40 +0000 (UTC)
Date: Thu, 10 Sep 2020 14:04:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2] qcow2: Skip copy-on-write when allocating a zero
 cluster
Message-ID: <20200910120439.GE7100@linux.fritz.box>
References: <20200827145350.26686-1-berto@igalia.com>
 <1cc85e0a-56b9-8eea-548b-ca7db83dd0ad@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <1cc85e0a-56b9-8eea-548b-ca7db83dd0ad@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 02:38:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 09.09.2020 um 21:23 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 27.08.2020 17:53, Alberto Garcia wrote:
> > Since commit c8bb23cbdbe32f5c326365e0a82e1b0e68cdcd8a when a write
> > request results in a new allocation QEMU first tries to see if the
> > rest of the cluster outside the written area contains only zeroes.
> > 
> > In that case, instead of doing a normal copy-on-write operation and
> > writing explicit zero buffers to disk, the code zeroes the whole
> > cluster efficiently using pwrite_zeroes() with BDRV_REQ_NO_FALLBACK.
> > 
> > This improves performance very significantly but it only happens when
> > we are writing to an area that was completely unallocated before. Zero
> > clusters (QCOW2_CLUSTER_ZERO_*) are treated like normal clusters and
> > are therefore slower to allocate.
> > 
> > This happens because the code uses bdrv_is_allocated_above() rather
> > bdrv_block_status_above(). The former is not as accurate for this
> > purpose but it is faster. However in the case of qcow2 the underlying
> > call does already report zero clusters just fine so there is no reason
> > why we cannot use that information.
> > 
> > After testing 4KB writes on an image that only contains zero clusters
> > this patch results in almost five times more IOPS.
> > 
> > Signed-off-by: Alberto Garcia <berto@igalia.com>
> > ---
> > v2:
> > - Add new, simpler API: bdrv_is_unallocated_or_zero_above()
> > 
> >   include/block/block.h |  2 ++
> >   block/io.c            | 24 ++++++++++++++++++++++++
> >   block/qcow2.c         | 37 +++++++++++++++++++++----------------
> >   3 files changed, 47 insertions(+), 16 deletions(-)
> > 
> > diff --git a/include/block/block.h b/include/block/block.h
> > index 6e36154061..477a72b2e9 100644
> > --- a/include/block/block.h
> > +++ b/include/block/block.h
> > @@ -496,6 +496,8 @@ int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
> >   int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
> >                               bool include_base, int64_t offset, int64_t bytes,
> >                               int64_t *pnum);
> > +int bdrv_is_unallocated_or_zero_above(BlockDriverState *bs, int64_t offset,
> > +                                      int64_t bytes);
> >   bool bdrv_is_read_only(BlockDriverState *bs);
> >   int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
> > diff --git a/block/io.c b/block/io.c
> > index ad3a51ed53..94faa3f9d7 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -2557,6 +2557,30 @@ int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
> >                                      offset, bytes, pnum, map, file);
> >   }
> > +/*
> > + * Check @bs (and its backing chain) to see if the range defined
> > + * by @offset and @bytes is unallocated or known to read as zeroes.
> > + * Return 1 if that is the case, 0 otherwise and -errno on error.
> > + * This test is meant to be fast rather than accurate so returning 0
> > + * does not guarantee non-zero data.
> > + */
> > +int bdrv_is_unallocated_or_zero_above(BlockDriverState *bs, int64_t offset,
> > +                                      int64_t bytes)
> 
> _above prefix for block-status functions usually assume existing of "base"
> parameter, otherwise, it's not clear "above what?"
> 
> Also, actually the caller doesn't care about it it allocated or not. It only wants to know is it read-as-zero or not. So, probably better name is bdrv_is_zero_fast()
> 
> > +{
> > +    int ret;
> > +    int64_t pnum = bytes;
> > +
> > +    ret = bdrv_common_block_status_above(bs, NULL, false, offset,
> > +                                         bytes, &pnum, NULL, NULL);
> > +
> > +    if (ret < 0) {
> > +        return ret;
> > +    }
> > +
> > +    return (pnum == bytes) &&
> > +        ((ret & BDRV_BLOCK_ZERO) || (!(ret & BDRV_BLOCK_ALLOCATED)));
> 
> Note that some protocol drivers returns unallocated status when it doesn't read-as-zero, so in general, we can't use this function as is_zero.
> 
> I think, that better to keep only (pnum == bytes) && (ret & BDRV_BLOCK_ZERO) here

Ah, very good, you already mentioned the main points I had, and more. (I
didn't realise that using BDRV_BLOCK_ALLOCATED is actually wrong, just
that it's more complicated than necessary.)

What I would like to add is that a bdrv_co_is_zero_fast() would be even
better. is_zero_cow() isn't marked as such yet, but semantically it's a
coroutine_fn, so we have no reason to go through the synchronous
wrappers.

> , and to make it work correctly improve bdrv_co_block_status like this:
> 
> diff --git a/block/io.c b/block/io.c
> index ad3a51ed53..33b2e91bcd 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2408,15 +2408,15 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
>      if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
>          ret |= BDRV_BLOCK_ALLOCATED;
> -    } else if (want_zero && bs->drv->supports_backing) {
> -        if (bs->backing) {
> +    } else if (bs->drv->supports_backing) {
> +        if (bs->backing && want_zero) {
>              BlockDriverState *bs2 = bs->backing->bs;
>              int64_t size2 = bdrv_getlength(bs2);
>              if (size2 >= 0 && offset >= size2) {
>                  ret |= BDRV_BLOCK_ZERO;
>              }
> -        } else {
> +        } else if (!bs->backing) {
>              ret |= BDRV_BLOCK_ZERO;
>          }
>      }
> 
> - we can always add ZERO flag to backing-supporting formats if range is unallocated and there is no backing file.

This makes sense to me, though it should be a separate patch. This one
wouldn't become incorrect without it, but it would be less effective.

Kevin


