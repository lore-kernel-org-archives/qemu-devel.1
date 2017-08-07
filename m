Received: from eggs.gnu.org ([2001:4830:134:3::10]:49147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJB-0007U0-LF
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIv-000405-Vq
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:05 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:34 +0200
Message-Id: <1502117160-24655-31-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 30/56] block: Make write thresholds
 unsigned in QAPI/QMP
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

File offsets should use QAPI type 'size' (uint64_t).
block-set-write-threshold parameter @write-threshold is 'int'
(int64_t).  qmp_block_set_write_threshold() passes it on to
bdrv_write_threshold_set(), implicitly converting to uint64_t.
BLOCK_WRITE_THRESHOLD parameters @write-threshold, @amount-exceeded
are 'int'.  before_write_notify() gets them from BlockDriverState
member write_threshold_offset and bdrv_write_threshold_exceeded(),
implicitly converting from uint64_t.  BlockDeviceInfo members
@write_threshold is 'int'.  bdrv_block_device_info() gets it from
bdrv_write_threshold_get(), implicitly converting from uint64_t.

Change them all to 'size'.  Drop a redundant initializer while there.

block-set-write-threshold now accepts file offsets between 2^63 and
2^64-1.  It accepts negative values as before, because that's how the
QObject input visitor works for backward compatibility.

There is no matching HMP command.

BLOCK_WRITE_THRESHOLD, query-block and query-named-block-nodes now
report write threshold values above 2^63-1 correctly instead of their
(negative) two's complement.

HMP's info block does not report write thresholds.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/write-threshold.c | 2 +-
 qapi/block-core.json    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/write-threshold.c b/block/write-threshold.c
index 0bd1a01..c4572d9 100644
--- a/block/write-threshold.c
+++ b/block/write-threshold.c
@@ -56,7 +56,7 @@ static int coroutine_fn before_write_notify(NotifierWithReturn *notifier,
 {
     BdrvTrackedRequest *req = opaque;
     BlockDriverState *bs = req->bs;
-    uint64_t amount = 0;
+    uint64_t amount;
 
     amount = bdrv_write_threshold_exceeded(bs, req);
     if (amount > 0) {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 60e1b6f..9e96590 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -366,7 +366,7 @@
             '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
             '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
             '*iops_size': 'int', '*group': 'str', 'cache': 'BlockdevCacheInfo',
-            'write_threshold': 'int' } }
+            'write_threshold': 'size' } }
 
 ##
 # @BlockDeviceIoStatus:
@@ -3748,8 +3748,8 @@
 ##
 { 'event': 'BLOCK_WRITE_THRESHOLD',
   'data': { 'node-name': 'str',
-            'amount-exceeded': 'uint64',
-            'write-threshold': 'uint64' } }
+            'amount-exceeded': 'size',
+            'write-threshold': 'size' } }
 
 ##
 # @block-set-write-threshold:
@@ -3779,7 +3779,7 @@
 #
 ##
 { 'command': 'block-set-write-threshold',
-  'data': { 'node-name': 'str', 'write-threshold': 'uint64' } }
+  'data': { 'node-name': 'str', 'write-threshold': 'size' } }
 
 ##
 # @x-blockdev-change:
-- 
2.7.5
