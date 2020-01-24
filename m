Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200F7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D937F2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJ8F8R5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D937F2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuweX-0002O5-3I
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iuwdo-0001sD-1f
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iuwdm-00073V-GL
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:56:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35733
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iuwdm-00072b-C1
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:56:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579863401;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+SjyjaAkQ6xmBKUmToLceJ45VcM1BU8gRgz9BD7jPM=;
 b=RJ8F8R5FabIbrnSgLbHIOn3hSuYaZryxZ7DfweKWkpB5cZR054MQTZ14QfSObwExi2UDPT
 8Dayy+KskgkpOy253p6iYn69tD5tZhL6K8CK/w/cw+xy5Fgm7Z1lXqGSNBEpl1+QLJiRrG
 9iepSt82v8nccLtCqxX4pDfp9gahDSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-YtgMgqU_MgyTLHwypegt5A-1; Fri, 24 Jan 2020 05:56:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9D77107ACC5;
 Fri, 24 Jan 2020 10:56:36 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A15C7620D8;
 Fri, 24 Jan 2020 10:56:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 1/7] migration/block-dirty-bitmap: refactor incoming state
 to be one struct
In-Reply-To: <20200122132328.31156-2-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 22 Jan 2020 16:23:22 +0300")
References: <20200122132328.31156-1-vsementsov@virtuozzo.com>
 <20200122132328.31156-2-vsementsov@virtuozzo.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 24 Jan 2020 11:56:28 +0100
Message-ID: <87eevp5dib.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: YtgMgqU_MgyTLHwypegt5A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 dgilbert@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> Move enabled_bitmaps and finish_lock, which are part of incoming state
> to DirtyBitmapLoadState, and make static global variable to store state
> instead of static local one.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  migration/block-dirty-bitmap.c | 77 +++++++++++++++++++---------------
>  1 file changed, 43 insertions(+), 34 deletions(-)
>
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitma=
p.c
> index 7eafface61..281d20f41d 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -125,6 +125,13 @@ typedef struct DirtyBitmapMigState {
>      BlockDriverState *prev_bs;
>      BdrvDirtyBitmap *prev_bitmap;
>  } DirtyBitmapMigState;
> +static DirtyBitmapMigState dirty_bitmap_mig_state;

Missing new line.

> +
> +typedef struct DirtyBitmapLoadBitmapState {
> +    BlockDriverState *bs;
> +    BdrvDirtyBitmap *bitmap;
> +    bool migrated;
> +} DirtyBitmapLoadBitmapState;
> =20
>  typedef struct DirtyBitmapLoadState {
>      uint32_t flags;
> @@ -132,21 +139,15 @@ typedef struct DirtyBitmapLoadState {
>      char bitmap_name[256];
>      BlockDriverState *bs;
>      BdrvDirtyBitmap *bitmap;
> -} DirtyBitmapLoadState;
> =20
> -static DirtyBitmapMigState dirty_bitmap_mig_state;
> -
> -typedef struct DirtyBitmapLoadBitmapState {
> -    BlockDriverState *bs;
> -    BdrvDirtyBitmap *bitmap;
> -    bool migrated;
> -} DirtyBitmapLoadBitmapState;
> -static GSList *enabled_bitmaps;
> -QemuMutex finish_lock;
> +    GSList *enabled_bitmaps;
> +    QemuMutex finish_lock;
> +} DirtyBitmapLoadState;
> +static DirtyBitmapLoadState dbm_load_state;

You move two global variables to an struct (good)
But you create a even bigger global variable (i.e. state that was not
shared before.)

>  /* First occurrence of this bitmap. It should be created if doesn't exis=
t */
> -static int dirty_bitmap_load_start(QEMUFile *f, DirtyBitmapLoadState *s)
> +static int dirty_bitmap_load_start(QEMUFile *f)
>  {
> +    DirtyBitmapLoadState *s =3D &dbm_load_state;

You create a local alias.

>      Error *local_err =3D NULL;
>      uint32_t granularity =3D qemu_get_be32(f);
>      uint8_t flags =3D qemu_get_byte(f);
> @@ -482,7 +484,8 @@ static int dirty_bitmap_load_start(QEMUFile *f, Dirty=
BitmapLoadState *s)
>          b->bs =3D s->bs;
>          b->bitmap =3D s->bitmap;
>          b->migrated =3D false;
> -        enabled_bitmaps =3D g_slist_prepend(enabled_bitmaps, b);
> +        dbm_load_state.enabled_bitmaps =3D
> +            g_slist_prepend(dbm_load_state.enabled_bitmaps, b);

And then you access it using the global variable?

> -static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState=
 *s)
> +static void dirty_bitmap_load_complete(QEMUFile *f)
>  {
> +    DirtyBitmapLoadState *s =3D &dbm_load_state;

Exactly the same on this function.

I still don't understand why you are removing the pass as parameters of
this function.


> -    static DirtyBitmapLoadState s;

Aha, this is why you are moving it as a global.

But, why can't you put this inside dirty_bitmap_mig_state?  Then you:
a- don't have to have "yet" another global variable
b- you can clean it up on save_cleanup handler.

not related to this patch, but to the file in general:

static void dirty_bitmap_save_cleanup(void *opaque)
{
    dirty_bitmap_mig_cleanup();
}

We have opaque here, that we can do:

DirtyBitmapMigBitmapState *dbms =3D opaque;

And then pass dbms to dirty_bitmap_mig_cleanup().

/* Called with iothread lock taken.  */
static void dirty_bitmap_mig_cleanup(void)
{
    DirtyBitmapMigBitmapState *dbms;

    while ((dbms =3D QSIMPLEQ_FIRST(&dirty_bitmap_mig_state.dbms_list)) !=
=3D NULL) {
        QSIMPLEQ_REMOVE_HEAD(&dirty_bitmap_mig_state.dbms_list, entry);
        bdrv_dirty_bitmap_set_busy(dbms->bitmap, false);
        bdrv_unref(dbms->bs);
        g_free(dbms);
    }
}


Because here we just use the global variable.

Later, Juan.


