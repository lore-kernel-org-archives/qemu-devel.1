Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC4BC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B16920658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNyQZic6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B16920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4oSj-0004ck-BB
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:14:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4oNS-00034z-NK
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:08:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4oNR-0005EF-5q
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:08:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46230
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4oNR-0005E1-12
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582214916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SV6cCgR5vGPvx+m/2n/rccL9WOTCAUOs32GzciPYSDM=;
 b=JNyQZic6q3xR1l0pNgNwf3k/Si6DGYYWuL3xVt+F5G25m6hd/7mT9G/LDcl5jD7220A3QL
 bdqWZ/VpS4fHvdL9y3uc6Vlru/DAxwA0KZnXbEG1RahAwapU8Au9EpbRSfS40w/BZfumdg
 wO6YiP23deLf7s/clvtU5z8HZwvePQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-fXQVIqFrP-m6EiHueBAk1Q-1; Thu, 20 Feb 2020 11:08:33 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A317E18B9FCB;
 Thu, 20 Feb 2020 16:08:30 +0000 (UTC)
Received: from localhost (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE4775DA82;
 Thu, 20 Feb 2020 16:08:28 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 05/18] qapi: Allow getting flat output from
 'query-named-block-nodes'
Date: Thu, 20 Feb 2020 17:06:57 +0100
Message-Id: <20200220160710.533297-6-mreitz@redhat.com>
In-Reply-To: <20200220160710.533297-1-mreitz@redhat.com>
References: <20200220160710.533297-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: fXQVIqFrP-m6EiHueBAk1Q-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Krempa <pkrempa@redhat.com>

When a management application manages node names there's no reason to
recurse into backing images in the output of query-named-block-nodes.

Add a parameter to the command which will return just the top level
structs.

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
Message-Id: <4470f8c779abc404dcf65e375db195cd91a80651.1579509782.git.pkremp=
a@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[mreitz: Fixed coding style]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c               |  5 +++--
 block/qapi.c          | 11 +++++++++--
 blockdev.c            |  8 ++++++--
 include/block/block.h |  2 +-
 include/block/qapi.h  |  4 +++-
 monitor/hmp-cmds.c    |  2 +-
 qapi/block-core.json  |  7 ++++++-
 7 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index 946e3c896e..08372ced26 100644
--- a/block.c
+++ b/block.c
@@ -4807,14 +4807,15 @@ BlockDriverState *bdrv_find_node(const char *node_n=
ame)
 }
=20
 /* Put this QMP function here so it can access the static graph_bdrv_state=
s. */
-BlockDeviceInfoList *bdrv_named_nodes_list(Error **errp)
+BlockDeviceInfoList *bdrv_named_nodes_list(bool flat,
+                                           Error **errp)
 {
     BlockDeviceInfoList *list, *entry;
     BlockDriverState *bs;
=20
     list =3D NULL;
     QTAILQ_FOREACH(bs, &graph_bdrv_states, node_list) {
-        BlockDeviceInfo *info =3D bdrv_block_device_info(NULL, bs, errp);
+        BlockDeviceInfo *info =3D bdrv_block_device_info(NULL, bs, flat, e=
rrp);
         if (!info) {
             qapi_free_BlockDeviceInfoList(list);
             return NULL;
diff --git a/block/qapi.c b/block/qapi.c
index 9a5d0c9b27..3f09477cc5 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -42,7 +42,9 @@
 #include "qemu/cutils.h"
=20
 BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
-                                        BlockDriverState *bs, Error **errp=
)
+                                        BlockDriverState *bs,
+                                        bool flat,
+                                        Error **errp)
 {
     ImageInfo **p_image_info;
     BlockDriverState *bs0;
@@ -156,6 +158,11 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *=
blk,
             return NULL;
         }
=20
+        /* stop gathering data for flat output */
+        if (flat) {
+            break;
+        }
+
         if (bs0->drv && bs0->backing) {
             info->backing_file_depth++;
             bs0 =3D bs0->backing->bs;
@@ -389,7 +396,7 @@ static void bdrv_query_info(BlockBackend *blk, BlockInf=
o **p_info,
=20
     if (bs && bs->drv) {
         info->has_inserted =3D true;
-        info->inserted =3D bdrv_block_device_info(blk, bs, errp);
+        info->inserted =3D bdrv_block_device_info(blk, bs, false, errp);
         if (info->inserted =3D=3D NULL) {
             goto err;
         }
diff --git a/blockdev.c b/blockdev.c
index 45de0ba37e..011dcfec27 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3734,9 +3734,13 @@ void qmp_drive_backup(DriveBackup *backup, Error **e=
rrp)
     blockdev_do_action(&action, errp);
 }
=20
-BlockDeviceInfoList *qmp_query_named_block_nodes(Error **errp)
+BlockDeviceInfoList *qmp_query_named_block_nodes(bool has_flat,
+                                                 bool flat,
+                                                 Error **errp)
 {
-    return bdrv_named_nodes_list(errp);
+    bool return_flat =3D has_flat && flat;
+
+    return bdrv_named_nodes_list(return_flat, errp);
 }
=20
 XDbgBlockGraph *qmp_x_debug_query_block_graph(Error **errp)
diff --git a/include/block/block.h b/include/block/block.h
index 314ce63ed9..cd6b5b95aa 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -454,7 +454,7 @@ void bdrv_lock_medium(BlockDriverState *bs, bool locked=
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
=20
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
index b237613e0d..53bc3f76c4 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -620,7 +620,7 @@ void hmp_info_block(Monitor *mon, const QDict *qdict)
     }
=20
     /* Print node information */
-    blockdev_list =3D qmp_query_named_block_nodes(NULL);
+    blockdev_list =3D qmp_query_named_block_nodes(false, false, NULL);
     for (blockdev =3D blockdev_list; blockdev; blockdev =3D blockdev->next=
) {
         assert(blockdev->value->has_node_name);
         if (device && strcmp(device, blockdev->value->node_name)) {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 37d7ea7295..85e27bb61f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1758,6 +1758,9 @@
 #
 # Get the named block driver list
 #
+# @flat: Omit the nested data about backing image ("backing-image" key) if=
 true.
+#        Default is false (Since 5.0)
+#
 # Returns: the list of BlockDeviceInfo
 #
 # Since: 2.0
@@ -1811,7 +1814,9 @@
 #                    } } ] }
 #
 ##
-{ 'command': 'query-named-block-nodes', 'returns': [ 'BlockDeviceInfo' ] }
+{ 'command': 'query-named-block-nodes',
+  'returns': [ 'BlockDeviceInfo' ],
+  'data': { '*flat': 'bool' } }
=20
 ##
 # @XDbgBlockGraphNodeType:
--=20
2.24.1


