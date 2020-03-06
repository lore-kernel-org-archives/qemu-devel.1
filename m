Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AE0C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5989B20709
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5Wx+XnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5989B20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGgN-0006eB-H0
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:22:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZV-0004zT-3T
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZR-0007wF-9M
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29936
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZP-0007hz-Ek
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tboAIphVvqU1ZFgI6+jiEo1h3mxn9y2aYL7rSvanyKM=;
 b=e5Wx+XnDSt/cJNhOCug22t113m15yllEMRY33moBBw+hSeTifZeDEj5YdZuTEqt+CCIvfU
 RgQX0ReTHljYndBIySwtCobTov2K6Nhu+ppwqmyO1dggoM0/XJlhmGfTJ9NF3o8U/OqahV
 /zMLUhrjDOH4MhtWeg12NumeqjiGqLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-atHyNf73OeqRTLra91MlRw-1; Fri, 06 Mar 2020 12:15:27 -0500
X-MC-Unique: atHyNf73OeqRTLra91MlRw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CC4E184C805;
 Fri,  6 Mar 2020 17:15:26 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CC9473873;
 Fri,  6 Mar 2020 17:15:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 16/29] blockdev-nbd: Boxed argument type for nbd-server-add
Date: Fri,  6 Mar 2020 18:14:45 +0100
Message-Id: <20200306171458.1848-17-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the arguments of nbd-server-add to a new struct BlockExportNbd and
convert the command to 'boxed': true. This makes it easier to share code
with the storage daemon.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200224143008.13362-11-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 18 ++++++++++++++----
 blockdev-nbd.c       | 35 ++++++++++++++++-------------------
 monitor/hmp-cmds.c   | 21 +++++++++++++++++----
 3 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f8888f06c8..cdc585385c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5112,9 +5112,9 @@
             '*tls-authz': 'str'} }
=20
 ##
-# @nbd-server-add:
+# @BlockExportNbd:
 #
-# Export a block node to QEMU's embedded NBD server.
+# An NBD block export.
 #
 # @device: The device name or node name of the node to be exported
 #
@@ -5131,14 +5131,24 @@
 #          NBD client can use NBD_OPT_SET_META_CONTEXT with
 #          "qemu:dirty-bitmap:NAME" to inspect the bitmap. (since 4.0)
 #
+# Since: 5.0
+##
+{ 'struct': 'BlockExportNbd',
+  'data': {'device': 'str', '*name': 'str', '*description': 'str',
+           '*writable': 'bool', '*bitmap': 'str' } }
+
+##
+# @nbd-server-add:
+#
+# Export a block node to QEMU's embedded NBD server.
+#
 # Returns: error if the server is not running, or export with the same nam=
e
 #          already exists.
 #
 # Since: 1.3.0
 ##
 { 'command': 'nbd-server-add',
-  'data': {'device': 'str', '*name': 'str', '*description': 'str',
-           '*writable': 'bool', '*bitmap': 'str' } }
+  'data': 'BlockExportNbd', 'boxed': true }
=20
 ##
 # @NbdServerRemoveMode:
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index d8c892f7da..1a95d89f00 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -148,10 +148,7 @@ void qmp_nbd_server_start(SocketAddressLegacy *addr,
     qapi_free_SocketAddress(addr_flat);
 }
=20
-void qmp_nbd_server_add(const char *device, bool has_name, const char *nam=
e,
-                        bool has_description, const char *description,
-                        bool has_writable, bool writable,
-                        bool has_bitmap, const char *bitmap, Error **errp)
+void qmp_nbd_server_add(BlockExportNbd *arg, Error **errp)
 {
     BlockDriverState *bs =3D NULL;
     BlockBackend *on_eject_blk;
@@ -164,28 +161,28 @@ void qmp_nbd_server_add(const char *device, bool has_=
name, const char *name,
         return;
     }
=20
-    if (!has_name) {
-        name =3D device;
+    if (!arg->has_name) {
+        arg->name =3D arg->device;
     }
=20
-    if (strlen(name) > NBD_MAX_STRING_SIZE) {
-        error_setg(errp, "export name '%s' too long", name);
+    if (strlen(arg->name) > NBD_MAX_STRING_SIZE) {
+        error_setg(errp, "export name '%s' too long", arg->name);
         return;
     }
=20
-    if (has_description && strlen(description) > NBD_MAX_STRING_SIZE) {
-        error_setg(errp, "description '%s' too long", description);
+    if (arg->description && strlen(arg->description) > NBD_MAX_STRING_SIZE=
) {
+        error_setg(errp, "description '%s' too long", arg->description);
         return;
     }
=20
-    if (nbd_export_find(name)) {
-        error_setg(errp, "NBD server already has export named '%s'", name)=
;
+    if (nbd_export_find(arg->name)) {
+        error_setg(errp, "NBD server already has export named '%s'", arg->=
name);
         return;
     }
=20
-    on_eject_blk =3D blk_by_name(device);
+    on_eject_blk =3D blk_by_name(arg->device);
=20
-    bs =3D bdrv_lookup_bs(device, device, errp);
+    bs =3D bdrv_lookup_bs(arg->device, arg->device, errp);
     if (!bs) {
         return;
     }
@@ -199,15 +196,15 @@ void qmp_nbd_server_add(const char *device, bool has_=
name, const char *name,
         goto out;
     }
=20
-    if (!has_writable) {
-        writable =3D false;
+    if (!arg->has_writable) {
+        arg->writable =3D false;
     }
     if (bdrv_is_read_only(bs)) {
-        writable =3D false;
+        arg->writable =3D false;
     }
=20
-    exp =3D nbd_export_new(bs, 0, len, name, description, bitmap,
-                         !writable, !writable,
+    exp =3D nbd_export_new(bs, 0, len, arg->name, arg->description, arg->b=
itmap,
+                         !arg->writable, !arg->writable,
                          NULL, false, on_eject_blk, errp);
     if (!exp) {
         goto out;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 30313858c2..fb4c2fd2a8 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -2341,6 +2341,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *=
qdict)
     Error *local_err =3D NULL;
     BlockInfoList *block_list, *info;
     SocketAddress *addr;
+    BlockExportNbd export;
=20
     if (writable && !all) {
         error_setg(&local_err, "-w only valid together with -a");
@@ -2373,8 +2374,13 @@ void hmp_nbd_server_start(Monitor *mon, const QDict =
*qdict)
             continue;
         }
=20
-        qmp_nbd_server_add(info->value->device, false, NULL, false, NULL,
-                           true, writable, false, NULL, &local_err);
+        export =3D (BlockExportNbd) {
+            .device         =3D info->value->device,
+            .has_writable   =3D true,
+            .writable       =3D writable,
+        };
+
+        qmp_nbd_server_add(&export, &local_err);
=20
         if (local_err !=3D NULL) {
             qmp_nbd_server_stop(NULL);
@@ -2395,8 +2401,15 @@ void hmp_nbd_server_add(Monitor *mon, const QDict *q=
dict)
     bool writable =3D qdict_get_try_bool(qdict, "writable", false);
     Error *local_err =3D NULL;
=20
-    qmp_nbd_server_add(device, !!name, name, false, NULL, true, writable,
-                       false, NULL, &local_err);
+    BlockExportNbd export =3D {
+        .device         =3D (char *) device,
+        .has_name       =3D !!name,
+        .name           =3D (char *) name,
+        .has_writable   =3D true,
+        .writable       =3D writable,
+    };
+
+    qmp_nbd_server_add(&export, &local_err);
     hmp_handle_error(mon, local_err);
 }
=20
--=20
2.20.1


