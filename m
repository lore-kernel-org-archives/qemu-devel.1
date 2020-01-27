Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603CAC33CB1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BFB920702
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Egu7MZsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFB920702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw1oI-0008Kr-8Y
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 05:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iw1lh-0002wa-VA
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:37:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iw1lg-0002ov-Ar
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:37:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53948
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iw1lg-0002oR-6Z
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:37:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580121440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oGv9T2GPTuz3dOrNCau3Ule/BMxlDyBkADZLw7tnsdg=;
 b=Egu7MZszGjpc2HHlAjjssaF1wflF5sDsYtMrnpUzagTIeR58kli+4Isse5Y8fsrRpxpuvo
 jTwdJ3MLvI0Sh9O0EbrOn2ASxQGVZCLWua3Cuwmy7Po7ZMSsqukuFuASoxYBRzHUMg3Rrk
 2F1GwoZzD3IHSQ0d40hRBUyg9DB/64w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-9IBnumEQP1avW2EA3BHMEQ-1; Mon, 27 Jan 2020 05:37:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70417800D41;
 Mon, 27 Jan 2020 10:37:16 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FCCFF6C1;
 Mon, 27 Jan 2020 10:37:14 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/13] monitor/hmp: move hmp_snapshot_* to block-hmp-cmds.c
Date: Mon, 27 Jan 2020 12:36:41 +0200
Message-Id: <20200127103647.17761-8-mlevitsk@redhat.com>
In-Reply-To: <20200127103647.17761-1-mlevitsk@redhat.com>
References: <20200127103647.17761-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 9IBnumEQP1avW2EA3BHMEQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
 block/monitor/block-hmp-cmds.c     | 47 ++++++++++++++++++++++++++++++
 include/block/block-hmp-commands.h |  4 +++
 include/monitor/hmp.h              |  3 --
 monitor/hmp-cmds.c                 | 47 ------------------------------
 4 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.=
c
index ed3c350143..9aa94ea6e0 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -280,3 +280,50 @@ void hmp_block_job_complete(Monitor *mon, const QDict =
*qdict)
=20
     hmp_handle_error(mon, error);
 }
+
+void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict)
+{
+    const char *device =3D qdict_get_str(qdict, "device");
+    const char *filename =3D qdict_get_try_str(qdict, "snapshot-file");
+    const char *format =3D qdict_get_try_str(qdict, "format");
+    bool reuse =3D qdict_get_try_bool(qdict, "reuse", false);
+    enum NewImageMode mode;
+    Error *err =3D NULL;
+
+    if (!filename) {
+        /* In the future, if 'snapshot-file' is not specified, the snapsho=
t
+           will be taken internally. Today it's actually required. */
+        error_setg(&err, QERR_MISSING_PARAMETER, "snapshot-file");
+        hmp_handle_error(mon, err);
+        return;
+    }
+
+    mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABSOLUTE_PAT=
HS;
+    qmp_blockdev_snapshot_sync(true, device, false, NULL,
+                               filename, false, NULL,
+                               !!format, format,
+                               true, mode, &err);
+    hmp_handle_error(mon, err);
+}
+
+void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict)
+{
+    const char *device =3D qdict_get_str(qdict, "device");
+    const char *name =3D qdict_get_str(qdict, "name");
+    Error *err =3D NULL;
+
+    qmp_blockdev_snapshot_internal_sync(device, name, &err);
+    hmp_handle_error(mon, err);
+}
+
+void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qdict)
+{
+    const char *device =3D qdict_get_str(qdict, "device");
+    const char *name =3D qdict_get_str(qdict, "name");
+    const char *id =3D qdict_get_try_str(qdict, "id");
+    Error *err =3D NULL;
+
+    qmp_blockdev_snapshot_delete_internal_sync(device, !!id, id,
+                                               true, name, &err);
+    hmp_handle_error(mon, err);
+}
diff --git a/include/block/block-hmp-commands.h b/include/block/block-hmp-c=
ommands.h
index ea6578a5f6..3fc2daf3a9 100644
--- a/include/block/block-hmp-commands.h
+++ b/include/block/block-hmp-commands.h
@@ -17,4 +17,8 @@ void hmp_block_job_pause(Monitor *mon, const QDict *qdict=
);
 void hmp_block_job_resume(Monitor *mon, const QDict *qdict);
 void hmp_block_job_complete(Monitor *mon, const QDict *qdict);
=20
+void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict);
+void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict);
+void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qdict)=
;
+
 #endif
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 592ce0ccfe..6d34e29bb6 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -61,9 +61,6 @@ void hmp_set_link(Monitor *mon, const QDict *qdict);
 void hmp_block_passwd(Monitor *mon, const QDict *qdict);
 void hmp_balloon(Monitor *mon, const QDict *qdict);
 void hmp_block_resize(Monitor *mon, const QDict *qdict);
-void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict);
-void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict);
-void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qdict)=
;
 void hmp_loadvm(Monitor *mon, const QDict *qdict);
 void hmp_savevm(Monitor *mon, const QDict *qdict);
 void hmp_delvm(Monitor *mon, const QDict *qdict);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 996ce96430..46b46b6dd7 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1337,53 +1337,6 @@ void hmp_block_resize(Monitor *mon, const QDict *qdi=
ct)
     hmp_handle_error(mon, err);
 }
=20
-void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict)
-{
-    const char *device =3D qdict_get_str(qdict, "device");
-    const char *filename =3D qdict_get_try_str(qdict, "snapshot-file");
-    const char *format =3D qdict_get_try_str(qdict, "format");
-    bool reuse =3D qdict_get_try_bool(qdict, "reuse", false);
-    enum NewImageMode mode;
-    Error *err =3D NULL;
-
-    if (!filename) {
-        /* In the future, if 'snapshot-file' is not specified, the snapsho=
t
-           will be taken internally. Today it's actually required. */
-        error_setg(&err, QERR_MISSING_PARAMETER, "snapshot-file");
-        hmp_handle_error(mon, err);
-        return;
-    }
-
-    mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABSOLUTE_PAT=
HS;
-    qmp_blockdev_snapshot_sync(true, device, false, NULL,
-                               filename, false, NULL,
-                               !!format, format,
-                               true, mode, &err);
-    hmp_handle_error(mon, err);
-}
-
-void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict)
-{
-    const char *device =3D qdict_get_str(qdict, "device");
-    const char *name =3D qdict_get_str(qdict, "name");
-    Error *err =3D NULL;
-
-    qmp_blockdev_snapshot_internal_sync(device, name, &err);
-    hmp_handle_error(mon, err);
-}
-
-void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qdict)
-{
-    const char *device =3D qdict_get_str(qdict, "device");
-    const char *name =3D qdict_get_str(qdict, "name");
-    const char *id =3D qdict_get_try_str(qdict, "id");
-    Error *err =3D NULL;
-
-    qmp_blockdev_snapshot_delete_internal_sync(device, !!id, id,
-                                               true, name, &err);
-    hmp_handle_error(mon, err);
-}
-
 void hmp_loadvm(Monitor *mon, const QDict *qdict)
 {
     int saved_vm_running  =3D runstate_is_running();
--=20
2.17.2


