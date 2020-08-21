Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EA8C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461A420FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdJaTzrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461A420FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97n0-0006tk-Ga
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97iu-00076f-Pt
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49192
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97iq-0004Vr-WE
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598018928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mP0yQS1S+Jw+c7RTKmW1Fy96BiPBJqEi1uJiEFIMJkw=;
 b=WdJaTzrXZsKZOrcxQkxHHMkvcfgmj++rvNFLX2hc4+KH7vuVWWHPTuOe6d9oTx4Ue4f1Cq
 MMFplpvxI92125aN5qRZ1jzyN+Js+F2R3Ac1PCugeHz0l1KinuZmg56uCIHhla4Ur5tw1/
 4PzyRE/gaoSzgHTOpyGLJ3q3odWD63Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-_5XPMJ4wPS2rfQ7W4_NbHg-1; Fri, 21 Aug 2020 10:08:44 -0400
X-MC-Unique: _5XPMJ4wPS2rfQ7W4_NbHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C68EC8797DD;
 Fri, 21 Aug 2020 14:08:42 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-220.phx2.redhat.com [10.3.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1742774E2A;
 Fri, 21 Aug 2020 14:08:39 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/14] migration: Add block-bitmap-mapping parameter
Date: Fri, 21 Aug 2020 09:08:24 -0500
Message-Id: <20200821140826.194322-13-eblake@redhat.com>
In-Reply-To: <20200821140826.194322-1-eblake@redhat.com>
References: <20200821140826.194322-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:55:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Dirty Bitmaps" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

This migration parameter allows mapping block node names and bitmap
names to aliases for the purpose of block dirty bitmap migration.

This way, management tools can use different node and bitmap names on
the source and destination and pass the mapping of how bitmaps are to be
transferred to qemu (on the source, the destination, or even both with
arbitrary aliases in the migration stream).

While touching this code, fix a bug where bitmap names longer than 255
bytes would fail an assertion in qemu_put_counted_string().

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200820150725.68687-2-mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/migration.json            | 104 ++++++++-
 migration/migration.h          |   3 +
 migration/block-dirty-bitmap.c | 410 ++++++++++++++++++++++++++++-----
 migration/migration.c          |  30 +++
 monitor/hmp-cmds.c             |  30 +++
 5 files changed, 521 insertions(+), 56 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index ea53b23dca90..5f6b06172cab 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -508,6 +508,44 @@
   'data': [ 'none', 'zlib',
             { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }

+##
+# @BitmapMigrationBitmapAlias:
+#
+# @name: The name of the bitmap.
+#
+# @alias: An alias name for migration (for example the bitmap name on
+#         the opposite site).
+#
+# Since: 5.2
+##
+{ 'struct': 'BitmapMigrationBitmapAlias',
+  'data': {
+      'name': 'str',
+      'alias': 'str'
+  } }
+
+##
+# @BitmapMigrationNodeAlias:
+#
+# Maps a block node name and the bitmaps it has to aliases for dirty
+# bitmap migration.
+#
+# @node-name: A block node name.
+#
+# @alias: An alias block node name for migration (for example the
+#         node name on the opposite site).
+#
+# @bitmaps: Mappings for the bitmaps on this node.
+#
+# Since: 5.2
+##
+{ 'struct': 'BitmapMigrationNodeAlias',
+  'data': {
+      'node-name': 'str',
+      'alias': 'str',
+      'bitmaps': [ 'BitmapMigrationBitmapAlias' ]
+  } }
+
 ##
 # @MigrationParameter:
 #
@@ -642,6 +680,25 @@
 #          will consume more CPU.
 #          Defaults to 1. (Since 5.0)
 #
+# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
+#          aliases for the purpose of dirty bitmap migration.  Such
+#          aliases may for example be the corresponding names on the
+#          opposite site.
+#          The mapping must be one-to-one, but not necessarily
+#          complete: On the source, unmapped bitmaps and all bitmaps
+#          on unmapped nodes will be ignored.  On the destination,
+#          encountering an unmapped alias in the incoming migration
+#          stream will result in a report, and all further bitmap
+#          migration data will then be discarded.
+#          Note that the destination does not know about bitmaps it
+#          does not receive, so there is no limitation or requirement
+#          regarding the number of bitmaps received, or how they are
+#          named, or on which nodes they are placed.
+#          By default (when this parameter has never been set), bitmap
+#          names are mapped to themselves.  Nodes are mapped to their
+#          block device name if there is one, and to their node name
+#          otherwise. (Since 5.2)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -656,7 +713,8 @@
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
-           'multifd-zlib-level' ,'multifd-zstd-level' ] }
+           'multifd-zlib-level' ,'multifd-zstd-level',
+           'block-bitmap-mapping' ] }

 ##
 # @MigrateSetParameters:
