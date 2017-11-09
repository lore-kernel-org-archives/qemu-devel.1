Received: from eggs.gnu.org ([2001:4830:134:3::10]:39606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCqBI-00033d-AP
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCqBC-0000lm-5j
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:59:56 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  9 Nov 2017 10:59:34 -0600
Message-Id: <20171109165939.23154-4-eblake@redhat.com>
In-Reply-To: <20171109165939.23154-1-eblake@redhat.com>
References: <20171109165939.23154-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 3/8] nbd-client: Refuse read-only client with
 BDRV_O_RDWR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

The NBD spec says that clients should not try to write/trim to
an export advertised as read-only by the server.  But we failed
to check that, and would allow the block layer to use NBD with
BDRV_O_RDWR even when the server is read-only, which meant we
were depending on the server sending a proper EPERM failure for
various commands, and also exposes a leaky abstraction: using
qemu-io in read-write mode would succeed on 'w -z 0 0' because
of local short-circuiting logic, but 'w 0 0' would send a
request over the wire (where it then depends on the server, and
fails at least for qemu-nbd but might pass for other NBD
implementations).

With this patch, a client MUST request read-only mode to access
a server that is doing a read-only export, or else it will get
a message like:

can't open device nbd://localhost:10809/foo: request for write access conflicts with read-only export

It is no longer possible to even attempt writes over the wire
(including the corner case of 0-length writes), because the block
layer enforces the explicit read-only request; this matches the
behavior of qcow2 when backed by a read-only POSIX file.

Fix several iotests to comply with the new behavior (since
qemu-nbd of an internal snapshot, as well as nbd-server-add over QMP,
default to a read-only export, we must tell blockdev-add/qemu-io to
set up a read-only client).

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20171108215703.9295-3-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c     | 9 +++++++++
 tests/qemu-iotests/058 | 8 ++++----
 tests/qemu-iotests/140 | 4 ++--
 tests/qemu-iotests/147 | 1 +
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index de6c153328..daa4392531 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -697,6 +697,7 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
         .len = bytes,
     };

+    assert(!(client->info.flags & NBD_FLAG_READ_ONLY));
     if (flags & BDRV_REQ_FUA) {
         assert(client->info.flags & NBD_FLAG_SEND_FUA);
         request.flags |= NBD_CMD_FLAG_FUA;
@@ -717,6 +718,7 @@ int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
         .len = bytes,
     };

+    assert(!(client->info.flags & NBD_FLAG_READ_ONLY));
     if (!(client->info.flags & NBD_FLAG_SEND_WRITE_ZEROES)) {
         return -ENOTSUP;
     }
@@ -756,6 +758,7 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
         .len = bytes,
     };

+    assert(!(client->info.flags & NBD_FLAG_READ_ONLY));
     if (!(client->info.flags & NBD_FLAG_SEND_TRIM)) {
         return 0;
     }
@@ -814,6 +817,12 @@ int nbd_client_init(BlockDriverState *bs,
         logout("Failed to negotiate with the NBD server\n");
         return ret;
     }
+    if (client->info.flags & NBD_FLAG_READ_ONLY &&
+        !bdrv_is_read_only(bs)) {
+        error_setg(errp,
+                   "request for write access conflicts with read-only export");
+        return -EACCES;
+    }
     if (client->info.flags & NBD_FLAG_SEND_FUA) {
         bs->supported_write_flags = BDRV_REQ_FUA;
         bs->supported_zero_flags |= BDRV_REQ_FUA;
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

diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index db34838cd0..90f40ed245 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -43,6 +43,7 @@ class NBDBlockdevAddBase(iotests.QMPTestCase):
                     'driver': 'raw',
                     'file': {
                         'driver': 'nbd',
+                        'read-only': True,
                         'server': address
                     } }
         if export is not None:
-- 
2.13.6
