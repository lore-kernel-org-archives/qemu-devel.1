Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124C3C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17F520702
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ow9JijR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17F520702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw1o9-0007zj-VQ
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 05:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iw1lj-000315-Pb
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:37:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iw1li-0002ru-7C
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:37:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51588
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iw1li-0002qn-1r
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580121441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sH/Jm8wqFvAlabLvAmrYRoUC/jk7ZOh1WJoqF40h1gI=;
 b=Ow9JijR9TWSJgLlxmynQap5PaF07E9zsqgKpVCyQZ0rW033FtU5hoc/ubmWv0D0phC+mdM
 rCTLkQAdAgYSZxW22GPsYXhkGXe77E3hP6tleXV39fsK+UCi/dOdtyBWlgra5R8rYjcFgm
 Rq/qGcZE+BXLGSCjqX8oB/1e40OGxRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-68-FB-qQNdiNtaXMPoLPwg-1; Mon, 27 Jan 2020 05:37:19 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAEEA107ACC4;
 Mon, 27 Jan 2020 10:37:18 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C97BCF6C1;
 Mon, 27 Jan 2020 10:37:16 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/13] monitor/hmp: move hmp_nbd_server* to block-hmp-cmds.c
Date: Mon, 27 Jan 2020 12:36:42 +0200
Message-Id: <20200127103647.17761-9-mlevitsk@redhat.com>
In-Reply-To: <20200127103647.17761-1-mlevitsk@redhat.com>
References: <20200127103647.17761-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 68-FB-qQNdiNtaXMPoLPwg-1
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
 block/monitor/block-hmp-cmds.c     | 88 ++++++++++++++++++++++++++++++
 include/block/block-hmp-commands.h |  5 ++
 include/monitor/hmp.h              |  4 --
 monitor/hmp-cmds.c                 | 87 -----------------------------
 4 files changed, 93 insertions(+), 91 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.=
c
index 9aa94ea6e0..df0178d0f9 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -22,8 +22,10 @@
 #include "qapi/qmp/qerror.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
+#include "qemu/sockets.h"
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
+#include "block/nbd.h"
 #include "block/block_int.h"
 #include "block/block-hmp-commands.h"
 #include "monitor/hmp.h"
@@ -327,3 +329,89 @@ void hmp_snapshot_delete_blkdev_internal(Monitor *mon,=
 const QDict *qdict)
                                                true, name, &err);
     hmp_handle_error(mon, err);
 }
+
+void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
+{
+    const char *uri =3D qdict_get_str(qdict, "uri");
+    bool writable =3D qdict_get_try_bool(qdict, "writable", false);
+    bool all =3D qdict_get_try_bool(qdict, "all", false);
+    Error *local_err =3D NULL;
+    BlockInfoList *block_list, *info;
+    SocketAddress *addr;
+
+    if (writable && !all) {
+        error_setg(&local_err, "-w only valid together with -a");
+        goto exit;
+    }
+
+    /* First check if the address is valid and start the server.  */
+    addr =3D socket_parse(uri, &local_err);
+    if (local_err !=3D NULL) {
+        goto exit;
+    }
+
+    nbd_server_start(addr, NULL, NULL, &local_err);
+    qapi_free_SocketAddress(addr);
+    if (local_err !=3D NULL) {
+        goto exit;
+    }
+
+    if (!all) {
+        return;
+    }
+
+    /* Then try adding all block devices.  If one fails, close all and
+     * exit.
+     */
+    block_list =3D qmp_query_block(NULL);
+
+    for (info =3D block_list; info; info =3D info->next) {
+        if (!info->value->has_inserted) {
+            continue;
+        }
+
+        qmp_nbd_server_add(info->value->device, false, NULL,
+                           true, writable, false, NULL, &local_err);
+
+        if (local_err !=3D NULL) {
+            qmp_nbd_server_stop(NULL);
+            break;
+        }
+    }
+
+    qapi_free_BlockInfoList(block_list);
+
+exit:
+    hmp_handle_error(mon, local_err);
+}
+
+void hmp_nbd_server_add(Monitor *mon, const QDict *qdict)
+{
+    const char *device =3D qdict_get_str(qdict, "device");
+    const char *name =3D qdict_get_try_str(qdict, "name");
+    bool writable =3D qdict_get_try_bool(qdict, "writable", false);
+    Error *local_err =3D NULL;
+
+    qmp_nbd_server_add(device, !!name, name, true, writable,
+                       false, NULL, &local_err);
+    hmp_handle_error(mon, local_err);
+}
+
+void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict)
+{
+    const char *name =3D qdict_get_str(qdict, "name");
+    bool force =3D qdict_get_try_bool(qdict, "force", false);
+    Error *err =3D NULL;
+
+    /* Rely on NBD_SERVER_REMOVE_MODE_SAFE being the default */
+    qmp_nbd_server_remove(name, force, NBD_SERVER_REMOVE_MODE_HARD, &err);
+    hmp_handle_error(mon, err);
+}
+
+void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict)
+{
+    Error *err =3D NULL;
+
+    qmp_nbd_server_stop(&err);
+    hmp_handle_error(mon, err);
+}
diff --git a/include/block/block-hmp-commands.h b/include/block/block-hmp-c=
ommands.h
index 3fc2daf3a9..721b9a1978 100644
--- a/include/block/block-hmp-commands.h
+++ b/include/block/block-hmp-commands.h
@@ -21,4 +21,9 @@ void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict=
);
 void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict);
 void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qdict)=
