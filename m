Received: from eggs.gnu.org ([2001:4830:134:3::10]:49119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJA-0007SH-IC
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIu-0003yz-Md
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:04 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:35 +0200
Message-Id: <1502117160-24655-32-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 31/56] block: Make throttle byte rates and
 sizes unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Sizes and byte rates should use QAPI type 'size' (uint64_t).
BlockIOThrottle and BlockDeviceInfo members @bps, @bps_rd, @bps_wr,
@bps_max, @bps_rd_max, @bps_wr_max, @iops_size are 'int' (int64_t).
qmp_block_set_io_throttle() and bdrv_block_device_info() copy @bps,
@bps_rd, @bps_wr to / from LeakyBucket member @avg (implicit
conversion to / from double), @bps_max, @bps_rd_max, @bps_wr_max to /
from LeakyBucket member @max (implicit conversion to / from double),
and @iops_size to / from ThrottleConfig member op_size (implicit
conversion to / from uint64_t).

Change these BlockIOThrottle and BlockDeviceInfo members to 'size'.

block_set_io_throttle now accepts sizes and rates between 2^63 and
2^64-1.  It accepts negative values as before, because that's how the
QObject input visitor works for backward compatibility.

Doing the same for HMP's block_set_io_throttle deserves its own commit
(the next one).

query-block and query-named-block-nodes now report sizes and rates
above 2^63-1 correctly instead of their (negative) two's complement.

So does HMP's "info block".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hmp.c                | 12 ++++++------
 qapi/block-core.json | 20 ++++++++++----------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/hmp.c b/hmp.c
index 9bcdcb3..3253674 100644
--- a/hmp.c
+++ b/hmp.c
@@ -468,17 +468,17 @@ static void print_block_info(Monitor *mon, BlockInfo *info,
     if (inserted->bps  || inserted->bps_rd  || inserted->bps_wr  ||
         inserted->iops || inserted->iops_rd || inserted->iops_wr)
     {
-        monitor_printf(mon, "    I/O throttling:   bps=%" PRId64
-                        " bps_rd=%" PRId64  " bps_wr=%" PRId64
-                        " bps_max=%" PRId64
-                        " bps_rd_max=%" PRId64
-                        " bps_wr_max=%" PRId64
+        monitor_printf(mon, "    I/O throttling:   bps=%" PRIu64
+                        " bps_rd=%" PRIu64  " bps_wr=%" PRIu64
+                        " bps_max=%" PRIu64
+                        " bps_rd_max=%" PRIu64
+                        " bps_wr_max=%" PRIu64
                         " iops=%" PRId64 " iops_rd=%" PRId64
                         " iops_wr=%" PRId64
                         " iops_max=%" PRId64
                         " iops_rd_max=%" PRId64
                         " iops_wr_max=%" PRId64
-                        " iops_size=%" PRId64
+                        " iops_size=%" PRIu64
                         " group=%s\n",
                         inserted->bps,
                         inserted->bps_rd,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 9e96590..1e26cb0 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -356,16 +356,16 @@
             '*backing_file': 'str', 'backing_file_depth': 'int',
             'encrypted': 'bool', 'encryption_key_missing': 'bool',
             'detect_zeroes': 'BlockdevDetectZeroesOptions',
-            'bps': 'int', 'bps_rd': 'int', 'bps_wr': 'int',
+            'bps': 'size', 'bps_rd': 'size', 'bps_wr': 'size',
             'iops': 'int', 'iops_rd': 'int', 'iops_wr': 'int',
             'image': 'ImageInfo',
-            '*bps_max': 'int', '*bps_rd_max': 'int',
-            '*bps_wr_max': 'int', '*iops_max': 'int',
+            '*bps_max': 'size', '*bps_rd_max': 'size',
+            '*bps_wr_max': 'size', '*iops_max': 'int',
             '*iops_rd_max': 'int', '*iops_wr_max': 'int',
             '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
             '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
             '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
-            '*iops_size': 'int', '*group': 'str', 'cache': 'BlockdevCacheInfo',
+            '*iops_size': 'size', '*group': 'str', 'cache': 'BlockdevCacheInfo',
             'write_threshold': 'size' } }
 
 ##
@@ -1866,15 +1866,15 @@
 # Since: 1.1
 ##
 { 'struct': 'BlockIOThrottle',
-  'data': { '*device': 'str', '*id': 'str', 'bps': 'int', 'bps_rd': 'int',
-            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr': 'int',
-            '*bps_max': 'int', '*bps_rd_max': 'int',
-            '*bps_wr_max': 'int', '*iops_max': 'int',
-            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
+  'data': { '*device': 'str', '*id': 'str',
+            'bps': 'size', 'bps_rd': 'size', 'bps_wr': 'size',
+            'iops': 'int', 'iops_rd': 'int', 'iops_wr': 'int',
+            '*bps_max': 'size', '*bps_rd_max': 'size', '*bps_wr_max': 'size',
+            '*iops_max': 'int', '*iops_rd_max': 'int', '*iops_wr_max': 'int',
             '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
             '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
             '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
-            '*iops_size': 'int', '*group': 'str' } }
+            '*iops_size': 'size', '*group': 'str' } }
 
 ##
 # @block-stream:
-- 
2.7.5