@@ -782,6 +840,25 @@
 #          will consume more CPU.
 #          Defaults to 1. (Since 5.0)
 #
+# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
+#          aliases for the purpose of dirty bitmap migration.  Such
+#          aliases may for example be the corresponding names on the
+#          opposite site.
+#          The mapping must be one-to-one, but not necessarily
+#          complete: On the source, unmapped bitmaps and all bitmaps
+#          on unmapped nodes will be ignored.  On the destination,
+#          encountering an unmapped alias in the incoming migration
+#          stream will result in a report, and all further bitmap
+#          migration data will then be discarded.
+#          Note that the destination does not know about bitmaps it
+#          does not receive, so there is no limitation or requirement
+#          regarding the number of bitmaps received, or how they are
+#          named, or on which nodes they are placed.
+#          By default (when this parameter has never been set), bitmap
+#          names are mapped to themselves.  Nodes are mapped to their
+#          block device name if there is one, and to their node name
+#          otherwise. (Since 5.2)
+#
 # Since: 2.4
 ##
 # TODO either fuse back into MigrationParameters, or make
@@ -812,7 +889,8 @@
             '*max-cpu-throttle': 'int',
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'int',
-            '*multifd-zstd-level': 'int' } }
+            '*multifd-zstd-level': 'int',
+            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }

 ##
 # @migrate-set-parameters:
@@ -958,6 +1036,25 @@
 #          will consume more CPU.
 #          Defaults to 1. (Since 5.0)
 #
+# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
+#          aliases for the purpose of dirty bitmap migration.  Such
+#          aliases may for example be the corresponding names on the
+#          opposite site.
+#          The mapping must be one-to-one, but not necessarily
+#          complete: On the source, unmapped bitmaps and all bitmaps
+#          on unmapped nodes will be ignored.  On the destination,
+#          encountering an unmapped alias in the incoming migration
+#          stream will result in a report, and all further bitmap
+#          migration data will then be discarded.
+#          Note that the destination does not know about bitmaps it
+#          does not receive, so there is no limitation or requirement
+#          regarding the number of bitmaps received, or how they are
+#          named, or on which nodes they are placed.
+#          By default (when this parameter has never been set), bitmap
+#          names are mapped to themselves.  Nodes are mapped to their
+#          block device name if there is one, and to their node name
+#          otherwise. (Since 5.2)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -986,7 +1083,8 @@
             '*max-cpu-throttle': 'uint8',
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'uint8',
-            '*multifd-zstd-level': 'uint8' } }
+            '*multifd-zstd-level': 'uint8',
+            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }

 ##
 # @query-migrate-parameters:
diff --git a/migration/migration.h b/migration/migration.h
index 6c6a931d0dc2..2ed55c4aefc3 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -337,6 +337,9 @@ void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
 void dirty_bitmap_mig_before_vm_start(void);
 void dirty_bitmap_mig_cancel_outgoing(void);
 void dirty_bitmap_mig_cancel_incoming(void);
+bool check_dirty_bitmap_mig_alias_map(const BitmapMigrationNodeAliasList *bbm,
+                                      Error **errp);
+
 void migrate_add_address(SocketAddress *address);

 int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 784330ebe130..549e14daba4f 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -29,10 +29,10 @@
  *
  * # Header (shared for different chunk types)
  * 1, 2 or 4 bytes: flags (see qemu_{put,put}_flags)
