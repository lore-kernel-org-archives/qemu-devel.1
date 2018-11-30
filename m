Received: from eggs.gnu.org ([2001:4830:134:3::10]:60184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gSk4l-0005Lb-2R
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:47:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gSk4g-0003zp-PA
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:47:26 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 30 Nov 2018 14:47:19 +0000
Message-ID: <20181130144705.77454-3-anton.nefedov@virtuozzo.com>
References: <20181130144705.77454-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181130144705.77454-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v6 2/9] qapi: add unmap to BlockDeviceStats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json       | 29 +++++++++++++++++++++++------
 include/block/accounting.h |  1 +
 block/qapi.c               |  6 ++++++
 tests/qemu-iotests/227.out | 18 ++++++++++++++++++
 4 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0fa0743833..959358ccc4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -777,6 +777,8 @@
 #
 # @wr_bytes:      The number of bytes written by the device.
 #
+# @unmap_bytes: The number of bytes unmapped by the device (Since 4.0)
+#
 # @rd_operations: The number of read operations performed by the device.
 #
 # @wr_operations: The number of write operations performed by the device.
@@ -784,6 +786,9 @@
 # @flush_operations: The number of cache flush operations performed by the
 #                    device (since 0.15.0)
 #
+# @unmap_operations: The number of unmap operations performed by the devic=
e
+#                    (Since 4.0)
+#
 # @rd_total_time_ns: Total time spent on reads in nanoseconds (since 0.15.=
0).
 #
 # @wr_total_time_ns: Total time spent on writes in nanoseconds (since 0.15=
.0).
@@ -791,6 +796,9 @@
 # @flush_total_time_ns: Total time spent on cache flushes in nanoseconds
 #                       (since 0.15.0).
 #
+# @unmap_total_time_ns: Total time spent on unmap operations in nanosecond=
s
+#                       (Since 4.0)
+#
 # @wr_highest_offset: The offset after the greatest byte written to the
 #                     device.  The intended use of this information is for
 #                     growable sparse files (like qcow2) that are used on =
top
@@ -802,6 +810,9 @@
 # @wr_merged: Number of write requests that have been merged into another
 #             request (Since 2.3).
 #
+# @unmap_merged: Number of unmap requests that have been merged into anoth=
er
+#                request (Since 4.0)
+#
 # @idle_time_ns: Time since the last I/O operation, in
 #                nanoseconds. If the field is absent it means that
 #                there haven't been any operations yet (Since 2.5).
@@ -815,6 +826,9 @@
 # @failed_flush_operations: The number of failed flush operations
 #                           performed by the device (Since 2.5)
 #
+# @failed_unmap_operations: The number of failed unmap operations performe=
d
+#                           by the device (Since 4.0)
+#
 # @invalid_rd_operations: The number of invalid read operations
 #                          performed by the device (Since 2.5)
 #
@@ -824,6 +838,9 @@
 # @invalid_flush_operations: The number of invalid flush operations
 #                            performed by the device (Since 2.5)
 #
+# @invalid_unmap_operations: The number of invalid unmap operations perfor=
med
+#                            by the device (Since 4.0)
+#
 # @account_invalid: Whether invalid operations are included in the
 #                   last access statistics (Since 2.5)
 #
