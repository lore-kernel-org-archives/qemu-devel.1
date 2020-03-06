Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FBAC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:35:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 013812051A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMm8aH8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013812051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGsS-0003mB-1N
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:35:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZd-0005Dh-Jl
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZU-00083z-7C
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58832
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZS-0007Ur-3b
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TZdfB9uUnkpbgxbQFnOfaUQie/7861t/X8KZlyloYYA=;
 b=KMm8aH8an1Ye9q/bIKxkr4zz5Hk49IdrRqfoCmFNYjJtbHQ9EMrq4dr0VTsODm5ammdE9Y
 uBHXRLZwV/cDiS8tql2uegYhXmSH81oeI0PFV6YKFlkZ2HlS3vM5/evTqhGRqi0GCkHXfD
 24E27Y+6PUjhrrY7t5GkSxW49ugUQxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-PYRYH2DON5a7V2pLGlrl6w-1; Fri, 06 Mar 2020 12:15:18 -0500
X-MC-Unique: PYRYH2DON5a7V2pLGlrl6w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC4C1107ACC7;
 Fri,  6 Mar 2020 17:15:17 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6380A73873;
 Fri,  6 Mar 2020 17:15:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 09/29] block: Move system emulator QMP commands to
 block/qapi-sysemu.c
Date: Fri,  6 Mar 2020 18:14:38 +0100
Message-Id: <20200306171458.1848-10-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These commands make only sense for system emulators and their
implementations call functions that don't exist in tools (e.g. to
resolve qdev IDs). Move them out so that blockdev.c can be linked to
qemu-storage-daemon.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200224143008.13362-4-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qapi-sysemu.c | 590 ++++++++++++++++++++++++++++++++++++++++++++
 blockdev.c          | 559 -----------------------------------------
 block/Makefile.objs |   2 +
 3 files changed, 592 insertions(+), 559 deletions(-)
 create mode 100644 block/qapi-sysemu.c

