Received: from eggs.gnu.org ([2001:4830:134:3::10]:34576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFlwM-0006BA-5d
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:04:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFlwL-0000Ia-59
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:04:38 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 17 Nov 2017 13:04:22 -0600
Message-Id: <20171117190422.23626-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11] iotests: Fix 176 on 32-bit host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org

The contents of a qcow2 bitmap are rounded up to a size that
matches the number of bits available for the granularity, but
that granularity differs for 32-bit hosts (our default 64k
cluster allows for 2M bitmap coverage per 'long') and 64-bit
hosts (4M bitmap per 'long').  If the image is a multiple of
2M but not 4M, then the number of bytes occupied by the array
of longs in memory differs between architecture, thus
resulting in different SHA256 hashes.

Furthermore (but untested by me), if our computation of the
SHA256 hash is at all endian-dependent because of how we store
data in memory, that's another variable we'd have to account
for (ideally, we specified the bitmap stored in qcow2 as
fixed-endian on disk, because the same qcow2 file must be
usable across any architecture; but that says nothing about
how we represent things in memory).  But we already have test
165 to validate that bitmaps are stored correctly on disk,
while this test is merely testing that the bitmap exists.

So for this test, the easiest solution is to filter out the
actual hash value.  Broken in commit 4096974e.

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/176     | 3 ++-
 tests/qemu-iotests/176.out | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index 0f31a20294..b8dc17c592 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -52,7 +52,8 @@ _supported_os Linux
 function run_qemu()
 {
     $QEMU -nographic -qmp stdio -serial none "$@" 2>&1 \
-	| _filter_testdir | _filter_qmp | _filter_qemu
+	| _filter_testdir | _filter_qmp | _filter_qemu \
+        | sed 's/"sha256": ".\{64\}"/"sha256": HASH/'
 }

 for reason in snapshot bitmap; do
diff --git a/tests/qemu-iotests/176.out b/tests/qemu-iotests/176.out
index e62085cd0a..f03a2e776c 100644
--- a/tests/qemu-iotests/176.out
+++ b/tests/qemu-iotests/176.out
@@ -205,7 +205,7 @@ Offset          Length          File
 QMP_VERSION
 {"return": {}}
 {"return": {}}
-{"return": {"sha256": "e12600978d86b5a453861ae5c17d275204673fef3874b7c3c5433c6153d84706"}}
+{"return": {"sha256": HASH}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}

@@ -255,7 +255,7 @@ Offset          Length          File
 QMP_VERSION
 {"return": {}}
 {"return": {}}
-{"return": {"sha256": "e12600978d86b5a453861ae5c17d275204673fef3874b7c3c5433c6153d84706"}}
+{"return": {"sha256": HASH}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}

@@ -305,7 +305,7 @@ Offset          Length          File
 QMP_VERSION
 {"return": {}}
 {"return": {}}
-{"return": {"sha256": "e12600978d86b5a453861ae5c17d275204673fef3874b7c3c5433c6153d84706"}}
+{"return": {"sha256": HASH}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}

@@ -352,7 +352,7 @@ Offset          Length          File
 QMP_VERSION
 {"return": {}}
 {"return": {}}
-{"return": {"sha256": "e12600978d86b5a453861ae5c17d275204673fef3874b7c3c5433c6153d84706"}}
+{"return": {"sha256": HASH}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
 *** done
-- 
2.13.6
