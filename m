Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184EDC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4836206D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTphY3z9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4836206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix95X-0003tM-WF
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 07:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1ix92g-0006Ml-QA
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1ix92e-00055x-95
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:35:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59251
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1ix92e-000552-4t
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580387727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UvYNkohCd3m/eEBdExljAj3+OmHolEEu7gFb5aHvbsY=;
 b=BTphY3z9cPEDwrSe2mOd9Rc9QYlaNxVgrzn/ja1XO8ZrcJyWlkeg038vICfYnQJhzjhB7M
 ph1/OIpKFAov1cBJAuJ0C1HzihZKDzhlqXHNigtTrbfYkPjuxPAAspKQaOYDQUdWYpGojO
 T5IL03drBT4/hQ3hdDF9sTI3Bs9xy1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-0OwxYeHcMX2o8Zk4U0s7fA-1; Thu, 30 Jan 2020 07:35:23 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAFCD801E67;
 Thu, 30 Jan 2020 12:35:22 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA697166A9;
 Thu, 30 Jan 2020 12:35:20 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/11] monitor/hmp: move remaining hmp_block* functions to
 block-hmp-cmds.c
Date: Thu, 30 Jan 2020 14:34:46 +0200
Message-Id: <20200130123448.21093-10-mlevitsk@redhat.com>
In-Reply-To: <20200130123448.21093-1-mlevitsk@redhat.com>
References: <20200130123448.21093-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 0OwxYeHcMX2o8Zk4U0s7fA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 140 +++++++++++++++++++++++++++++++++
 include/block/block-hmp-cmds.h |   9 +++
 include/monitor/hmp.h          |   6 --
 monitor/hmp-cmds.c             | 137 --------------------------------
 4 files changed, 149 insertions(+), 143 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.=
c
index d72e2164fe..15bc565527 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -50,6 +50,7 @@
 #include "block/nbd.h"
 #include "block/block_int.h"
 #include "block/block-hmp-cmds.h"
+#include "qemu-io.h"
=20
 void hmp_drive_add(Monitor *mon, const QDict *qdict)
 {
@@ -440,3 +441,142 @@ void hmp_nbd_server_stop(Monitor *mon, const QDict *q=
dict)
     qmp_nbd_server_stop(&err);
     hmp_handle_error(mon, err);
 }
