Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DDFC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B463821655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="baSVu2dm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B463821655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iflfn-00055m-5a
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 09:12:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iflf3-0004YE-Oj
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:11:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iflf1-0007HF-T7
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:11:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29569
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1iflf0-0007EF-KF
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576246273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JECB0MatuUVIWaMZKQVLAjz0Jf53W98F/a+FaZzHqfo=;
 b=baSVu2dmMv2j+N/dsfXAHrbnXoVMxms6GrY/gigS7Bs5EPhXUSmZy6OzhN1QDEM5MUM+Dt
 uQhV/wBD6GDA+js3RWxBull6hcRsmbkH2Rrv0Vb877yVYEVhjFDJKwARcd3MoRaWop3Luu
 X94B14m8X+I8tBuTZrTO7PfEEvlu9oI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-rMYg2Q67O7y2lwR7SJE5Fg-1; Fri, 13 Dec 2019 09:11:10 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 694FF1005502;
 Fri, 13 Dec 2019 14:11:09 +0000 (UTC)
Received: from angien.redhat.com (unknown [10.43.2.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0154D19C4F;
 Fri, 13 Dec 2019 14:11:07 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC] qapi: Allow getting flat output from
 'query-named-block-nodes'
Date: Fri, 13 Dec 2019 15:11:07 +0100
Message-Id: <42dae98e1f6a9f444f48a20192f45195337824f0.1576246045.git.pkrempa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: rMYg2Q67O7y2lwR7SJE5Fg-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a management application manages node names there's no reason to
recurse into backing images in the output of query-named-block-nodes.

Add a parameter to the command which will return just the top level
structs.

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
---
 block.c               |  5 +++--
 block/qapi.c          | 10 ++++++++--
 blockdev.c            | 12 ++++++++++--
 include/block/block.h |  2 +-
 include/block/qapi.h  |  4 +++-
 monitor/hmp-cmds.c    |  2 +-
 qapi/block-core.json  |  6 +++++-
 7 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index 473eb6eeaa..b30bdfa0d3 100644
--- a/block.c
+++ b/block.c
@@ -4766,14 +4766,15 @@ BlockDriverState *bdrv_find_node(const char *node_n=
ame)
 }

 /* Put this QMP function here so it can access the static graph_bdrv_state=
s. */
-BlockDeviceInfoList *bdrv_named_nodes_list(Error **errp)
+BlockDeviceInfoList *bdrv_named_nodes_list(bool flat,
+                                           Error **errp)
 {
     BlockDeviceInfoList *list, *entry;
     BlockDriverState *bs;

     list =3D NULL;
     QTAILQ_FOREACH(bs, &graph_bdrv_states, node_list) {
-        BlockDeviceInfo *info =3D bdrv_block_device_info(NULL, bs, errp);
+        BlockDeviceInfo *info =3D bdrv_block_device_info(NULL, bs, flat, e=
rrp);
         if (!info) {
             qapi_free_BlockDeviceInfoList(list);
             return NULL;
diff --git a/block/qapi.c b/block/qapi.c
index 9a5d0c9b27..84048e1a57 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -42,7 +42,9 @@
 #include "qemu/cutils.h"

 BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
-                                        BlockDriverState *bs, Error **errp=
)
+                                        BlockDriverState *bs,
+                                        bool flat,
+                                        Error **errp)
 {
     ImageInfo **p_image_info;
     BlockDriverState *bs0;
@@ -156,6 +158,10 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *=
blk,
             return NULL;
         }

+        /* stop gathering data for flat output */
+        if (flat)
+            break;
+
         if (bs0->drv && bs0->backing) {
             info->backing_file_depth++;
             bs0 =3D bs0->backing->bs;
@@ -389,7 +395,7 @@ static void bdrv_query_info(BlockBackend *blk, BlockInf=
o **p_info,

     if (bs && bs->drv) {
         info->has_inserted =3D true;
-        info->inserted =3D bdrv_block_device_info(blk, bs, errp);
+        info->inserted =3D bdrv_block_device_info(blk, bs, false, errp);
         if (info->inserted =3D=3D NULL) {
             goto err;
         }
diff --git a/blockdev.c b/blockdev.c
index 8e029e9c01..5f9c5e258f 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3707,9 +3707,17 @@ void qmp_drive_backup(DriveBackup *arg, Error **errp=
)
     }
 }

-BlockDeviceInfoList *qmp_query_named_block_nodes(Error **errp)
+BlockDeviceInfoList *qmp_query_named_block_nodes(bool has_flat,
+                                                 bool flat,
+                                                 Error **errp)
 {
-    return bdrv_named_nodes_list(errp);
+    bool return_flat =3D false;
+
+    if (has_flat) {
+        return_flat =3D flat;
+    }
+
+    return bdrv_named_nodes_list(return_flat, errp);
 }

 XDbgBlockGraph *qmp_x_debug_query_block_graph(Error **errp)
diff --git a/include/block/block.h b/include/block/block.h
index 1df9848e74..177ba09e3f 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -468,7 +468,7 @@ void bdrv_lock_medium(BlockDriverState *bs, bool locked=
);
 void bdrv_eject(BlockDriverState *bs, bool eject_flag);
 const char *bdrv_get_format_name(BlockDriverState *bs);
 BlockDriverState *bdrv_find_node(const char *node_name);
-BlockDeviceInfoList *bdrv_named_nodes_list(Error **errp);
+BlockDeviceInfoList *bdrv_named_nodes_list(bool flat, Error **errp);
 XDbgBlockGraph *bdrv_get_xdbg_block_graph(Error **errp);
 BlockDriverState *bdrv_lookup_bs(const char *device,
                                  const char *node_name,
diff --git a/include/block/qapi.h b/include/block/qapi.h
index cd9410dee3..22c7807c89 100644
--- a/include/block/qapi.h
+++ b/include/block/qapi.h
@@ -29,7 +29,9 @@
 #include "block/snapshot.h"

 BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
-                                        BlockDriverState *bs, Error **errp=
);
+                                        BlockDriverState *bs,
+                                        bool flat,
+                                        Error **errp);
 int bdrv_query_snapshot_info_list(BlockDriverState *bs,
                                   SnapshotInfoList **p_list,
                                   Error **errp);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index b2551c16d1..651969819b 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -620,7 +620,7 @@ void hmp_info_block(Monitor *mon, const QDict *qdict)
     }

     /* Print node information */
-    blockdev_list =3D qmp_query_named_block_nodes(NULL);
+    blockdev_list =3D qmp_query_named_block_nodes(false, false, NULL);
     for (blockdev =3D blockdev_list; blockdev; blockdev =3D blockdev->next=
) {
         assert(blockdev->value->has_node_name);
         if (device && strcmp(device, blockdev->value->node_name)) {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0cf68fea14..bd651106bd 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1752,6 +1752,8 @@
 #
 # Get the named block driver list
 #
+# @flat: don't recurse into backing images if true. Default is false (Sinc=
e 5.0)
+#
 # Returns: the list of BlockDeviceInfo
 #
 # Since: 2.0
@@ -1805,7 +1807,9 @@
 #                    } } ] }
 #
 ##
-{ 'command': 'query-named-block-nodes', 'returns': [ 'BlockDeviceInfo' ] }
+{ 'command': 'query-named-block-nodes',
+  'returns': [ 'BlockDeviceInfo' ],
+  'data': { '*flat': 'bool' } }

 ##
 # @XDbgBlockGraphNodeType:
--=20
2.23.0