- * [ 1 byte: node name size ] \  flags & DEVICE_NAME
- * [ n bytes: node name     ] /
- * [ 1 byte: bitmap name size ] \  flags & BITMAP_NAME
- * [ n bytes: bitmap name     ] /
+ * [ 1 byte: node alias size ] \  flags & DEVICE_NAME
+ * [ n bytes: node alias     ] /
+ * [ 1 byte: bitmap alias size ] \  flags & BITMAP_NAME
+ * [ n bytes: bitmap alias     ] /
  *
  * # Start of bitmap migration (flags & START)
  * header
@@ -72,7 +72,9 @@
 #include "migration/register.h"
 #include "qemu/hbitmap.h"
 #include "qemu/cutils.h"
+#include "qemu/id.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-migration.h"
 #include "trace.h"

 #define CHUNK_SIZE     (1 << 10)
@@ -104,7 +106,8 @@
 typedef struct SaveBitmapState {
     /* Written during setup phase. */
     BlockDriverState *bs;
-    const char *node_name;
+    char *node_alias;
+    char *bitmap_alias;
     BdrvDirtyBitmap *bitmap;
     uint64_t total_sectors;
     uint64_t sectors_per_chunk;
@@ -138,8 +141,9 @@ typedef struct LoadBitmapState {
 /* State of the dirty bitmap migration (DBM) during load process */
 typedef struct DBMLoadState {
     uint32_t flags;
-    char node_name[256];
-    char bitmap_name[256];
+    char node_alias[256];
+    char bitmap_alias[256];
+    char bitmap_name[BDRV_BITMAP_MAX_NAME_SIZE + 1];
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;

@@ -165,6 +169,188 @@ typedef struct DBMState {

 static DBMState dbm_state;

+/* For hash tables that map node/bitmap names to aliases */
+typedef struct AliasMapInnerNode {
+    char *string;
+    GHashTable *subtree;
+} AliasMapInnerNode;
+
+static void free_alias_map_inner_node(void *amin_ptr)
+{
+    AliasMapInnerNode *amin = amin_ptr;
+
+    g_free(amin->string);
+    g_hash_table_unref(amin->subtree);
+    g_free(amin);
+}
+
+/**
+ * Construct an alias map based on the given QMP structure.
+ *
+ * (Note that we cannot store such maps in the MigrationParameters
+ * object, because that struct is defined by the QAPI schema, which
+ * makes it basically impossible to have dicts with arbitrary keys.
+ * Therefore, we instead have to construct these maps when migration
+ * starts.)
+ *
+ * @bbm is the block_bitmap_mapping from the migration parameters.
+ *
+ * If @name_to_alias is true, the returned hash table will map node
+ * and bitmap names to their respective aliases (for outgoing
+ * migration).
+ *
+ * If @name_to_alias is false, the returned hash table will map node
+ * and bitmap aliases to their respective names (for incoming
+ * migration).
+ *
+ * The hash table maps node names/aliases to AliasMapInnerNode
+ * objects, whose .string is the respective node alias/name, and whose
+ * .subtree table maps bitmap names/aliases to the respective bitmap
+ * alias/name.
+ */
+static GHashTable *construct_alias_map(const BitmapMigrationNodeAliasList *bbm,
+                                       bool name_to_alias,
+                                       Error **errp)
+{
+    GHashTable *alias_map;
+    size_t max_node_name_len = sizeof_field(BlockDriverState, node_name) - 1;
+
+    alias_map = g_hash_table_new_full(g_str_hash, g_str_equal,
+                                      g_free, free_alias_map_inner_node);
+
+    for (; bbm; bbm = bbm->next) {
+        const BitmapMigrationNodeAlias *bmna = bbm->value;
+        const BitmapMigrationBitmapAliasList *bmbal;
+        AliasMapInnerNode *amin;
+        GHashTable *bitmaps_map;
+        const char *node_map_from, *node_map_to;
+
+        if (!id_wellformed(bmna->alias)) {
+            error_setg(errp, "The node alias '%s' is not well-formed",
+                       bmna->alias);
+            goto fail;
+        }
+
+        if (strlen(bmna->alias) > UINT8_MAX) {
+            error_setg(errp, "The node alias '%s' is longer than %u bytes",
+                       bmna->alias, UINT8_MAX);
+            goto fail;
+        }
+
+        if (strlen(bmna->node_name) > max_node_name_len) {
+            error_setg(errp, "The node name '%s' is longer than %zu bytes",
+                       bmna->node_name, max_node_name_len);
+            goto fail;
+        }
+
+        if (name_to_alias) {
+            if (g_hash_table_contains(alias_map, bmna->node_name)) {
+                error_setg(errp, "The node name '%s' is mapped twice",
+                           bmna->node_name);
+                goto fail;
+            }
+
+            node_map_from = bmna->node_name;
+            node_map_to = bmna->alias;
+        } else {
+            if (g_hash_table_contains(alias_map, bmna->alias)) {
+                error_setg(errp, "The node alias '%s' is used twice",
+                           bmna->alias);
+                goto fail;
+            }
+
+            node_map_from = bmna->alias;
+            node_map_to = bmna->node_name;
+        }
+
+        bitmaps_map = g_hash_table_new_full(g_str_hash, g_str_equal,
+                                            g_free, g_free);
+
+        amin = g_new(AliasMapInnerNode, 1);
+        *amin = (AliasMapInnerNode){
+            .string = g_strdup(node_map_to),
+            .subtree = bitmaps_map,
+        };
+
+        g_hash_table_insert(alias_map, g_strdup(node_map_from), amin);
+
+        for (bmbal = bmna->bitmaps; bmbal; bmbal = bmbal->next) {
+            const BitmapMigrationBitmapAlias *bmba = bmbal->value;
+            const char *bmap_map_from, *bmap_map_to;
+
+            if (strlen(bmba->alias) > UINT8_MAX) {
+                error_setg(errp,
+                           "The bitmap alias '%s' is longer than %u bytes",
+                           bmba->alias, UINT8_MAX);
+                goto fail;
+            }
+
+            if (strlen(bmba->name) > BDRV_BITMAP_MAX_NAME_SIZE) {
+                error_setg(errp, "The bitmap name '%s' is longer than %d bytes",
+                           bmba->name, BDRV_BITMAP_MAX_NAME_SIZE);
+                goto fail;
+            }
+
+            if (name_to_alias) {
+                bmap_map_from = bmba->name;
+                bmap_map_to = bmba->alias;
+
+                if (g_hash_table_contains(bitmaps_map, bmba->name)) {
+                    error_setg(errp, "The bitmap '%s'/'%s' is mapped twice",
+                               bmna->node_name, bmba->name);
+                    goto fail;
+                }
+            } else {
+                bmap_map_from = bmba->alias;
+                bmap_map_to = bmba->name;
+
+                if (g_hash_table_contains(bitmaps_map, bmba->alias)) {
+                    error_setg(errp, "The bitmap alias '%s'/'%s' is used twice",
+                               bmna->alias, bmba->alias);
+                    goto fail;
+                }
+            }
+
+            g_hash_table_insert(bitmaps_map,
+                                g_strdup(bmap_map_from), g_strdup(bmap_map_to));
+        }
+    }
+
+    return alias_map;
+
+fail:
+    g_hash_table_destroy(alias_map);
+    return NULL;
+}
+
+/**
+ * Run construct_alias_map() in both directions to check whether @bbm
+ * is valid.
+ * (This function is to be used by migration/migration.c to validate
+ * the user-specified block-bitmap-mapping migration parameter.)
+ *
+ * Returns true if and only if the mapping is valid.
+ */
+bool check_dirty_bitmap_mig_alias_map(const BitmapMigrationNodeAliasList *bbm,
+                                      Error **errp)
+{
+    GHashTable *alias_map;
+
+    alias_map = construct_alias_map(bbm, true, errp);
+    if (!alias_map) {
+        return false;
+    }
+    g_hash_table_destroy(alias_map);
+
+    alias_map = construct_alias_map(bbm, false, errp);
+    if (!alias_map) {
+        return false;
+    }
+    g_hash_table_destroy(alias_map);
+
+    return true;
+}
+
 static uint32_t qemu_get_bitmap_flags(QEMUFile *f)
 {
     uint8_t flags = qemu_get_byte(f);
@@ -207,11 +393,11 @@ static void send_bitmap_header(QEMUFile *f, DBMSaveState *s,
     qemu_put_bitmap_flags(f, flags);

     if (flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) {
-        qemu_put_counted_string(f, dbms->node_name);
+        qemu_put_counted_string(f, dbms->node_alias);
     }

     if (flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
-        qemu_put_counted_string(f, bdrv_dirty_bitmap_name(bitmap));
+        qemu_put_counted_string(f, dbms->bitmap_alias);
     }
 }

@@ -282,18 +468,25 @@ static void dirty_bitmap_do_save_cleanup(DBMSaveState *s)
         QSIMPLEQ_REMOVE_HEAD(&s->dbms_list, entry);
         bdrv_dirty_bitmap_set_busy(dbms->bitmap, false);
         bdrv_unref(dbms->bs);
+        g_free(dbms->node_alias);
+        g_free(dbms->bitmap_alias);
         g_free(dbms);
     }
 }

 /* Called with iothread lock taken. */
 static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
-                               const char *bs_name)
+                               const char *bs_name, GHashTable *alias_map)
 {
     BdrvDirtyBitmap *bitmap;
     SaveBitmapState *dbms;
+    GHashTable *bitmap_aliases;
+    const char *node_alias, *bitmap_name, *bitmap_alias;
     Error *local_err = NULL;

+    /* When an alias map is given, @bs_name must be @bs's node name */
+    assert(!alias_map || !strcmp(bs_name, bdrv_get_node_name(bs)));
+
     FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
         if (bdrv_dirty_bitmap_name(bitmap)) {
             break;
@@ -303,21 +496,39 @@ static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
         return 0;
     }

+    bitmap_name = bdrv_dirty_bitmap_name(bitmap);
+
     if (!bs_name || strcmp(bs_name, "") == 0) {
         error_report("Bitmap '%s' in unnamed node can't be migrated",
-                     bdrv_dirty_bitmap_name(bitmap));
+                     bitmap_name);
         return -1;
     }

-    if (bs_name[0] == '#') {
+    if (alias_map) {
+        const AliasMapInnerNode *amin = g_hash_table_lookup(alias_map, bs_name);
+
+        if (!amin) {
+            /* Skip bitmaps on nodes with no alias */
+            return 0;
+        }
+
+        node_alias = amin->string;
+        bitmap_aliases = amin->subtree;
+    } else {
+        node_alias = bs_name;
+        bitmap_aliases = NULL;
+    }
+
+    if (node_alias[0] == '#') {
         error_report("Bitmap '%s' in a node with auto-generated "
                      "name '%s' can't be migrated",
-                     bdrv_dirty_bitmap_name(bitmap), bs_name);
+                     bitmap_name, node_alias);
         return -1;
     }

     FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
-        if (!bdrv_dirty_bitmap_name(bitmap)) {
+        bitmap_name = bdrv_dirty_bitmap_name(bitmap);
+        if (!bitmap_name) {
             continue;
         }

@@ -326,12 +537,29 @@ static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
             return -1;
         }

+        if (bitmap_aliases) {
+            bitmap_alias = g_hash_table_lookup(bitmap_aliases, bitmap_name);
+            if (!bitmap_alias) {
+                /* Skip bitmaps with no alias */
+                continue;
+            }
+        } else {
+            if (strlen(bitmap_name) > UINT8_MAX) {
+                error_report("Cannot migrate bitmap '%s' on node '%s': "
+                             "Name is longer than %u bytes",
+                             bitmap_name, bs_name, UINT8_MAX);
+                return -1;
+            }
+            bitmap_alias = bitmap_name;
+        }
+
         bdrv_ref(bs);
         bdrv_dirty_bitmap_set_busy(bitmap, true);

         dbms = g_new0(SaveBitmapState, 1);
         dbms->bs = bs;
-        dbms->node_name = bs_name;
+        dbms->node_alias = g_strdup(node_alias);
+        dbms->bitmap_alias = g_strdup(bitmap_alias);
         dbms->bitmap = bitmap;
         dbms->total_sectors = bdrv_nb_sectors(bs);
         dbms->sectors_per_chunk = CHUNK_SIZE * 8 *
@@ -356,43 +584,52 @@ static int init_dirty_bitmap_migration(DBMSaveState *s)
     SaveBitmapState *dbms;
     GHashTable *handled_by_blk = g_hash_table_new(NULL, NULL);
     BlockBackend *blk;
+    const MigrationParameters *mig_params = &migrate_get_current()->parameters;
+    GHashTable *alias_map = NULL;
+
+    if (mig_params->has_block_bitmap_mapping) {
+        alias_map = construct_alias_map(mig_params->block_bitmap_mapping, true,
+                                        &error_abort);
+    }

     s->bulk_completed = false;
     s->prev_bs = NULL;
     s->prev_bitmap = NULL;
     s->no_bitmaps = false;

-    /*
-     * Use blockdevice name for direct (or filtered) children of named block
-     * backends.
-     */
-    for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
-        const char *name = blk_name(blk);
+    if (!alias_map) {
+        /*
+         * Use blockdevice name for direct (or filtered) children of named block
+         * backends.
+         */
+        for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
+            const char *name = blk_name(blk);

-        if (!name || strcmp(name, "") == 0) {
-            continue;
-        }
+            if (!name || strcmp(name, "") == 0) {
+                continue;
+            }

-        bs = blk_bs(blk);
+            bs = blk_bs(blk);

-        /* Skip filters without bitmaps */
-        while (bs && bs->drv && bs->drv->is_filter &&
-               !bdrv_has_named_bitmaps(bs))
-        {
-            if (bs->backing) {
-                bs = bs->backing->bs;
-            } else if (bs->file) {
-                bs = bs->file->bs;
-            } else {
-                bs = NULL;
+            /* Skip filters without bitmaps */
+            while (bs && bs->drv && bs->drv->is_filter &&
+                   !bdrv_has_named_bitmaps(bs))
+            {
+                if (bs->backing) {
+                    bs = bs->backing->bs;
+                } else if (bs->file) {
+                    bs = bs->file->bs;
+                } else {
+                    bs = NULL;
+                }
             }
-        }

-        if (bs && bs->drv && !bs->drv->is_filter) {
-            if (add_bitmaps_to_list(s, bs, name)) {
-                goto fail;
+            if (bs && bs->drv && !bs->drv->is_filter) {
+                if (add_bitmaps_to_list(s, bs, name, NULL)) {
+                    goto fail;
+                }
+                g_hash_table_add(handled_by_blk, bs);
             }
-            g_hash_table_add(handled_by_blk, bs);
         }
     }

@@ -401,7 +638,7 @@ static int init_dirty_bitmap_migration(DBMSaveState *s)
             continue;
         }

-        if (add_bitmaps_to_list(s, bs, bdrv_get_node_name(bs))) {
+        if (add_bitmaps_to_list(s, bs, bdrv_get_node_name(bs), alias_map)) {
             goto fail;
         }
     }
@@ -416,11 +653,17 @@ static int init_dirty_bitmap_migration(DBMSaveState *s)
     }

     g_hash_table_destroy(handled_by_blk);
+    if (alias_map) {
+        g_hash_table_destroy(alias_map);
+    }

     return 0;

 fail:
     g_hash_table_destroy(handled_by_blk);
+    if (alias_map) {
+        g_hash_table_destroy(alias_map);
+    }
     dirty_bitmap_do_save_cleanup(s);

     return -1;
@@ -770,8 +1013,10 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
     return 0;
 }

