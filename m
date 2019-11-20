Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF339C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 19:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3961E2068D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 19:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/dPVPli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3961E2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXVIR-0003zW-0u
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 14:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iXVC7-0006rC-N9
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iXVC1-0002Po-Ab
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:59:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42417
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iXVC1-0002PT-6L
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574276348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2jPXd9RRuJ1QAZuZDD2p3oh3JNFMusAC7ISScYXRgdE=;
 b=F/dPVPlirXVPydZeZVnoe51z481HvTPBObaEXPsZR2mdOdyD1SFEm0Pju/CHX6KezeXpCd
 KXCSVi7p0Er7rn0v79BpAGP+z/ZoSdfeMop/T6o+HNm04wvk3mE/CSSNfHwEEBLewtvgo1
 XHnHd05SGJcibMYWtXcQI6nlnFD7Xb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-E6VRTA63P0GY95fW83lAjg-1; Wed, 20 Nov 2019 13:59:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B864800054;
 Wed, 20 Nov 2019 18:59:03 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 471D863647;
 Wed, 20 Nov 2019 18:59:01 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/9] monitor: move hmp_drive_mirror and hmp_drive_backup to
 blockdev-hmp-cmds.c
Date: Wed, 20 Nov 2019 20:58:45 +0200
Message-Id: <20191120185850.18986-5-mlevitsk@redhat.com>
In-Reply-To: <20191120185850.18986-1-mlevitsk@redhat.com>
References: <20191120185850.18986-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: E6VRTA63P0GY95fW83lAjg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 blockdev-hmp-cmds.c | 61 +++++++++++++++++++++++++++++++++++++++++++++
 monitor/hmp-cmds.c  | 58 ------------------------------------------
 2 files changed, 61 insertions(+), 58 deletions(-)

diff --git a/blockdev-hmp-cmds.c b/blockdev-hmp-cmds.c
index 8884618238..5ae899a324 100644
--- a/blockdev-hmp-cmds.c
+++ b/blockdev-hmp-cmds.c
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


