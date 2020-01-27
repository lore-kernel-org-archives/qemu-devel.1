Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7B0C3F68F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68AE207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5nIrJ/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68AE207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw1qF-0002xp-QS
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 05:42:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iw1la-0002d7-7d
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:37:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iw1lY-0002hK-PL
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:37:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32414
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iw1lY-0002h7-Kp
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:37:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580121432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NDjvXUBukfhRwJQSnKZ8WLKTPhZssMZ7mCFAtCzLico=;
 b=B5nIrJ/v7C5wT7q7YLEtRe+F88Pnc9aH1JLykMux7Hy+GCbZjMbfMvXwYMnTHts64+zsWp
 EMSYaKuSLma6qM5NXDxID1gYf3oxt3yCZ5OpWP/mTpOYZaNj9tn6/xuSLNmerCW5HZT5lp
 WCL2doWRBUdBzs+yWk42viJB1YHWm04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-tVaALd9fO_6sKkCBcS3YPw-1; Mon, 27 Jan 2020 05:37:10 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E2E9107ACC4;
 Mon, 27 Jan 2020 10:37:09 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28C1FF6C1;
 Mon, 27 Jan 2020 10:37:06 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/13] monitor/hmp: move hmp_drive_mirror and
 hmp_drive_backup to block-hmp-cmds.c
Date: Mon, 27 Jan 2020 12:36:39 +0200
Message-Id: <20200127103647.17761-6-mlevitsk@redhat.com>
In-Reply-To: <20200127103647.17761-1-mlevitsk@redhat.com>
References: <20200127103647.17761-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: tVaALd9fO_6sKkCBcS3YPw-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/monitor/block-hmp-cmds.c     | 64 ++++++++++++++++++++++++++++++
 include/block/block-hmp-commands.h |  3 ++
 include/monitor/hmp.h              |  2 -
 monitor/hmp-cmds.c                 | 58 ---------------------------
 4 files changed, 67 insertions(+), 60 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.=
c
index 9614c67e77..ae3890aaab 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -2,6 +2,10 @@
  * Blockdev HMP commands
  *
  * Copyright (c) 2004 Fabrice Bellard
+ * Copyright IBM, Corp. 2011
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2.
  * or (at your option) any later version.
@@ -15,12 +19,14 @@
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
 #include "block/block_int.h"
 #include "block/block-hmp-commands.h"
+#include "monitor/hmp.h"
=20
 void hmp_drive_add(Monitor *mon, const QDict *qdict)
 {
@@ -164,3 +170,61 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
         error_report("'commit' error for '%s': %s", device, strerror(-ret)=
);
     }
 }
+
+void hmp_drive_mirror(Monitor *mon, const QDict *qdict)
+{
+    const char *filename =3D qdict_get_str(qdict, "target");
+    const char *format =3D qdict_get_try_str(qdict, "format");
+    bool reuse =3D qdict_get_try_bool(qdict, "reuse", false);
+    bool full =3D qdict_get_try_bool(qdict, "full", false);
+    Error *err =3D NULL;
+    DriveMirror mirror =3D {
+        .device =3D (char *)qdict_get_str(qdict, "device"),
+        .target =3D (char *)filename,
+        .has_format =3D !!format,
+        .format =3D (char *)format,
+        .sync =3D full ? MIRROR_SYNC_MODE_FULL : MIRROR_SYNC_MODE_TOP,
+        .has_mode =3D true,
+        .mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABSOLUT=
E_PATHS,
+        .unmap =3D true,
+    };
+
+    if (!filename) {
+        error_setg(&err, QERR_MISSING_PARAMETER, "target");
+        hmp_handle_error(mon, err);
+        return;
+    }
+    qmp_drive_mirror(&mirror, &err);
+    hmp_handle_error(mon, err);
+}
+
+void hmp_drive_backup(Monitor *mon, const QDict *qdict)
+{
+    const char *device =3D qdict_get_str(qdict, "device");
+    const char *filename =3D qdict_get_str(qdict, "target");
+    const char *format =3D qdict_get_try_str(qdict, "format");
+    bool reuse =3D qdict_get_try_bool(qdict, "reuse", false);
+    bool full =3D qdict_get_try_bool(qdict, "full", false);
+    bool compress =3D qdict_get_try_bool(qdict, "compress", false);
+    Error *err =3D NULL;
+    DriveBackup backup =3D {
+        .device =3D (char *)device,
+        .target =3D (char *)filename,
+        .has_format =3D !!format,
+        .format =3D (char *)format,
+        .sync =3D full ? MIRROR_SYNC_MODE_FULL : MIRROR_SYNC_MODE_TOP,
+        .has_mode =3D true,
+        .mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABSOLUT=
E_PATHS,
+        .has_compress =3D !!compress,
+        .compress =3D compress,
+    };
+
+    if (!filename) {
+        error_setg(&err, QERR_MISSING_PARAMETER, "target");
+        hmp_handle_error(mon, err);
+        return;
+    }
+
+    qmp_drive_backup(&backup, &err);
+    hmp_handle_error(mon, err);
+}
diff --git a/include/block/block-hmp-commands.h b/include/block/block-hmp-c=
ommands.h
index c5e394c0fc..fcaf753118 100644
--- a/include/block/block-hmp-commands.h
+++ b/include/block/block-hmp-commands.h
@@ -8,4 +8,7 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict);
 void hmp_commit(Monitor *mon, const QDict *qdict);
 void hmp_drive_del(Monitor *mon, const QDict *qdict);
