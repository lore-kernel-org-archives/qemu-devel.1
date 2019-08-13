Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E80C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 22:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5FA520644
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 22:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FA520644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxfXi-0001sC-U5
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 18:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55445)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hxfXD-0000wO-6s
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 18:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hxfXB-0003OS-UR
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 18:44:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44506)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hxfX9-0003Na-Bq; Tue, 13 Aug 2019 18:44:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9703883F3C;
 Tue, 13 Aug 2019 22:44:50 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-169.bos.redhat.com [10.18.17.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FAD94C5;
 Tue, 13 Aug 2019 22:44:47 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue, 13 Aug 2019 18:44:46 -0400
Message-Id: <20190813224446.14145-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 13 Aug 2019 22:44:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC] dirty-bitmaps: add block-dirty-bitmap-persist
 command
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is for the purpose of toggling on/off persistence on a bitmap.
This enables you to save a bitmap that was not persistent, but may
have already accumulated valuable data.

This is simply a QOL enhancement:
- Allows user to "upgrade" an existing bitmap to persistent
- Allows user to "downgrade" an existing bitmap to transient,
  removing it from storage without deleting the bitmap.

Signed-off-by: John Snow <jsnow@redhat.com>
---

This is just an RFC because I'm not sure if I really want to pursue
adding this, but it was raised in a discussion I had recently that it
was a little annoying as an API design that persistence couldn't be
changed after addition, so I wanted to see how much code it would take
to address that.

(So this patch isn't really tested; just: "Hey, look!")

I don't like this patch because it exacerbates my perceived problems
with the "check if I can make it persistent, then toggle the flag"
model, where I prefer the "Just try to set it persistent and let it fail
if it cannot" model, but there were some issues with that patchset that
I want to revisit.

---

 blockdev.c           | 49 ++++++++++++++++++++++++++++++++++++++++++++
 qapi/block-core.json | 34 ++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index 2d7e7be538..230442e921 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3095,6 +3095,55 @@ void qmp_block_dirty_bitmap_merge(const char *node=
, const char *target,
     do_block_dirty_bitmap_merge(node, target, bitmaps, NULL, errp);
 }
=20
+void qmp_block_dirty_bitmap_persist(const char *node, const char *name,
+                                    bool persist, Error **errp)
+{
+    BdrvDirtyBitmap *bitmap;
+    BlockDriverState *bs;
+    AioContext *aio_context =3D NULL;
+    Error *local_err =3D NULL;
+    bool persistent;
+
+    bitmap =3D block_dirty_bitmap_lookup(node, name, &bs, errp);
+    if (!bitmap || !bs) {
+        return;
+    }
+
+    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, errp)) {
+        return;
+    }
+
+    persistent =3D bdrv_dirty_bitmap_get_persistence(bitmap);
+
+    if (persist !=3D persistent) {
+        aio_context =3D bdrv_get_aio_context(bs);
+        aio_context_acquire(aio_context);
+    }
+
+    if (!persist && persistent) {
+        bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
+        if (local_err !=3D NULL) {
+            error_propagate(errp, local_err);
+            goto out;
+        }
+    }
+
+    if (persist && !persistent) {
+        uint32_t granularity =3D bdrv_dirty_bitmap_granularity(bitmap);
+        if (!bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp=
)) {
+            goto out;
+        }
+    }
+
+    bdrv_dirty_bitmap_set_persistence(bitmap, persistent);
+
+ out:
+    if (aio_context) {
+        aio_context_release(aio_context);
+    }
+    return;
+}
+
 BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char=
 *node,
                                                               const char=
 *name,
                                                               Error **er=
rp)
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 3dbf23d874..9c0957f528 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2001,6 +2001,19 @@
   'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
             '*persistent': 'bool', '*autoload': 'bool', '*disabled': 'bo=
ol' } }
=20
+##
+# @BlockDirtyBitmapPersist:
+#
+# @persist: True sets the specified bitmap as persistent.
+#           False will remove it from storage and mark it transient.
+#
+# Since: 4.2
+##
+{ 'struct': 'BlockDirtyBitmapPersist',
+  'base': 'BlockDirtyBitmap',
+  'data': { 'persist': 'bool' }
+}
+
 ##
 # @BlockDirtyBitmapMergeSource:
 #
@@ -2173,6 +2186,27 @@
       { 'command': 'block-dirty-bitmap-merge',
         'data': 'BlockDirtyBitmapMerge' }
=20
+##
+# @block-dirty-bitmap-persist:
+#
+# Mark a dirty bitmap as either persistent or transient.
+#
+# Returns: nothing on success; including for no-op.
+#          GenericError with explanation if the operation did not succee=
d.
+#
+# Example:
+#
+# -> { "execute": "block-dirty-bitmap-persist",
+#      "arguments": { "node": "drive0",
+#                     "bitmap": "bitmap0",
+#                     "persist": true } }
+# <- { "return": {} }
+#
+# Since: 4.2
+##
+{ 'command': 'block-dirty-bitmap-persist',
+  'data': 'BlockDirtyBitmapPersist' }
+
 ##
 # @BlockDirtyBitmapSha256:
 #
--=20
2.21.0


