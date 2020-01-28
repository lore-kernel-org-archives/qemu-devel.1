Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DF4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E40F1206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdoKkAqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40F1206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWkM-00066N-4F
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iwWYA-0007mQ-No
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iwWY9-0005Te-15
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:29:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41753
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iwWY8-0005TL-TL
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580239764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qtMvPOxCDMMMo+38UjjeCsodWHOlDJYgdeX8lEHywzg=;
 b=MdoKkAqYUxgN7Brt0EcLG4Vvl2BjP5PGXvmQgYW+A0To8acbtBrwBwn35c3FznU5UzEM6K
 GMkoOvZNPYzAZC/5str0yF0SlQ6gxkKMU7IlWDtDN/warJ2G+JyYOys5gppy+2UX8iKwQi
 a0WUE2PU6O0F0zRxenPFelw1IDp9E3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-rAdKsa55MBSpWqslkmYNJw-1; Tue, 28 Jan 2020 14:29:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C5188010D0;
 Tue, 28 Jan 2020 19:29:20 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D197060BE0;
 Tue, 28 Jan 2020 19:29:15 +0000 (UTC)
Message-ID: <706ed868240fafd8a04c5013d1f71740f63e8656.camel@redhat.com>
Subject: Re: [PATCH v3 04/13] monitor/hmp: move hmp_drive_del and hmp_commit
 to block-hmp-cmds.c
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Date: Tue, 28 Jan 2020 21:29:14 +0200
In-Reply-To: <20200128175147.GW3215@work-vm>
References: <20200127103647.17761-1-mlevitsk@redhat.com>
 <20200127103647.17761-5-mlevitsk@redhat.com>
 <20200128175147.GW3215@work-vm>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: rAdKsa55MBSpWqslkmYNJw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

