Received: from eggs.gnu.org ([2001:4830:134:3::10]:50904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7pd-00046r-VI
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7pb-00069L-B2
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:21:49 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 31 Jul 2017 13:21:29 +0300
Message-Id: <f80ac75d0e6e6e7481d61cdb86e5a741a442f100.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/25] qcow2: fix null pointer dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

It seems this assert() was somehow misplaced.

block/qcow2-refcount.c:2193:42: warning: Array access (from variable 'on_=
disk_reftable') results in a null pointer dereference
        on_disk_reftable[refblock_index] =3D refblock_offset;
        ~~~~~~~~~~~~~~~~                 ^

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 block/qcow2-refcount.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index c9b0dcb4f3..168fc32e7b 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2189,6 +2189,8 @@ write_refblocks:
              * this will leak that range, but we can easily fix that by =
running
              * a leak-fixing check after this rebuild operation */
             reftable_offset =3D -1;
+        } else {
+            assert(on_disk_reftable);
         }
         on_disk_reftable[refblock_index] =3D refblock_offset;
=20
@@ -2258,8 +2260,6 @@ write_refblocks:
         goto write_refblocks;
     }
=20
-    assert(on_disk_reftable);
-
     for (refblock_index =3D 0; refblock_index < reftable_size; refblock_=
index++) {
         cpu_to_be64s(&on_disk_reftable[refblock_index]);
     }
--=20
2.11.0
