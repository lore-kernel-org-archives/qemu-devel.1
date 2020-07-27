Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A0FC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E788820663
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EqWvMK05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E788820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k01Hh-0008PY-7v
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 07:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k01EV-0005Fy-UD
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:23:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58380
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k01ET-0007De-JG
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595849028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CGBjB8Olgmv7Tm5YeXDjEo7jUcD4dc9WQbUPilASnI0=;
 b=EqWvMK05QzJL4ag0zEyAxQmkjsuDPHU3RHh0t9vPTunAfeaddInHGDpcLSfF5Y/NJviN+T
 hROt/0qtVAE1xCqgr02sAeUDPg96yrdotYXOW02U049Z6HpObgJvxu1FjNs89qxb2tImVW
 kYwNbZjhtFQ8Sll2IyXThyZxnFfFLv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-I7mEPw-5OmaVt6aLonjInA-1; Mon, 27 Jul 2020 07:23:46 -0400
X-MC-Unique: I7mEPw-5OmaVt6aLonjInA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82A2B106B242;
 Mon, 27 Jul 2020 11:23:45 +0000 (UTC)
Received: from work-vm (ovpn-114-135.ams2.redhat.com [10.36.114.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 05AF260FC2;
 Mon, 27 Jul 2020 11:23:39 +0000 (UTC)
Date: Mon, 27 Jul 2020 12:23:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 15/21] migration/block-dirty-bitmap: relax error
 handling in incoming part
Message-ID: <20200727112337.GK3040@work-vm>
References: <20200724084327.15665-1-vsementsov@virtuozzo.com>
 <20200724084327.15665-16-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200724084327.15665-16-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 quintela@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> Bitmaps data is not critical, and we should not fail the migration (or
> use postcopy recovering) because of dirty-bitmaps migration failure.
> Instead we should just lose unfinished bitmaps.
> 
> Still we have to report io stream violation errors, as they affect the
> whole migration stream.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  migration/block-dirty-bitmap.c | 152 +++++++++++++++++++++++++--------
>  1 file changed, 117 insertions(+), 35 deletions(-)
> 
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index eb4ffeac4d..c24d4614bf 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -145,6 +145,15 @@ typedef struct DBMLoadState {
>  
>      bool before_vm_start_handled; /* set in dirty_bitmap_mig_before_vm_start */
>  
> +    /*
> +     * cancelled
> +     * Incoming migration is cancelled for some reason. That means that we
> +     * still should read our chunks from migration stream, to not affect other
> +     * migration objects (like RAM), but just ignore them and do not touch any
> +     * bitmaps or nodes.
> +     */
> +    bool cancelled;
> +
>      GSList *bitmaps;
>      QemuMutex lock; /* protect bitmaps */
>  } DBMLoadState;
> @@ -531,6 +540,10 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
>      uint8_t flags = qemu_get_byte(f);
>      LoadBitmapState *b;
>  
> +    if (s->cancelled) {
> +        return 0;
> +    }
> +
>      if (s->bitmap) {
>          error_report("Bitmap with the same name ('%s') already exists on "
>                       "destination", bdrv_dirty_bitmap_name(s->bitmap));
> @@ -613,13 +626,47 @@ void dirty_bitmap_mig_before_vm_start(void)
>      qemu_mutex_unlock(&s->lock);
>  }
>  
> +static void cancel_incoming_locked(DBMLoadState *s)
> +{
> +    GSList *item;
> +
> +    if (s->cancelled) {
> +        return;
> +    }
> +
> +    s->cancelled = true;
> +    s->bs = NULL;
> +    s->bitmap = NULL;
> +
> +    /* Drop all unfinished bitmaps */
> +    for (item = s->bitmaps; item; item = g_slist_next(item)) {
> +        LoadBitmapState *b = item->data;
> +
> +        /*
> +         * Bitmap must be unfinished, as finished bitmaps should already be
> +         * removed from the list.
> +         */
> +        assert(!s->before_vm_start_handled || !b->migrated);
> +        if (bdrv_dirty_bitmap_has_successor(b->bitmap)) {
> +            bdrv_reclaim_dirty_bitmap(b->bitmap, &error_abort);
> +        }
> +        bdrv_release_dirty_bitmap(b->bitmap);
> +    }
> +
> +    g_slist_free_full(s->bitmaps, g_free);
> +    s->bitmaps = NULL;
> +}
> +
>  static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
>  {
>      GSList *item;
>      trace_dirty_bitmap_load_complete();
> -    bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
>  
> -    qemu_mutex_lock(&s->lock);
> +    if (s->cancelled) {
> +        return;
> +    }
> +
> +    bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
>  
>      if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
>          bdrv_reclaim_dirty_bitmap(s->bitmap, &error_abort);
> @@ -637,8 +684,6 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
>              break;
>          }
>      }
> -
> -    qemu_mutex_unlock(&s->lock);
>  }
>  
>  static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
> @@ -650,15 +695,32 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
>  
>      if (s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
>          trace_dirty_bitmap_load_bits_zeroes();
> -        bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte, nr_bytes,
> -                                             false);
> +        if (!s->cancelled) {
> +            bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte,
> +                                                 nr_bytes, false);
> +        }
>      } else {
>          size_t ret;
>          uint8_t *buf;
>          uint64_t buf_size = qemu_get_be64(f);
> -        uint64_t needed_size =
> -            bdrv_dirty_bitmap_serialization_size(s->bitmap,
> -                                                 first_byte, nr_bytes);
> +        uint64_t needed_size;
> +
> +        buf = g_malloc(buf_size);
> +        ret = qemu_get_buffer(f, buf, buf_size);
> +        if (ret != buf_size) {
> +            error_report("Failed to read bitmap bits");
> +            g_free(buf);
> +            return -EIO;
> +        }
> +
> +        if (s->cancelled) {
> +            g_free(buf);
> +            return 0;
> +        }
> +
> +        needed_size = bdrv_dirty_bitmap_serialization_size(s->bitmap,
> +                                                           first_byte,
> +                                                           nr_bytes);
>  
>          if (needed_size > buf_size ||
>              buf_size > QEMU_ALIGN_UP(needed_size, 4 * sizeof(long))
> @@ -667,15 +729,8 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
>              error_report("Migrated bitmap granularity doesn't "
>                           "match the destination bitmap '%s' granularity",
>                           bdrv_dirty_bitmap_name(s->bitmap));
> -            return -EINVAL;
> -        }
> -
> -        buf = g_malloc(buf_size);
> -        ret = qemu_get_buffer(f, buf, buf_size);
> -        if (ret != buf_size) {
> -            error_report("Failed to read bitmap bits");
> -            g_free(buf);
> -            return -EIO;
> +            cancel_incoming_locked(s);
> +            return 0;
>          }
>  
>          bdrv_dirty_bitmap_deserialize_part(s->bitmap, buf, first_byte, nr_bytes,
> @@ -700,14 +755,16 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
>              error_report("Unable to read node name string");
>              return -EINVAL;
>          }
> -        s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
> -        if (!s->bs) {
> -            error_report_err(local_err);
> -            return -EINVAL;
> +        if (!s->cancelled) {
> +            s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
> +            if (!s->bs) {
> +                error_report_err(local_err);
> +                cancel_incoming_locked(s);
> +            }
>          }
> -    } else if (!s->bs && !nothing) {
> +    } else if (!s->bs && !nothing && !s->cancelled) {
>          error_report("Error: block device name is not set");
> -        return -EINVAL;
> +        cancel_incoming_locked(s);
>      }
>  
>      if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
> @@ -715,24 +772,38 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
>              error_report("Unable to read bitmap name string");
>              return -EINVAL;
>          }
> -        s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
> -
> -        /* bitmap may be NULL here, it wouldn't be an error if it is the
> -         * first occurrence of the bitmap */
> -        if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
> -            error_report("Error: unknown dirty bitmap "
> -                         "'%s' for block device '%s'",
> -                         s->bitmap_name, s->node_name);
> -            return -EINVAL;
> +        if (!s->cancelled) {
> +            s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
> +
> +            /*
> +             * bitmap may be NULL here, it wouldn't be an error if it is the
> +             * first occurrence of the bitmap
> +             */
> +            if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
> +                error_report("Error: unknown dirty bitmap "
> +                             "'%s' for block device '%s'",
> +                             s->bitmap_name, s->node_name);
> +                cancel_incoming_locked(s);
> +            }
>          }
> -    } else if (!s->bitmap && !nothing) {
> +    } else if (!s->bitmap && !nothing && !s->cancelled) {
>          error_report("Error: block device name is not set");
> -        return -EINVAL;
> +        cancel_incoming_locked(s);
>      }
>  
>      return 0;
>  }
>  
> +/*
> + * dirty_bitmap_load
> + *
> + * Load sequence of dirty bitmap chunks. Return error only on fatal io stream
> + * violations. On other errors just cancel bitmaps incoming migration and return
> + * 0.
> + *
> + * Note, than when incoming bitmap migration is canceled, we still must read all
> + * our chunks (and just ignore them), to not affect other migration objects.
> + */
>  static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>  {
>      DBMLoadState *s = &((DBMState *)opaque)->load;
> @@ -741,12 +812,19 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>      trace_dirty_bitmap_load_enter();
>  
>      if (version_id != 1) {
> +        qemu_mutex_lock(&s->lock);
> +        cancel_incoming_locked(s);
> +        qemu_mutex_unlock(&s->lock);
>          return -EINVAL;
>      }
>  
>      do {
> +        qemu_mutex_lock(&s->lock);

Would QEMU_LOCK_GUARD(&s->lock)  work there?
It avoids the need to catch the unlock on each of the failure cases.

Dave

>          ret = dirty_bitmap_load_header(f, s);
>          if (ret < 0) {
> +            cancel_incoming_locked(s);
> +            qemu_mutex_unlock(&s->lock);
>              return ret;
>          }
>  
> @@ -763,8 +841,12 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
>          }
>  
>          if (ret) {
> +            cancel_incoming_locked(s);
> +            qemu_mutex_unlock(&s->lock);
>              return ret;
>          }
> +
> +        qemu_mutex_unlock(&s->lock);
>      } while (!(s->flags & DIRTY_BITMAP_MIG_FLAG_EOS));
>  
>      trace_dirty_bitmap_load_success();
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


