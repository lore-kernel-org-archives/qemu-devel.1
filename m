Received: from eggs.gnu.org ([2001:4830:134:3::10]:55761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Cb8-0001yK-Hh
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Cax-0001In-H1
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:38 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:15 +0200
Message-Id: <1493411622-5343-8-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/34] qemu-iotests: Filter HMP readline escape
 characters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

The only thing the escape characters achieve is making the reference
output unreadable and lines that are potentially so long that git
doesn't want to put them into an email any more. Let's filter them out.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/028.out       |   2 +-
 tests/qemu-iotests/051           |   3 +-
 tests/qemu-iotests/051.out       | 106 +++++++++++++++----------------
 tests/qemu-iotests/051.pc.out    | 132 +++++++++++++++++++--------------------
 tests/qemu-iotests/068           |   4 +-
 tests/qemu-iotests/068.out       |   6 +-
 tests/qemu-iotests/130.out       |   4 +-
 tests/qemu-iotests/142           |   2 +-
 tests/qemu-iotests/142.out       |  10 +--
 tests/qemu-iotests/145           |   3 +-
 tests/qemu-iotests/145.out       |   2 +-
 tests/qemu-iotests/common.filter |   7 +++
 tests/qemu-iotests/common.qemu   |   4 +-
 13 files changed, 147 insertions(+), 138 deletions(-)