@@ -842,18 +859,18 @@
 # Since: 0.14.0
 ##
 { 'struct': 'BlockDeviceStats',
-  'data': {'rd_bytes': 'int', 'wr_bytes': 'int',
+  'data': {'rd_bytes': 'int', 'wr_bytes': 'int', 'unmap_bytes' : 'int',
            'rd_operations': 'int', 'wr_operations': 'int',
-           'flush_operations': 'int',
+           'flush_operations': 'int', 'unmap_operations': 'int',
            'rd_total_time_ns': 'int', 'wr_total_time_ns': 'int',
-           'flush_total_time_ns': 'int',
+           'flush_total_time_ns': 'int', 'unmap_total_time_ns': 'int',
            'wr_highest_offset': 'int',
-           'rd_merged': 'int', 'wr_merged': 'int',
+           'rd_merged': 'int', 'wr_merged': 'int', 'unmap_merged': 'int',
            '*idle_time_ns': 'int',
            'failed_rd_operations': 'int', 'failed_wr_operations': 'int',
-           'failed_flush_operations': 'int',
+           'failed_flush_operations': 'int', 'failed_unmap_operations': 'i=
nt',
            'invalid_rd_operations': 'int', 'invalid_wr_operations': 'int',
-           'invalid_flush_operations': 'int',
+           'invalid_flush_operations': 'int', 'invalid_unmap_operations': =
'int',
            'account_invalid': 'bool', 'account_failed': 'bool',
            'timed_stats': ['BlockDeviceTimedStats'],
            '*x_rd_latency_histogram': 'BlockLatencyHistogramInfo',
diff --git a/include/block/accounting.h b/include/block/accounting.h
index d1f67b10dd..ba8b04d572 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -36,6 +36,7 @@ enum BlockAcctType {
     BLOCK_ACCT_READ,
     BLOCK_ACCT_WRITE,
     BLOCK_ACCT_FLUSH,
+    BLOCK_ACCT_UNMAP,
     BLOCK_MAX_IOTYPE,
 };
=20
diff --git a/block/qapi.c b/block/qapi.c
index c66f949db8..df31f351d2 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -432,24 +432,30 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds=
, BlockBackend *blk)
=20
     ds->rd_bytes =3D stats->nr_bytes[BLOCK_ACCT_READ];
     ds->wr_bytes =3D stats->nr_bytes[BLOCK_ACCT_WRITE];
+    ds->unmap_bytes =3D stats->nr_bytes[BLOCK_ACCT_UNMAP];
     ds->rd_operations =3D stats->nr_ops[BLOCK_ACCT_READ];
     ds->wr_operations =3D stats->nr_ops[BLOCK_ACCT_WRITE];
+    ds->unmap_operations =3D stats->nr_ops[BLOCK_ACCT_UNMAP];
=20
     ds->failed_rd_operations =3D stats->failed_ops[BLOCK_ACCT_READ];
     ds->failed_wr_operations =3D stats->failed_ops[BLOCK_ACCT_WRITE];
     ds->failed_flush_operations =3D stats->failed_ops[BLOCK_ACCT_FLUSH];
+    ds->failed_unmap_operations =3D stats->failed_ops[BLOCK_ACCT_UNMAP];
=20
     ds->invalid_rd_operations =3D stats->invalid_ops[BLOCK_ACCT_READ];
     ds->invalid_wr_operations =3D stats->invalid_ops[BLOCK_ACCT_WRITE];
     ds->invalid_flush_operations =3D
         stats->invalid_ops[BLOCK_ACCT_FLUSH];
+    ds->invalid_unmap_operations =3D stats->invalid_ops[BLOCK_ACCT_UNMAP];
=20
     ds->rd_merged =3D stats->merged[BLOCK_ACCT_READ];
     ds->wr_merged =3D stats->merged[BLOCK_ACCT_WRITE];
+    ds->unmap_merged =3D stats->merged[BLOCK_ACCT_UNMAP];
     ds->flush_operations =3D stats->nr_ops[BLOCK_ACCT_FLUSH];
     ds->wr_total_time_ns =3D stats->total_time_ns[BLOCK_ACCT_WRITE];
     ds->rd_total_time_ns =3D stats->total_time_ns[BLOCK_ACCT_READ];
     ds->flush_total_time_ns =3D stats->total_time_ns[BLOCK_ACCT_FLUSH];
+    ds->unmap_total_time_ns =3D stats->total_time_ns[BLOCK_ACCT_UNMAP];
=20
     ds->has_idle_time_ns =3D stats->last_access_time_ns > 0;
     if (ds->has_idle_time_ns) {
diff --git a/tests/qemu-iotests/227.out b/tests/qemu-iotests/227.out
index 736f2e3b11..62a9dbaffa 100644
--- a/tests/qemu-iotests/227.out
+++ b/tests/qemu-iotests/227.out
@@ -15,6 +15,8 @@ Testing: -drive driver=3Dnull-co,if=3Dvirtio
         {
             "device": "virtio0",
             "stats": {
+                "unmap_operations": 0,
+                "unmap_merged": 0,
                 "flush_total_time_ns": 0,
                 "wr_highest_offset": 0,
                 "wr_total_time_ns": 0,
@@ -24,13 +26,17 @@ Testing: -drive driver=3Dnull-co,if=3Dvirtio
                 "wr_bytes": 0,
                 "timed_stats": [
                 ],
+                "failed_unmap_operations": 0,
                 "failed_flush_operations": 0,
                 "account_invalid": true,
                 "rd_total_time_ns": 0,
+                "invalid_unmap_operations": 0,
                 "flush_operations": 0,
                 "wr_operations": 0,
+                "unmap_bytes": 0,
                 "rd_merged": 0,
                 "rd_bytes": 0,
+                "unmap_total_time_ns": 0,
                 "invalid_flush_operations": 0,
                 "account_failed": true,
                 "rd_operations": 0,
@@ -73,6 +79,8 @@ Testing: -drive driver=3Dnull-co,if=3Dnone
         {
             "device": "none0",
             "stats": {
+                "unmap_operations": 0,
+                "unmap_merged": 0,
                 "flush_total_time_ns": 0,
                 "wr_highest_offset": 0,
                 "wr_total_time_ns": 0,
@@ -82,13 +90,17 @@ Testing: -drive driver=3Dnull-co,if=3Dnone
                 "wr_bytes": 0,
                 "timed_stats": [
                 ],
+                "failed_unmap_operations": 0,
                 "failed_flush_operations": 0,
                 "account_invalid": true,
                 "rd_total_time_ns": 0,
+                "invalid_unmap_operations": 0,
                 "flush_operations": 0,
                 "wr_operations": 0,
+                "unmap_bytes": 0,
                 "rd_merged": 0,
                 "rd_bytes": 0,
+                "unmap_total_time_ns": 0,
                 "invalid_flush_operations": 0,
                 "account_failed": true,
                 "rd_operations": 0,
@@ -160,6 +172,8 @@ Testing: -blockdev driver=3Dnull-co,node-name=3Dnull -d=
evice virtio-blk,drive=3Dnull,i
         {
             "device": "",
             "stats": {
+                "unmap_operations": 0,
+                "unmap_merged": 0,
                 "flush_total_time_ns": 0,
                 "wr_highest_offset": 0,
                 "wr_total_time_ns": 0,
@@ -169,13 +183,17 @@ Testing: -blockdev driver=3Dnull-co,node-name=3Dnull =
-device virtio-blk,drive=3Dnull,i
                 "wr_bytes": 0,
                 "timed_stats": [
                 ],
+                "failed_unmap_operations": 0,
                 "failed_flush_operations": 0,
                 "account_invalid": false,
                 "rd_total_time_ns": 0,
+                "invalid_unmap_operations": 0,
                 "flush_operations": 0,
                 "wr_operations": 0,
+                "unmap_bytes": 0,
                 "rd_merged": 0,
                 "rd_bytes": 0,
+                "unmap_total_time_ns": 0,
                 "invalid_flush_operations": 0,
                 "account_failed": false,
                 "rd_operations": 0,
--=20
2.17.1
