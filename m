Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF5BC33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:53:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D64F22522
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbUDWUye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D64F22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwV3M-0004NK-7c
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 12:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iwV1z-0002cF-7J
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iwV1x-00046E-Et
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:52:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35785
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iwV1x-00041J-9y
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580233920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2j1BnoBCJ5Us6rUiTz9wTw3V0z3x0WCpON4ndTAolS0=;
 b=RbUDWUyeDGTehJ690uwwzD9SjjaTrE9p9yA/pZuXnEWNsDf3uvCxEE+ByfSjecWqRmobb4
 Pcl8Ygai7EYykcotndFLuHlZnv2vZzl66oU8E6TAPdrEXJkMVay29RSKpmlw9f9msZ7D8B
 lgQxGtQQIY1p5uY8ab4P+6AEohQG+PA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-Rt9K4qQmNveaTP4FTNZIdg-1; Tue, 28 Jan 2020 12:51:56 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24F361800D41;
 Tue, 28 Jan 2020 17:51:55 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F07A41001DE0;
 Tue, 28 Jan 2020 17:51:49 +0000 (UTC)
Date: Tue, 28 Jan 2020 17:51:47 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 04/13] monitor/hmp: move hmp_drive_del and hmp_commit
 to block-hmp-cmds.c
Message-ID: <20200128175147.GW3215@work-vm>
References: <20200127103647.17761-1-mlevitsk@redhat.com>
 <20200127103647.17761-5-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200127103647.17761-5-mlevitsk@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Rt9K4qQmNveaTP4FTNZIdg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Maxim Levitsky (mlevitsk@redhat.com) wrote:
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

(It's easier to compare if you keep the function order the same)

> ---
>  block/monitor/block-hmp-cmds.c     | 97 +++++++++++++++++++++++++++++-
>  blockdev.c                         | 95 -----------------------------
>  include/block/block-hmp-commands.h |  3 +
>  include/sysemu/blockdev.h          |  4 --
>  4 files changed, 99 insertions(+), 100 deletions(-)
>=20
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmd=
s.c
> index c65aaa86ea..9614c67e77 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -12,6 +12,7 @@
>  #include "hw/boards.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/blockdev.h"
> +#include "qapi/qapi-commands-block.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/error.h"
>  #include "qemu/config-file.h"
> @@ -21,7 +22,6 @@
>  #include "block/block_int.h"
>  #include "block/block-hmp-commands.h"
> =20
> -
>  void hmp_drive_add(Monitor *mon, const QDict *qdict)
>  {
>      Error *err =3D NULL;
> @@ -69,3 +69,98 @@ err:
>          blk_unref(blk);
>      }
>  }
> +
> +void hmp_drive_del(Monitor *mon, const QDict *qdict)
> +{
> +    const char *id =3D qdict_get_str(qdict, "id");
> +    BlockBackend *blk;
> +    BlockDriverState *bs;
> +    AioContext *aio_context;
> +    Error *local_err =3D NULL;
> +
> +    bs =3D bdrv_find_node(id);
> +    if (bs) {
> +        qmp_blockdev_del(id, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +        }
> +        return;
> +    }
> +
> +    blk =3D blk_by_name(id);
> +    if (!blk) {
> +        error_report("Device '%s' not found", id);
> +        return;
> +    }
> +
> +    if (!blk_legacy_dinfo(blk)) {
> +        error_report("Deleting device added with blockdev-add"
> +                     " is not supported");
> +        return;
> +    }
> +
> +    aio_context =3D blk_get_aio_context(blk);
> +    aio_context_acquire(aio_context);
> +
> +    bs =3D blk_bs(blk);
> +    if (bs) {
> +        if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_DRIVE_DEL, &local_err))=
 {
> +            error_report_err(local_err);
> +            aio_context_release(aio_context);
> +            return;
> +        }
> +
> +        blk_remove_bs(blk);
> +    }
> +
> +    /* Make the BlockBackend and the attached BlockDriverState anonymous=
 */
