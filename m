Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E00C10F27
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 09:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB638206D7
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 09:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bomw2Qdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB638206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAsEz-0001Ci-Od
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 05:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jAsBN-0003I4-Gg
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 05:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jAsBM-00007I-1j
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 05:25:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31477
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jAsBL-00006t-Tn
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 05:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583659511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=99y7vF6wkCV/UtdwMXgwZEQJ0z2dhLG3C4JW1s+J4lw=;
 b=Bomw2QdrF/zdRPjIsjSBRkVZ0yeHfadCcsQmyZANvrWTsG/a2ghMNZJqpx1UvkOUqKRTe2
 F6yuf44lQ9H+toyqKsbqxMOhds28Q9O4LYlZSKrHFLaWkfm5JYQ+5Lrd/mrILDd+r8lICy
 bod8Pzzu0MJmqXBUCGK6fi/HKj9pFwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-7KowSpKnPxmZo0Ved6md3Q-1; Sun, 08 Mar 2020 05:25:09 -0400
X-MC-Unique: 7KowSpKnPxmZo0Ved6md3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E836107ACC7;
 Sun,  8 Mar 2020 09:25:08 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16C43100E805;
 Sun,  8 Mar 2020 09:25:02 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/11] monitor/hmp: move hmp_snapshot_* to block-hmp-cmds.c
Date: Sun,  8 Mar 2020 11:24:36 +0200
Message-Id: <20200308092440.23564-8-mlevitsk@redhat.com>
In-Reply-To: <20200308092440.23564-1-mlevitsk@redhat.com>
References: <20200308092440.23564-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hmp_snapshot_blkdev is from GPLv2 version of the hmp-cmds.c thus
have to change the licence to GPLv2

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
index ac90a9e0c6..74e6e5b7ef 100644
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
2.17.2


