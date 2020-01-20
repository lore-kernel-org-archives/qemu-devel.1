Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C9CC33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8C32077C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0Z9YM8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8C32077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itSrG-0003tQ-8z
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 03:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1itSlw-0000Ol-NL
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:51:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1itSlq-0001yC-Ja
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:50:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51478
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1itSlq-0001xg-7q
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579510253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hM/Zi1dbJNKYx0P8grt5QihhSHIvqzqjEsDj4SB6TIs=;
 b=M0Z9YM8+FJfc9mIejOqKky1XN2x72F4ZstNanYoiiQUzMb3x80WqerN4PMtPxuobTxl5LT
 uM9Fvl6jHS/vJRdsusdf2LA9Y6pdDwNmu82T9XIkAVtfeCJ9lwMnCbE0tscziAyorKXb9w
 C6PWNiiHg6K+DjOVfLaMQNbsgHWcXtU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-wAQHhwjdNN2l-BlzLYGz1A-1; Mon, 20 Jan 2020 03:50:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65137477;
 Mon, 20 Jan 2020 08:50:51 +0000 (UTC)
Received: from angien.redhat.com (unknown [10.43.2.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A78B60BF7;
 Mon, 20 Jan 2020 08:50:50 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] qapi: Allow getting flat output from
 'query-named-block-nodes'
Date: Mon, 20 Jan 2020 09:50:49 +0100
Message-Id: <4470f8c779abc404dcf65e375db195cd91a80651.1579509782.git.pkrempa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: wAQHhwjdNN2l-BlzLYGz1A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

Diff to v1:
 - rewrote setting of 'return_flat' in qmp_query_named_block_nodes
 - tried to clarify the QMP schema docs for the new field

This patch does not aim to fix the rather suboptimal original
documentation of the command as that is going to end up in a bunch of
bikeshedding.

While I know that there are plans for a new command that should fix
this, the plans were already there for quite some time without much
happening. This is a quick fix to a real problem, because if you have
(maybe unpractically) deep backing chains, the returned JSON is getting
huge. (140 nesting levels exceeds 10MiB of JSON)

 block.c               |  5 +++--
 block/qapi.c          | 10 ++++++++--
 blockdev.c            |  8 ++++++--
 include/block/block.h |  2 +-
 include/block/qapi.h  |  4 +++-
 monitor/hmp-cmds.c    |  2 +-
 qapi/block-core.json  |  7 ++++++-
 7 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index ecd09dbbfd..73d70aec11 100644
--- a/block.c
+++ b/block.c
@@ -4784,14 +4784,15 @@ BlockDriverState *bdrv_find_node(const char *node_n=
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
index 8e029e9c01..cba2f567aa 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3707,9 +3707,13 @@ void qmp_drive_backup(DriveBackup *arg, Error **errp=
)
     }
 }

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

 XDbgBlockGraph *qmp_x_debug_query_block_graph(Error **errp)
diff --git a/include/block/block.h b/include/block/block.h
index e9dcfef7fa..afced5249c 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -469,7 +469,7 @@ void bdrv_lock_medium(BlockDriverState *bs, bool locked=
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
index d0e0af893a..bece8447a5 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -619,7 +619,7 @@ void hmp_info_block(Monitor *mon, const QDict *qdict)
     }

     /* Print node information */
-    blockdev_list =3D qmp_query_named_block_nodes(NULL);
+    blockdev_list =3D qmp_query_named_block_nodes(false, false, NULL);
     for (blockdev =3D blockdev_list; blockdev; blockdev =3D blockdev->next=
) {
         assert(blockdev->value->has_node_name);
         if (device && strcmp(device, blockdev->value->node_name)) {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ff5e5edaf..56561ff703 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1752,6 +1752,9 @@
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
@@ -1805,7 +1808,9 @@
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
2.24.1


