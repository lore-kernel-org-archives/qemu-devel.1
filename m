Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149A5C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32482068E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+/tBeH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32482068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYCCO-0000hF-19
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 11:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iYC6l-0005v4-9n
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iYC6j-0004CE-6j
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23511
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iYC6f-0004BN-2l
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574441308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iKqafnCqR2aLg/UdQXXO92kdXfQ8opoR83LlgLBIjzQ=;
 b=h+/tBeH7s58dRT4LyBkjA+dv1MnyILKSmE/DPNbYJprs0Xq13xB6vx6ctOJ8u6k+NlkT0/
 7VqK/wl3LSW1+O1WTl7hDkj5x5zRMXfDPdBketjJleyHV+qyZFEjgAylGHWWJB5vPSClln
 ndIaftNIUoA2dpBajOT/awIdeXO61+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-UCPSzsKiNMGaLOqwzQstBA-1; Fri, 22 Nov 2019 11:48:25 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F3551005502;
 Fri, 22 Nov 2019 16:48:24 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA4307700F;
 Fri, 22 Nov 2019 16:48:22 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/9] monitor/hmp: move hmp_snapshot_* to block-hmp-cmds.c
Date: Fri, 22 Nov 2019 18:48:04 +0200
Message-Id: <20191122164807.27938-7-mlevitsk@redhat.com>
In-Reply-To: <20191122164807.27938-1-mlevitsk@redhat.com>
References: <20191122164807.27938-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UCPSzsKiNMGaLOqwzQstBA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
 block/monitor/block-hmp-cmds.c | 47 ++++++++++++++++++++++++++++++++++
 monitor/hmp-cmds.c             | 46 ---------------------------------
 2 files changed, 47 insertions(+), 46 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.=
c
index e333de27b1..f3d22c7dd3 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -290,3 +290,50 @@ void hmp_block_job_complete(Monitor *mon, const QDict =
*qdict)
=20
     hmp_handle_error(mon, &error);
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
+        hmp_handle_error(mon, &err);
+        return;
+    }
+
+    mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABSOLUTE_PAT=
HS;
+    qmp_blockdev_snapshot_sync(true, device, false, NULL,
+                               filename, false, NULL,
+                               !!format, format,
+                               true, mode, &err);
+    hmp_handle_error(mon, &err);
+}
+
+void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict)
+{
+    const char *device =3D qdict_get_str(qdict, "device");
+    const char *name =3D qdict_get_str(qdict, "name");
+    Error *err =3D NULL;
+
+    qmp_blockdev_snapshot_internal_sync(device, name, &err);
+    hmp_handle_error(mon, &err);
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
+    hmp_handle_error(mon, &err);
+}
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 326276cced..2acdcd6e1e 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1338,52 +1338,6 @@ void hmp_block_resize(Monitor *mon, const QDict *qdi=
ct)
     hmp_handle_error(mon, &err);
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
-        hmp_handle_error(mon, &err);
-        return;
-    }
-
-    mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABSOLUTE_PAT=
HS;
-    qmp_blockdev_snapshot_sync(true, device, false, NULL,
-                               filename, false, NULL,
-                               !!format, format,
-                               true, mode, &err);
-    hmp_handle_error(mon, &err);
-}
-
-void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict)
-{
-    const char *device =3D qdict_get_str(qdict, "device");
-    const char *name =3D qdict_get_str(qdict, "name");
-    Error *err =3D NULL;
-
-    qmp_blockdev_snapshot_internal_sync(device, name, &err);
-    hmp_handle_error(mon, &err);
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
-    hmp_handle_error(mon, &err);
-}
=20
 void hmp_loadvm(Monitor *mon, const QDict *qdict)
 {
--=20
2.17.2


