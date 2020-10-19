Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADE3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61783221FC
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZ0tMp93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61783221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUTm1-0000ES-5D
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 07:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kUTgm-0005HQ-9S
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:50:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kUTgg-0000wt-Nx
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603108248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bpd+mW36h+SHgohbT6wljW+pCvqfaLYc2gD8p3c0omY=;
 b=XZ0tMp936uk8GNxeMDqo7DNE5HFoU33wojUlz4W6XUtizt565QaAM82YQSKMyjd/S5fpIb
 R9OSdjS2+9P9winSoeuXESv/8ObYLKKgyNOBWuWAivdc91QP4wrmsXotL9e4GI/9nD9cov
 4xy+nXETJxX6Z3W2KFB5fQWjLy1g+lE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-9x7Qfq1aNRmVFPkbC1gFfw-1; Mon, 19 Oct 2020 07:50:47 -0400
X-MC-Unique: 9x7Qfq1aNRmVFPkbC1gFfw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F82F1009440;
 Mon, 19 Oct 2020 11:50:44 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-121.ams2.redhat.com [10.36.114.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5359C5C1A3;
 Mon, 19 Oct 2020 11:50:37 +0000 (UTC)
Date: Mon, 19 Oct 2020 13:50:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 01/13] block: return status from bdrv_append and friends
Message-ID: <20201019115035.GC6508@merkur.fritz.box>
References: <20201016171057.6182-1-vsementsov@virtuozzo.com>
 <20201016171057.6182-2-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20201016171057.6182-2-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: berto@igalia.com, pavel.dovgaluk@ispras.ru, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, armbru@redhat.com, Greg Kurz <groug@kaod.org>,
 stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com, mreitz@redhat.com,
 jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 16.10.2020 um 19:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
> The recommended use of qemu error api assumes returning status together
> with setting errp and avoid void functions with errp parameter. Let's
> improve bdrv_append and some friends to reduce error-propagation
> overhead in further patches.
> 
> Choose int return status, because bdrv_replace_node() has call to
> bdrv_check_update_perm(), which reports int status, which seems correct
> to propagate.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  include/block/block.h | 12 ++++++------
>  block.c               | 39 ++++++++++++++++++++++++---------------
>  2 files changed, 30 insertions(+), 21 deletions(-)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index d16c401cb4..afb29cdbe4 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -346,10 +346,10 @@ int bdrv_create(BlockDriver *drv, const char* filename,
>  int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp);
>  
>  BlockDriverState *bdrv_new(void);
> -void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
> -                 Error **errp);
> -void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
> -                       Error **errp);
> +int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
> +                Error **errp);
> +int bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
> +                      Error **errp);
>  
>  int bdrv_parse_aio(const char *mode, int *flags);
>  int bdrv_parse_cache_mode(const char *mode, int *flags, bool *writethrough);
> @@ -361,8 +361,8 @@ BdrvChild *bdrv_open_child(const char *filename,
>                             BdrvChildRole child_role,
>                             bool allow_none, Error **errp);
>  BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp);
> -void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
> -                         Error **errp);
> +int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
> +                        Error **errp);
>  int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
>                             const char *bdref_key, Error **errp);
>  BlockDriverState *bdrv_open(const char *filename, const char *reference,
> diff --git a/block.c b/block.c
> index 430edf79bb..b05fbff42d 100644
> --- a/block.c
> +++ b/block.c
> @@ -2870,14 +2870,15 @@ static BdrvChildRole bdrv_backing_role(BlockDriverState *bs)
>   * Sets the bs->backing link of a BDS. A new reference is created; callers
>   * which don't need their own reference any more must call bdrv_unref().
>   */
> -void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
> +int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
>                           Error **errp)
>  {
> +    int ret = 0;
>      bool update_inherits_from = bdrv_chain_contains(bs, backing_hd) &&
>          bdrv_inherits_from_recursive(backing_hd, bs);
>  
>      if (bdrv_is_backing_chain_frozen(bs, child_bs(bs->backing), errp)) {
> -        return;
> +        return -EPERM;
>      }
>  
>      if (backing_hd) {
> @@ -2896,15 +2897,22 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
>  
>      bs->backing = bdrv_attach_child(bs, backing_hd, "backing", &child_of_bds,
>                                      bdrv_backing_role(bs), errp);
> +    if (!bs->backing) {
> +        ret = -EINVAL;

I think -EPERM describes the actual error cases better (though I'm not
sure if we're going to actually use the error code anywhere).

> +        goto out;
> +    }
> +
>      /* If backing_hd was already part of bs's backing chain, and
>       * inherits_from pointed recursively to bs then let's update it to
>       * point directly to bs (else it will become NULL). */
> -    if (bs->backing && update_inherits_from) {
> +    if (update_inherits_from) {
>          backing_hd->inherits_from = bs;
>      }
>  
>  out:

Please move the ret = 0 from the declaration to right above this line.
Otherwise we'd have to be careful in the future that the last assignment
of ret can't give it a non-zero (probably positive) value. Having
ret = 0 immediately before the label is the safe pattern.

Another possible advantage is that in some cases the compiler may then
be able to warn if you forget to set ret in an error path.

>      bdrv_refresh_limits(bs, NULL);
> +
> +    return ret;
>  }
>  
>  /*
> @@ -4554,8 +4562,8 @@ static bool should_update_child(BdrvChild *c, BlockDriverState *to)
>      return ret;
>  }
>  
> -void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
> -                       Error **errp)
> +int bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
> +                      Error **errp)
>  {
>      BdrvChild *c, *next;
>      GSList *list = NULL, *p;
> @@ -4577,6 +4585,7 @@ void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
>              continue;
>          }
>          if (c->frozen) {
> +            ret = -EPERM;
>              error_setg(errp, "Cannot change '%s' link to '%s'",
>                         c->name, from->node_name);
>              goto out;
> @@ -4612,6 +4621,8 @@ out:
>      g_slist_free(list);
>      bdrv_drained_end(from);
>      bdrv_unref(from);
> +
> +    return ret;

Please add the ret = 0 before the label, too.

>  }
>  
>  /*
> @@ -4630,20 +4641,16 @@ out:
>   * parents of bs_top after bdrv_append() returns. If the caller needs to keep a
>   * reference of its own, it must call bdrv_ref().
>   */
> -void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
> -                 Error **errp)
> +int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
> +                Error **errp)
>  {
> -    Error *local_err = NULL;
> -
> -    bdrv_set_backing_hd(bs_new, bs_top, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    int ret = bdrv_set_backing_hd(bs_new, bs_top, errp);
> +    if (ret < 0) {
>          goto out;
>      }
>  
> -    bdrv_replace_node(bs_top, bs_new, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    ret = bdrv_replace_node(bs_top, bs_new, errp);
> +    if (ret < 0) {
>          bdrv_set_backing_hd(bs_new, NULL, &error_abort);
>          goto out;
>      }
> @@ -4652,6 +4659,8 @@ void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
>       * additional reference any more. */
>  out:

And another one.

>      bdrv_unref(bs_new);
> +
> +    return ret;
>  }

Looks good to me otherwise.

Kevin