=20
+void hmp_drive_mirror(Monitor *mon, const QDict *qdict);
+void hmp_drive_backup(Monitor *mon, const QDict *qdict);
+
 #endif
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 3d329853b2..c1b363ee57 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -64,8 +64,6 @@ void hmp_block_resize(Monitor *mon, const QDict *qdict);
 void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict);
 void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict);
 void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qdict)=
;
-void hmp_drive_mirror(Monitor *mon, const QDict *qdict);
-void hmp_drive_backup(Monitor *mon, const QDict *qdict);
 void hmp_loadvm(Monitor *mon, const QDict *qdict);
 void hmp_savevm(Monitor *mon, const QDict *qdict);
 void hmp_delvm(Monitor *mon, const QDict *qdict);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index d0e0af893a..a70bcb1d16 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1337,64 +1337,6 @@ void hmp_block_resize(Monitor *mon, const QDict *qdi=
ct)
     hmp_handle_error(mon, err);
 }
=20
-void hmp_drive_mirror(Monitor *mon, const QDict *qdict)
-{
-    const char *filename =3D qdict_get_str(qdict, "target");
-    const char *format =3D qdict_get_try_str(qdict, "format");
-    bool reuse =3D qdict_get_try_bool(qdict, "reuse", false);
-    bool full =3D qdict_get_try_bool(qdict, "full", false);
-    Error *err =3D NULL;
-    DriveMirror mirror =3D {
-        .device =3D (char *)qdict_get_str(qdict, "device"),
-        .target =3D (char *)filename,
-        .has_format =3D !!format,
-        .format =3D (char *)format,
-        .sync =3D full ? MIRROR_SYNC_MODE_FULL : MIRROR_SYNC_MODE_TOP,
-        .has_mode =3D true,
-        .mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABSOLUT=
E_PATHS,
-        .unmap =3D true,
-    };
-
-    if (!filename) {
-        error_setg(&err, QERR_MISSING_PARAMETER, "target");
-        hmp_handle_error(mon, err);
-        return;
-    }
-    qmp_drive_mirror(&mirror, &err);
-    hmp_handle_error(mon, err);
-}
-
-void hmp_drive_backup(Monitor *mon, const QDict *qdict)
-{
-    const char *device =3D qdict_get_str(qdict, "device");
-    const char *filename =3D qdict_get_str(qdict, "target");
-    const char *format =3D qdict_get_try_str(qdict, "format");
-    bool reuse =3D qdict_get_try_bool(qdict, "reuse", false);
-    bool full =3D qdict_get_try_bool(qdict, "full", false);
-    bool compress =3D qdict_get_try_bool(qdict, "compress", false);
-    Error *err =3D NULL;
-    DriveBackup backup =3D {
-        .device =3D (char *)device,
-        .target =3D (char *)filename,
-        .has_format =3D !!format,
-        .format =3D (char *)format,
-        .sync =3D full ? MIRROR_SYNC_MODE_FULL : MIRROR_SYNC_MODE_TOP,
-        .has_mode =3D true,
-        .mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABSOLUT=
E_PATHS,
-        .has_compress =3D !!compress,
-        .compress =3D compress,
-    };
-
-    if (!filename) {
-        error_setg(&err, QERR_MISSING_PARAMETER, "target");
-        hmp_handle_error(mon, err);
-        return;
-    }
-
-    qmp_drive_backup(&backup, &err);
-    hmp_handle_error(mon, err);
-}
-
 void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict)
 {
     const char *device =3D qdict_get_str(qdict, "device");
--=20
2.17.2


