Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18E9C433E8
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:00:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC5720E65
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQ+fGgCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC5720E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYsjE-0001JM-CV
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 10:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYsi2-0008QT-Du
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:50:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35251
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYsi0-0007N2-4l
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589381406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KUcrD3c8mrxQR9hwuNwAclZ3iYvjlWPS1OOl3SMATVs=;
 b=gQ+fGgCXiAsJcKEuR2PUSRqME3NZoUO8HoTg9bk/xMi3KxXv/GELDnBDIY2ygxibwNzWkU
 mdtlm4upsJdayjeyG2lE6eZOuPoS1jBOjSIPd9U+iHgeQDGUNOBW528tCqHXzIWcLiU1+X
 Hmtd9/CyVDpvNQ7H5jZiQfJzCwCN7n0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-1mqyXG0OPeiBExmYjP97Rg-1; Wed, 13 May 2020 10:49:44 -0400
X-MC-Unique: 1mqyXG0OPeiBExmYjP97Rg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFB141005510;
 Wed, 13 May 2020 14:49:43 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 229FE648DB;
 Wed, 13 May 2020 14:49:42 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC] migration: Add migrate-set-bitmap-node-mapping
Date: Wed, 13 May 2020 16:49:41 +0200
Message-Id: <20200513144941.1469447-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This command allows mapping block node names to aliases for the purpose
of block dirty bitmap migration.

This way, management tools can use different node names on the source
and destination and pass the mapping of how bitmaps are to be
transferred to qemu (on the source, the destination, or even both with
arbitrary aliases in the migration stream).

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
Branch: https://github.com/XanClic/qemu.git migration-bitmap-mapping-rfc
Branch: https://git.xanclic.moe/XanClic/qemu.git migration-bitmap-mapping-rfc

Vladimir has proposed something like this in April:
https://lists.nongnu.org/archive/html/qemu-block/2020-04/msg00171.html

Now I’ve been asked by my manager to look at this, so I decided to just
write a patch to see how it’d play out.

This is an RFC, because I’d like to tack on tests to the final version,
but I’m not sure whether I can come up with something before the end of
the week (and I’ll be on PTO for the next two weeks).

Also, I don’t know whether migration/block-dirty-bitmap.c is the best
place to put qmp_migrate_set_bitmap_mapping(), but it appears we already
have some QMP handlers in migration/, so I suppose it isn’t too bad.
---
 qapi/migration.json            | 36 ++++++++++++++++++++
 migration/block-dirty-bitmap.c | 60 ++++++++++++++++++++++++++++++++--
 2 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index d5000558c6..94aec8d194 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1621,3 +1621,39 @@
 ##
 { 'event': 'UNPLUG_PRIMARY',
   'data': { 'device-id': 'str' } }
+
+##
+# @MigrationBlockNodeMapping:
+#
+# Maps a block node name to an alias for migration.
+#
+# @node-name: A block node name.
+#
+# @alias: An alias name for migration (for example the node name on
+#         the opposite site).
+#
+# Since: 5.1
+##
+{ 'struct': 'MigrationBitmapMapping',
+  'data': {
+      'node-name': 'str',
+      'alias': 'str'
+  } }
+
+##
+# @migrate-set-bitmap-node-mapping:
+#
+# Maps block node names to arbitrary aliases for the purpose of dirty
+# bitmap migration.  Such aliases may for example be the corresponding
+# node names on the opposite site.
+#
+# By default, every node name is mapped to itself.
+#
+# @mapping: The mapping; must be one-to-one, but not necessarily
+#           complete.  Any mapping not given will be reset to the
+#           default (i.e. the identity mapping).
+#
+# Since: 5.1
+##
+{ 'command': 'migrate-set-bitmap-node-mapping',
+  'data': { 'mapping': ['MigrationBlockNodeMapping'] } }
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 7eafface61..8b434f7011 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -73,6 +73,8 @@
 #include "qemu/hbitmap.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-migration.h"
