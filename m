Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E598C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6602E206B5
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E110u8Ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6602E206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8LnV-0007jQ-Mn
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 06:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8Lmu-00071d-9J
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 06:57:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55928
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8Lms-0005Zf-JH
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 06:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597834665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJTh0pPL8LXPnIXNWTl3ZUZaeDHBHp1jwdaBbZvDQuU=;
 b=E110u8CamjggStBhq/xOWHYFH1QuwG5GMMo9xfY9Isps9+VgTImpcdM9RZ8cqTrfb/KTCD
 c9blFbn2yCXUrFFIMP3TaldlhXlSG59zHHeZXo1LFNsMhrBJGIostYXoUsS4Ii6079Fpzj
 INShFh6Pffr7rsPAA1BOOo+CaXMiCYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-lBjYwv57PY-Lm4BqdkvfBg-1; Wed, 19 Aug 2020 06:57:43 -0400
X-MC-Unique: lBjYwv57PY-Lm4BqdkvfBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBF701007463;
 Wed, 19 Aug 2020 10:57:42 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-19.ams2.redhat.com [10.36.114.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC8601014181;
 Wed, 19 Aug 2020 10:57:41 +0000 (UTC)
Date: Wed, 19 Aug 2020 12:57:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v7 25/47] block: Def. impl.s for get_allocated_file_size
Message-ID: <20200819105740.GB10272@linux.fritz.box>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-26-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625152215.941773-26-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.06.2020 um 17:21 hat Max Reitz geschrieben:
> If every BlockDriver were to implement bdrv_get_allocated_file_size(),
> there are basically three ways it would be handled:
> (1) For protocol drivers: Figure out the actual allocated file size in
>     some protocol-specific way
> (2) For protocol drivers: If that is not possible (or we just have not
>     bothered to implement it yet), return -ENOTSUP
> (3) For drivers with children: Return the sum of some or all their
>     children's sizes
> 
> For the drivers we have, case (3) boils down to either:
> (a) The sum of all children's sizes
> (b) The size of the primary child
> 
> (2), (3a) and (3b) can be implemented generically, so this patch adds
> such generic implementations for drivers to use.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/block_int.h |  5 ++++
>  block.c                   | 51 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 5da793bfc3..c963ee9f28 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -1318,6 +1318,11 @@ int coroutine_fn bdrv_co_block_status_from_backing(BlockDriverState *bs,
>                                                     int64_t *pnum,
>                                                     int64_t *map,
>                                                     BlockDriverState **file);
> +
> +int64_t bdrv_sum_allocated_file_size(BlockDriverState *bs);
> +int64_t bdrv_primary_allocated_file_size(BlockDriverState *bs);
> +int64_t bdrv_notsup_allocated_file_size(BlockDriverState *bs);
> +
>  const char *bdrv_get_parent_name(const BlockDriverState *bs);
>  void blk_dev_change_media_cb(BlockBackend *blk, bool load, Error **errp);
>  bool blk_dev_has_removable_media(BlockBackend *blk);
> diff --git a/block.c b/block.c
> index 1c71ecab7c..fc01ce90b3 100644
> --- a/block.c
> +++ b/block.c
> @@ -5003,6 +5003,57 @@ int64_t bdrv_get_allocated_file_size(BlockDriverState *bs)
>      return -ENOTSUP;
>  }
>  
> +/**
> + * Implementation of BlockDriver.bdrv_get_allocated_file_size() for
> + * block drivers that want it to sum all children they store data on.
> + * (This excludes backing children.)
> + */
> +int64_t bdrv_sum_allocated_file_size(BlockDriverState *bs)
> +{
> +    BdrvChild *child;
> +    int64_t child_size, sum = 0;
> +
> +    QLIST_FOREACH(child, &bs->children, next) {
> +        if (child->role & (BDRV_CHILD_DATA | BDRV_CHILD_METADATA |
> +                           BDRV_CHILD_FILTERED))
> +        {
> +            child_size = bdrv_get_allocated_file_size(child->bs);
> +            if (child_size < 0) {
> +                return child_size;
> +            }
> +            sum += child_size;
> +        }
> +    }
> +
> +    return sum;
> +}

The only user apart from bdrv_get_allocated_file_size() is blkverify. As
I argued that blkverify shouldn't use it, this can become static.

> +/**
> + * Implementation of BlockDriver.bdrv_get_allocated_file_size() for
> + * block drivers that want it to return only the size of a node's
> + * primary child.
> + */
> +int64_t bdrv_primary_allocated_file_size(BlockDriverState *bs)
> +{
> +    BlockDriverState *primary_bs;
> +
> +    primary_bs = bdrv_primary_bs(bs);
> +    if (!primary_bs) {
> +        return -ENOTSUP;
> +    }
> +
> +    return bdrv_get_allocated_file_size(primary_bs);
> +}

This can become static, too (never used as a callback), and possibly
even be inlined.

> +/**
> + * Implementation of BlockDriver.bdrv_get_allocated_file_size() for
> + * protocol block drivers that just do not support it.
> + */
> +int64_t bdrv_notsup_allocated_file_size(BlockDriverState *bs)
> +{
> +    return -ENOTSUP;
> +}

Also never used as a callback. I think inlining it would almost
certainly make more sense.

Kevin


