Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD8FC10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B63424654
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GndXJmJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B63424654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBORM-0005q8-QE
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jBOMj-0005qb-93
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jBOMh-0008U3-Hn
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40408
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jBOMh-0008Tl-DI
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583783223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pFkk8n0BXDwSaST7ZRHkndtHn5fZMoTWvv+hP9VC6AA=;
 b=GndXJmJqwvS8bFZvlNc9xzcT2l0bED04nd43O4ITHVi4OEzgWkT9d16oZ12fmesDPKk6cH
 FDGfVb//X1CZoCwGEo5Vw6FWm00EOKiX1Tt5wH9OSpwa7YWRlsjc1ViwaWoJ53mwrHh+5s
 B5RrMKHbMGzgnfH7cJG+h25Pr0fWcSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-bBU_mvjOPWeKZMxSGYzq0w-1; Mon, 09 Mar 2020 15:47:00 -0400
X-MC-Unique: bBU_mvjOPWeKZMxSGYzq0w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E2B7800D48
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 19:46:59 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A42015C54A;
 Mon,  9 Mar 2020 19:46:58 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	mlevitsk@redhat.com,
	thuth@redhat.com
Subject: [PULL 05/12] monitor/hmp: move hmp_drive_mirror and hmp_drive_backup
 to block-hmp-cmds.c
Date: Mon,  9 Mar 2020 19:46:43 +0000
Message-Id: <20200309194650.160552-6-dgilbert@redhat.com>
In-Reply-To: <20200309194650.160552-1-dgilbert@redhat.com>
References: <20200309194650.160552-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

Moved code was added after 2012-01-13, thus under GPLv2+

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200308092440.23564-6-mlevitsk@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  Fixed commit message
---
 block/monitor/block-hmp-cmds.c | 60 ++++++++++++++++++++++++++++++++++
 include/block/block-hmp-cmds.h | 12 +++++--
 include/monitor/hmp.h          |  2 --
 monitor/hmp-cmds.c             | 58 --------------------------------
 4 files changed, 69 insertions(+), 63 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.=
c
index ad727a6b08..d6dd5d97f7 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -37,10 +37,12 @@
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "block/block_int.h"
 #include "block/block-hmp-cmds.h"
=20
@@ -187,3 +189,61 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
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
diff --git a/include/block/block-hmp-cmds.h b/include/block/block-hmp-cmds.=
h
index 30b0f56415..a64b737b3a 100644
--- a/include/block/block-hmp-cmds.h
+++ b/include/block/block-hmp-cmds.h
@@ -3,10 +3,13 @@
  *
  * Copyright (c) 2003-2008 Fabrice Bellard
  * Copyright (c) 2020 Red Hat, Inc.
+ * Copyright IBM, Corp. 2011
  *
- * This work is licensed under the terms of the GNU GPL, version 2.
- * or (at your option) any later version.
- * See the COPYING file in the top-level directory.
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
  */
=20
 #ifndef BLOCK_HMP_COMMANDS_H
@@ -17,4 +20,7 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict);
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
index 6fd7aca500..6254f19842 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1342,64 +1342,6 @@ void hmp_block_resize(Monitor *mon, const QDict *qdi=
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
2.24.1


