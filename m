Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25D2C3F2C6
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D7FD2465A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMYIZuvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7FD2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOSt-0000qx-OE
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jBOMm-0005xJ-7z
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jBOMk-0008W1-Gw
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31575
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jBOMk-0008Vg-Br
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583783226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFAs+OpKYRWhCwTaLheh2EhuVyZgT48DWrj/HJkwA10=;
 b=GMYIZuvkNr6LGR4SYU34eWhkAI9UVqmrQ5nrt+qOApvA7Ug5tinsPAFrHy5CSy8gyJPFhw
 Io3IEi4k606+uLGYkYLiHWy2WTo8WbxC3eafVVbl/MxQWoH63EHsImm3qkW+eXzjlhI18x
 Peoj5Nc3+kgU6iDzBBmwwqmeY82/A+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-HhWja8vINV-Wwww_w4miGQ-1; Mon, 09 Mar 2020 15:47:03 -0400
X-MC-Unique: HhWja8vINV-Wwww_w4miGQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F393118C43C8
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 19:47:02 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 219575C28D;
 Mon,  9 Mar 2020 19:47:01 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	mlevitsk@redhat.com,
	thuth@redhat.com
Subject: [PULL 08/12] monitor/hmp: move hmp_nbd_server* to block-hmp-cmds.c
Date: Mon,  9 Mar 2020 19:46:46 +0000
Message-Id: <20200309194650.160552-9-dgilbert@redhat.com>
In-Reply-To: <20200309194650.160552-1-dgilbert@redhat.com>
References: <20200309194650.160552-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200308092440.23564-9-mlevitsk@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 101 +++++++++++++++++++++++++++++++++
 include/block/block-hmp-cmds.h |   5 ++
 include/monitor/hmp.h          |   4 --
 monitor/hmp-cmds.c             | 100 --------------------------------
 4 files changed, 106 insertions(+), 104 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.=
c
index 0131be8ecf..188374abbc 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -45,9 +45,11 @@
 #include "qapi/qmp/qerror.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
+#include "qemu/sockets.h"
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
+#include "block/nbd.h"
 #include "block/block_int.h"
 #include "block/block-hmp-cmds.h"
=20
@@ -353,3 +355,102 @@ void hmp_snapshot_delete_blkdev_internal(Monitor *mon=
, const QDict *qdict)
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
+    BlockExportNbd export;
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
+        export =3D (BlockExportNbd) {
+            .device         =3D info->value->device,
+            .has_writable   =3D true,
+            .writable       =3D writable,
+        };
+
+        qmp_nbd_server_add(&export, &local_err);
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
+    BlockExportNbd export =3D {
+        .device         =3D (char *) device,
+        .has_name       =3D !!name,
+        .name           =3D (char *) name,
+        .has_writable   =3D true,
+        .writable       =3D writable,
+    };
+
+    qmp_nbd_server_add(&export, &local_err);
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
diff --git a/include/block/block-hmp-cmds.h b/include/block/block-hmp-cmds.=
h
index cc81779c7c..50ff802598 100644
--- a/include/block/block-hmp-cmds.h
+++ b/include/block/block-hmp-cmds.h
@@ -33,4 +33,9 @@ void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict=
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
index 7b199794b0..573ddf473a 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -47,7 +47,6 @@
 #include "qapi/string-output-visitor.h"
 #include "qom/object_interfaces.h"
 #include "ui/console.h"
-#include "block/nbd.h"
 #include "block/qapi.h"
 #include "qemu-io.h"
 #include "qemu/cutils.h"
@@ -2176,105 +2175,6 @@ void hmp_screendump(Monitor *mon, const QDict *qdic=
t)
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
-    BlockExportNbd export;
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
-        export =3D (BlockExportNbd) {
-            .device         =3D info->value->device,
-            .has_writable   =3D true,
-            .writable       =3D writable,
-        };
-
-        qmp_nbd_server_add(&export, &local_err);
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
-    BlockExportNbd export =3D {
-        .device         =3D (char *) device,
-        .has_name       =3D !!name,
-        .name           =3D (char *) name,
-        .has_writable   =3D true,
-        .writable       =3D writable,
-    };
-
-    qmp_nbd_server_add(&export, &local_err);
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
2.24.1