-static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
+static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s,
+                                    GHashTable *alias_map)
 {
+    GHashTable *bitmap_alias_map = NULL;
     Error *local_err = NULL;
     bool nothing;
     s->flags = qemu_get_bitmap_flags(f);
@@ -780,28 +1025,75 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
     nothing = s->flags == (s->flags & DIRTY_BITMAP_MIG_FLAG_EOS);

     if (s->flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) {
-        if (!qemu_get_counted_string(f, s->node_name)) {
-            error_report("Unable to read node name string");
+        if (!qemu_get_counted_string(f, s->node_alias)) {
+            error_report("Unable to read node alias string");
             return -EINVAL;
         }
+
         if (!s->cancelled) {
-            s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
+            if (alias_map) {
+                const AliasMapInnerNode *amin;
+
+                amin = g_hash_table_lookup(alias_map, s->node_alias);
+                if (!amin) {
+                    error_setg(&local_err, "Error: Unknown node alias '%s'",
+                               s->node_alias);
+                    s->bs = NULL;
+                } else {
+                    bitmap_alias_map = amin->subtree;
+                    s->bs = bdrv_lookup_bs(NULL, amin->string, &local_err);
+                }
+            } else {
+                s->bs = bdrv_lookup_bs(s->node_alias, s->node_alias,
+                                       &local_err);
+            }
             if (!s->bs) {
                 error_report_err(local_err);
                 cancel_incoming_locked(s);
             }
         }
-    } else if (!s->bs && !nothing && !s->cancelled) {
+    } else if (s->bs) {
+        if (alias_map) {
+            const AliasMapInnerNode *amin;
+
+            /* Must be present in the map, or s->bs would not be set */
+            amin = g_hash_table_lookup(alias_map, s->node_alias);
+            assert(amin != NULL);
+
+            bitmap_alias_map = amin->subtree;
+        }
+    } else if (!nothing && !s->cancelled) {
         error_report("Error: block device name is not set");
         cancel_incoming_locked(s);
     }

+    assert(nothing || s->cancelled || !!alias_map == !!bitmap_alias_map);
+
     if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
-        if (!qemu_get_counted_string(f, s->bitmap_name)) {
-            error_report("Unable to read bitmap name string");
+        const char *bitmap_name;
+
+        if (!qemu_get_counted_string(f, s->bitmap_alias)) {
+            error_report("Unable to read bitmap alias string");
             return -EINVAL;
         }
+
         if (!s->cancelled) {
+            if (bitmap_alias_map) {
+                bitmap_name = g_hash_table_lookup(bitmap_alias_map,
+                                                  s->bitmap_alias);
+                if (!bitmap_name) {
+                    error_report("Error: Unknown bitmap alias '%s' on node "
+                                 "'%s' (alias '%s')", s->bitmap_alias,
+                                 s->bs->node_name, s->node_alias);
+                    cancel_incoming_locked(s);
+                }
+            } else {
+                bitmap_name = s->bitmap_alias;
+            }
+        }
+
+        if (!s->cancelled) {
+            g_strlcpy(s->bitmap_name, bitmap_name, sizeof(s->bitmap_name));
             s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);

             /*
@@ -811,7 +1103,7 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
             if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
                 error_report("Error: unknown dirty bitmap "
                              "'%s' for block device '%s'",
-                             s->bitmap_name, s->node_name);
+                             s->bitmap_name, s->bs->node_name);
                 cancel_incoming_locked(s);
             }
         }
@@ -835,6 +1127,8 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
  */
 static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
 {
+    GHashTable *alias_map = NULL;
+    const MigrationParameters *mig_params = &migrate_get_current()->parameters;
     DBMLoadState *s = &((DBMState *)opaque)->load;
     int ret = 0;

@@ -846,13 +1140,18 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
         return -EINVAL;
     }

+    if (mig_params->has_block_bitmap_mapping) {
+        alias_map = construct_alias_map(mig_params->block_bitmap_mapping,
+                                        false, &error_abort);
+    }
+
     do {
         QEMU_LOCK_GUARD(&s->lock);

-        ret = dirty_bitmap_load_header(f, s);
+        ret = dirty_bitmap_load_header(f, s, alias_map);
         if (ret < 0) {
             cancel_incoming_locked(s);
-            return ret;
+            goto fail;
         }

         if (s->flags & DIRTY_BITMAP_MIG_FLAG_START) {
@@ -869,12 +1168,17 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)

         if (ret) {
             cancel_incoming_locked(s);
-            return ret;
+            goto fail;
         }
     } while (!(s->flags & DIRTY_BITMAP_MIG_FLAG_EOS));

     trace_dirty_bitmap_load_success();
-    return 0;
+    ret = 0;
+fail:
+    if (alias_map) {
+        g_hash_table_destroy(alias_map);
+    }
+    return ret;
 }

 static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
diff --git a/migration/migration.c b/migration/migration.c
index 8fe36339dbe8..dbd4afa1e895 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -36,6 +36,7 @@
 #include "block/block.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-migration.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-events-migration.h"
@@ -843,6 +844,13 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->has_announce_step = true;
     params->announce_step = s->parameters.announce_step;

+    if (s->parameters.has_block_bitmap_mapping) {
+        params->has_block_bitmap_mapping = true;
+        params->block_bitmap_mapping =
+            QAPI_CLONE(BitmapMigrationNodeAliasList,
+                       s->parameters.block_bitmap_mapping);
+    }
+
     return params;
 }

@@ -1308,6 +1316,13 @@ static bool migrate_params_check(MigrationParameters *params, Error **errp)
                    "is invalid, it must be in the range of 1 to 10000 ms");
        return false;
     }
