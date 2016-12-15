Received: from eggs.gnu.org ([2001:4830:134:3::10]:42985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC9-0003uw-Fl
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC6-0001Ue-3m
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38904
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKC5-0001Tf-QY
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:45 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hlaD140205
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:45 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm28ws0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:45 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:44 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:41 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-48-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 47/67] block: Don't mark node clean after
 failed flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Kevin Wolf <kwolf@redhat.com>

Commit 3ff2f67a changed bdrv_co_flush() so that no flush is issues if
the image hasn't been dirtied since the last flush. This is not quite
correct: The condition should be that the image hasn't been dirtied
since the last _successful_ flush. This patch changes the logic
accordingly.

Without this fix, subsequent bdrv_co_flush() calls would return success
without actually doing anything even though the image is still dirty.
The difference is visible in some blkdebug test cases where error
messages incorrectly disappeared after commit 3ff2f67a.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 1478300595-10090-1-git-send-email-kwolf@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit e6af1e085416378918cca357bf2abd8b90224667)

Conflicts:
	block/io.c

* remove context dep on 9972354

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/io.c                         |  4 +++-
 tests/qemu-iotests/026.out         | 22 ++++++++++++++++++++++
 tests/qemu-iotests/026.out.nocache | 22 ++++++++++++++++++++++
 tests/qemu-iotests/071.out         |  2 ++
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 487755a..e579eda 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2381,7 +2381,9 @@ flush_parent:
     ret = bs->file ? bdrv_co_flush(bs->file->bs) : 0;
 out:
     /* Notify any pending flushes that we have completed */
-    bs->flushed_gen = current_gen;
+    if (ret == 0) {
+        bs->flushed_gen = current_gen;
+    }
     bs->active_flush_req = NULL;
     /* Return value is ignored - it's ok if wait queue is empty */
     qemu_co_queue_next(&bs->flush_queue);
diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
index 8531735..59b8f74 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -14,6 +14,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 5; imm: off; once: off; write
+Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 
@@ -22,6 +23,7 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 5; imm: off; once: off; write -b
+Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 
@@ -40,6 +42,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 28; imm: off; once: off; write
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
@@ -48,6 +51,7 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 28; imm: off; once: off; write -b
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
@@ -286,12 +290,14 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 5; imm: off; once: off; write
+Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 5; imm: off; once: off; write -b
+Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
@@ -308,12 +314,14 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 28; imm: off; once: off; write
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 28; imm: off; once: off; write -b
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
@@ -330,12 +338,14 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 5; imm: off; once: off; write
+Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 5; imm: off; once: off; write -b
+Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
@@ -352,12 +362,14 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 28; imm: off; once: off; write
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 28; imm: off; once: off; write -b
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
@@ -374,12 +386,14 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 5; imm: off; once: off; write
+Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 5; imm: off; once: off; write -b
+Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
@@ -396,12 +410,14 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 28; imm: off; once: off; write
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 28; imm: off; once: off; write -b
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
@@ -513,6 +529,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
@@ -521,6 +538,7 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write -b
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
@@ -539,6 +557,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
@@ -547,6 +566,7 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write -b
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
@@ -611,6 +631,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_write_table; errno: 5; imm: off; once: off
+Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
@@ -622,6 +643,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_write_table; errno: 28; imm: off; once: off
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
diff --git a/tests/qemu-iotests/026.out.nocache b/tests/qemu-iotests/026.out.nocache
index 672d77c..b4aeebc 100644
--- a/tests/qemu-iotests/026.out.nocache
+++ b/tests/qemu-iotests/026.out.nocache
@@ -14,6 +14,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_update; errno: 5; imm: off; once: off; write 
+Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 
@@ -22,6 +23,7 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_update; errno: 5; imm: off; once: off; write -b
+Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 
@@ -40,6 +42,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_update; errno: 28; imm: off; once: off; write 
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
@@ -48,6 +51,7 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_update; errno: 28; imm: off; once: off; write -b
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
@@ -294,12 +298,14 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_load; errno: 5; imm: off; once: off; write 
+Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_load; errno: 5; imm: off; once: off; write -b
+Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
@@ -316,12 +322,14 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_load; errno: 28; imm: off; once: off; write 
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_load; errno: 28; imm: off; once: off; write -b
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
@@ -338,12 +346,14 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_update_part; errno: 5; imm: off; once: off; write 
+Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_update_part; errno: 5; imm: off; once: off; write -b
+Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
@@ -360,12 +370,14 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_update_part; errno: 28; imm: off; once: off; write 
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_update_part; errno: 28; imm: off; once: off; write -b
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
@@ -382,12 +394,14 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc; errno: 5; imm: off; once: off; write 
+Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc; errno: 5; imm: off; once: off; write -b
+Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
@@ -404,12 +418,14 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc; errno: 28; imm: off; once: off; write 
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc; errno: 28; imm: off; once: off; write -b
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
@@ -521,6 +537,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write 
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
@@ -529,6 +546,7 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write -b
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
@@ -547,6 +565,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write 
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
@@ -555,6 +574,7 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write -b
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
@@ -619,6 +639,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_grow_write_table; errno: 5; imm: off; once: off
+Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
@@ -630,6 +651,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
 Event: l1_grow_write_table; errno: 28; imm: off; once: off
+Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 No errors were found on the image.
diff --git a/tests/qemu-iotests/071.out b/tests/qemu-iotests/071.out
index 8c6851e..8ff423f 100644
--- a/tests/qemu-iotests/071.out
+++ b/tests/qemu-iotests/071.out
@@ -86,5 +86,7 @@ read failed: Input/output error
 {"return": ""}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
+QEMU_PROG: Failed to flush the L2 table cache: Input/output error
+QEMU_PROG: Failed to flush the refcount block cache: Input/output error
 
 *** done
-- 
1.9.1