On Tue, 2020-01-28 at 17:51 +0000, Dr. David Alan Gilbert wrote:
> * Maxim Levitsky (mlevitsk@redhat.com) wrote:
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> (It's easier to compare if you keep the function order the same)

Sorry about that, next time I will do that.
Thanks a lot for the review!
Best regards,
	Maxim Levitsky
> 
> > ---
> >  block/monitor/block-hmp-cmds.c     | 97 +++++++++++++++++++++++++++++-
> >  blockdev.c                         | 95 -----------------------------
> >  include/block/block-hmp-commands.h |  3 +
> >  include/sysemu/blockdev.h          |  4 --
> >  4 files changed, 99 insertions(+), 100 deletions(-)
> > 
> > diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
> > index c65aaa86ea..9614c67e77 100644
> > --- a/block/monitor/block-hmp-cmds.c
> > +++ b/block/monitor/block-hmp-cmds.c
> > @@ -12,6 +12,7 @@
> >  #include "hw/boards.h"
> >  #include "sysemu/block-backend.h"
> >  #include "sysemu/blockdev.h"
> > +#include "qapi/qapi-commands-block.h"
> >  #include "qapi/qmp/qdict.h"
> >  #include "qapi/error.h"
> >  #include "qemu/config-file.h"
> > @@ -21,7 +22,6 @@
> >  #include "block/block_int.h"
> >  #include "block/block-hmp-commands.h"
> >  
> > -
> >  void hmp_drive_add(Monitor *mon, const QDict *qdict)
> >  {
> >      Error *err = NULL;
> > @@ -69,3 +69,98 @@ err:
> >          blk_unref(blk);
> >      }
> >  }
> > +
> > +void hmp_drive_del(Monitor *mon, const QDict *qdict)
> > +{
> > +    const char *id = qdict_get_str(qdict, "id");
> > +    BlockBackend *blk;
> > +    BlockDriverState *bs;
> > +    AioContext *aio_context;
> > +    Error *local_err = NULL;
> > +
> > +    bs = bdrv_find_node(id);
> > +    if (bs) {
> > +        qmp_blockdev_del(id, &local_err);
> > +        if (local_err) {
> > +            error_report_err(local_err);
> > +        }
> > +        return;
> > +    }
> > +
> > +    blk = blk_by_name(id);
> > +    if (!blk) {
> > +        error_report("Device '%s' not found", id);
> > +        return;
> > +    }
> > +
> > +    if (!blk_legacy_dinfo(blk)) {
> > +        error_report("Deleting device added with blockdev-add"
> > +                     " is not supported");
> > +        return;
> > +    }
> > +
> > +    aio_context = blk_get_aio_context(blk);
> > +    aio_context_acquire(aio_context);
> > +
> > +    bs = blk_bs(blk);
> > +    if (bs) {
> > +        if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_DRIVE_DEL, &local_err)) {
> > +            error_report_err(local_err);
> > +            aio_context_release(aio_context);
> > +            return;
> > +        }
> > +
> > +        blk_remove_bs(blk);
> > +    }
> > +
> > +    /* Make the BlockBackend and the attached BlockDriverState anonymous */
> > +    monitor_remove_blk(blk);
> > +
> > +    /* If this BlockBackend has a device attached to it, its refcount will be
> > +     * decremented when the device is removed; otherwise we have to do so here.
> > +     */
> > +    if (blk_get_attached_dev(blk)) {
> > +        /* Further I/O must not pause the guest */
> > +        blk_set_on_error(blk, BLOCKDEV_ON_ERROR_REPORT,
> > +                         BLOCKDEV_ON_ERROR_REPORT);
> > +    } else {
> > +        blk_unref(blk);
> > +    }
> > +
> > +    aio_context_release(aio_context);
> > +}
> > +
> > +void hmp_commit(Monitor *mon, const QDict *qdict)
> > +{
> > +    const char *device = qdict_get_str(qdict, "device");
> > +    BlockBackend *blk;
> > +    int ret;
> > +
> > +    if (!strcmp(device, "all")) {
> > +        ret = blk_commit_all();
> > +    } else {
> > +        BlockDriverState *bs;
> > +        AioContext *aio_context;
> > +
> > +        blk = blk_by_name(device);
> > +        if (!blk) {
> > +            error_report("Device '%s' not found", device);
> > +            return;
> > +        }
> > +        if (!blk_is_available(blk)) {
> > +            error_report("Device '%s' has no medium", device);
> > +            return;
> > +        }
> > +
> > +        bs = blk_bs(blk);
> > +        aio_context = bdrv_get_aio_context(bs);
> > +        aio_context_acquire(aio_context);
> > +
> > +        ret = bdrv_commit(bs);
> > +
> > +        aio_context_release(aio_context);
> > +    }
> > +    if (ret < 0) {
> > +        error_report("'commit' error for '%s': %s", device, strerror(-ret));
> > +    }
> > +}
> > diff --git a/blockdev.c b/blockdev.c
> > index 8e029e9c01..df43e0aaef 100644
> > --- a/blockdev.c
> > +++ b/blockdev.c
> > @@ -1074,41 +1074,6 @@ static BlockBackend *qmp_get_blk(const char *blk_name, const char *qdev_id,
> >      return blk;
> >  }
> >  
> > -void hmp_commit(Monitor *mon, const QDict *qdict)
> > -{
> > -    const char *device = qdict_get_str(qdict, "device");
> > -    BlockBackend *blk;
> > -    int ret;
> > -
> > -    if (!strcmp(device, "all")) {
> > -        ret = blk_commit_all();
> > -    } else {
> > -        BlockDriverState *bs;
> > -        AioContext *aio_context;
> > -
> > -        blk = blk_by_name(device);
> > -        if (!blk) {
> > -            error_report("Device '%s' not found", device);
> > -            return;
> > -        }
> > -        if (!blk_is_available(blk)) {
> > -            error_report("Device '%s' has no medium", device);
> > -            return;
> > -        }
> > -
> > -        bs = blk_bs(blk);
> > -        aio_context = bdrv_get_aio_context(bs);
> > -        aio_context_acquire(aio_context);
> > -
> > -        ret = bdrv_commit(bs);
> > -
> > -        aio_context_release(aio_context);
> > -    }
> > -    if (ret < 0) {
> > -        error_report("'commit' error for '%s': %s", device, strerror(-ret));
> > -    }
> > -}
> > -
> >  static void blockdev_do_action(TransactionAction *action, Error **errp)
> >  {
> >      TransactionActionList list;
> > @@ -3101,66 +3066,6 @@ BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
> >      return ret;
> >  }
> >  
> > -void hmp_drive_del(Monitor *mon, const QDict *qdict)
> > -{
> > -    const char *id = qdict_get_str(qdict, "id");
> > -    BlockBackend *blk;
> > -    BlockDriverState *bs;
> > -    AioContext *aio_context;
> > -    Error *local_err = NULL;
> > -
> > -    bs = bdrv_find_node(id);
> > -    if (bs) {
> > -        qmp_blockdev_del(id, &local_err);
> > -        if (local_err) {
> > -            error_report_err(local_err);
> > -        }
> > -        return;
> > -    }
> > -
> > -    blk = blk_by_name(id);
> > -    if (!blk) {
> > -        error_report("Device '%s' not found", id);
> > -        return;
> > -    }
> > -
> > -    if (!blk_legacy_dinfo(blk)) {
> > -        error_report("Deleting device added with blockdev-add"
> > -                     " is not supported");
> > -        return;
> > -    }
> > -
> > -    aio_context = blk_get_aio_context(blk);
> > -    aio_context_acquire(aio_context);
> > -
> > -    bs = blk_bs(blk);
> > -    if (bs) {
> > -        if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_DRIVE_DEL, &local_err)) {
> > -            error_report_err(local_err);
> > -            aio_context_release(aio_context);
> > -            return;
> > -        }
> > -
> > -        blk_remove_bs(blk);
> > -    }
> > -
> > -    /* Make the BlockBackend and the attached BlockDriverState anonymous */
> > -    monitor_remove_blk(blk);
> > -
> > -    /* If this BlockBackend has a device attached to it, its refcount will be
> > -     * decremented when the device is removed; otherwise we have to do so here.
> > -     */
> > -    if (blk_get_attached_dev(blk)) {
> > -        /* Further I/O must not pause the guest */
> > -        blk_set_on_error(blk, BLOCKDEV_ON_ERROR_REPORT,
> > -                         BLOCKDEV_ON_ERROR_REPORT);
> > -    } else {
> > -        blk_unref(blk);
> > -    }
> > -
> > -    aio_context_release(aio_context);
> > -}
> > -
> >  void qmp_block_resize(bool has_device, const char *device,
> >                        bool has_node_name, const char *node_name,
> >                        int64_t size, Error **errp)
> > diff --git a/include/block/block-hmp-commands.h b/include/block/block-hmp-commands.h
> > index 4f9033a8a6..c5e394c0fc 100644
> > --- a/include/block/block-hmp-commands.h
> > +++ b/include/block/block-hmp-commands.h
> > @@ -5,4 +5,7 @@
> >  
> >  void hmp_drive_add(Monitor *mon, const QDict *qdict);
> >  
> > +void hmp_commit(Monitor *mon, const QDict *qdict);
> > +void hmp_drive_del(Monitor *mon, const QDict *qdict);
> > +
> >  #endif
> > diff --git a/include/sysemu/blockdev.h b/include/sysemu/blockdev.h
> > index d34c4920dc..a86d99b3d8 100644
> > --- a/include/sysemu/blockdev.h
> > +++ b/include/sysemu/blockdev.h
> > @@ -57,8 +57,4 @@ QemuOpts *drive_add(BlockInterfaceType type, int index, const char *file,
> >  DriveInfo *drive_new(QemuOpts *arg, BlockInterfaceType block_default_type,
> >                       Error **errp);
> >  
> > -/* device-hotplug */
> > -
> > -void hmp_commit(Monitor *mon, const QDict *qdict);
> > -void hmp_drive_del(Monitor *mon, const QDict *qdict);
> >  #endif
> > -- 
> > 2.17.2
> > 
> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