+
+void hmp_block_resize(Monitor *mon, const QDict *qdict)
+{
+    const char *device =3D qdict_get_str(qdict, "device");
+    int64_t size =3D qdict_get_int(qdict, "size");
+    Error *err =3D NULL;
+
+    qmp_block_resize(true, device, false, NULL, size, &err);
+    hmp_handle_error(mon, err);
+}
+
+void hmp_block_stream(Monitor *mon, const QDict *qdict)
+{
+    Error *error =3D NULL;
+    const char *device =3D qdict_get_str(qdict, "device");
+    const char *base =3D qdict_get_try_str(qdict, "base");
+    int64_t speed =3D qdict_get_try_int(qdict, "speed", 0);
+
+    qmp_block_stream(true, device, device, base !=3D NULL, base, false, NU=
LL,
+                     false, NULL, qdict_haskey(qdict, "speed"), speed, tru=
e,
+                     BLOCKDEV_ON_ERROR_REPORT, false, false, false, false,
+                     &error);
+
+    hmp_handle_error(mon, error);
+}
+
+void hmp_block_passwd(Monitor *mon, const QDict *qdict)
+{
+    const char *device =3D qdict_get_str(qdict, "device");
+    const char *password =3D qdict_get_str(qdict, "password");
+    Error *err =3D NULL;
+
+    qmp_block_passwd(true, device, false, NULL, password, &err);
+    hmp_handle_error(mon, err);
+}
+
+void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
+{
+    Error *err =3D NULL;
+    char *device =3D (char *) qdict_get_str(qdict, "device");
+    BlockIOThrottle throttle =3D {
+        .bps =3D qdict_get_int(qdict, "bps"),
+        .bps_rd =3D qdict_get_int(qdict, "bps_rd"),
+        .bps_wr =3D qdict_get_int(qdict, "bps_wr"),
+        .iops =3D qdict_get_int(qdict, "iops"),
+        .iops_rd =3D qdict_get_int(qdict, "iops_rd"),
+        .iops_wr =3D qdict_get_int(qdict, "iops_wr"),
+    };
+
+    /*
+     * qmp_block_set_io_throttle has separate parameters for the
+     * (deprecated) block device name and the qdev ID but the HMP
+     * version has only one, so we must decide which one to pass.
+     */
+    if (blk_by_name(device)) {
+        throttle.has_device =3D true;
+        throttle.device =3D device;
+    } else {
+        throttle.has_id =3D true;
+        throttle.id =3D device;
+    }
+
+    qmp_block_set_io_throttle(&throttle, &err);
+    hmp_handle_error(mon, err);
+}
+
+void hmp_eject(Monitor *mon, const QDict *qdict)
+{
+    bool force =3D qdict_get_try_bool(qdict, "force", false);
+    const char *device =3D qdict_get_str(qdict, "device");
+    Error *err =3D NULL;
+
+    qmp_eject(true, device, false, NULL, true, force, &err);
+    hmp_handle_error(mon, err);
+}
+
+void hmp_qemu_io(Monitor *mon, const QDict *qdict)
+{
+    BlockBackend *blk;
+    BlockBackend *local_blk =3D NULL;
+    bool qdev =3D qdict_get_try_bool(qdict, "qdev", false);
+    const char *device =3D qdict_get_str(qdict, "device");
+    const char *command =3D qdict_get_str(qdict, "command");
+    Error *err =3D NULL;
+    int ret;
+
+    if (qdev) {
+        blk =3D blk_by_qdev_id(device, &err);
+        if (!blk) {
+            goto fail;
+        }
+    } else {
+        blk =3D blk_by_name(device);
+        if (!blk) {
+            BlockDriverState *bs =3D bdrv_lookup_bs(NULL, device, &err);
+            if (bs) {
+                blk =3D local_blk =3D blk_new(bdrv_get_aio_context(bs),
+                                          0, BLK_PERM_ALL);
+                ret =3D blk_insert_bs(blk, bs, &err);
+                if (ret < 0) {
+                    goto fail;
+                }
+            } else {
+                goto fail;
+            }
+        }
+    }
+
+    /*
+     * Notably absent: Proper permission management. This is sad, but it s=
eems
+     * almost impossible to achieve without changing the semantics and the=
reby
+     * limiting the use cases of the qemu-io HMP command.
+     *
+     * In an ideal world we would unconditionally create a new BlockBacken=
d for
+     * qemuio_command(), but we have commands like 'reopen' and want them =
to
+     * take effect on the exact BlockBackend whose name the user passed in=
stead
+     * of just on a temporary copy of it.
+     *
+     * Another problem is that deleting the temporary BlockBackend involve=
s
+     * draining all requests on it first, but some qemu-iotests cases want=
 to
+     * issue multiple aio_read/write requests and expect them to complete =
in
+     * the background while the monitor has already returned.
+     *
+     * This is also what prevents us from saving the original permissions =
and
+     * restoring them later: We can't revoke permissions until all request=
s
+     * have completed, and we don't know when that is nor can we really le=
t
+     * anything else run before we have revoken them to avoid race conditi=
ons.
+     *
+     * What happens now is that command() in qemu-io-cmds.c can extend the
+     * permissions if necessary for the qemu-io command. And they simply s=
tay
+     * extended, possibly resulting in a read-only guest device keeping wr=
ite
+     * permissions. Ugly, but it appears to be the lesser evil.
+     */
+    qemuio_command(blk, command);
+
+fail:
+    blk_unref(local_blk);
+    hmp_handle_error(mon, err);
+}
diff --git a/include/block/block-hmp-cmds.h b/include/block/block-hmp-cmds.=
h
index 50ff802598..c2d18fba06 100644
--- a/include/block/block-hmp-cmds.h
+++ b/include/block/block-hmp-cmds.h
@@ -38,4 +38,13 @@ void hmp_nbd_server_add(Monitor *mon, const QDict *qdict=
);
 void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict);
 void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict);
=20
+void hmp_block_resize(Monitor *mon, const QDict *qdict);
+void hmp_block_stream(Monitor *mon, const QDict *qdict);
+void hmp_block_passwd(Monitor *mon, const QDict *qdict);
+void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict);
+void hmp_eject(Monitor *mon, const QDict *qdict);
+
+void hmp_qemu_io(Monitor *mon, const QDict *qdict);
+
+
 #endif
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 736a969131..47a7cad734 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -58,9 +58,7 @@ void hmp_cont(Monitor *mon, const QDict *qdict);
 void hmp_system_wakeup(Monitor *mon, const QDict *qdict);
 void hmp_nmi(Monitor *mon, const QDict *qdict);
 void hmp_set_link(Monitor *mon, const QDict *qdict);
