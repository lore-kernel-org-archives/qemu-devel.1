Received: from eggs.gnu.org ([2001:4830:134:3::10]:54696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCYlD-0008AL-Pr
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 17:23:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCYlC-0004AV-PM
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 17:23:51 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed,  8 Nov 2017 16:23:37 -0600
Message-Id: <20171108222337.12400-1-eblake@redhat.com>
In-Reply-To: <20171108215703.9295-3-eblake@redhat.com>
References: <20171108215703.9295-3-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2.5/7] fixup! nbd-client: Refuse read-only
 client with BDRV_O_RDWR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, pbonzini@redhat.com, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

...

Fix several iotests to comply with the new behavior (since
qemu-nbd of an internal snapshot, as well as nbd-server-add over QMP,
default to a read-only export, we must tell blockdev-add/qemu-io to
set up a read-only client).

Signed-off-by: Eric Blake <eblake@redhat.com>

---
Will squash when applying this series to the NBD queue.
---
 tests/qemu-iotests/058 | 8 ++++----
 tests/qemu-iotests/140 | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/058 b/tests/qemu-iotests/058
index 2253c6a6d1..5eb8784669 100755
--- a/tests/qemu-iotests/058
+++ b/tests/qemu-iotests/058
@@ -117,15 +117,15 @@ _export_nbd_snapshot sn1

 echo
 echo "== verifying the exported snapshot with patterns, method 1 =="
-$QEMU_IO_NBD -c 'read -P 0xa 0x1000 0x1000' "$nbd_snapshot_img" | _filter_qemu_io
-$QEMU_IO_NBD -c 'read -P 0xb 0x2000 0x1000' "$nbd_snapshot_img" | _filter_qemu_io
+$QEMU_IO_NBD -r -c 'read -P 0xa 0x1000 0x1000' "$nbd_snapshot_img" | _filter_qemu_io
+$QEMU_IO_NBD -r -c 'read -P 0xb 0x2000 0x1000' "$nbd_snapshot_img" | _filter_qemu_io

 _export_nbd_snapshot1 sn1

 echo
 echo "== verifying the exported snapshot with patterns, method 2 =="
-$QEMU_IO_NBD -c 'read -P 0xa 0x1000 0x1000' "$nbd_snapshot_img" | _filter_qemu_io
-$QEMU_IO_NBD -c 'read -P 0xb 0x2000 0x1000' "$nbd_snapshot_img" | _filter_qemu_io
+$QEMU_IO_NBD -r -c 'read -P 0xa 0x1000 0x1000' "$nbd_snapshot_img" | _filter_qemu_io
+$QEMU_IO_NBD -r -c 'read -P 0xb 0x2000 0x1000' "$nbd_snapshot_img" | _filter_qemu_io

 $QEMU_IMG convert "$TEST_IMG" -l sn1 -O qcow2 "$converted_image"

diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index f89d0d6789..a8fc95145c 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -78,7 +78,7 @@ _send_qemu_cmd $QEMU_HANDLE \
        'arguments': { 'device': 'drv' }}" \
     'return'

-$QEMU_IO_PROG -f raw -c 'read -P 42 0 64k' \
+$QEMU_IO_PROG -f raw -r -c 'read -P 42 0 64k' \
     "nbd+unix:///drv?socket=$TEST_DIR/nbd" 2>&1 \
     | _filter_qemu_io | _filter_nbd

@@ -87,7 +87,7 @@ _send_qemu_cmd $QEMU_HANDLE \
        'arguments': { 'device': 'drv' }}" \
     'return'

-$QEMU_IO_PROG -f raw -c close \
+$QEMU_IO_PROG -f raw -r -c close \
     "nbd+unix:///drv?socket=$TEST_DIR/nbd" 2>&1 \
     | _filter_qemu_io | _filter_nbd

-- 
2.13.6
