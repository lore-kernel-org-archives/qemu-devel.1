Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F3BC10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7EE920828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULIpdaoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7EE920828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOQ4-0002m9-VP
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jBOMq-00066G-3t
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jBOMo-000070-Fl
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22475
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jBOMo-00006j-B7
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583783230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+ZQggYrwC2aHURFye9MJWb37s6Jv3ICl1jJ/qQLxsI=;
 b=ULIpdaoP4dkvB0HbtxYlxjqUwIX8tYAKbUu4I8SQi7hT4WMSEEHyw0Y6ZYtV65lYuLfqFl
 ehXybUScKJOAWDeizA6zcgRgY9uC6hS8RqLTGpRwVmCfhRWfK8Fe1v79a+CMIxbQcbCydt
 LHlLcJZkqw63YsZbB0yuihL8XmUJ2Mc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-b92WVh3xMW-VvdaDYXltjg-1; Mon, 09 Mar 2020 15:47:02 -0400
X-MC-Unique: b92WVh3xMW-VvdaDYXltjg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9FA5DBA3
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 19:47:01 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEEBE5C28D;
 Mon,  9 Mar 2020 19:47:00 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	mlevitsk@redhat.com,
	thuth@redhat.com
Subject: [PULL 07/12] monitor/hmp: move hmp_snapshot_* to block-hmp-cmds.c
Date: Mon,  9 Mar 2020 19:46:45 +0000
Message-Id: <20200309194650.160552-8-dgilbert@redhat.com>
In-Reply-To: <20200309194650.160552-1-dgilbert@redhat.com>
References: <20200309194650.160552-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

hmp_snapshot_blkdev is from GPLv2 version of the hmp-cmds.c thus
have to change the licence to GPLv2

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200308092440.23564-8-mlevitsk@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 58 ++++++++++++++++++++++++++++++++--
 include/block/block-hmp-cmds.h |  4 +++
 include/monitor/hmp.h          |  3 --
 monitor/hmp-cmds.c             | 47 ---------------------------
 4 files changed, 60 insertions(+), 52 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.=
c
index 8e8288c2f1..0131be8ecf 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -1,10 +1,15 @@
 /*
  * Blockdev HMP commands
  *
+ *  Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
  * Copyright (c) 2003-2008 Fabrice Bellard
  *
- * This work is licensed under the terms of the GNU GPL, version 2 or
- * later.  See the COPYING file in the top-level directory.
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
  *
  * This file incorporates work covered by the following copyright and
  * permission notice:
@@ -299,3 +304,52 @@ void hmp_block_job_complete(Monitor *mon, const QDict =
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
+        /*
+         * In the future, if 'snapshot-file' is not specified, the snapsho=
t
+         * will be taken internally. Today it's actually required.
+         */
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
diff --git a/include/block/block-hmp-cmds.h b/include/block/block-hmp-cmds.=
h
index fcdf1eec48..cc81779c7c 100644
--- a/include/block/block-hmp-cmds.h
+++ b/include/block/block-hmp-cmds.h
@@ -29,4 +29,8 @@ void hmp_block_job_pause(Monitor *mon, const QDict *qdict=
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
index 25d1c19a96..7b199794b0 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1342,53 +1342,6 @@ void hmp_block_resize(Monitor *mon, const QDict *qdi=
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
2.24.1


