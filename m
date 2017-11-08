Received: from eggs.gnu.org ([2001:4830:134:3::10]:45847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCYLU-0004z8-KJ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 16:57:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCYLT-0000UM-RA
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 16:57:16 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed,  8 Nov 2017 15:56:58 -0600
Message-Id: <20171108215703.9295-3-eblake@redhat.com>
In-Reply-To: <20171108215703.9295-1-eblake@redhat.com>
References: <20171108215703.9295-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/7] nbd-client: Refuse read-only client
 with BDRV_O_RDWR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, pbonzini@redhat.com, kwolf@redhat.com, qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>

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

Fix iotest 147 to comply with the new behavior (since nbd-server-add
defaults to a read-only export, we must tell blockdev-add to set up a
read-only client).

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: retitle; require explicit read-only request, rather than magically
setting it (includes iotest fallout) [Kevin]
---
 block/nbd-client.c     | 9 +++++++++
 tests/qemu-iotests/147 | 1 +
 2 files changed, 10 insertions(+)

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