+#include "qapi/qmp/qdict.h"
 #include "trace.h"
 
 #define CHUNK_SIZE     (1 << 10)
@@ -121,6 +123,9 @@ typedef struct DirtyBitmapMigState {
     bool bulk_completed;
     bool no_bitmaps;
 
+    QDict *node_in_mapping;
+    QDict *node_out_mapping;
+
     /* for send_bitmap_bits() */
     BlockDriverState *prev_bs;
     BdrvDirtyBitmap *prev_bitmap;
@@ -281,8 +286,13 @@ static int init_dirty_bitmap_migration(void)
     dirty_bitmap_mig_state.no_bitmaps = false;
 
     for (bs = bdrv_next_all_states(NULL); bs; bs = bdrv_next_all_states(bs)) {
+        const QDict *map = dirty_bitmap_mig_state.node_out_mapping;
         const char *name = bdrv_get_device_or_node_name(bs);
 
+        if (map) {
+            name = qdict_get_try_str(map, name) ?: name;
+        }
+
         FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
             if (!bdrv_dirty_bitmap_name(bitmap)) {
                 continue;
@@ -600,6 +610,8 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DirtyBitmapLoadState *s)
 
 static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
 {
+    const QDict *map = dirty_bitmap_mig_state.node_in_mapping;
+    const char *mapped_node = "(none)";
     Error *local_err = NULL;
     bool nothing;
     s->flags = qemu_get_bitmap_flags(f);
@@ -612,7 +624,13 @@ static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
             error_report("Unable to read node name string");
             return -EINVAL;
         }
-        s->bs = bdrv_lookup_bs(s->node_name, s->node_name, &local_err);
+
+        mapped_node = s->node_name;
+        if (map) {
+            mapped_node = qdict_get_try_str(map, mapped_node) ?: mapped_node;
+        }
+
+        s->bs = bdrv_lookup_bs(mapped_node, mapped_node, &local_err);
         if (!s->bs) {
             error_report_err(local_err);
             return -EINVAL;
@@ -634,7 +652,7 @@ static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
         if (!s->bitmap && !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
             error_report("Error: unknown dirty bitmap "
                          "'%s' for block device '%s'",
-                         s->bitmap_name, s->node_name);
+                         s->bitmap_name, mapped_node);
             return -EINVAL;
         }
     } else if (!s->bitmap && !nothing) {
@@ -713,6 +731,44 @@ static bool dirty_bitmap_has_postcopy(void *opaque)
     return true;
 }
 
+void qmp_migrate_set_bitmap_mapping(MigrationBitmapMappingList *mapping,
+                                    Error **errp)
+{
+    QDict *in_mapping = qdict_new();
+    QDict *out_mapping = qdict_new();
+
+    for (; mapping; mapping = mapping->next) {
+        MigrationBitmapMapping *entry = mapping->value;
+
+        if (qdict_haskey(out_mapping, entry->node_name)) {
+            error_setg(errp, "Cannot map node name '%s' twice",
+                       entry->node_name);
+            goto fail;
+        }
+
+        if (qdict_haskey(in_mapping, entry->alias)) {
+            error_setg(errp, "Cannot use alias '%s' twice",
+                       entry->alias);
+            goto fail;
+        }
+
+        qdict_put_str(in_mapping, entry->alias, entry->node_name);
+        qdict_put_str(out_mapping, entry->node_name, entry->alias);
+    }
+
+    qobject_unref(dirty_bitmap_mig_state.node_in_mapping);
+    qobject_unref(dirty_bitmap_mig_state.node_out_mapping);
+
+    dirty_bitmap_mig_state.node_in_mapping = in_mapping;
+    dirty_bitmap_mig_state.node_out_mapping = out_mapping;
+
+    return;
+
+fail:
+    qobject_unref(in_mapping);
+    qobject_unref(out_mapping);
+}
+
 static SaveVMHandlers savevm_dirty_bitmap_handlers = {
     .save_setup = dirty_bitmap_save_setup,
     .save_live_complete_postcopy = dirty_bitmap_save_complete,
-- 
2.26.2