diff --git a/tests/qemu-iotests/028.out b/tests/qemu-iotests/028.out
index acd2870..7d54aeb 100644
--- a/tests/qemu-iotests/028.out
+++ b/tests/qemu-iotests/028.out
@@ -469,7 +469,7 @@ No errors were found on the image.
 block-backup
 
 Formatting 'TEST_DIR/t.IMGFMT.copy', fmt=IMGFMT size=4294968832 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K[D[D[D[D[D[D[D[D[D[Dinfo block-[K[D[D[D[D[D[D[D[D[D[D[Dinfo block-j[K[D[D[D[D[D[D[D[D[D[D[D[Dinfo block-jo[K[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block-job[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block-jobs[K
+(qemu) info block-jobs
 No active jobs
 === IO: pattern 195
 read 512/512 bytes at offset 3221194240
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 630cb7a..7c78a02 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -60,7 +60,8 @@ function do_run_qemu()
 
 function run_qemu()
 {
-    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_generated_node_ids
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu |
+        _filter_generated_node_ids | _filter_hmp
 }
 
 size=128M
diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index 7524c62..3b7b040 100644
--- a/tests/qemu-iotests/051.out
+++ b/tests/qemu-iotests/051.out
@@ -58,12 +58,12 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive file=TEST_DIR/t.qcow2,driver=qcow2,backing.file.filename=TEST_DIR/t.qcow2.orig,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K
+(qemu) info block
 drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.orig (chain depth: 1)
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,driver=raw,backing.file.filename=TEST_DIR/t.qcow2.orig
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,driver=raw,backing.file.filename=TEST_DIR/t.qcow2.orig: Driver doesn't support backing files
@@ -79,11 +79,11 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,file.backing.driver=qcow2,file.backing.f
 
 Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=on
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=off
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=: Parameter 'lazy-refcounts' expects 'on' or 'off'
@@ -103,7 +103,7 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=on: Lazy ref
 
 Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=off
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 
 === No medium ===
@@ -117,93 +117,93 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=virtio,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 
 === Cache modes ===
 
 Testing: -drive driver=null-co,cache=none
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive driver=null-co,cache=directsync
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive driver=null-co,cache=writeback
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive driver=null-co,cache=writethrough
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive driver=null-co,cache=unsafe
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive driver=null-co,cache=invalid_value
 QEMU_PROG: -drive driver=null-co,cache=invalid_value: invalid cache option
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writeback,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K
+(qemu) info block
 drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K[D[D[D[D[D[D[D[D[D[Dinfo block [K[D[D[D[D[D[D[D[D[D[D[Dinfo block f[K[D[D[D[D[D[D[D[D[D[D[D[Dinfo block fi[K[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block fil[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block file[K
+(qemu) info block file
 
 file: TEST_DIR/t.qcow2 (file)
     Cache mode:       writeback
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K[D[D[D[D[D[D[D[D[D[Dinfo block [K[D[D[D[D[D[D[D[D[D[D[Dinfo block b[K[D[D[D[D[D[D[D[D[D[D[D[Dinfo block ba[K[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block bac[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block back[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backi[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backin[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing[K
+(qemu) info block backing
 backing: TEST_DIR/t.qcow2.base (qcow2, read-only)
     Cache mode:       writeback, ignore flushes
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K[D[D[D[D[D[D[D[D[D[Dinfo block [K[D[D[D[D[D[D[D[D[D[D[Dinfo block b[K[D[D[D[D[D[D[D[D[D[D[D[Dinfo block ba[K[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block bac[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block back[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backi[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backin[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-f[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-fi[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinf
 o block backing-fil[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-file[K
+(qemu) info block backing-file
 
 backing-file: TEST_DIR/t.qcow2.base (file, read-only)
     Cache mode:       writeback, ignore flushes
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writethrough,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K
+(qemu) info block
 drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writethrough
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K[D[D[D[D[D[D[D[D[D[Dinfo block [K[D[D[D[D[D[D[D[D[D[D[Dinfo block f[K[D[D[D[D[D[D[D[D[D[D[D[Dinfo block fi[K[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block fil[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block file[K
+(qemu) info block file
 
 file: TEST_DIR/t.qcow2 (file)
     Cache mode:       writeback
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K[D[D[D[D[D[D[D[D[D[Dinfo block [K[D[D[D[D[D[D[D[D[D[D[Dinfo block b[K[D[D[D[D[D[D[D[D[D[D[D[Dinfo block ba[K[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block bac[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block back[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backi[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backin[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing[K
+(qemu) info block backing
 backing: TEST_DIR/t.qcow2.base (qcow2, read-only)
     Cache mode:       writeback, ignore flushes
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K[D[D[D[D[D[D[D[D[D[Dinfo block [K[D[D[D[D[D[D[D[D[D[D[Dinfo block b[K[D[D[D[D[D[D[D[D[D[D[D[Dinfo block ba[K[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block bac[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block back[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backi[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backin[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-f[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-fi[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinf
 o block backing-fil[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-file[K
+(qemu) info block backing-file
 
 backing-file: TEST_DIR/t.qcow2.base (file, read-only)
     Cache mode:       writeback, ignore flushes
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=unsafe,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K
+(qemu) info block
 drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback, ignore flushes
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K[D[D[D[D[D[D[D[D[D[Dinfo block [K[D[D[D[D[D[D[D[D[D[D[Dinfo block f[K[D[D[D[D[D[D[D[D[D[D[D[Dinfo block fi[K[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block fil[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block file[K
+(qemu) info block file
 
 file: TEST_DIR/t.qcow2 (file)
     Cache mode:       writeback, ignore flushes
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K[D[D[D[D[D[D[D[D[D[Dinfo block [K[D[D[D[D[D[D[D[D[D[D[Dinfo block b[K[D[D[D[D[D[D[D[D[D[D[D[Dinfo block ba[K[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block bac[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block back[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backi[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backin[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing[K
+(qemu) info block backing
 backing: TEST_DIR/t.qcow2.base (qcow2, read-only)
     Cache mode:       writeback, ignore flushes
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K[D[D[D[D[D[D[D[D[D[Dinfo block [K[D[D[D[D[D[D[D[D[D[D[Dinfo block b[K[D[D[D[D[D[D[D[D[D[D[D[Dinfo block ba[K[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block bac[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block back[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backi[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backin[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-f[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-fi[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinf
 o block backing-fil[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-file[K
+(qemu) info block backing-file
 
 backing-file: TEST_DIR/t.qcow2.base (file, read-only)
     Cache mode:       writeback, ignore flushes
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=invalid_value,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,cache=invalid_value,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0: invalid cache option
@@ -213,7 +213,7 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,cache=invalid_value,backing.file.filenam
 
 Testing: -drive file=TEST_DIR/t.qcow2,file.driver=file
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 
 === Leaving out required options ===
@@ -307,15 +307,15 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,throttling.bps-total=-5: bps/iops/max va
 
 Testing: -drive file=TEST_DIR/t.qcow2,bps=0
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,bps=1
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,bps=1000000000000000
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,bps=1000000000000001
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,bps=1000000000000001: bps/iops/max values must be within [0, 1000000000000000]
@@ -337,11 +337,11 @@ QEMU_PROG: -drive file.filename=foo:bar: Could not open 'foo:bar': No such file
 
 Testing: -hda file:TEST_DIR/t.qcow2
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=file:TEST_DIR/t.qcow2
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file.filename=file:TEST_DIR/t.qcow2
 QEMU_PROG: -drive file.filename=file:TEST_DIR/t.qcow2: Could not open 'file:TEST_DIR/t.qcow2': No such file or directory
@@ -353,78 +353,78 @@ wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=drive0 -snapshot
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqe[K[D[Dqem[K[D[D[Dqemu[K[D[D[D[Dqemu-[K[D[D[D[D[Dqemu-i[K[D[D[D[D[D[Dqemu-io[K[D[D[D[D[D[D[Dqemu-io [K[D[D[D[D[D[D[D[Dqemu-io d[K[D[D[D[D[D[D[D[D[Dqemu-io dr[K[D[D[D[D[D[D[D[D[D[Dqemu-io dri[K[D[D[D[D[D[D[D[D[D[D[Dqemu-io driv[K[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive[K[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "w[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wr[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wri[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "writ[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqem
 u-io drive0 "write [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x2[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0[K[D
 [D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k"[K
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,snapshot=on,if=none,id=drive0
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqe[K[D[Dqem[K[D[D[Dqemu[K[D[D[D[Dqemu-[K[D[D[D[D[Dqemu-i[K[D[D[D[D[D[Dqemu-io[K[D[D[D[D[D[D[Dqemu-io [K[D[D[D[D[D[D[D[Dqemu-io d[K[D[D[D[D[D[D[D[D[Dqemu-io dr[K[D[D[D[D[D[D[D[D[D[Dqemu-io dri[K[D[D[D[D[D[D[D[D[D[D[Dqemu-io driv[K[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive[K[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "w[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wr[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wri[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "writ[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqem
 u-io drive0 "write [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x2[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0[K[D
 [D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k"[K
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file.filename=TEST_DIR/t.qcow2,driver=qcow2,snapshot=on,if=none,id=drive0
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqe[K[D[Dqem[K[D[D[Dqemu[K[D[D[D[Dqemu-[K[D[D[D[D[Dqemu-i[K[D[D[D[D[D[Dqemu-io[K[D[D[D[D[D[D[Dqemu-io [K[D[D[D[D[D[D[D[Dqemu-io d[K[D[D[D[D[D[D[D[D[Dqemu-io dr[K[D[D[D[D[D[D[D[D[D[Dqemu-io dri[K[D[D[D[D[D[D[D[D[D[D[Dqemu-io driv[K[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive[K[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "w[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wr[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wri[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "writ[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqem
 u-io drive0 "write [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x2[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0[K[D
 [D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k"[K
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file.filename=TEST_DIR/t.qcow2,driver=qcow2,if=none,id=drive0 -snapshot
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqe[K[D[Dqem[K[D[D[Dqemu[K[D[D[D[Dqemu-[K[D[D[D[D[Dqemu-i[K[D[D[D[D[D[Dqemu-io[K[D[D[D[D[D[D[Dqemu-io [K[D[D[D[D[D[D[D[Dqemu-io d[K[D[D[D[D[D[D[D[D[Dqemu-io dr[K[D[D[D[D[D[D[D[D[D[Dqemu-io dri[K[D[D[D[D[D[D[D[D[D[D[Dqemu-io driv[K[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive[K[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "w[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wr[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wri[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "writ[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqem
 u-io drive0 "write [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x2[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0[K[D
 [D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k"[K
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=file:TEST_DIR/t.qcow2,if=none,id=drive0 -snapshot
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqe[K[D[Dqem[K[D[D[Dqemu[K[D[D[D[Dqemu-[K[D[D[D[D[Dqemu-i[K[D[D[D[D[D[Dqemu-io[K[D[D[D[D[D[D[Dqemu-io [K[D[D[D[D[D[D[D[Dqemu-io d[K[D[D[D[D[D[D[D[D[Dqemu-io dr[K[D[D[D[D[D[D[D[D[D[Dqemu-io dri[K[D[D[D[D[D[D[D[D[D[D[Dqemu-io driv[K[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive[K[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "w[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wr[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wri[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "writ[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqem
 u-io drive0 "write [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x2[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0[K[D
 [D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k"[K
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=file:TEST_DIR/t.qcow2,snapshot=on,if=none,id=drive0
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqe[K[D[Dqem[K[D[D[Dqemu[K[D[D[D[Dqemu-[K[D[D[D[D[Dqemu-i[K[D[D[D[D[D[Dqemu-io[K[D[D[D[D[D[D[Dqemu-io [K[D[D[D[D[D[D[D[Dqemu-io d[K[D[D[D[D[D[D[D[D[Dqemu-io dr[K[D[D[D[D[D[D[D[D[D[Dqemu-io dri[K[D[D[D[D[D[D[D[D[D[D[Dqemu-io driv[K[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive[K[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "w[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wr[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wri[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "writ[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqem
 u-io drive0 "write [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x2[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0[K[D
 [D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k"[K
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=drive0 -snapshot
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqe[K[D[Dqem[K[D[D[Dqemu[K[D[D[D[Dqemu-[K[D[D[D[D[Dqemu-i[K[D[D[D[D[D[Dqemu-io[K[D[D[D[D[D[D[Dqemu-io [K[D[D[D[D[D[D[D[Dqemu-io d[K[D[D[D[D[D[D[D[D[Dqemu-io dr[K[D[D[D[D[D[D[D[D[D[Dqemu-io dri[K[D[D[D[D[D[D[D[D[D[D[Dqemu-io driv[K[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive[K[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "w[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wr[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wri[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "writ[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqem
 u-io drive0 "write [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x2[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0[K[D
 [D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k"[K
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,snapshot=on,if=none,id=drive0
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqe[K[D[Dqem[K[D[D[Dqemu[K[D[D[D[Dqemu-[K[D[D[D[D[Dqemu-i[K[D[D[D[D[D[Dqemu-io[K[D[D[D[D[D[D[Dqemu-io [K[D[D[D[D[D[D[D[Dqemu-io d[K[D[D[D[D[D[D[D[D[Dqemu-io dr[K[D[D[D[D[D[D[D[D[D[Dqemu-io dri[K[D[D[D[D[D[D[D[D[D[D[Dqemu-io driv[K[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive[K[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "w[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wr[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wri[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "writ[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqem
 u-io drive0 "write [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x2[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0[K[D
 [D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k"[K
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Testing: -drive file=TEST_DIR/t.qcow2,snapshot=off,if=none,id=drive0
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqe[K[D[Dqem[K[D[D[Dqemu[K[D[D[D[Dqemu-[K[D[D[D[D[Dqemu-i[K[D[D[D[D[D[Dqemu-io[K[D[D[D[D[D[D[Dqemu-io [K[D[D[D[D[D[D[D[Dqemu-io d[K[D[D[D[D[D[D[D[D[Dqemu-io dr[K[D[D[D[D[D[D[D[D[D[Dqemu-io dri[K[D[D[D[D[D[D[D[D[D[D[Dqemu-io driv[K[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive[K[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "w[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wr[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wri[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "writ[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqem
 u-io drive0 "write [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x2[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0[K[D
 [D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k"[K
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Testing: -drive file=TEST_DIR/t.qcow2,snapshot=on,if=none,id=drive0
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqe[K[D[Dqem[K[D[D[Dqemu[K[D[D[D[Dqemu-[K[D[D[D[D[Dqemu-i[K[D[D[D[D[D[Dqemu-io[K[D[D[D[D[D[D[Dqemu-io [K[D[D[D[D[D[D[D[Dqemu-io d[K[D[D[D[D[D[D[D[D[Dqemu-io dr[K[D[D[D[D[D[D[D[D[D[Dqemu-io dri[K[D[D[D[D[D[D[D[D[D[D[Dqemu-io driv[K[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive[K[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "w[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wr[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wri[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "writ[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqem
 u-io drive0 "write [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x3[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x33[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x33 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x33 0[K[D
 [D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x33 0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x33 0 4[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x33 0 4k[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x33 0 4k"[K
+(qemu) qemu-io drive0 "write -P 0x33 0 4k"
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) c[K[Dco[K[D[Dcom[K[D[D[Dcomm[K[D[D[D[Dcommi[K[D[D[D[D[Dcommit[K[D[D[D[D[D[Dcommit [K[D[D[D[D[D[D[Dcommit d[K[D[D[D[D[D[D[D[Dcommit dr[K[D[D[D[D[D[D[D[D[Dcommit dri[K[D[D[D[D[D[D[D[D[D[Dcommit driv[K[D[D[D[D[D[D[D[D[D[D[Dcommit drive[K[D[D[D[D[D[D[D[D[D[D[D[Dcommit drive0[K
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) commit drive0
+(qemu) quit
 
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index c6f4eef..7f9a121 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -58,12 +58,12 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive file=TEST_DIR/t.qcow2,driver=qcow2,backing.file.filename=TEST_DIR/t.qcow2.orig,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K
+(qemu) info block
 drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.orig (chain depth: 1)
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,driver=raw,backing.file.filename=TEST_DIR/t.qcow2.orig
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,driver=raw,backing.file.filename=TEST_DIR/t.qcow2.orig: Driver doesn't support backing files
@@ -79,11 +79,11 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,file.backing.driver=qcow2,file.backing.f
 
 Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=on
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=off
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=: Parameter 'lazy-refcounts' expects 'on' or 'off'
@@ -103,23 +103,23 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=on: Lazy ref
 
 Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=off
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 
 === No medium ===
 
 Testing: -drive if=floppy
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive if=ide,media=cdrom
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive if=scsi,media=cdrom
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) QEMU_PROG: -drive if=scsi,media=cdrom: warning: bus=0,unit=0 is deprecated with this machine type
-q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+quit
 
 Testing: -drive if=ide
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -137,11 +137,11 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive if=none,id=disk -device ide-cd,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive if=none,id=disk -device lsi53c895a -device scsi-cd,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive if=none,id=disk -device ide-drive,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -166,16 +166,16 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=floppy,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=ide,media=cdrom,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=scsi,media=cdrom,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=scsi,media=cdrom,readonly=on: warning: bus=0,unit=0 is deprecated with this machine type
-q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=ide,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -185,19 +185,19 @@ QEMU_PROG: Initialization of device ide-hd failed: Device initialization failed.
 Testing: -drive file=TEST_DIR/t.qcow2,if=scsi,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=scsi,readonly=on: warning: bus=0,unit=0 is deprecated with this machine type
-q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=virtio,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device ide-cd,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device lsi53c895a -device scsi-cd,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device ide-drive,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -211,97 +211,97 @@ QEMU_PROG: -device ide-hd,drive=disk: Device initialization failed.
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device lsi53c895a -device scsi-disk,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device lsi53c895a -device scsi-hd,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 
 === Cache modes ===
 
 Testing: -drive driver=null-co,cache=none
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive driver=null-co,cache=directsync
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive driver=null-co,cache=writeback
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive driver=null-co,cache=writethrough
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive driver=null-co,cache=unsafe
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive driver=null-co,cache=invalid_value
 QEMU_PROG: -drive driver=null-co,cache=invalid_value: invalid cache option
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writeback,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K
+(qemu) info block
 drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K[D[D[D[D[D[D[D[D[D[Dinfo block [K[D[D[D[D[D[D[D[D[D[D[Dinfo block f[K[D[D[D[D[D[D[D[D[D[D[D[Dinfo block fi[K[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block fil[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block file[K
+(qemu) info block file
 
 file: TEST_DIR/t.qcow2 (file)
     Cache mode:       writeback
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K[D[D[D[D[D[D[D[D[D[Dinfo block [K[D[D[D[D[D[D[D[D[D[D[Dinfo block b[K[D[D[D[D[D[D[D[D[D[D[D[Dinfo block ba[K[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block bac[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block back[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backi[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backin[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing[K
+(qemu) info block backing
 backing: TEST_DIR/t.qcow2.base (qcow2, read-only)
     Cache mode:       writeback, ignore flushes
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K[D[D[D[D[D[D[D[D[D[Dinfo block [K[D[D[D[D[D[D[D[D[D[D[Dinfo block b[K[D[D[D[D[D[D[D[D[D[D[D[Dinfo block ba[K[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block bac[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block back[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backi[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backin[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-f[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-fi[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinf
 o block backing-fil[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-file[K
+(qemu) info block backing-file
 
 backing-file: TEST_DIR/t.qcow2.base (file, read-only)
     Cache mode:       writeback, ignore flushes
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writethrough,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K
+(qemu) info block
 drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writethrough
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K[D[D[D[D[D[D[D[D[D[Dinfo block [K[D[D[D[D[D[D[D[D[D[D[Dinfo block f[K[D[D[D[D[D[D[D[D[D[D[D[Dinfo block fi[K[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block fil[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block file[K
+(qemu) info block file
 
 file: TEST_DIR/t.qcow2 (file)
     Cache mode:       writeback
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K[D[D[D[D[D[D[D[D[D[Dinfo block [K[D[D[D[D[D[D[D[D[D[D[Dinfo block b[K[D[D[D[D[D[D[D[D[D[D[D[Dinfo block ba[K[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block bac[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block back[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backi[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backin[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing[K
+(qemu) info block backing
 backing: TEST_DIR/t.qcow2.base (qcow2, read-only)
     Cache mode:       writeback, ignore flushes
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K[D[D[D[D[D[D[D[D[D[Dinfo block [K[D[D[D[D[D[D[D[D[D[D[Dinfo block b[K[D[D[D[D[D[D[D[D[D[D[D[Dinfo block ba[K[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block bac[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block back[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backi[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backin[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-f[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-fi[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinf
 o block backing-fil[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-file[K
+(qemu) info block backing-file
 
 backing-file: TEST_DIR/t.qcow2.base (file, read-only)
     Cache mode:       writeback, ignore flushes
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=unsafe,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K
+(qemu) info block
 drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback, ignore flushes
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K[D[D[D[D[D[D[D[D[D[Dinfo block [K[D[D[D[D[D[D[D[D[D[D[Dinfo block f[K[D[D[D[D[D[D[D[D[D[D[D[Dinfo block fi[K[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block fil[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block file[K
+(qemu) info block file
 
 file: TEST_DIR/t.qcow2 (file)
     Cache mode:       writeback, ignore flushes
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K[D[D[D[D[D[D[D[D[D[Dinfo block [K[D[D[D[D[D[D[D[D[D[D[Dinfo block b[K[D[D[D[D[D[D[D[D[D[D[D[Dinfo block ba[K[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block bac[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block back[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backi[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backin[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing[K
+(qemu) info block backing
 backing: TEST_DIR/t.qcow2.base (qcow2, read-only)
     Cache mode:       writeback, ignore flushes
-(qemu) i[K[Din[K[D[Dinf[K[D[D[Dinfo[K[D[D[D[Dinfo [K[D[D[D[D[Dinfo b[K[D[D[D[D[D[Dinfo bl[K[D[D[D[D[D[D[Dinfo blo[K[D[D[D[D[D[D[D[Dinfo bloc[K[D[D[D[D[D[D[D[D[Dinfo block[K[D[D[D[D[D[D[D[D[D[Dinfo block [K[D[D[D[D[D[D[D[D[D[D[Dinfo block b[K[D[D[D[D[D[D[D[D[D[D[D[Dinfo block ba[K[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block bac[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block back[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backi[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backin[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-f[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-fi[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinf
 o block backing-fil[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dinfo block backing-file[K
+(qemu) info block backing-file
 
 backing-file: TEST_DIR/t.qcow2.base (file, read-only)
     Cache mode:       writeback, ignore flushes
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=invalid_value,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,cache=invalid_value,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0: invalid cache option
@@ -311,7 +311,7 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,cache=invalid_value,backing.file.filenam
 
 Testing: -drive file=TEST_DIR/t.qcow2,file.driver=file
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 
 === Leaving out required options ===
@@ -405,15 +405,15 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,throttling.bps-total=-5: bps/iops/max va
 
 Testing: -drive file=TEST_DIR/t.qcow2,bps=0
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,bps=1
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,bps=1000000000000000
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,bps=1000000000000001
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,bps=1000000000000001: bps/iops/max values must be within [0, 1000000000000000]
@@ -435,11 +435,11 @@ QEMU_PROG: -drive file.filename=foo:bar: Could not open 'foo:bar': No such file
 
 Testing: -hda file:TEST_DIR/t.qcow2
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=file:TEST_DIR/t.qcow2
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file.filename=file:TEST_DIR/t.qcow2
 QEMU_PROG: -drive file.filename=file:TEST_DIR/t.qcow2: Could not open 'file:TEST_DIR/t.qcow2': No such file or directory
@@ -451,78 +451,78 @@ wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=drive0 -snapshot
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqe[K[D[Dqem[K[D[D[Dqemu[K[D[D[D[Dqemu-[K[D[D[D[D[Dqemu-i[K[D[D[D[D[D[Dqemu-io[K[D[D[D[D[D[D[Dqemu-io [K[D[D[D[D[D[D[D[Dqemu-io d[K[D[D[D[D[D[D[D[D[Dqemu-io dr[K[D[D[D[D[D[D[D[D[D[Dqemu-io dri[K[D[D[D[D[D[D[D[D[D[D[Dqemu-io driv[K[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive[K[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "w[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wr[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wri[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "writ[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqem
 u-io drive0 "write [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x2[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0[K[D
 [D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k"[K
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,snapshot=on,if=none,id=drive0
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqe[K[D[Dqem[K[D[D[Dqemu[K[D[D[D[Dqemu-[K[D[D[D[D[Dqemu-i[K[D[D[D[D[D[Dqemu-io[K[D[D[D[D[D[D[Dqemu-io [K[D[D[D[D[D[D[D[Dqemu-io d[K[D[D[D[D[D[D[D[D[Dqemu-io dr[K[D[D[D[D[D[D[D[D[D[Dqemu-io dri[K[D[D[D[D[D[D[D[D[D[D[Dqemu-io driv[K[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive[K[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "w[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wr[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wri[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "writ[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqem
 u-io drive0 "write [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x2[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0[K[D
 [D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k"[K
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file.filename=TEST_DIR/t.qcow2,driver=qcow2,snapshot=on,if=none,id=drive0
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqe[K[D[Dqem[K[D[D[Dqemu[K[D[D[D[Dqemu-[K[D[D[D[D[Dqemu-i[K[D[D[D[D[D[Dqemu-io[K[D[D[D[D[D[D[Dqemu-io [K[D[D[D[D[D[D[D[Dqemu-io d[K[D[D[D[D[D[D[D[D[Dqemu-io dr[K[D[D[D[D[D[D[D[D[D[Dqemu-io dri[K[D[D[D[D[D[D[D[D[D[D[Dqemu-io driv[K[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive[K[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "w[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wr[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wri[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "writ[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqem
 u-io drive0 "write [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x2[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0[K[D
 [D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k"[K
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file.filename=TEST_DIR/t.qcow2,driver=qcow2,if=none,id=drive0 -snapshot
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqe[K[D[Dqem[K[D[D[Dqemu[K[D[D[D[Dqemu-[K[D[D[D[D[Dqemu-i[K[D[D[D[D[D[Dqemu-io[K[D[D[D[D[D[D[Dqemu-io [K[D[D[D[D[D[D[D[Dqemu-io d[K[D[D[D[D[D[D[D[D[Dqemu-io dr[K[D[D[D[D[D[D[D[D[D[Dqemu-io dri[K[D[D[D[D[D[D[D[D[D[D[Dqemu-io driv[K[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive[K[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "w[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wr[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wri[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "writ[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqem
 u-io drive0 "write [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x2[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0[K[D
 [D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k"[K
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=file:TEST_DIR/t.qcow2,if=none,id=drive0 -snapshot
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqe[K[D[Dqem[K[D[D[Dqemu[K[D[D[D[Dqemu-[K[D[D[D[D[Dqemu-i[K[D[D[D[D[D[Dqemu-io[K[D[D[D[D[D[D[Dqemu-io [K[D[D[D[D[D[D[D[Dqemu-io d[K[D[D[D[D[D[D[D[D[Dqemu-io dr[K[D[D[D[D[D[D[D[D[D[Dqemu-io dri[K[D[D[D[D[D[D[D[D[D[D[Dqemu-io driv[K[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive[K[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "w[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wr[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wri[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "writ[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqem
 u-io drive0 "write [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x2[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0[K[D
 [D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k"[K
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=file:TEST_DIR/t.qcow2,snapshot=on,if=none,id=drive0
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqe[K[D[Dqem[K[D[D[Dqemu[K[D[D[D[Dqemu-[K[D[D[D[D[Dqemu-i[K[D[D[D[D[D[Dqemu-io[K[D[D[D[D[D[D[Dqemu-io [K[D[D[D[D[D[D[D[Dqemu-io d[K[D[D[D[D[D[D[D[D[Dqemu-io dr[K[D[D[D[D[D[D[D[D[D[Dqemu-io dri[K[D[D[D[D[D[D[D[D[D[D[Dqemu-io driv[K[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive[K[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "w[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wr[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wri[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "writ[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqem
 u-io drive0 "write [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x2[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0[K[D
 [D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k"[K
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=drive0 -snapshot
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqe[K[D[Dqem[K[D[D[Dqemu[K[D[D[D[Dqemu-[K[D[D[D[D[Dqemu-i[K[D[D[D[D[D[Dqemu-io[K[D[D[D[D[D[D[Dqemu-io [K[D[D[D[D[D[D[D[Dqemu-io d[K[D[D[D[D[D[D[D[D[Dqemu-io dr[K[D[D[D[D[D[D[D[D[D[Dqemu-io dri[K[D[D[D[D[D[D[D[D[D[D[Dqemu-io driv[K[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive[K[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "w[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wr[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wri[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "writ[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqem
 u-io drive0 "write [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x2[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0[K[D
 [D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k"[K
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,snapshot=on,if=none,id=drive0
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqe[K[D[Dqem[K[D[D[Dqemu[K[D[D[D[Dqemu-[K[D[D[D[D[Dqemu-i[K[D[D[D[D[D[Dqemu-io[K[D[D[D[D[D[D[Dqemu-io [K[D[D[D[D[D[D[D[Dqemu-io d[K[D[D[D[D[D[D[D[D[Dqemu-io dr[K[D[D[D[D[D[D[D[D[D[Dqemu-io dri[K[D[D[D[D[D[D[D[D[D[D[Dqemu-io driv[K[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive[K[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "w[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wr[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wri[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "writ[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqem
 u-io drive0 "write [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x2[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0[K[D
 [D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k"[K
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Testing: -drive file=TEST_DIR/t.qcow2,snapshot=off,if=none,id=drive0
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqe[K[D[Dqem[K[D[D[Dqemu[K[D[D[D[Dqemu-[K[D[D[D[D[Dqemu-i[K[D[D[D[D[D[Dqemu-io[K[D[D[D[D[D[D[Dqemu-io [K[D[D[D[D[D[D[D[Dqemu-io d[K[D[D[D[D[D[D[D[D[Dqemu-io dr[K[D[D[D[D[D[D[D[D[D[Dqemu-io dri[K[D[D[D[D[D[D[D[D[D[D[Dqemu-io driv[K[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive[K[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "w[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wr[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wri[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "writ[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqem
 u-io drive0 "write [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x2[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0[K[D
 [D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x22 0 4k"[K
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Testing: -drive file=TEST_DIR/t.qcow2,snapshot=on,if=none,id=drive0
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqe[K[D[Dqem[K[D[D[Dqemu[K[D[D[D[Dqemu-[K[D[D[D[D[Dqemu-i[K[D[D[D[D[D[Dqemu-io[K[D[D[D[D[D[D[Dqemu-io [K[D[D[D[D[D[D[D[Dqemu-io d[K[D[D[D[D[D[D[D[D[Dqemu-io dr[K[D[D[D[D[D[D[D[D[D[Dqemu-io dri[K[D[D[D[D[D[D[D[D[D[D[Dqemu-io driv[K[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive[K[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "w[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wr[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "wri[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "writ[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqem
 u-io drive0 "write [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x3[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x33[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x33 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x33 0[K[D
 [D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x33 0 [K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x33 0 4[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x33 0 4k[K[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[D[Dqemu-io drive0 "write -P 0x33 0 4k"[K
+(qemu) qemu-io drive0 "write -P 0x33 0 4k"
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) c[K[Dco[K[D[Dcom[K[D[D[Dcomm[K[D[D[D[Dcommi[K[D[D[D[D[Dcommit[K[D[D[D[D[D[Dcommit [K[D[D[D[D[D[D[Dcommit d[K[D[D[D[D[D[D[D[Dcommit dr[K[D[D[D[D[D[D[D[D[Dcommit dri[K[D[D[D[D[D[D[D[D[D[Dcommit driv[K[D[D[D[D[D[D[D[D[D[D[Dcommit drive[K[D[D[D[D[D[D[D[D[D[D[D[Dcommit drive0[K
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) commit drive0
+(qemu) quit
 
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index 68f6e82..9c1687d 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -62,11 +62,11 @@ esac
 # Give qemu some time to boot before saving the VM state
 bash -c 'sleep 1; echo -e "savevm 0\nquit"' |\
     $QEMU $platform_parm -nographic -monitor stdio -serial none -hda "$TEST_IMG" |\
-    _filter_qemu
+    _filter_qemu | _filter_hmp
 # Now try to continue from that VM state (this should just work)
 echo quit |\
     $QEMU $platform_parm -nographic -monitor stdio -serial none -hda "$TEST_IMG" -loadvm 0 |\
-    _filter_qemu
+    _filter_qemu | _filter_hmp
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/068.out b/tests/qemu-iotests/068.out
index 84f19b4..0fa5340 100644
--- a/tests/qemu-iotests/068.out
+++ b/tests/qemu-iotests/068.out
@@ -4,8 +4,8 @@ QA output created by 068
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) s[K[Dsa[K[D[Dsav[K[D[D[Dsave[K[D[D[D[Dsavev[K[D[D[D[D[Dsavevm[K[D[D[D[D[D[Dsavevm [K[D[D[D[D[D[D[Dsavevm 0[K
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) savevm 0
+(qemu) quit
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 *** done
diff --git a/tests/qemu-iotests/130.out b/tests/qemu-iotests/130.out
index ae95b50..93020c3 100644
--- a/tests/qemu-iotests/130.out
+++ b/tests/qemu-iotests/130.out
@@ -9,14 +9,14 @@ virtual size: 64M (67108864 bytes)
 === HMP commit ===
 
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) c[K[Dco[K[D[Dcom[K[D[D[Dcomm[K[D[D[D[Dcommi[K[D[D[D[D[Dcommit[K[D[D[D[D[D[Dcommit [K[D[D[D[D[D[D[Dcommit t[K[D[D[D[D[D[D[D[Dcommit te[K[D[D[D[D[D[D[D[D[Dcommit tes[K[D[D[D[D[D[D[D[D[D[Dcommit test[K[D[D[D[D[D[D[D[D[D[D[Dcommit testd[K[D[D[D[D[D[D[D[D[D[D[D[Dcommit testdi[K[D[D[D[D[D[D[D[D[D[D[D[D[Dcommit testdis[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dcommit testdisk[K
+(qemu) commit testdisk
 (qemu) 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64M (67108864 bytes)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.orig backing_fmt=raw
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) c[K[Dco[K[D[Dcom[K[D[D[Dcomm[K[D[D[D[Dcommi[K[D[D[D[D[Dcommit[K[D[D[D[D[D[Dcommit [K[D[D[D[D[D[D[Dcommit t[K[D[D[D[D[D[D[D[Dcommit te[K[D[D[D[D[D[D[D[D[Dcommit tes[K[D[D[D[D[D[D[D[D[D[Dcommit test[K[D[D[D[D[D[D[D[D[D[D[Dcommit testd[K[D[D[D[D[D[D[D[D[D[D[D[Dcommit testdi[K[D[D[D[D[D[D[D[D[D[D[D[D[Dcommit testdis[K[D[D[D[D[D[D[D[D[D[D[D[D[D[Dcommit testdisk[K
+(qemu) commit testdisk
 (qemu) 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index 29c0606..9a5b713 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -62,7 +62,7 @@ function do_run_qemu()
 
 function run_qemu()
 {
-    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_hmp
 }
 
 size=128M
diff --git a/tests/qemu-iotests/142.out b/tests/qemu-iotests/142.out
index 600beca..3667e38 100644
--- a/tests/qemu-iotests/142.out
+++ b/tests/qemu-iotests/142.out
@@ -7,23 +7,23 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=none
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=directsync
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writeback
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writethrough
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=unsafe
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=invalid_value
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,cache=invalid_value: invalid cache option
diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index 1eca0e8..e6c6bc4 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -43,7 +43,8 @@ _supported_proto generic
 _supported_os Linux
 
 _make_test_img 1M
-echo quit | $QEMU -nographic -hda "$TEST_IMG" -incoming 'exec:true' -snapshot -serial none -monitor stdio | _filter_qemu
+echo quit | $QEMU -nographic -hda "$TEST_IMG" -incoming 'exec:true' -snapshot -serial none -monitor stdio |
+    _filter_qemu | _filter_hmp
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/145.out b/tests/qemu-iotests/145.out
index 75b5c8a..9a90009 100644
--- a/tests/qemu-iotests/145.out
+++ b/tests/qemu-iotests/145.out
@@ -1,5 +1,5 @@
 QA output created by 145
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) quit
 *** done
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index c9a2d5c..e83885a 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -86,6 +86,13 @@ _filter_qmp()
         -e '    QMP_VERSION'
 }
 
+# readline makes HMP command strings so long that git complains
+_filter_hmp()
+{
+    sed -e $'s/^\\((qemu) \\)\\?.*\e\\[D/\\1/g' \
+        -e $'s/\e\\[K//g'
+}
+
 # replace block job offset
 _filter_block_job_offset()
 {
diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.qemu
index 4278789..7a78a00 100644
--- a/tests/qemu-iotests/common.qemu
+++ b/tests/qemu-iotests/common.qemu
@@ -59,7 +59,7 @@ function _timed_wait_for()
     do
         if [ -z "${silent}" ]; then
             echo "${resp}" | _filter_testdir | _filter_qemu \
-                           | _filter_qemu_io | _filter_qmp
+                           | _filter_qemu_io | _filter_qmp | _filter_hmp
         fi
         grep -q "${*}" < <(echo ${resp})
         if [ $? -eq 0 ]; then
@@ -217,7 +217,7 @@ function _cleanup_qemu()
 
         if [ -n "${wait}" ]; then
             cat <&${QEMU_OUT[$i]} | _filter_testdir | _filter_qemu \
-                                  | _filter_qemu_io | _filter_qmp
+                                  | _filter_qemu_io | _filter_qmp | _filter_hmp
         fi
         rm -f "${QEMU_FIFO_IN}_${i}" "${QEMU_FIFO_OUT}_${i}"
         eval "exec ${QEMU_IN[$i]}<&-"   # close file descriptors
-- 
1.8.3.1
