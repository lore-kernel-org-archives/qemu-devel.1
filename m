Received: from eggs.gnu.org ([209.51.188.92]:44729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqlVQ-0002c0-Tk
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqlQp-0004k0-H3
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:05:33 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  4 Feb 2019 15:05:12 -0600
Message-Id: <20190204210512.27458-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] dirty-bitmap: Expose persistent flag to
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
Cc: jsnow@redhat.com, qemu-block@nongnu.org, andrey.shinkevich@virtuozzo.com, vsementsov@virtuozzo.com, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

Since qemu currently doesn't flush persistent bitmaps to disk until
shutdown (which might be MUCH later), it's useful if 'query-block'
at least shows WHICH bitmaps will (eventually) make it to persistent
storage.  Update affected iotests.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v2: also update iotest output [John]; R-b added since changes only to tes=
ts
---
 qapi/block-core.json       |  5 ++++-
 block/dirty-bitmap.c       |  1 +
 tests/qemu-iotests/124     |  1 +
 tests/qemu-iotests/236.out | 14 ++++++++++++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5f17d67d714..f2bfe566d8d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -447,11 +447,14 @@
 #
 # @status: current status of the dirty bitmap (since 2.4)
 #
+# @persistent: true if the bitmap will eventually be flushed to persiste=
nt
+#              storage (since 4.0)
+#
 # Since: 1.3
 ##
 { 'struct': 'BlockDirtyInfo',
   'data': {'*name': 'str', 'count': 'int', 'granularity': 'uint32',
-           'status': 'DirtyBitmapStatus'} }
+           'status': 'DirtyBitmapStatus', 'persistent': 'bool' } }

 ##
 # @BlockLatencyHistogramInfo:
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 00ea36f5545..e46f72b346c 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -440,6 +440,7 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDri=
verState *bs)
         info->has_name =3D !!bm->name;
         info->name =3D g_strdup(bm->name);
         info->status =3D bdrv_dirty_bitmap_status(bm);
+        info->persistent =3D bm->persistent;
         entry->value =3D info;
         *plist =3D entry;
         plist =3D &entry->next;
diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index 9f189e3b540..5aa1bf1bd64 100755
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -350,6 +350,7 @@ class TestIncrementalBackup(TestIncrementalBackupBase=
):
         self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/count', 4587=
52)
         self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/granularity'=
, 65536)
         self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/status', 'ac=
tive')
+        self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/persistent',=
 False)

         # Prepare a cluster_size=3D128k backup target without a backing =
file.
         (target, _) =3D bitmap0.new_target()
diff --git a/tests/qemu-iotests/236.out b/tests/qemu-iotests/236.out
index bb2d71ea5ec..5006f7bca16 100644
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
--=20
2.20.1
