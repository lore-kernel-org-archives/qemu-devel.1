Received: from eggs.gnu.org ([209.51.188.92]:39931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliNp-0001Fa-VQ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliNn-00054I-C2
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:32 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 21 Jan 2019 16:48:50 -0600
Message-Id: <20190121224907.26634-5-eblake@redhat.com>
In-Reply-To: <20190121224907.26634-1-eblake@redhat.com>
References: <20190121224907.26634-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/21] qemu-nbd: Sanity check partition bounds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Richard W . M . Jones" <rjones@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

When the user requests a partition, we were using data read
from the disk as disk offsets without a bounds check. We got
lucky that even when computed offsets are out-of-bounds,
blk_pread() will gracefully catch the error later (so I don't
think a malicious image can crash or exploit qemu-nbd, and am
not treating this as a security flaw), but it's better to
flag the problem up front than to risk permanent EIO death of
the block device down the road.  The new bounds check adds
an assertion that will never fail, but rather exists to help
the compiler see that adding two positive 41-bit values
(given MBR constraints) can't overflow 64-bit off_t.

Using off_t to represent a partition length is a bit of a
misnomer; a later patch will update to saner types, but it
is left separate in case the bounds check needs to be
backported in isolation.

Also, note that the partition code blindly overwrites any
non-zero offset passed in by the user; so for now, make the
-o/-P combo an error for less confusion.  In the future, we
may let -o and -P work together (selecting a subset of a
partition); so it is okay that an explicit '-o 0' behaves
no differently from omitting -o.

This can be tested with nbdkit:
$ echo hi > file
$ nbdkit -fv --filter=3Dtruncate partitioning file truncate=3D64k

Pre-patch:
$ qemu-nbd -p 10810 -P 1 -f raw nbd://localhost:10809 &
$ qemu-io -f raw nbd://localhost:10810
qemu-io> r -v 0 1
Disconnect client, due to: Failed to send reply: reading from file failed=
: Input/output error
Connection closed
read failed: Input/output error
qemu-io> q
[1]+  Done                    qemu-nbd -p 10810 -P 1 -f raw nbd://localho=
st:10809

Post-patch:
$ qemu-nbd -p 10810 -P 1 -f raw nbd://localhost:10809
qemu-nbd: Discovered partition 1 at offset 1048576 size 512, but size exc=
eeds file length 65536

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Message-Id: <20190117193658.16413-5-eblake@redhat.com>
---
 qemu-nbd.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 51b55f2e066..5c90c5e55f7 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -1013,12 +1013,32 @@ int main(int argc, char **argv)
     fd_size -=3D dev_offset;

     if (partition !=3D -1) {
-        ret =3D find_partition(blk, partition, &dev_offset, &fd_size);
+        off_t limit;
+
+        if (dev_offset) {
+            error_report("Cannot request partition and offset together")=
;
+            exit(EXIT_FAILURE);
+        }
+        ret =3D find_partition(blk, partition, &dev_offset, &limit);
         if (ret < 0) {
             error_report("Could not find partition %d: %s", partition,
                          strerror(-ret));
             exit(EXIT_FAILURE);
         }
+        /*
+         * MBR partition limits are (32-bit << 9); this assert lets
+         * the compiler know that we have two positive values that
+         * can't overflow 64 bits.
+         */
+        assert(dev_offset >=3D 0 && dev_offset + limit >=3D dev_offset);
+        if (dev_offset + limit > fd_size) {
+            error_report("Discovered partition %d at offset %lld size %l=
ld, "
+                         "but size exceeds file length %lld", partition,
+                         (long long int) dev_offset, (long long int) lim=
it,
+                         (long long int) fd_size);
+            exit(EXIT_FAILURE);
+        }
+        fd_size =3D limit;
     }

     export =3D nbd_export_new(bs, dev_offset, fd_size, export_name,
--=20
2.20.1