-void hmp_block_passwd(Monitor *mon, const QDict *qdict);
 void hmp_balloon(Monitor *mon, const QDict *qdict);
-void hmp_block_resize(Monitor *mon, const QDict *qdict);
 void hmp_loadvm(Monitor *mon, const QDict *qdict);
 void hmp_savevm(Monitor *mon, const QDict *qdict);
 void hmp_delvm(Monitor *mon, const QDict *qdict);
@@ -80,10 +78,7 @@ void hmp_migrate_start_postcopy(Monitor *mon, const QDic=
t *qdict);
 void hmp_x_colo_lost_heartbeat(Monitor *mon, const QDict *qdict);
 void hmp_set_password(Monitor *mon, const QDict *qdict);
 void hmp_expire_password(Monitor *mon, const QDict *qdict);
-void hmp_eject(Monitor *mon, const QDict *qdict);
 void hmp_change(Monitor *mon, const QDict *qdict);
-void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict);
-void hmp_block_stream(Monitor *mon, const QDict *qdict);
 void hmp_migrate(Monitor *mon, const QDict *qdict);
 void hmp_device_add(Monitor *mon, const QDict *qdict);
 void hmp_device_del(Monitor *mon, const QDict *qdict);
@@ -98,7 +93,6 @@ void hmp_chardev_add(Monitor *mon, const QDict *qdict);
 void hmp_chardev_change(Monitor *mon, const QDict *qdict);
 void hmp_chardev_remove(Monitor *mon, const QDict *qdict);
 void hmp_chardev_send_break(Monitor *mon, const QDict *qdict);
-void hmp_qemu_io(Monitor *mon, const QDict *qdict);
 void hmp_cpu_add(Monitor *mon, const QDict *qdict);
 void hmp_object_add(Monitor *mon, const QDict *qdict);
 void hmp_object_del(Monitor *mon, const QDict *qdict);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 67d2ca8a4c..c224e0f338 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -46,7 +46,6 @@
 #include "qom/object_interfaces.h"
 #include "ui/console.h"
 #include "block/qapi.h"