diff --git a/block/qapi-sysemu.c b/block/qapi-sysemu.c
new file mode 100644
index 0000000000..8498402ad4
--- /dev/null
+++ b/block/qapi-sysemu.c
@@ -0,0 +1,590 @@
+/*
+ * QMP command handlers specific to the system emulators
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ *
+ * This file incorporates work covered by the following copyright and
+ * permission notice:
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+#include "qapi/qapi-commands-block.h"
+#include "qapi/qmp/qdict.h"
+#include "sysemu/block-backend.h"
+#include "sysemu/blockdev.h"
+
+static BlockBackend *qmp_get_blk(const char *blk_name, const char *qdev_id=
,
+                                 Error **errp)
+{
+    BlockBackend *blk;
+
+    if (!blk_name =3D=3D !qdev_id) {
+        error_setg(errp, "Need exactly one of 'device' and 'id'");
+        return NULL;
+    }
+
+    if (qdev_id) {
+        blk =3D blk_by_qdev_id(qdev_id, errp);
+    } else {
+        blk =3D blk_by_name(blk_name);
+        if (blk =3D=3D NULL) {
+            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
+                      "Device '%s' not found", blk_name);
+        }
+    }
+
+    return blk;
+}
+
+/*
+ * Attempt to open the tray of @device.
+ * If @force, ignore its tray lock.
+ * Else, if the tray is locked, don't open it, but ask the guest to open i=
t.
+ * On error, store an error through @errp and return -errno.
+ * If @device does not exist, return -ENODEV.
+ * If it has no removable media, return -ENOTSUP.
+ * If it has no tray, return -ENOSYS.
+ * If the guest was asked to open the tray, return -EINPROGRESS.
+ * Else, return 0.
+ */
+static int do_open_tray(const char *blk_name, const char *qdev_id,
+                        bool force, Error **errp)
+{
+    BlockBackend *blk;
+    const char *device =3D qdev_id ?: blk_name;
+    bool locked;
+
+    blk =3D qmp_get_blk(blk_name, qdev_id, errp);
+    if (!blk) {
+        return -ENODEV;
+    }
+
+    if (!blk_dev_has_removable_media(blk)) {
+        error_setg(errp, "Device '%s' is not removable", device);
+        return -ENOTSUP;
+    }
+
+    if (!blk_dev_has_tray(blk)) {
+        error_setg(errp, "Device '%s' does not have a tray", device);
+        return -ENOSYS;
+    }
+
+    if (blk_dev_is_tray_open(blk)) {
+        return 0;
+    }
+
+    locked =3D blk_dev_is_medium_locked(blk);
+    if (locked) {
+        blk_dev_eject_request(blk, force);
+    }
+
+    if (!locked || force) {
+        blk_dev_change_media_cb(blk, false, &error_abort);
+    }
+
+    if (locked && !force) {
+        error_setg(errp, "Device '%s' is locked and force was not specifie=
d, "
+                   "wait for tray to open and try again", device);
+        return -EINPROGRESS;
+    }
+
+    return 0;
+}
+
+void qmp_blockdev_open_tray(bool has_device, const char *device,
+                            bool has_id, const char *id,
+                            bool has_force, bool force,
+                            Error **errp)
+{
+    Error *local_err =3D NULL;
+    int rc;
+
+    if (!has_force) {
+        force =3D false;
+    }
+    rc =3D do_open_tray(has_device ? device : NULL,
+                      has_id ? id : NULL,
+                      force, &local_err);
+    if (rc && rc !=3D -ENOSYS && rc !=3D -EINPROGRESS) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    error_free(local_err);
+}
+
+void qmp_blockdev_close_tray(bool has_device, const char *device,
+                             bool has_id, const char *id,
+                             Error **errp)
+{
+    BlockBackend *blk;
+    Error *local_err =3D NULL;
+
+    device =3D has_device ? device : NULL;
+    id =3D has_id ? id : NULL;
+
+    blk =3D qmp_get_blk(device, id, errp);
+    if (!blk) {
+        return;
+    }
+
+    if (!blk_dev_has_removable_media(blk)) {
+        error_setg(errp, "Device '%s' is not removable", device ?: id);
+        return;
+    }
+
+    if (!blk_dev_has_tray(blk)) {
+        /* Ignore this command on tray-less devices */
+        return;
+    }
+
+    if (!blk_dev_is_tray_open(blk)) {
+        return;
+    }
+
+    blk_dev_change_media_cb(blk, true, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
+static void blockdev_remove_medium(bool has_device, const char *device,
+                                   bool has_id, const char *id, Error **er=
rp)
+{
+    BlockBackend *blk;
+    BlockDriverState *bs;
+    AioContext *aio_context;
+    bool has_attached_device;
+
+    device =3D has_device ? device : NULL;
+    id =3D has_id ? id : NULL;
+
+    blk =3D qmp_get_blk(device, id, errp);
+    if (!blk) {
+        return;
+    }
+
+    /* For BBs without a device, we can exchange the BDS tree at will */
+    has_attached_device =3D blk_get_attached_dev(blk);
+
+    if (has_attached_device && !blk_dev_has_removable_media(blk)) {
+        error_setg(errp, "Device '%s' is not removable", device ?: id);
+        return;
+    }
+
+    if (has_attached_device && blk_dev_has_tray(blk) &&
+        !blk_dev_is_tray_open(blk))
+    {
+        error_setg(errp, "Tray of device '%s' is not open", device ?: id);
+        return;
+    }
+
+    bs =3D blk_bs(blk);
+    if (!bs) {
+        return;
+    }
+
+    aio_context =3D bdrv_get_aio_context(bs);
+    aio_context_acquire(aio_context);
+
+    if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_EJECT, errp)) {
+        goto out;
+    }
+
+    blk_remove_bs(blk);
+
+    if (!blk_dev_has_tray(blk)) {
+        /* For tray-less devices, blockdev-open-tray is a no-op (or may no=
t be
+         * called at all); therefore, the medium needs to be ejected here.
+         * Do it after blk_remove_bs() so blk_is_inserted(blk) returns the=
 @load
+         * value passed here (i.e. false). */
+        blk_dev_change_media_cb(blk, false, &error_abort);
+    }
+
+out:
+    aio_context_release(aio_context);
+}
+
+void qmp_blockdev_remove_medium(const char *id, Error **errp)
+{
+    blockdev_remove_medium(false, NULL, true, id, errp);
+}
+
+static void qmp_blockdev_insert_anon_medium(BlockBackend *blk,
+                                            BlockDriverState *bs, Error **=
errp)
+{
+    Error *local_err =3D NULL;
+    bool has_device;
+    int ret;
+
+    /* For BBs without a device, we can exchange the BDS tree at will */
+    has_device =3D blk_get_attached_dev(blk);
+
+    if (has_device && !blk_dev_has_removable_media(blk)) {
+        error_setg(errp, "Device is not removable");
+        return;
+    }
+
+    if (has_device && blk_dev_has_tray(blk) && !blk_dev_is_tray_open(blk))=
 {
+        error_setg(errp, "Tray of the device is not open");
+        return;
+    }
+
+    if (blk_bs(blk)) {
+        error_setg(errp, "There already is a medium in the device");
+        return;
+    }
+
+    ret =3D blk_insert_bs(blk, bs, errp);
+    if (ret < 0) {
+        return;
+    }
+
+    if (!blk_dev_has_tray(blk)) {
+        /* For tray-less devices, blockdev-close-tray is a no-op (or may n=
ot be
+         * called at all); therefore, the medium needs to be pushed into t=
he
+         * slot here.
+         * Do it after blk_insert_bs() so blk_is_inserted(blk) returns the=
 @load
+         * value passed here (i.e. true). */
+        blk_dev_change_media_cb(blk, true, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            blk_remove_bs(blk);
+            return;
+        }
+    }
+}
+
+static void blockdev_insert_medium(bool has_device, const char *device,
+                                   bool has_id, const char *id,
+                                   const char *node_name, Error **errp)
+{
+    BlockBackend *blk;
+    BlockDriverState *bs;
+
+    blk =3D qmp_get_blk(has_device ? device : NULL,
+                      has_id ? id : NULL,
+                      errp);
+    if (!blk) {
+        return;
+    }
+
+    bs =3D bdrv_find_node(node_name);
+    if (!bs) {
+        error_setg(errp, "Node '%s' not found", node_name);
+        return;
+    }
+
+    if (bdrv_has_blk(bs)) {
+        error_setg(errp, "Node '%s' is already in use", node_name);
+        return;
+    }
+
+    qmp_blockdev_insert_anon_medium(blk, bs, errp);
+}
+
+void qmp_blockdev_insert_medium(const char *id, const char *node_name,
+                                Error **errp)
+{
+    blockdev_insert_medium(false, NULL, true, id, node_name, errp);
+}
+
+void qmp_blockdev_change_medium(bool has_device, const char *device,
+                                bool has_id, const char *id,
+                                const char *filename,
+                                bool has_format, const char *format,
+                                bool has_read_only,
+                                BlockdevChangeReadOnlyMode read_only,
+                                Error **errp)
+{
+    BlockBackend *blk;
+    BlockDriverState *medium_bs =3D NULL;
+    int bdrv_flags;
+    bool detect_zeroes;
+    int rc;
+    QDict *options =3D NULL;
+    Error *err =3D NULL;
+
+    blk =3D qmp_get_blk(has_device ? device : NULL,
+                      has_id ? id : NULL,
+                      errp);
+    if (!blk) {
+        goto fail;
+    }
+
+    if (blk_bs(blk)) {
+        blk_update_root_state(blk);
+    }
+
+    bdrv_flags =3D blk_get_open_flags_from_root_state(blk);
+    bdrv_flags &=3D ~(BDRV_O_TEMPORARY | BDRV_O_SNAPSHOT | BDRV_O_NO_BACKI=
NG |
+        BDRV_O_PROTOCOL | BDRV_O_AUTO_RDONLY);
+
+    if (!has_read_only) {
+        read_only =3D BLOCKDEV_CHANGE_READ_ONLY_MODE_RETAIN;
+    }
+
+    switch (read_only) {
+    case BLOCKDEV_CHANGE_READ_ONLY_MODE_RETAIN:
+        break;
+
+    case BLOCKDEV_CHANGE_READ_ONLY_MODE_READ_ONLY:
+        bdrv_flags &=3D ~BDRV_O_RDWR;
+        break;
+
+    case BLOCKDEV_CHANGE_READ_ONLY_MODE_READ_WRITE:
+        bdrv_flags |=3D BDRV_O_RDWR;
+        break;
+
+    default:
+        abort();
+    }
+
+    options =3D qdict_new();
+    detect_zeroes =3D blk_get_detect_zeroes_from_root_state(blk);
+    qdict_put_str(options, "detect-zeroes", detect_zeroes ? "on" : "off");
+
+    if (has_format) {
+        qdict_put_str(options, "driver", format);
+    }
+
+    medium_bs =3D bdrv_open(filename, NULL, options, bdrv_flags, errp);
+    if (!medium_bs) {
+        goto fail;
+    }
+
+    rc =3D do_open_tray(has_device ? device : NULL,
+                      has_id ? id : NULL,
+                      false, &err);
+    if (rc && rc !=3D -ENOSYS) {
+        error_propagate(errp, err);
+        goto fail;
+    }
+    error_free(err);
+    err =3D NULL;
+
+    blockdev_remove_medium(has_device, device, has_id, id, &err);
+    if (err) {
+        error_propagate(errp, err);
+        goto fail;
+    }
+
+    qmp_blockdev_insert_anon_medium(blk, medium_bs, &err);
+    if (err) {
+        error_propagate(errp, err);
+        goto fail;
+    }
+
+    qmp_blockdev_close_tray(has_device, device, has_id, id, errp);
+
+fail:
+    /* If the medium has been inserted, the device has its own reference, =
so
+     * ours must be relinquished; and if it has not been inserted successf=
ully,
+     * the reference must be relinquished anyway */
+    bdrv_unref(medium_bs);
+}
+
+void qmp_eject(bool has_device, const char *device,
+               bool has_id, const char *id,
+               bool has_force, bool force, Error **errp)
+{
+    Error *local_err =3D NULL;
+    int rc;
+
+    if (!has_force) {
+        force =3D false;
+    }
+
+    rc =3D do_open_tray(has_device ? device : NULL,
+                      has_id ? id : NULL,
+                      force, &local_err);
+    if (rc && rc !=3D -ENOSYS) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    error_free(local_err);
+
+    blockdev_remove_medium(has_device, device, has_id, id, errp);
+}
+
+/* throttling disk I/O limits */
+void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
+{
+    ThrottleConfig cfg;
+    BlockDriverState *bs;
+    BlockBackend *blk;
+    AioContext *aio_context;
+
+    blk =3D qmp_get_blk(arg->has_device ? arg->device : NULL,
+                      arg->has_id ? arg->id : NULL,
+                      errp);
+    if (!blk) {
+        return;
+    }
+
+    aio_context =3D blk_get_aio_context(blk);
+    aio_context_acquire(aio_context);
+
+    bs =3D blk_bs(blk);
+    if (!bs) {
+        error_setg(errp, "Device has no medium");
+        goto out;
+    }
+
+    throttle_config_init(&cfg);
+    cfg.buckets[THROTTLE_BPS_TOTAL].avg =3D arg->bps;
+    cfg.buckets[THROTTLE_BPS_READ].avg  =3D arg->bps_rd;
+    cfg.buckets[THROTTLE_BPS_WRITE].avg =3D arg->bps_wr;
+
+    cfg.buckets[THROTTLE_OPS_TOTAL].avg =3D arg->iops;
+    cfg.buckets[THROTTLE_OPS_READ].avg  =3D arg->iops_rd;
+    cfg.buckets[THROTTLE_OPS_WRITE].avg =3D arg->iops_wr;
+
+    if (arg->has_bps_max) {
+        cfg.buckets[THROTTLE_BPS_TOTAL].max =3D arg->bps_max;
+    }
+    if (arg->has_bps_rd_max) {
+        cfg.buckets[THROTTLE_BPS_READ].max =3D arg->bps_rd_max;
+    }
+    if (arg->has_bps_wr_max) {
+        cfg.buckets[THROTTLE_BPS_WRITE].max =3D arg->bps_wr_max;
+    }
+    if (arg->has_iops_max) {
+        cfg.buckets[THROTTLE_OPS_TOTAL].max =3D arg->iops_max;
+    }
+    if (arg->has_iops_rd_max) {
+        cfg.buckets[THROTTLE_OPS_READ].max =3D arg->iops_rd_max;
+    }
+    if (arg->has_iops_wr_max) {
+        cfg.buckets[THROTTLE_OPS_WRITE].max =3D arg->iops_wr_max;
+    }
+
+    if (arg->has_bps_max_length) {
+        cfg.buckets[THROTTLE_BPS_TOTAL].burst_length =3D arg->bps_max_leng=
th;
+    }
+    if (arg->has_bps_rd_max_length) {
+        cfg.buckets[THROTTLE_BPS_READ].burst_length =3D arg->bps_rd_max_le=
ngth;
+    }
+    if (arg->has_bps_wr_max_length) {
+        cfg.buckets[THROTTLE_BPS_WRITE].burst_length =3D arg->bps_wr_max_l=
ength;
+    }
+    if (arg->has_iops_max_length) {
+        cfg.buckets[THROTTLE_OPS_TOTAL].burst_length =3D arg->iops_max_len=
gth;
+    }
+    if (arg->has_iops_rd_max_length) {
+        cfg.buckets[THROTTLE_OPS_READ].burst_length =3D arg->iops_rd_max_l=
ength;
+    }
+    if (arg->has_iops_wr_max_length) {
+        cfg.buckets[THROTTLE_OPS_WRITE].burst_length =3D arg->iops_wr_max_=
length;
+    }
+
+    if (arg->has_iops_size) {
+        cfg.op_size =3D arg->iops_size;
+    }
+
+    if (!throttle_is_valid(&cfg, errp)) {
+        goto out;
+    }
+
+    if (throttle_enabled(&cfg)) {
+        /* Enable I/O limits if they're not enabled yet, otherwise
+         * just update the throttling group. */
+        if (!blk_get_public(blk)->throttle_group_member.throttle_state) {
+            blk_io_limits_enable(blk,
+                                 arg->has_group ? arg->group :
+                                 arg->has_device ? arg->device :
+                                 arg->id);
+        } else if (arg->has_group) {
+            blk_io_limits_update_group(blk, arg->group);
+        }
+        /* Set the new throttling configuration */
+        blk_set_io_limits(blk, &cfg);
+    } else if (blk_get_public(blk)->throttle_group_member.throttle_state) =
{
+        /* If all throttling settings are set to 0, disable I/O limits */
+        blk_io_limits_disable(blk);
+    }
+
+out:
+    aio_context_release(aio_context);
+}
+
+void qmp_block_latency_histogram_set(
+    const char *id,
+    bool has_boundaries, uint64List *boundaries,
+    bool has_boundaries_read, uint64List *boundaries_read,
+    bool has_boundaries_write, uint64List *boundaries_write,
+    bool has_boundaries_flush, uint64List *boundaries_flush,
+    Error **errp)
+{
+    BlockBackend *blk =3D qmp_get_blk(NULL, id, errp);
+    BlockAcctStats *stats;
+    int ret;
+
+    if (!blk) {
+        return;
+    }
+
+    stats =3D blk_get_stats(blk);
+
+    if (!has_boundaries && !has_boundaries_read && !has_boundaries_write &=
&
+        !has_boundaries_flush)
+    {
+        block_latency_histograms_clear(stats);
+        return;
+    }
+
+    if (has_boundaries || has_boundaries_read) {
+        ret =3D block_latency_histogram_set(
+            stats, BLOCK_ACCT_READ,
+            has_boundaries_read ? boundaries_read : boundaries);
+        if (ret) {
+            error_setg(errp, "Device '%s' set read boundaries fail", id);
+            return;
+        }
+    }
+
+    if (has_boundaries || has_boundaries_write) {
+        ret =3D block_latency_histogram_set(
+            stats, BLOCK_ACCT_WRITE,
+            has_boundaries_write ? boundaries_write : boundaries);
+        if (ret) {
+            error_setg(errp, "Device '%s' set write boundaries fail", id);
+            return;
+        }
+    }
+
+    if (has_boundaries || has_boundaries_flush) {
+        ret =3D block_latency_histogram_set(
+            stats, BLOCK_ACCT_FLUSH,
+            has_boundaries_flush ? boundaries_flush : boundaries);
+        if (ret) {
+            error_setg(errp, "Device '%s' set flush boundaries fail", id);
+            return;
+        }
+    }
+}
diff --git a/blockdev.c b/blockdev.c
index 011dcfec27..3e44fa766b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -67,14 +67,6 @@
 static QTAILQ_HEAD(, BlockDriverState) monitor_bdrv_states =3D
     QTAILQ_HEAD_INITIALIZER(monitor_bdrv_states);