+
+    if (params->has_block_bitmap_mapping &&
+        !check_dirty_bitmap_mig_alias_map(params->block_bitmap_mapping, errp)) {
+        error_prepend(errp, "Invalid mapping given for block-bitmap-mapping: ");
+        return false;
+    }
+
     return true;
 }

@@ -1402,6 +1417,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_announce_step) {
         dest->announce_step = params->announce_step;
     }
+
+    if (params->has_block_bitmap_mapping) {
+        dest->has_block_bitmap_mapping = true;
+        dest->block_bitmap_mapping = params->block_bitmap_mapping;
+    }
 }

 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
@@ -1514,6 +1534,16 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_announce_step) {
         s->parameters.announce_step = params->announce_step;
     }
+
+    if (params->has_block_bitmap_mapping) {
+        qapi_free_BitmapMigrationNodeAliasList(
+            s->parameters.block_bitmap_mapping);
+
+        s->parameters.has_block_bitmap_mapping = true;
+        s->parameters.block_bitmap_mapping =
+            QAPI_CLONE(BitmapMigrationNodeAliasList,
+                       params->block_bitmap_mapping);
+    }
 }

 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index ae4b6a4246b5..7711726fd222 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -469,6 +469,32 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
             params->tls_authz);
+
+        if (params->has_block_bitmap_mapping) {
+            const BitmapMigrationNodeAliasList *bmnal;
+
+            monitor_printf(mon, "%s:\n",
+                           MigrationParameter_str(
+                               MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING));
+
+            for (bmnal = params->block_bitmap_mapping;
+                 bmnal;
+                 bmnal = bmnal->next)
+            {
+                const BitmapMigrationNodeAlias *bmna = bmnal->value;
+                const BitmapMigrationBitmapAliasList *bmbal;
+
+                monitor_printf(mon, "  '%s' -> '%s'\n",
+                               bmna->node_name, bmna->alias);
+
+                for (bmbal = bmna->bitmaps; bmbal; bmbal = bmbal->next) {
+                    const BitmapMigrationBitmapAlias *bmba = bmbal->value;
+
+                    monitor_printf(mon, "    '%s' -> '%s'\n",
+                                   bmba->name, bmba->alias);
+                }
+            }
+        }
     }

     qapi_free_MigrationParameters(params);
@@ -1384,6 +1410,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_announce_step = true;
         visit_type_size(v, param, &p->announce_step, &err);
         break;
+    case MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING:
+        error_setg(&err, "The block-bitmap-mapping parameter can only be set "
+                   "through QMP");
+        break;
     default:
         assert(0);
     }
-- 
2.28.0


