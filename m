Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8322BC00454
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:07:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D67020692
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbS67out"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D67020692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieLYp-0002Xr-Ec
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 11:06:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ieLY5-0001rJ-3u
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ieLY2-00089O-5H
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:06:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56463
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ieLY1-00088b-JN
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575907568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+RbFC4eEhTNJHx837P7drSLdPkMBBSzO7Ars7IuAwP0=;
 b=TbS67outPcWbvXxndLiLluu/L4D+5jip+gaMdZDerC2U+HocJ+AkGraW53D5etkBZRhj0r
 9g/nIi5r/18+8QACFl1q7UokQPpeTOcMFBWIURIHl8C1DSNS04ZDf71EWeUea3uL0LQSvj
 vxtPTnuPQNIBqxW8vo5439CUsx5nU3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-K4Pr2tYPPv2KII3Mft9F_Q-1; Mon, 09 Dec 2019 11:06:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B8A4107ACC5;
 Mon,  9 Dec 2019 16:06:06 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-116.ams2.redhat.com [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE5A646;
 Mon,  9 Dec 2019 16:06:02 +0000 (UTC)
Date: Mon, 9 Dec 2019 17:06:01 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v5 4/4] blockdev: honor bdrv_try_set_aio_context()
 context requirements
Message-ID: <20191209160601.GB6715@linux.fritz.box>
References: <20191128104129.250206-1-slp@redhat.com>
 <20191128104129.250206-5-slp@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191128104129.250206-5-slp@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: K4Pr2tYPPv2KII3Mft9F_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.11.2019 um 11:41 hat Sergio Lopez geschrieben:
