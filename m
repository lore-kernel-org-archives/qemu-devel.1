Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F302AFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C850720640
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C850720640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5b2-00047i-N3
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iL5S8-0000jc-8U
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iL5S6-0008Sg-St
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58108)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iL5Rz-0008Nr-Vs; Thu, 17 Oct 2019 09:04:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3D624300BCE9;
 Thu, 17 Oct 2019 13:04:19 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-24.ams2.redhat.com
 [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE9CD1001B11;
 Thu, 17 Oct 2019 13:04:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 07/18] blockdev-nbd: Boxed argument type for nbd-server-add
Date: Thu, 17 Oct 2019 15:01:53 +0200
Message-Id: <20191017130204.16131-8-kwolf@redhat.com>
In-Reply-To: <20191017130204.16131-1-kwolf@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 17 Oct 2019 13:04:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the arguments of nbd-server-add to a new struct BlockExportNbd and
convert the command to 'boxed': true. This makes it easier to share code
with the storage daemon.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block.json    | 20 +++++++++++++++-----
 blockdev-nbd.c     | 25 ++++++++++++-------------
 monitor/hmp-cmds.c | 21 +++++++++++++++++----
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 7fe0cf6538..567f116875 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -259,9 +259,9 @@
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
@@ -270,19 +270,29 @@
 #
 # @writable: Whether clients should be able to write to the device via t=
he
 #     NBD connection (default false).
-
+#
 # @bitmap: Also export the dirty bitmap reachable from @device, so the
 #          NBD client can use NBD_OPT_SET_META_CONTEXT with
 #          "qemu:dirty-bitmap:NAME" to inspect the bitmap. (since 4.0)
 #
+# Since: 4.2
+##
+{ 'struct': 'BlockExportNbd',
+  'data': {'device': 'str', '*name': 'str', '*writable': 'bool',
+           '*bitmap': 'str' } }
+
+##
+# @nbd-server-add:
+#
+# Export a block node to QEMU's embedded NBD server.
+#
 # Returns: error if the server is not running, or export with the same n=
ame
 #          already exists.
 #
 # Since: 1.3.0
 ##
 { 'command': 'nbd-server-add',
-  'data': {'device': 'str', '*name': 'str', '*writable': 'bool',
-           '*bitmap': 'str' } }
+  'data': 'BlockExportNbd', 'boxed': true }
=20
 ##
 # @NbdServerRemoveMode:
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index d4c1fd4166..ee8262cd4c 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -148,9 +148,7 @@ void qmp_nbd_server_start(SocketAddressLegacy *addr,
     qapi_free_SocketAddress(addr_flat);
 }
=20
-void qmp_nbd_server_add(const char *device, bool has_name, const char *n=
ame,
-                        bool has_writable, bool writable,
-                        bool has_bitmap, const char *bitmap, Error **err=
p)
+void qmp_nbd_server_add(BlockExportNbd *arg, Error **errp)
 {
     BlockDriverState *bs =3D NULL;
     BlockBackend *on_eject_blk;
@@ -163,18 +161,18 @@ void qmp_nbd_server_add(const char *device, bool ha=
s_name, const char *name,
         return;
     }
=20
-    if (!has_name) {
-        name =3D device;
+    if (!arg->has_name) {
+        arg->name =3D arg->device;
     }
=20
-    if (nbd_export_find(name)) {
-        error_setg(errp, "NBD server already has export named '%s'", nam=
e);
+    if (nbd_export_find(arg->name)) {
+        error_setg(errp, "NBD server already has export named '%s'", arg=
->name);
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
@@ -188,14 +186,15 @@ void qmp_nbd_server_add(const char *device, bool ha=
s_name, const char *name,
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
-    exp =3D nbd_export_new(bs, 0, len, name, NULL, bitmap, !writable, !w=
ritable,
+    exp =3D nbd_export_new(bs, 0, len, arg->name, NULL, arg->bitmap,
+                         !arg->writable, !arg->writable,
                          NULL, false, on_eject_blk, errp);
     if (!exp) {
         goto out;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index b2551c16d1..22d7e6e222 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -2320,6 +2320,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict=
 *qdict)
     Error *local_err =3D NULL;
     BlockInfoList *block_list, *info;
     SocketAddress *addr;
+    BlockExportNbd export;
=20
     if (writable && !all) {
         error_setg(&local_err, "-w only valid together with -a");
@@ -2352,8 +2353,13 @@ void hmp_nbd_server_start(Monitor *mon, const QDic=
t *qdict)
             continue;
         }
=20
-        qmp_nbd_server_add(info->value->device, false, NULL,
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
@@ -2374,8 +2380,15 @@ void hmp_nbd_server_add(Monitor *mon, const QDict =
*qdict)
     bool writable =3D qdict_get_try_bool(qdict, "writable", false);
     Error *local_err =3D NULL;
=20
-    qmp_nbd_server_add(device, !!name, name, true, writable,
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
     hmp_handle_error(mon, &local_err);
 }
=20
--=20
2.20.1