=20
-static int do_open_tray(const char *blk_name, const char *qdev_id,
-                        bool force, Error **errp);
-static void blockdev_remove_medium(bool has_device, const char *device,
-                                   bool has_id, const char *id, Error **er=
rp);
-static void blockdev_insert_medium(bool has_device, const char *device,
-                                   bool has_id, const char *id,
-                                   const char *node_name, Error **errp);
-
 static const char *const if_name[IF_COUNT] =3D {
     [IF_NONE] =3D "none",
     [IF_IDE] =3D "ide",
@@ -1047,29 +1039,6 @@ static BlockDriverState *qmp_get_root_bs(const char =
*name, Error **errp)
     return bs;
 }
=20
-static BlockBackend *qmp_get_blk(const char *blk_name, const char *qdev_id=
,
-                                 Error **errp)
-{
-    BlockBackend *blk;
-
-    if (!blk_name =3D=3D !qdev_id) {
-        error_setg(errp, "Need exactly one of 'device' and 'id'");
-        return NULL;
-    }
-
-    if (qdev_id) {
-        blk =3D blk_by_qdev_id(qdev_id, errp);
-    } else {
-        blk =3D blk_by_name(blk_name);
-        if (blk =3D=3D NULL) {
-            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
-                      "Device '%s' not found", blk_name);
-        }
-    }
-
-    return blk;
-}
-
 void hmp_commit(Monitor *mon, const QDict *qdict)
 {
     const char *device =3D qdict_get_str(qdict, "device");
@@ -2508,29 +2477,6 @@ exit:
     job_txn_unref(block_job_txn);
 }