> bdrv_try_set_aio_context() requires that the old context is held, and
> the new context is not held. Fix all the occurrences where it's not
> done this way.
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  blockdev.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 62 insertions(+), 10 deletions(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index 152a0f7454..e33abd7fd2 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1535,6 +1535,7 @@ static void external_snapshot_prepare(BlkActionStat=
e *common,
>                               DO_UPCAST(ExternalSnapshotState, common, co=
mmon);
>      TransactionAction *action =3D common->action;
>      AioContext *aio_context;
> +    AioContext *old_context;
>      int ret;
> =20
>      /* 'blockdev-snapshot' and 'blockdev-snapshot-sync' have similar
> @@ -1675,7 +1676,16 @@ static void external_snapshot_prepare(BlkActionSta=
te *common,
>          goto out;
>      }
> =20
> +    /* Honor bdrv_try_set_aio_context() context acquisition requirements=
. */
> +    old_context =3D bdrv_get_aio_context(state->new_bs);
> +    aio_context_release(aio_context);
> +    aio_context_acquire(old_context);
> +
>      ret =3D bdrv_try_set_aio_context(state->new_bs, aio_context, errp);
> +
> +    aio_context_release(old_context);
> +    aio_context_acquire(aio_context);
> +
>      if (ret < 0) {
>          goto out;
>      }
> @@ -1775,11 +1785,13 @@ static void drive_backup_prepare(BlkActionState *=
common, Error **errp)
>      BlockDriverState *target_bs;
>      BlockDriverState *source =3D NULL;
>      AioContext *aio_context;
> +    AioContext *old_context;
>      QDict *options;
>      Error *local_err =3D NULL;
>      int flags;
>      int64_t size;
>      bool set_backing_hd =3D false;
> +    int ret;
> =20
>      assert(common->action->type =3D=3D TRANSACTION_ACTION_KIND_DRIVE_BAC=
KUP);
>      backup =3D common->action->u.drive_backup.data;
> @@ -1868,6 +1880,20 @@ static void drive_backup_prepare(BlkActionState *c=
ommon, Error **errp)
>          goto out;
>      }
> =20
> +    /* Honor bdrv_try_set_aio_context() context acquisition requirements=
. */
> +    old_context =3D bdrv_get_aio_context(target_bs);
> +    aio_context_release(aio_context);
> +    aio_context_acquire(old_context);
> +
> +    ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
> +    aio_context_release(old_context);
> +    aio_context_acquire(aio_context);
> +
> +    if (ret < 0) {
> +        goto out;

I think this needs to be 'goto unref'.

Or in fact, I think you need to hold the AioContext of a bs to
bdrv_unref() it, so maybe 'goto out' is right, but you need to unref
target_bs while you still hold old_context.

> +    }
> +
>      if (set_backing_hd) {
>          bdrv_set_backing_hd(target_bs, source, &local_err);
>          if (local_err) {
> @@ -1947,6 +1973,8 @@ static void blockdev_backup_prepare(BlkActionState =
*common, Error **errp)
>      BlockDriverState *bs;
>      BlockDriverState *target_bs;
>      AioContext *aio_context;
> +    AioContext *old_context;
> +    int ret;
> =20
>      assert(common->action->type =3D=3D TRANSACTION_ACTION_KIND_BLOCKDEV_=
BACKUP);
>      backup =3D common->action->u.blockdev_backup.data;
> @@ -1961,7 +1989,18 @@ static void blockdev_backup_prepare(BlkActionState=
 *common, Error **errp)
>          return;
>      }
> =20
> +    /* Honor bdrv_try_set_aio_context() context acquisition requirements=
. */
>      aio_context =3D bdrv_get_aio_context(bs);
> +    old_context =3D bdrv_get_aio_context(target_bs);
> +    aio_context_acquire(old_context);
> +
> +    ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
> +    if (ret < 0) {
> +        aio_context_release(old_context);
> +        return;
> +    }
> +
> +    aio_context_release(old_context);
>      aio_context_acquire(aio_context);
>      state->bs =3D bs;
> =20
> @@ -3562,7 +3601,6 @@ static BlockJob *do_backup_common(BackupCommon *bac=
kup,
>      BlockJob *job =3D NULL;
>      BdrvDirtyBitmap *bmap =3D NULL;
>      int job_flags =3D JOB_DEFAULT;
> -    int ret;
> =20
>      if (!backup->has_speed) {
>          backup->speed =3D 0;
> @@ -3586,11 +3624,6 @@ static BlockJob *do_backup_common(BackupCommon *ba=
ckup,
>          backup->compress =3D false;
>      }
> =20
> -    ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
> -    if (ret < 0) {
> -        return NULL;
> -    }
> -
>      if ((backup->sync =3D=3D MIRROR_SYNC_MODE_BITMAP) ||
>          (backup->sync =3D=3D MIRROR_SYNC_MODE_INCREMENTAL)) {
>          /* done before desugaring 'incremental' to print the right messa=
ge */
> @@ -3825,6 +3858,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
>      BlockDriverState *bs;
>      BlockDriverState *source, *target_bs;
>      AioContext *aio_context;
> +    AioContext *old_context;
>      BlockMirrorBackingMode backing_mode;
>      Error *local_err =3D NULL;
>      QDict *options =3D NULL;
> @@ -3937,10 +3971,19 @@ void qmp_drive_mirror(DriveMirror *arg, Error **e=
rrp)
>                     (arg->mode =3D=3D NEW_IMAGE_MODE_EXISTING ||
>                      !bdrv_has_zero_init(target_bs)));
> =20
> +
> +    /* Honor bdrv_try_set_aio_context() context acquisition requirements=
. */
> +    old_context =3D bdrv_get_aio_context(target_bs);
> +    aio_context_release(aio_context);
> +    aio_context_acquire(old_context);
> +
>      ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
> +
> +    aio_context_release(old_context);
> +    aio_context_acquire(aio_context);
> +
>      if (ret < 0) {
> -        bdrv_unref(target_bs);
> -        goto out;
> +        goto unref;
>      }

Here you don't forget to unref target_bs, but it has still the same
problem as above that you need to hold old_context during bdrv_unref().

Kevin


