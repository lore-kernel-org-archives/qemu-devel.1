Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E04C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F5A20714
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UED3nk1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F5A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYCoe-0007uE-1V
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 12:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iYC6d-0005sI-9P
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iYC6b-00048c-SU
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:27 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34171
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iYC6b-00048B-OR
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574441304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bFc4vWFbcdoKHeLCl5y883Lkv2xRbfXZYzJqUEuvLD0=;
 b=UED3nk1/aL6WYmHPYFLjMhr5I/jyIQgPX8/sK9pilwAApx8I+Hf5U/5731gjCnZNOcBUGN
 bb6TG5k/jNxL1FjgKUCitwYIbZ8Z+FGyIUA7h4Ul5xPk77H/LEUhl0nngyESAIqmQjufK0
 V1OQ5bAW3+Sj1/uejppRBYsypNctppQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-nCdsm-R8OZihECmy2VzCEw-1; Fri, 22 Nov 2019 11:48:21 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21606107ACC4;
 Fri, 22 Nov 2019 16:48:20 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A5D466094;
 Fri, 22 Nov 2019 16:48:18 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/9] monitor/hmp: move hmp_drive_mirror and
 hmp_drive_backup to block-hmp-cmds.c
Date: Fri, 22 Nov 2019 18:48:02 +0200
Message-Id: <20191122164807.27938-5-mlevitsk@redhat.com>
In-Reply-To: <20191122164807.27938-1-mlevitsk@redhat.com>
References: <20191122164807.27938-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: nCdsm-R8OZihECmy2VzCEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 61 ++++++++++++++++++++++++++++++++++
 monitor/hmp-cmds.c             | 58 --------------------------------
 2 files changed, 61 insertions(+), 58 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.=
c
index 8884618238..5ae899a324 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -34,6 +34,8 @@
 #include "monitor/monitor.h"
 #include "block/block_int.h"
 #include "qapi/qapi-commands-block.h"
+#include "qapi/qmp/qerror.h"
+#include "monitor/hmp.h"
=20
 void hmp_drive_add(Monitor *mon, const QDict *qdict)
 {
@@ -177,3 +179,62 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
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
+        hmp_handle_error(mon, &err);
+        return;
+    }
+    qmp_drive_mirror(&mirror, &err);
+    hmp_handle_error(mon, &err);
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
+        hmp_handle_error(mon, &err);
+        return;
+    }
+
+    qmp_drive_backup(&backup, &err);
+    hmp_handle_error(mon, &err);
+}
+
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index b2551c16d1..aa94a15d74 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1338,64 +1338,6 @@ void hmp_block_resize(Monitor *mon, const QDict *qdi=
ct)
     hmp_handle_error(mon, &err);
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
-        hmp_handle_error(mon, &err);
-        return;
-    }
-    qmp_drive_mirror(&mirror, &err);
-    hmp_handle_error(mon, &err);
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
-        hmp_handle_error(mon, &err);
-        return;
-    }
-
-    qmp_drive_backup(&backup, &err);
-    hmp_handle_error(mon, &err);
-}
-
 void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict)
 {
     const char *device =3D qdict_get_str(qdict, "device");
--=20
2.17.2