;
=20
+void hmp_nbd_server_start(Monitor *mon, const QDict *qdict);
+void hmp_nbd_server_add(Monitor *mon, const QDict *qdict);
+void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict);
+void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict);
+
 #endif
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 6d34e29bb6..736a969131 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -94,10 +94,6 @@ void hmp_getfd(Monitor *mon, const QDict *qdict);
 void hmp_closefd(Monitor *mon, const QDict *qdict);
 void hmp_sendkey(Monitor *mon, const QDict *qdict);
 void hmp_screendump(Monitor *mon, const QDict *qdict);
-void hmp_nbd_server_start(Monitor *mon, const QDict *qdict);
-void hmp_nbd_server_add(Monitor *mon, const QDict *qdict);
-void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict);
-void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict);
 void hmp_chardev_add(Monitor *mon, const QDict *qdict);
 void hmp_chardev_change(Monitor *mon, const QDict *qdict);
 void hmp_chardev_remove(Monitor *mon, const QDict *qdict);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 46b46b6dd7..67d2ca8a4c 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -45,7 +45,6 @@
 #include "qapi/string-output-visitor.h"
 #include "qom/object_interfaces.h"
 #include "ui/console.h"
-#include "block/nbd.h"
 #include "block/qapi.h"
 #include "qemu-io.h"
 #include "qemu/cutils.h"
@@ -2154,92 +2153,6 @@ void hmp_screendump(Monitor *mon, const QDict *qdict=
)
     hmp_handle_error(mon, err);
 }
=20
-void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
-{
-    const char *uri =3D qdict_get_str(qdict, "uri");
-    bool writable =3D qdict_get_try_bool(qdict, "writable", false);
-    bool all =3D qdict_get_try_bool(qdict, "all", false);
-    Error *local_err =3D NULL;
-    BlockInfoList *block_list, *info;
-    SocketAddress *addr;
-
-    if (writable && !all) {
-        error_setg(&local_err, "-w only valid together with -a");
-        goto exit;
-    }
-
-    /* First check if the address is valid and start the server.  */
-    addr =3D socket_parse(uri, &local_err);
-    if (local_err !=3D NULL) {
-        goto exit;
-    }
-
-    nbd_server_start(addr, NULL, NULL, &local_err);
-    qapi_free_SocketAddress(addr);
-    if (local_err !=3D NULL) {
-        goto exit;
-    }
-
-    if (!all) {
-        return;
-    }
-
-    /* Then try adding all block devices.  If one fails, close all and
-     * exit.
-     */
-    block_list =3D qmp_query_block(NULL);
-
-    for (info =3D block_list; info; info =3D info->next) {
-        if (!info->value->has_inserted) {
-            continue;
-        }
-
-        qmp_nbd_server_add(info->value->device, false, NULL,
-                           true, writable, false, NULL, &local_err);
-
-        if (local_err !=3D NULL) {
-            qmp_nbd_server_stop(NULL);
-            break;
-        }
-    }
-
-    qapi_free_BlockInfoList(block_list);
-
-exit:
-    hmp_handle_error(mon, local_err);
-}
-
-void hmp_nbd_server_add(Monitor *mon, const QDict *qdict)
-{
-    const char *device =3D qdict_get_str(qdict, "device");
-    const char *name =3D qdict_get_try_str(qdict, "name");
-    bool writable =3D qdict_get_try_bool(qdict, "writable", false);
-    Error *local_err =3D NULL;
-
-    qmp_nbd_server_add(device, !!name, name, true, writable,
-                       false, NULL, &local_err);
-    hmp_handle_error(mon, local_err);
-}
-
-void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict)
-{
-    const char *name =3D qdict_get_str(qdict, "name");
-    bool force =3D qdict_get_try_bool(qdict, "force", false);
-    Error *err =3D NULL;
-
-    /* Rely on NBD_SERVER_REMOVE_MODE_SAFE being the default */
-    qmp_nbd_server_remove(name, force, NBD_SERVER_REMOVE_MODE_HARD, &err);
-    hmp_handle_error(mon, err);
-}
-
-void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict)
-{
-    Error *err =3D NULL;
-
-    qmp_nbd_server_stop(&err);
-    hmp_handle_error(mon, err);
-}
-
 void hmp_chardev_add(Monitor *mon, const QDict *qdict)
 {
     const char *args =3D qdict_get_str(qdict, "args");
--=20
2.17.2