> +    monitor_remove_blk(blk);
> +
> +    /* If this BlockBackend has a device attached to it, its refcount wi=
ll be
> +     * decremented when the device is removed; otherwise we have to do s=
o here.
> +     */
> +    if (blk_get_attached_dev(blk)) {
> +        /* Further I/O must not pause the guest */
> +        blk_set_on_error(blk, BLOCKDEV_ON_ERROR_REPORT,
> +                         BLOCKDEV_ON_ERROR_REPORT);
> +    } else {
> +        blk_unref(blk);
> +    }
> +
> +    aio_context_release(aio_context);
> +}
> +
> +void hmp_commit(Monitor *mon, const QDict *qdict)
> +{
> +    const char *device =3D qdict_get_str(qdict, "device");
> +    BlockBackend *blk;
> +    int ret;
> +
> +    if (!strcmp(device, "all")) {
> +        ret =3D blk_commit_all();
> +    } else {
> +        BlockDriverState *bs;
> +        AioContext *aio_context;
> +
> +        blk =3D blk_by_name(device);
> +        if (!blk) {
> +            error_report("Device '%s' not found", device);
> +            return;
> +        }
> +        if (!blk_is_available(blk)) {
> +            error_report("Device '%s' has no medium", device);
> +            return;
> +        }
> +
> +        bs =3D blk_bs(blk);
> +        aio_context =3D bdrv_get_aio_context(bs);
> +        aio_context_acquire(aio_context);
> +
> +        ret =3D bdrv_commit(bs);
> +
> +        aio_context_release(aio_context);
> +    }
> +    if (ret < 0) {
> +        error_report("'commit' error for '%s': %s", device, strerror(-re=
t));
> +    }
> +}
> diff --git a/blockdev.c b/blockdev.c
> index 8e029e9c01..df43e0aaef 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1074,41 +1074,6 @@ static BlockBackend *qmp_get_blk(const char *blk_n=
ame, const char *qdev_id,
>      return blk;
>  }
> =20
> -void hmp_commit(Monitor *mon, const QDict *qdict)
> -{
> -    const char *device =3D qdict_get_str(qdict, "device");
> -    BlockBackend *blk;
> -    int ret;
> -
> -    if (!strcmp(device, "all")) {
> -        ret =3D blk_commit_all();
> -    } else {
> -        BlockDriverState *bs;
> -        AioContext *aio_context;
> -
> -        blk =3D blk_by_name(device);
> -        if (!blk) {
> -            error_report("Device '%s' not found", device);
> -            return;
> -        }
> -        if (!blk_is_available(blk)) {
> -            error_report("Device '%s' has no medium", device);
> -            return;
> -        }
> -
> -        bs =3D blk_bs(blk);
> -        aio_context =3D bdrv_get_aio_context(bs);
> -        aio_context_acquire(aio_context);
> -
> -        ret =3D bdrv_commit(bs);
> -
> -        aio_context_release(aio_context);
> -    }
> -    if (ret < 0) {
> -        error_report("'commit' error for '%s': %s", device, strerror(-re=
t));
> -    }
> -}
> -
>  static void blockdev_do_action(TransactionAction *action, Error **errp)
>  {
>      TransactionActionList list;
> @@ -3101,66 +3066,6 @@ BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bi=
tmap_sha256(const char *node,
>      return ret;
>  }
> =20
> -void hmp_drive_del(Monitor *mon, const QDict *qdict)
> -{
> -    const char *id =3D qdict_get_str(qdict, "id");
> -    BlockBackend *blk;
> -    BlockDriverState *bs;
> -    AioContext *aio_context;
> -    Error *local_err =3D NULL;
> -
> -    bs =3D bdrv_find_node(id);
> -    if (bs) {
> -        qmp_blockdev_del(id, &local_err);
> -        if (local_err) {
> -            error_report_err(local_err);
> -        }
> -        return;
> -    }
> -
> -    blk =3D blk_by_name(id);
> -    if (!blk) {
> -        error_report("Device '%s' not found", id);
> -        return;
> -    }
> -
> -    if (!blk_legacy_dinfo(blk)) {
> -        error_report("Deleting device added with blockdev-add"
> -                     " is not supported");
> -        return;
> -    }
> -
> -    aio_context =3D blk_get_aio_context(blk);
> -    aio_context_acquire(aio_context);
> -
> -    bs =3D blk_bs(blk);
> -    if (bs) {
> -        if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_DRIVE_DEL, &local_err))=
 {
> -            error_report_err(local_err);
> -            aio_context_release(aio_context);
> -            return;
> -        }
> -
> -        blk_remove_bs(blk);
> -    }
> -
> -    /* Make the BlockBackend and the attached BlockDriverState anonymous=
 */
> -    monitor_remove_blk(blk);
> -
> -    /* If this BlockBackend has a device attached to it, its refcount wi=
ll be
> -     * decremented when the device is removed; otherwise we have to do s=
o here.
> -     */
> -    if (blk_get_attached_dev(blk)) {
> -        /* Further I/O must not pause the guest */
> -        blk_set_on_error(blk, BLOCKDEV_ON_ERROR_REPORT,
> -                         BLOCKDEV_ON_ERROR_REPORT);
> -    } else {
> -        blk_unref(blk);
> -    }
> -
> -    aio_context_release(aio_context);
> -}
> -
>  void qmp_block_resize(bool has_device, const char *device,
>                        bool has_node_name, const char *node_name,
>                        int64_t size, Error **errp)
> diff --git a/include/block/block-hmp-commands.h b/include/block/block-hmp=
-commands.h
> index 4f9033a8a6..c5e394c0fc 100644
> --- a/include/block/block-hmp-commands.h
> +++ b/include/block/block-hmp-commands.h
> @@ -5,4 +5,7 @@
> =20
>  void hmp_drive_add(Monitor *mon, const QDict *qdict);
> =20
> +void hmp_commit(Monitor *mon, const QDict *qdict);
> +void hmp_drive_del(Monitor *mon, const QDict *qdict);
> +
>  #endif
> diff --git a/include/sysemu/blockdev.h b/include/sysemu/blockdev.h
> index d34c4920dc..a86d99b3d8 100644
> --- a/include/sysemu/blockdev.h
> +++ b/include/sysemu/blockdev.h
> @@ -57,8 +57,4 @@ QemuOpts *drive_add(BlockInterfaceType type, int index,=
 const char *file,
>  DriveInfo *drive_new(QemuOpts *arg, BlockInterfaceType block_default_typ=
e,
>                       Error **errp);
> =20
> -/* device-hotplug */
> -
> -void hmp_commit(Monitor *mon, const QDict *qdict);
> -void hmp_drive_del(Monitor *mon, const QDict *qdict);
>  #endif
> --=20
> 2.17.2
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


