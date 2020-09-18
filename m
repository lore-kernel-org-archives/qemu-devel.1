Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44551C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7212078B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7212078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIL2-00083v-P1
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kJI6m-00005g-6F; Fri, 18 Sep 2020 11:15:32 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:55543)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kJI6i-0002Yk-9F; Fri, 18 Sep 2020 11:15:31 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.44])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 9E7576330DB6;
 Fri, 18 Sep 2020 17:15:15 +0200 (CEST)
Received: from kaod.org (37.59.142.106) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 18 Sep
 2020 17:15:14 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R00616c766d7-8503-4125-a30a-90446f1857a7,
 26E73787F9CAC9185D3FF732CC8AC9B997D690EB) smtp.auth=groug@kaod.org
Date: Fri, 18 Sep 2020 17:15:13 +0200
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 09/13] block/qcow2-bitmap: improve
 qcow2_load_dirty_bitmaps() interface
Message-ID: <20200918171513.1e8e680e@bahia.lan>
In-Reply-To: <20200917195519.19589-10-vsementsov@virtuozzo.com>
References: <20200917195519.19589-1-vsementsov@virtuozzo.com>
 <20200917195519.19589-10-vsementsov@virtuozzo.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 64d45ccc-5b6e-41eb-83cd-cc0f4265757b
X-Ovh-Tracer-Id: 14916766393310222779
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehkfiholhhfsehrvgguhhgrthdrtghomh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 11:15:16
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, berto@igalia.com, pavel.dovgaluk@ispras.ru,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com,
 ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Sep 2020 22:55:15 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> It's recommended for bool functions with errp to return true on success
> and false on failure. Non-standard interfaces don't help to understand
> the code. The change is also needed to reduce error propagation.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

With the documentation change suggested by Berto,

Reviewed-by: Greg Kurz <groug@kaod.org>

>  block/qcow2.h        |  3 ++-
>  block/qcow2-bitmap.c | 25 ++++++++++++++-----------
>  block/qcow2.c        |  6 ++----
>  3 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 6eac088f1c..3c64dcda33 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -972,7 +972,8 @@ void qcow2_cache_discard(Qcow2Cache *c, void *table);
>  int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>                                    void **refcount_table,
>                                    int64_t *refcount_table_size);
> -bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp);
> +bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, bool *header_updated,
> +                              Error **errp);
>  bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
>                                  Qcow2BitmapInfoList **info_list, Error **errp);
>  int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 4f6138f544..500175f4e8 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -962,25 +962,26 @@ static void set_readonly_helper(gpointer bitmap, gpointer value)
>      bdrv_dirty_bitmap_set_readonly(bitmap, (bool)value);
>  }
>  
> -/* qcow2_load_dirty_bitmaps()
> - * Return value is a hint for caller: true means that the Qcow2 header was
> - * updated. (false doesn't mean that the header should be updated by the
> - * caller, it just means that updating was not needed or the image cannot be
> - * written to).
> - * On failure the function returns false.
> +/*
> + * Return true on success, false on failure. Anyway, if header_updated
> + * provided set it appropriately.
>   */
> -bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
> +bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, bool *header_updated,
> +                              Error **errp)
>  {
>      BDRVQcow2State *s = bs->opaque;
>      Qcow2BitmapList *bm_list;
>      Qcow2Bitmap *bm;
>      GSList *created_dirty_bitmaps = NULL;
> -    bool header_updated = false;
>      bool needs_update = false;
>  
> +    if (header_updated) {
> +        *header_updated = false;
> +    }
> +
>      if (s->nb_bitmaps == 0) {
>          /* No bitmaps - nothing to do */
> -        return false;
> +        return true;
>      }
>  
>      bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
> @@ -1036,7 +1037,9 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>              error_setg_errno(errp, -ret, "Can't update bitmap directory");
>              goto fail;
>          }
> -        header_updated = true;
> +        if (header_updated) {
> +            *header_updated = true;
> +        }
>      }
>  
>      if (!can_write(bs)) {
> @@ -1047,7 +1050,7 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>      g_slist_free(created_dirty_bitmaps);
>      bitmap_list_free(bm_list);
>  
> -    return header_updated;
> +    return true;
>  
>  fail:
>      g_slist_foreach(created_dirty_bitmaps, release_dirty_bitmap_helper, bs);
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 8c89c98978..c4b86df7c0 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1297,7 +1297,6 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>      unsigned int len, i;
>      int ret = 0;
>      QCowHeader header;
> -    Error *local_err = NULL;
>      uint64_t ext_end;
>      uint64_t l1_vm_state_index;
>      bool update_header = false;
> @@ -1785,9 +1784,8 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>  
>      if (!(bdrv_get_flags(bs) & BDRV_O_INACTIVE)) {
>          /* It's case 1, 2 or 3.2. Or 3.1 which is BUG in management layer. */
> -        bool header_updated = qcow2_load_dirty_bitmaps(bs, &local_err);
> -        if (local_err != NULL) {
> -            error_propagate(errp, local_err);
> +        bool header_updated;
> +        if (!qcow2_load_dirty_bitmaps(bs, &header_updated, errp)) {
>              ret = -EINVAL;
>              goto fail;
>          }


