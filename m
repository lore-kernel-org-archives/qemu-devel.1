Received: from eggs.gnu.org ([209.51.188.92]:41598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtMUU-0003z8-Ma
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:04:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtMUO-0008W5-Jb
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:03:58 -0500
From: John Snow <jsnow@redhat.com>
Date: Mon, 11 Feb 2019 20:02:44 -0500
Message-Id: <20190212010248.11056-2-jsnow@redhat.com>
In-Reply-To: <20190212010248.11056-1-jsnow@redhat.com>
References: <20190212010248.11056-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] block/dirty-bitmap: add recording and busy
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>, eblake@redhat.com, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

The current API allows us to report a single status, which we've defined as:

Frozen: has a successor, treated as qmp_locked, may or may not be enabled.
Locked: no successor, qmp_locked. may or may not be enabled.
Disabled: Not frozen or locked, disabled.
Active: Not frozen, locked, or disabled.

The problem is that both "Frozen" and "Locked" mean nearly the same thing,
and that both of them do not intuit whether they are recording guest writes
or not.

This patch deprecates that status field and introduces two orthogonal
properties instead to replace it.
---
 block/dirty-bitmap.c       |  9 +++++++++
 qapi/block-core.json       |  9 ++++++++-
 tests/qemu-iotests/236.out | 28 ++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index c6d4acebfa..101383b3af 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -226,6 +226,13 @@ DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap)
     }
 }
 
+/* Called with BQL taken.  */
+static bool bdrv_dirty_bitmap_recording(BdrvDirtyBitmap *bitmap)
+{
+    return !bitmap->disabled || (bitmap->successor &&
+                                 !bitmap->successor->disabled);
+}
+
 /**
  * Create a successor bitmap destined to replace this bitmap after an operation.
  * Requires that the bitmap is not frozen and has no successor.
@@ -448,6 +455,8 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
         info->has_name = !!bm->name;
         info->name = g_strdup(bm->name);
         info->status = bdrv_dirty_bitmap_status(bm);
+        info->recording = bdrv_dirty_bitmap_recording(bm);
+        info->busy = bdrv_dirty_bitmap_user_locked(bm);
         info->persistent = bm->persistent;
         entry->value = info;
         *plist = entry;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5a0f5f5a95..275f0d573c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -455,7 +455,13 @@
 #
 # @granularity: granularity of the dirty bitmap in bytes (since 1.4)
 #
-# @status: current status of the dirty bitmap (since 2.4)
+# @status: Deprecated in favor of @recording and @locked. (since 4.0)
+#
+# @recording: true if the bitmap is recording new writes from the guest.
+#             Replaces `active` status. (since 4.0)
+#
+# @busy: true if the bitmap is in-use by some operation (NBD or jobs)
+#        and cannot be modified via QMP right now. (since 4.0)
 #
 # @persistent: true if the bitmap will eventually be flushed to persistent
 #              storage (since 4.0)
@@ -464,6 +470,7 @@
 ##
 { 'struct': 'BlockDirtyInfo',
   'data': {'*name': 'str', 'count': 'int', 'granularity': 'uint32',
+           'recording': 'bool', 'busy': 'bool',
            'status': 'DirtyBitmapStatus', 'persistent': 'bool' } }
 
 ##
diff --git a/tests/qemu-iotests/236.out b/tests/qemu-iotests/236.out
index 5006f7bca1..815cd053f0 100644
--- a/tests/qemu-iotests/236.out
+++ b/tests/qemu-iotests/236.out
@@ -22,17 +22,21 @@ write -P0xcd 0x3ff0000 64k
   "bitmaps": {
     "drive0": [
       {
+        "busy": false,
         "count": 262144,
         "granularity": 65536,
         "name": "bitmapB",
         "persistent": false,
+        "recording": true,
         "status": "active"
       },
       {
+        "busy": false,
         "count": 262144,
         "granularity": 65536,
         "name": "bitmapA",
         "persistent": false,
+        "recording": true,
         "status": "active"
       }
     ]
@@ -84,17 +88,21 @@ write -P0xcd 0x3ff0000 64k
   "bitmaps": {
     "drive0": [
       {
+        "busy": false,
         "count": 262144,
         "granularity": 65536,
         "name": "bitmapB",
         "persistent": false,
+        "recording": true,
         "status": "active"
       },
       {
+        "busy": false,
         "count": 262144,
         "granularity": 65536,
         "name": "bitmapA",
         "persistent": false,
+        "recording": true,
         "status": "active"
       }
     ]
@@ -184,24 +192,30 @@ write -P0xea 0x3fe0000 64k
   "bitmaps": {
     "drive0": [
       {
+        "busy": false,
         "count": 393216,
         "granularity": 65536,
         "name": "bitmapC",
         "persistent": false,
+        "recording": false,
         "status": "disabled"
       },
       {
+        "busy": false,
         "count": 262144,
         "granularity": 65536,
         "name": "bitmapB",
         "persistent": false,
+        "recording": false,
         "status": "disabled"
       },
       {
+        "busy": false,
         "count": 458752,
         "granularity": 65536,
         "name": "bitmapA",
         "persistent": false,
+        "recording": false,
         "status": "disabled"
       }
     ]
@@ -251,24 +265,30 @@ write -P0xea 0x3fe0000 64k
   "bitmaps": {
     "drive0": [
       {
+        "busy": false,
         "count": 393216,
         "granularity": 65536,
         "name": "bitmapC",
         "persistent": false,
+        "recording": false,
         "status": "disabled"
       },
       {
+        "busy": false,
         "count": 262144,
         "granularity": 65536,
         "name": "bitmapB",
         "persistent": false,
+        "recording": false,
         "status": "disabled"
       },
       {
+        "busy": false,
         "count": 458752,
         "granularity": 65536,
         "name": "bitmapA",
         "persistent": false,
+        "recording": false,
         "status": "disabled"
       }
     ]
@@ -311,31 +331,39 @@ write -P0xea 0x3fe0000 64k
   "bitmaps": {
     "drive0": [
       {
+        "busy": false,
         "count": 458752,
         "granularity": 65536,
         "name": "bitmapD",
         "persistent": false,
+        "recording": false,
         "status": "disabled"
       },
       {
+        "busy": false,
         "count": 393216,
         "granularity": 65536,
         "name": "bitmapC",
         "persistent": false,
+        "recording": false,
         "status": "disabled"
       },
       {
+        "busy": false,
         "count": 262144,
         "granularity": 65536,
         "name": "bitmapB",
         "persistent": false,
+        "recording": false,
         "status": "disabled"
       },
       {
+        "busy": false,
         "count": 458752,
         "granularity": 65536,
         "name": "bitmapA",
         "persistent": false,
+        "recording": false,
         "status": "disabled"
       }
     ]
-- 
2.17.2
