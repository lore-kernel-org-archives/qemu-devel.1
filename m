Received: from eggs.gnu.org ([2001:4830:134:3::10]:49039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ6-0007Q7-UI
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIr-0003wb-PU
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:00 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:30 +0200
Message-Id: <1502117160-24655-27-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 26/56] block: Make BlockMeasureInfo sizes
 unsigned in QAPI
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

Sizes should use QAPI type 'size' (uint64_t).  BlockMeasureInfo
members @required and @fully-allocated are 'int' (int64_t).

qcow2_measure() computes their values from qcow2_calc_prealloc_size(),
@virtual_size and @required, all uint64_t (the former only since the
previous commit).

raw_measure() computes them either from bdrv_getlength() or from
qemu_opt_get_size_del().  The former is int64_t, but we error out if
it's negative.  The latter is uint64_t.

Change these BlockMeasureInfo members to 'size'.

qemu-img now reports them correctly above 2^63-1 instead of their
(negative) two's complement.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/raw-format.c   | 10 ++++++----
 qapi/block-core.json |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/raw-format.c b/block/raw-format.c
index 142649e..6b73d5b 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -316,14 +316,16 @@ static BlockMeasureInfo *raw_measure(QemuOpts *opts, BlockDriverState *in_bs,
                                      Error **errp)
 {
     BlockMeasureInfo *info;
-    int64_t required;
+    int64_t size;
+    uint64_t required;
 
     if (in_bs) {
-        required = bdrv_getlength(in_bs);
-        if (required < 0) {
-            error_setg_errno(errp, -required, "Unable to get image size");
+        size = bdrv_getlength(in_bs);
+        if (size < 0) {
+            error_setg_errno(errp, -size, "Unable to get image size");
             return NULL;
         }
+        required = size;
     } else {
         required = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
                             BDRV_SECTOR_SIZE);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 02e12f7..bc8e5b6 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -485,7 +485,7 @@
 # Since: 2.10
 ##
 { 'struct': 'BlockMeasureInfo',
-  'data': {'required': 'int', 'fully-allocated': 'int'} }
+  'data': {'required': 'size', 'fully-allocated': 'size'} }
 
 ##
 # @query-block:
-- 
2.7.5
