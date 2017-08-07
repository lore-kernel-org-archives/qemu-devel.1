Received: from eggs.gnu.org ([2001:4830:134:3::10]:49258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJG-0007aP-Kc
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ1-00044b-9e
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:10 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:38 +0200
Message-Id: <1502117160-24655-35-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 34/56] block: Make BlockDeviceStats sizes,
 offsets unsigned in QAPI/QMP
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

Byte counts and file offsets should use QAPI type 'size' (uint64_t).
BlockDeviceStats members @rd_bytes, @wr_bytes and @wr_highest_offset
are 'int' (int64_t).  bdrv_query_blk_stats() gets them from
BlockAcctStats member nr_bytes[] and stat64_get(), implicitly
converting from uint64_t.

Change all three to 'size'.

query-blockstats now report byte counts and file offsets above 2^63-1
correctly instead of their (negative) two's complement.

So does HMP's "info blockstats".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hmp.c                | 4 ++--
 qapi/block-core.json | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hmp.c b/hmp.c
index 599e816..ecacb7f 100644
--- a/hmp.c
+++ b/hmp.c
@@ -577,8 +577,8 @@ void hmp_info_blockstats(Monitor *mon, const QDict *qdict)
         }
 
         monitor_printf(mon, "%s:", stats->value->device);
-        monitor_printf(mon, " rd_bytes=%" PRId64
-                       " wr_bytes=%" PRId64
+        monitor_printf(mon, " rd_bytes=%" PRIu64
+                       " wr_bytes=%" PRIu64
                        " rd_operations=%" PRId64
                        " wr_operations=%" PRId64
                        " flush_operations=%" PRId64
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 2e0d53c..1d68669 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -704,10 +704,10 @@
 # Since: 0.14.0
 ##
 { 'struct': 'BlockDeviceStats',
-  'data': {'rd_bytes': 'int', 'wr_bytes': 'int', 'rd_operations': 'int',
+  'data': {'rd_bytes': 'size', 'wr_bytes': 'size', 'rd_operations': 'int',
            'wr_operations': 'int', 'flush_operations': 'int',
            'flush_total_time_ns': 'int', 'wr_total_time_ns': 'int',
-           'rd_total_time_ns': 'int', 'wr_highest_offset': 'int',
+           'rd_total_time_ns': 'int', 'wr_highest_offset': 'size',
            'rd_merged': 'int', 'wr_merged': 'int', '*idle_time_ns': 'int',
            'failed_rd_operations': 'int', 'failed_wr_operations': 'int',
            'failed_flush_operations': 'int', 'invalid_rd_operations': 'int',
-- 
2.7.5
