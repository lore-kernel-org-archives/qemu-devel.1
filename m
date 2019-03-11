Received: from eggs.gnu.org ([209.51.188.92]:59362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h3O9U-0003FI-RK
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h3O8I-0007fR-4L
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:50:35 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 11 Mar 2019 17:50:12 +0100
Message-Id: <20190311165017.32247-6-kwolf@redhat.com>
In-Reply-To: <20190311165017.32247-1-kwolf@redhat.com>
References: <20190311165017.32247-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/10] file-posix: Fix bdrv_open_flags() for
 snapshot=on
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, berto@igalia.com, qemu-devel@nongnu.org

Using a different read-only setting for bs->open_flags than for the
flags to the driver's open function is just inconsistent and a bad idea.
After this patch, the temporary snapshot keeps being opened read-only if
read-only=3Don,snapshot=3Don is passed.

If we wanted to change this behaviour to make only the orginal image
file read-only, but the temporary overlay read-write (as the comment in
the removed code suggests), that change would have to be made in
bdrv_temp_snapshot_options() (where the comment suggests otherwise).

Addressing this inconsistency before introducing dynamic auto-read-only
is important because otherwise we would immediately try to reopen the
temporary overlay even though the file is already unlinked.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                       | 7 -------
 tests/qemu-iotests/051        | 7 +++++++
 tests/qemu-iotests/051.out    | 9 +++++++++
 tests/qemu-iotests/051.pc.out | 9 +++++++++
 4 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index 9b9d25e843..33804cdcaa 100644
--- a/block.c
+++ b/block.c
@@ -1163,13 +1163,6 @@ static int bdrv_open_flags(BlockDriverState *bs, i=
nt flags)
      */
     open_flags &=3D ~(BDRV_O_SNAPSHOT | BDRV_O_NO_BACKING | BDRV_O_PROTO=
COL);
=20
-    /*
-     * Snapshots should be writable.
-     */
-    if (flags & BDRV_O_TEMPORARY) {
-        open_flags |=3D BDRV_O_RDWR;
-    }
-
     return open_flags;
 }
=20
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 3b50c7f188..151b850a8b 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -356,6 +356,13 @@ $QEMU_IO -c "read -P 0x33 0 4k" "$TEST_IMG" | _filte=
r_qemu_io
 # Using snapshot=3Don with a non-existent TMPDIR
 TMPDIR=3D/nonexistent run_qemu -drive driver=3Dnull-co,snapshot=3Don
=20
+# Using snapshot=3Don together with read-only=3Don
+echo "info block" |
+    run_qemu -drive file=3D"$TEST_IMG",snapshot=3Don,read-only=3Don,if=3D=
none,id=3D$device_id |
+    _filter_qemu_io |
+    sed -e 's#"/[^"]*/vl\.[A-Za-z]\{6\}"#SNAPSHOT_PATH#g'
+
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index b900935fbc..9f1cf22608 100644
--- a/tests/qemu-iotests/051.out
+++ b/tests/qemu-iotests/051.out
@@ -458,4 +458,13 @@ read 4096/4096 bytes at offset 0
 Testing: -drive driver=3Dnull-co,snapshot=3Don
 QEMU_PROG: -drive driver=3Dnull-co,snapshot=3Don: Could not get temporar=
y filename: No such file or directory
=20
+Testing: -drive file=3DTEST_DIR/t.qcow2,snapshot=3Don,read-only=3Don,if=3D=
none,id=3Ddrive0
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"drive=
r": "file", "filename": "TEST_DIR/t.qcow2"}}, "driver": "qcow2", "file": =
{"driver": "file", "filename": SNAPSHOT_PATH}} (qcow2, read-only)
+    Removable device: not locked, tray closed
+    Cache mode:       writeback, ignore flushes
+    Backing file:     TEST_DIR/t.qcow2 (chain depth: 1)
+(qemu) quit
+
 *** done
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.ou=
t
index 8c5c735dfd..c4743cc31c 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -530,4 +530,13 @@ read 4096/4096 bytes at offset 0
 Testing: -drive driver=3Dnull-co,snapshot=3Don
 QEMU_PROG: -drive driver=3Dnull-co,snapshot=3Don: Could not get temporar=
y filename: No such file or directory
=20
+Testing: -drive file=3DTEST_DIR/t.qcow2,snapshot=3Don,read-only=3Don,if=3D=
none,id=3Ddrive0
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"drive=
r": "file", "filename": "TEST_DIR/t.qcow2"}}, "driver": "qcow2", "file": =
{"driver": "file", "filename": SNAPSHOT_PATH}} (qcow2, read-only)
+    Removable device: not locked, tray closed
+    Cache mode:       writeback, ignore flushes
+    Backing file:     TEST_DIR/t.qcow2 (chain depth: 1)
+(qemu) quit
+
 *** done
--=20
2.20.1