-#include "qemu-io.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "exec/ramlist.h"
@@ -1307,16 +1306,6 @@ void hmp_set_link(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
=20
-void hmp_block_passwd(Monitor *mon, const QDict *qdict)
-{
-    const char *device =3D qdict_get_str(qdict, "device");
-    const char *password =3D qdict_get_str(qdict, "password");
-    Error *err =3D NULL;
-
-    qmp_block_passwd(true, device, false, NULL, password, &err);
-    hmp_handle_error(mon, err);
-}
-
 void hmp_balloon(Monitor *mon, const QDict *qdict)
 {
     int64_t value =3D qdict_get_int(qdict, "value");
@@ -1326,16 +1315,6 @@ void hmp_balloon(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
=20
-void hmp_block_resize(Monitor *mon, const QDict *qdict)
-{
-    const char *device =3D qdict_get_str(qdict, "device");
-    int64_t size =3D qdict_get_int(qdict, "size");
-    Error *err =3D NULL;
-
-    qmp_block_resize(true, device, false, NULL, size, &err);
-    hmp_handle_error(mon, err);
-}
-
 void hmp_loadvm(Monitor *mon, const QDict *qdict)
 {
     int saved_vm_running  =3D runstate_is_running();
@@ -1818,15 +1797,6 @@ void hmp_expire_password(Monitor *mon, const QDict *=
qdict)
     hmp_handle_error(mon, err);
 }
=20
-void hmp_eject(Monitor *mon, const QDict *qdict)
-{
-    bool force =3D qdict_get_try_bool(qdict, "force", false);
-    const char *device =3D qdict_get_str(qdict, "device");
-    Error *err =3D NULL;
-
-    qmp_eject(true, device, false, NULL, true, force, &err);
-    hmp_handle_error(mon, err);
-}
=20
 #ifdef CONFIG_VNC
 static void hmp_change_read_arg(void *opaque, const char *password,
@@ -1884,49 +1854,6 @@ void hmp_change(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
=20
-void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
-{
-    Error *err =3D NULL;
-    char *device =3D (char *) qdict_get_str(qdict, "device");
-    BlockIOThrottle throttle =3D {
-        .bps =3D qdict_get_int(qdict, "bps"),
-        .bps_rd =3D qdict_get_int(qdict, "bps_rd"),
-        .bps_wr =3D qdict_get_int(qdict, "bps_wr"),
-        .iops =3D qdict_get_int(qdict, "iops"),
-        .iops_rd =3D qdict_get_int(qdict, "iops_rd"),
-        .iops_wr =3D qdict_get_int(qdict, "iops_wr"),
-    };
-
-    /* qmp_block_set_io_throttle has separate parameters for the
-     * (deprecated) block device name and the qdev ID but the HMP
-     * version has only one, so we must decide which one to pass. */
-    if (blk_by_name(device)) {
-        throttle.has_device =3D true;
-        throttle.device =3D device;
-    } else {
-        throttle.has_id =3D true;
-        throttle.id =3D device;
-    }
-
-    qmp_block_set_io_throttle(&throttle, &err);
-    hmp_handle_error(mon, err);
-}
-
-void hmp_block_stream(Monitor *mon, const QDict *qdict)
-{
-    Error *error =3D NULL;
-    const char *device =3D qdict_get_str(qdict, "device");
-    const char *base =3D qdict_get_try_str(qdict, "base");
-    int64_t speed =3D qdict_get_try_int(qdict, "speed", 0);
-
-    qmp_block_stream(true, device, device, base !=3D NULL, base, false, NU=
LL,
-                     false, NULL, qdict_haskey(qdict, "speed"), speed, tru=
e,
-                     BLOCKDEV_ON_ERROR_REPORT, false, false, false, false,
-                     &error);
-
-    hmp_handle_error(mon, error);
-}
-
 typedef struct HMPMigrationStatus
 {
     QEMUTimer *timer;
@@ -2219,70 +2146,6 @@ void hmp_chardev_send_break(Monitor *mon, const QDic=
t *qdict)
     hmp_handle_error(mon, local_err);
 }
=20
-void hmp_qemu_io(Monitor *mon, const QDict *qdict)
-{
-    BlockBackend *blk;
-    BlockBackend *local_blk =3D NULL;
-    bool qdev =3D qdict_get_try_bool(qdict, "qdev", false);
-    const char* device =3D qdict_get_str(qdict, "device");
-    const char* command =3D qdict_get_str(qdict, "command");
-    Error *err =3D NULL;
-    int ret;
-
-    if (qdev) {
-        blk =3D blk_by_qdev_id(device, &err);
-        if (!blk) {
-            goto fail;
-        }
-    } else {
-        blk =3D blk_by_name(device);
-        if (!blk) {
-            BlockDriverState *bs =3D bdrv_lookup_bs(NULL, device, &err);
-            if (bs) {
-                blk =3D local_blk =3D blk_new(bdrv_get_aio_context(bs),
-                                          0, BLK_PERM_ALL);
-                ret =3D blk_insert_bs(blk, bs, &err);
-                if (ret < 0) {
-                    goto fail;
-                }
-            } else {
-                goto fail;
-            }
-        }
-    }
-
-    /*
-     * Notably absent: Proper permission management. This is sad, but it s=
eems
-     * almost impossible to achieve without changing the semantics and the=
reby
-     * limiting the use cases of the qemu-io HMP command.
-     *
-     * In an ideal world we would unconditionally create a new BlockBacken=
d for
-     * qemuio_command(), but we have commands like 'reopen' and want them =
to
-     * take effect on the exact BlockBackend whose name the user passed in=
stead
-     * of just on a temporary copy of it.
-     *
-     * Another problem is that deleting the temporary BlockBackend involve=
s
-     * draining all requests on it first, but some qemu-iotests cases want=
 to
-     * issue multiple aio_read/write requests and expect them to complete =
in
-     * the background while the monitor has already returned.
-     *
-     * This is also what prevents us from saving the original permissions =
and
-     * restoring them later: We can't revoke permissions until all request=
s
-     * have completed, and we don't know when that is nor can we really le=
t
-     * anything else run before we have revoken them to avoid race conditi=
ons.
-     *
-     * What happens now is that command() in qemu-io-cmds.c can extend the
-     * permissions if necessary for the qemu-io command. And they simply s=
tay
-     * extended, possibly resulting in a read-only guest device keeping wr=
ite
-     * permissions. Ugly, but it appears to be the lesser evil.
-     */
-    qemuio_command(blk, command);
-
-fail:
-    blk_unref(local_blk);
-    hmp_handle_error(mon, err);
-}
-
 void hmp_object_del(Monitor *mon, const QDict *qdict)
 {
     const char *id =3D qdict_get_str(qdict, "id");
--=20
2.17.2


