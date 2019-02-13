Received: from eggs.gnu.org ([209.51.188.92]:50076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gu4HB-0002Uk-OM
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 18:49:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gu4HA-0003ch-Na
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 18:49:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gu4HA-0003cK-FM
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 18:49:12 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 13 Feb 2019 18:49:05 -0500
Message-Id: <20190213234907.24173-2-jsnow@redhat.com>
In-Reply-To: <20190213234907.24173-1-jsnow@redhat.com>
References: <20190213234907.24173-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] dirty-bitmap: Expose persistent flag to
 'query-block'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Eric Blake <eblake@redhat.com>

From: Eric Blake <eblake@redhat.com>

Since qemu currently doesn't flush persistent bitmaps to disk until
shutdown (which might be MUCH later), it's useful if 'query-block'
at least shows WHICH bitmaps will (eventually) make it to persistent
storage.  Update affected iotests.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20190204210512.27458-1-eblake@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c       |  1 +
 qapi/block-core.json       |  5 ++++-
 tests/qemu-iotests/124     |  1 +
 tests/qemu-iotests/236.out | 14 ++++++++++++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 00ea36f554..e46f72b346 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -440,6 +440,7 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
         info->has_name = !!bm->name;
         info->name = g_strdup(bm->name);
         info->status = bdrv_dirty_bitmap_status(bm);
+        info->persistent = bm->persistent;
         entry->value = info;
         *plist = entry;
         plist = &entry->next;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0f349d4603..7e8656d04c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -450,11 +450,14 @@
 #
 # @status: current status of the dirty bitmap (since 2.4)
 #
+# @persistent: true if the bitmap will eventually be flushed to persistent
+#              storage (since 4.0)
+#
 # Since: 1.3
 ##
 { 'struct': 'BlockDirtyInfo',
   'data': {'*name': 'str', 'count': 'int', 'granularity': 'uint32',
-           'status': 'DirtyBitmapStatus'} }
+           'status': 'DirtyBitmapStatus', 'persistent': 'bool' } }
 
 ##
 # @Qcow2BitmapInfoFlags:
diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index 9f189e3b54..5aa1bf1bd6 100755
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -350,6 +350,7 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
         self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/count', 458752)
         self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/granularity', 65536)
         self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/status', 'active')
+        self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/persistent', False)
 
         # Prepare a cluster_size=128k backup target without a backing file.
         (target, _) = bitmap0.new_target()
diff --git a/tests/qemu-iotests/236.out b/tests/qemu-iotests/236.out
index bb2d71ea5e..5006f7bca1 100644
--- a/tests/qemu-iotests/236.out
+++ b/tests/qemu-iotests/236.out
@@ -25,12 +25,14 @@ write -P0xcd 0x3ff0000 64k
         "count": 262144,
         "granularity": 65536,
         "name": "bitmapB",
+        "persistent": false,
         "status": "active"
       },
       {
         "count": 262144,
         "granularity": 65536,
         "name": "bitmapA",
+        "persistent": false,
         "status": "active"
       }
     ]
@@ -85,12 +87,14 @@ write -P0xcd 0x3ff0000 64k
         "count": 262144,
         "granularity": 65536,
         "name": "bitmapB",
+        "persistent": false,
         "status": "active"
       },
       {
         "count": 262144,
         "granularity": 65536,
         "name": "bitmapA",
+        "persistent": false,
         "status": "active"
       }
     ]
@@ -183,18 +187,21 @@ write -P0xea 0x3fe0000 64k
         "count": 393216,
         "granularity": 65536,
         "name": "bitmapC",
+        "persistent": false,
         "status": "disabled"
       },
       {
         "count": 262144,
         "granularity": 65536,
         "name": "bitmapB",
+        "persistent": false,
         "status": "disabled"
       },
       {
         "count": 458752,
         "granularity": 65536,
         "name": "bitmapA",
+        "persistent": false,
         "status": "disabled"
       }
     ]
@@ -247,18 +254,21 @@ write -P0xea 0x3fe0000 64k
         "count": 393216,
         "granularity": 65536,
         "name": "bitmapC",
+        "persistent": false,
         "status": "disabled"
       },
       {
         "count": 262144,
         "granularity": 65536,
         "name": "bitmapB",
+        "persistent": false,
         "status": "disabled"
       },
       {
         "count": 458752,
         "granularity": 65536,
         "name": "bitmapA",
+        "persistent": false,
         "status": "disabled"
       }
     ]
@@ -304,24 +314,28 @@ write -P0xea 0x3fe0000 64k
         "count": 458752,
         "granularity": 65536,
         "name": "bitmapD",
+        "persistent": false,
         "status": "disabled"
       },
       {
         "count": 393216,
         "granularity": 65536,
         "name": "bitmapC",
+        "persistent": false,
         "status": "disabled"
       },
       {
         "count": 262144,
         "granularity": 65536,
         "name": "bitmapB",
+        "persistent": false,
         "status": "disabled"
       },
       {
         "count": 458752,
         "granularity": 65536,
         "name": "bitmapA",
+        "persistent": false,
         "status": "disabled"
       }
     ]
-- 
2.17.2
