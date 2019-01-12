Received: from eggs.gnu.org ([209.51.188.92]:59671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1giNaU-0003aA-V4
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 13:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1giNYN-0001tN-AL
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 12:58:40 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 12 Jan 2019 11:57:56 -0600
Message-Id: <20190112175812.27068-4-eblake@redhat.com>
In-Reply-To: <20190112175812.27068-1-eblake@redhat.com>
References: <20190112175812.27068-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 03/19] qemu-nbd: Sanity check partition
 bounds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, rjones@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

When the user requests a partition, we were using data read
from the disk as disk offsets without a bounds check. We got
lucky that even when computed offsets are out-of-bounds,
blk_pread() will gracefully catch the error later (so I don't
think a malicious image can crash or exploit qemu-nbd, and am
not treating this as a security flaw), but it's better to
flag the problem up front than to risk permanent EIO death of
the block device down the road.  Also, note that the
partition code blindly overwrites any offset passed in by the
user; so make the -o/-P combo an error for less confusion.

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
---
v3: new patch
---
 qemu-nbd.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 51b55f2e066..ff4adb9b3eb 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -1013,12 +1013,28 @@ int main(int argc, char **argv)
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
+        /* partition limits are (32-bit << 9); can't overflow 64 bits */
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