=20
-void qmp_eject(bool has_device, const char *device,
-               bool has_id, const char *id,
-               bool has_force, bool force, Error **errp)
-{
-    Error *local_err =3D NULL;
-    int rc;
-
-    if (!has_force) {
-        force =3D false;
-    }
-
-    rc =3D do_open_tray(has_device ? device : NULL,
-                      has_id ? id : NULL,
-                      force, &local_err);
-    if (rc && rc !=3D -ENOSYS) {
-        error_propagate(errp, local_err);
-        return;
-    }
-    error_free(local_err);
-
-    blockdev_remove_medium(has_device, device, has_id, id, errp);
-}
-
 void qmp_block_passwd(bool has_device, const char *device,
                       bool has_node_name, const char *node_name,
                       const char *password, Error **errp)
@@ -2539,455 +2485,6 @@ void qmp_block_passwd(bool has_device, const char *=
device,
                "Setting block passwords directly is no longer supported");
 }
=20
-/*
- * Attempt to open the tray of @device.
- * If @force, ignore its tray lock.
- * Else, if the tray is locked, don't open it, but ask the guest to open i=
t.
- * On error, store an error through @errp and return -errno.
- * If @device does not exist, return -ENODEV.
- * If it has no removable media, return -ENOTSUP.
- * If it has no tray, return -ENOSYS.
- * If the guest was asked to open the tray, return -EINPROGRESS.
- * Else, return 0.
- */
-static int do_open_tray(const char *blk_name, const char *qdev_id,
-                        bool force, Error **errp)
-{
-    BlockBackend *blk;
-    const char *device =3D qdev_id ?: blk_name;
-    bool locked;
-
-    blk =3D qmp_get_blk(blk_name, qdev_id, errp);
-    if (!blk) {
-        return -ENODEV;
-    }
-
-    if (!blk_dev_has_removable_media(blk)) {
-        error_setg(errp, "Device '%s' is not removable", device);
-        return -ENOTSUP;
-    }
-
-    if (!blk_dev_has_tray(blk)) {
-        error_setg(errp, "Device '%s' does not have a tray", device);
-        return -ENOSYS;
-    }
-
-    if (blk_dev_is_tray_open(blk)) {
-        return 0;
-    }
-
-    locked =3D blk_dev_is_medium_locked(blk);
-    if (locked) {
-        blk_dev_eject_request(blk, force);
-    }
-
-    if (!locked || force) {
-        blk_dev_change_media_cb(blk, false, &error_abort);
-    }
-
-    if (locked && !force) {
-        error_setg(errp, "Device '%s' is locked and force was not specifie=
d, "
-                   "wait for tray to open and try again", device);
-        return -EINPROGRESS;
-    }
-
-    return 0;
-}
-
-void qmp_blockdev_open_tray(bool has_device, const char *device,
-                            bool has_id, const char *id,
-                            bool has_force, bool force,
-                            Error **errp)
-{
-    Error *local_err =3D NULL;
-    int rc;
-
-    if (!has_force) {
-        force =3D false;
-    }
-    rc =3D do_open_tray(has_device ? device : NULL,
-                      has_id ? id : NULL,
-                      force, &local_err);
-    if (rc && rc !=3D -ENOSYS && rc !=3D -EINPROGRESS) {
-        error_propagate(errp, local_err);
-        return;
-    }
-    error_free(local_err);
-}
-
-void qmp_blockdev_close_tray(bool has_device, const char *device,
-                             bool has_id, const char *id,
-                             Error **errp)
-{
-    BlockBackend *blk;
-    Error *local_err =3D NULL;
-
-    device =3D has_device ? device : NULL;
-    id =3D has_id ? id : NULL;
-
-    blk =3D qmp_get_blk(device, id, errp);
-    if (!blk) {
-        return;
-    }
-
-    if (!blk_dev_has_removable_media(blk)) {
-        error_setg(errp, "Device '%s' is not removable", device ?: id);
-        return;
-    }
-
-    if (!blk_dev_has_tray(blk)) {
-        /* Ignore this command on tray-less devices */
-        return;
-    }
-
-    if (!blk_dev_is_tray_open(blk)) {
-        return;
-    }
-
-    blk_dev_change_media_cb(blk, true, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-}
-
-static void blockdev_remove_medium(bool has_device, const char *device,
-                                   bool has_id, const char *id, Error **er=
rp)
-{
-    BlockBackend *blk;
-    BlockDriverState *bs;
-    AioContext *aio_context;
-    bool has_attached_device;
-
-    device =3D has_device ? device : NULL;
-    id =3D has_id ? id : NULL;
-
-    blk =3D qmp_get_blk(device, id, errp);
-    if (!blk) {
-        return;
-    }
-
-    /* For BBs without a device, we can exchange the BDS tree at will */
-    has_attached_device =3D blk_get_attached_dev(blk);
-
-    if (has_attached_device && !blk_dev_has_removable_media(blk)) {
-        error_setg(errp, "Device '%s' is not removable", device ?: id);
-        return;
-    }
-
-    if (has_attached_device && blk_dev_has_tray(blk) &&
-        !blk_dev_is_tray_open(blk))
-    {
-        error_setg(errp, "Tray of device '%s' is not open", device ?: id);
-        return;
-    }
-
-    bs =3D blk_bs(blk);
-    if (!bs) {
-        return;
-    }
-
-    aio_context =3D bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
-
-    if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_EJECT, errp)) {
-        goto out;
-    }
-
-    blk_remove_bs(blk);
-
-    if (!blk_dev_has_tray(blk)) {
-        /* For tray-less devices, blockdev-open-tray is a no-op (or may no=
t be
-         * called at all); therefore, the medium needs to be ejected here.
-         * Do it after blk_remove_bs() so blk_is_inserted(blk) returns the=
 @load
-         * value passed here (i.e. false). */
-        blk_dev_change_media_cb(blk, false, &error_abort);
-    }
-
-out:
-    aio_context_release(aio_context);
-}
-
-void qmp_blockdev_remove_medium(const char *id, Error **errp)
-{
-    blockdev_remove_medium(false, NULL, true, id, errp);
-}
-
-static void qmp_blockdev_insert_anon_medium(BlockBackend *blk,
-                                            BlockDriverState *bs, Error **=
errp)
-{
-    Error *local_err =3D NULL;
-    bool has_device;
-    int ret;
-
-    /* For BBs without a device, we can exchange the BDS tree at will */
-    has_device =3D blk_get_attached_dev(blk);
-
-    if (has_device && !blk_dev_has_removable_media(blk)) {
-        error_setg(errp, "Device is not removable");
-        return;
-    }
-
-    if (has_device && blk_dev_has_tray(blk) && !blk_dev_is_tray_open(blk))=
 {
-        error_setg(errp, "Tray of the device is not open");
-        return;
-    }
-
-    if (blk_bs(blk)) {
-        error_setg(errp, "There already is a medium in the device");
-        return;
-    }
-
-    ret =3D blk_insert_bs(blk, bs, errp);
-    if (ret < 0) {
-        return;
-    }
-
-    if (!blk_dev_has_tray(blk)) {
-        /* For tray-less devices, blockdev-close-tray is a no-op (or may n=
ot be
-         * called at all); therefore, the medium needs to be pushed into t=
he
-         * slot here.
-         * Do it after blk_insert_bs() so blk_is_inserted(blk) returns the=
 @load
-         * value passed here (i.e. true). */
-        blk_dev_change_media_cb(blk, true, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            blk_remove_bs(blk);
-            return;
-        }
-    }
-}
-
-static void blockdev_insert_medium(bool has_device, const char *device,
-                                   bool has_id, const char *id,
-                                   const char *node_name, Error **errp)
-{
-    BlockBackend *blk;
-    BlockDriverState *bs;
-
-    blk =3D qmp_get_blk(has_device ? device : NULL,
-                      has_id ? id : NULL,
-                      errp);
-    if (!blk) {
-        return;
-    }
-
-    bs =3D bdrv_find_node(node_name);
-    if (!bs) {
-        error_setg(errp, "Node '%s' not found", node_name);
-        return;
-    }
-
-    if (bdrv_has_blk(bs)) {
-        error_setg(errp, "Node '%s' is already in use", node_name);
-        return;
-    }
-
-    qmp_blockdev_insert_anon_medium(blk, bs, errp);
-}
-
-void qmp_blockdev_insert_medium(const char *id, const char *node_name,
-                                Error **errp)
-{
-    blockdev_insert_medium(false, NULL, true, id, node_name, errp);
-}
-
-void qmp_blockdev_change_medium(bool has_device, const char *device,
-                                bool has_id, const char *id,
-                                const char *filename,
-                                bool has_format, const char *format,
-                                bool has_read_only,
-                                BlockdevChangeReadOnlyMode read_only,
-                                Error **errp)
-{
-    BlockBackend *blk;
-    BlockDriverState *medium_bs =3D NULL;
-    int bdrv_flags;
-    bool detect_zeroes;
-    int rc;
-    QDict *options =3D NULL;
-    Error *err =3D NULL;
-
-    blk =3D qmp_get_blk(has_device ? device : NULL,
-                      has_id ? id : NULL,
-                      errp);
-    if (!blk) {
-        goto fail;
-    }
-
-    if (blk_bs(blk)) {
-        blk_update_root_state(blk);
-    }
-
-    bdrv_flags =3D blk_get_open_flags_from_root_state(blk);
-    bdrv_flags &=3D ~(BDRV_O_TEMPORARY | BDRV_O_SNAPSHOT | BDRV_O_NO_BACKI=
NG |
-        BDRV_O_PROTOCOL | BDRV_O_AUTO_RDONLY);
-
-    if (!has_read_only) {
-        read_only =3D BLOCKDEV_CHANGE_READ_ONLY_MODE_RETAIN;
-    }
-
-    switch (read_only) {
-    case BLOCKDEV_CHANGE_READ_ONLY_MODE_RETAIN:
-        break;
-
-    case BLOCKDEV_CHANGE_READ_ONLY_MODE_READ_ONLY:
-        bdrv_flags &=3D ~BDRV_O_RDWR;
-        break;
-
-    case BLOCKDEV_CHANGE_READ_ONLY_MODE_READ_WRITE:
-        bdrv_flags |=3D BDRV_O_RDWR;
-        break;
-
-    default:
-        abort();
-    }
-
-    options =3D qdict_new();
-    detect_zeroes =3D blk_get_detect_zeroes_from_root_state(blk);
-    qdict_put_str(options, "detect-zeroes", detect_zeroes ? "on" : "off");
-
-    if (has_format) {
-        qdict_put_str(options, "driver", format);
-    }
-
-    medium_bs =3D bdrv_open(filename, NULL, options, bdrv_flags, errp);
-    if (!medium_bs) {
-        goto fail;
-    }
-
-    rc =3D do_open_tray(has_device ? device : NULL,
-                      has_id ? id : NULL,
-                      false, &err);
-    if (rc && rc !=3D -ENOSYS) {
-        error_propagate(errp, err);
-        goto fail;
-    }
-    error_free(err);
-    err =3D NULL;
-
-    blockdev_remove_medium(has_device, device, has_id, id, &err);
-    if (err) {
-        error_propagate(errp, err);
-        goto fail;
-    }
-
-    qmp_blockdev_insert_anon_medium(blk, medium_bs, &err);
-    if (err) {
-        error_propagate(errp, err);
-        goto fail;
-    }
-
-    qmp_blockdev_close_tray(has_device, device, has_id, id, errp);
-
-fail:
-    /* If the medium has been inserted, the device has its own reference, =
so
-     * ours must be relinquished; and if it has not been inserted successf=
ully,
-     * the reference must be relinquished anyway */
-    bdrv_unref(medium_bs);
-}
-
-/* throttling disk I/O limits */
-void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
-{
-    ThrottleConfig cfg;
-    BlockDriverState *bs;
-    BlockBackend *blk;
-    AioContext *aio_context;
-
-    blk =3D qmp_get_blk(arg->has_device ? arg->device : NULL,
-                      arg->has_id ? arg->id : NULL,
-                      errp);
-    if (!blk) {
-        return;
-    }
-
-    aio_context =3D blk_get_aio_context(blk);
-    aio_context_acquire(aio_context);
-
-    bs =3D blk_bs(blk);
-    if (!bs) {
-        error_setg(errp, "Device has no medium");
-        goto out;
-    }
-
-    throttle_config_init(&cfg);
-    cfg.buckets[THROTTLE_BPS_TOTAL].avg =3D arg->bps;
-    cfg.buckets[THROTTLE_BPS_READ].avg  =3D arg->bps_rd;
-    cfg.buckets[THROTTLE_BPS_WRITE].avg =3D arg->bps_wr;
-
-    cfg.buckets[THROTTLE_OPS_TOTAL].avg =3D arg->iops;
-    cfg.buckets[THROTTLE_OPS_READ].avg  =3D arg->iops_rd;
-    cfg.buckets[THROTTLE_OPS_WRITE].avg =3D arg->iops_wr;
-
-    if (arg->has_bps_max) {
-        cfg.buckets[THROTTLE_BPS_TOTAL].max =3D arg->bps_max;
-    }
-    if (arg->has_bps_rd_max) {
-        cfg.buckets[THROTTLE_BPS_READ].max =3D arg->bps_rd_max;
-    }
-    if (arg->has_bps_wr_max) {
-        cfg.buckets[THROTTLE_BPS_WRITE].max =3D arg->bps_wr_max;
-    }
-    if (arg->has_iops_max) {
-        cfg.buckets[THROTTLE_OPS_TOTAL].max =3D arg->iops_max;
-    }
-    if (arg->has_iops_rd_max) {
-        cfg.buckets[THROTTLE_OPS_READ].max =3D arg->iops_rd_max;
-    }
-    if (arg->has_iops_wr_max) {
-        cfg.buckets[THROTTLE_OPS_WRITE].max =3D arg->iops_wr_max;
-    }
-
-    if (arg->has_bps_max_length) {
-        cfg.buckets[THROTTLE_BPS_TOTAL].burst_length =3D arg->bps_max_leng=
th;
-    }
-    if (arg->has_bps_rd_max_length) {
-        cfg.buckets[THROTTLE_BPS_READ].burst_length =3D arg->bps_rd_max_le=
ngth;
-    }
-    if (arg->has_bps_wr_max_length) {
-        cfg.buckets[THROTTLE_BPS_WRITE].burst_length =3D arg->bps_wr_max_l=
ength;
-    }
-    if (arg->has_iops_max_length) {
-        cfg.buckets[THROTTLE_OPS_TOTAL].burst_length =3D arg->iops_max_len=
gth;
-    }
-    if (arg->has_iops_rd_max_length) {
-        cfg.buckets[THROTTLE_OPS_READ].burst_length =3D arg->iops_rd_max_l=
ength;
-    }
-    if (arg->has_iops_wr_max_length) {
-        cfg.buckets[THROTTLE_OPS_WRITE].burst_length =3D arg->iops_wr_max_=
length;
-    }
-
-    if (arg->has_iops_size) {
-        cfg.op_size =3D arg->iops_size;
-    }
-
-    if (!throttle_is_valid(&cfg, errp)) {
-        goto out;
-    }
-
-    if (throttle_enabled(&cfg)) {
-        /* Enable I/O limits if they're not enabled yet, otherwise
-         * just update the throttling group. */
-        if (!blk_get_public(blk)->throttle_group_member.throttle_state) {
-            blk_io_limits_enable(blk,
-                                 arg->has_group ? arg->group :
-                                 arg->has_device ? arg->device :
-                                 arg->id);
-        } else if (arg->has_group) {
-            blk_io_limits_update_group(blk, arg->group);
-        }
-        /* Set the new throttling configuration */
-        blk_set_io_limits(blk, &cfg);
-    } else if (blk_get_public(blk)->throttle_group_member.throttle_state) =
{
-        /* If all throttling settings are set to 0, disable I/O limits */
-        blk_io_limits_disable(blk);
-    }
-
-out:
-    aio_context_release(aio_context);
-}
-
 void qmp_block_dirty_bitmap_add(const char *node, const char *name,
                                 bool has_granularity, uint32_t granularity=
,
                                 bool has_persistent, bool persistent,
@@ -4595,62 +4092,6 @@ void qmp_x_blockdev_set_iothread(const char *node_na=
me, StrOrNull *iothread,
     aio_context_release(old_context);
 }
=20
-void qmp_block_latency_histogram_set(
-    const char *id,
-    bool has_boundaries, uint64List *boundaries,
-    bool has_boundaries_read, uint64List *boundaries_read,
-    bool has_boundaries_write, uint64List *boundaries_write,
-    bool has_boundaries_flush, uint64List *boundaries_flush,
-    Error **errp)
-{
-    BlockBackend *blk =3D qmp_get_blk(NULL, id, errp);
-    BlockAcctStats *stats;
-    int ret;
-
-    if (!blk) {
-        return;
-    }
-
-    stats =3D blk_get_stats(blk);
-
-    if (!has_boundaries && !has_boundaries_read && !has_boundaries_write &=
&
-        !has_boundaries_flush)
-    {
-        block_latency_histograms_clear(stats);
-        return;
-    }
-
-    if (has_boundaries || has_boundaries_read) {
-        ret =3D block_latency_histogram_set(
-            stats, BLOCK_ACCT_READ,
-            has_boundaries_read ? boundaries_read : boundaries);
-        if (ret) {
-            error_setg(errp, "Device '%s' set read boundaries fail", id);
-            return;
-        }
-    }
-
-    if (has_boundaries || has_boundaries_write) {
-        ret =3D block_latency_histogram_set(
-            stats, BLOCK_ACCT_WRITE,
-            has_boundaries_write ? boundaries_write : boundaries);
-        if (ret) {
-            error_setg(errp, "Device '%s' set write boundaries fail", id);
-            return;
-        }
-    }
-
-    if (has_boundaries || has_boundaries_flush) {
-        ret =3D block_latency_histogram_set(
-            stats, BLOCK_ACCT_FLUSH,
-            has_boundaries_flush ? boundaries_flush : boundaries);
-        if (ret) {
-            error_setg(errp, "Device '%s' set flush boundaries fail", id);
-            return;
-        }
-    }
-}
-
 QemuOptsList qemu_common_drive_opts =3D {
     .name =3D "drive",
     .head =3D QTAILQ_HEAD_INITIALIZER(qemu_common_drive_opts.head),
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 3bcb35c81d..e06cf0b284 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -48,6 +48,8 @@ block-obj-y +=3D filter-compress.o
=20
 common-obj-y +=3D stream.o
=20
+common-obj-y +=3D qapi-sysemu.o
+
 nfs.o-libs         :=3D $(LIBNFS_LIBS)
 iscsi.o-cflags     :=3D $(LIBISCSI_CFLAGS)
 iscsi.o-libs       :=3D $(LIBISCSI_LIBS)
--=20
2.20.1


