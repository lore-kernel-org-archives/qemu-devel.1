Received: from eggs.gnu.org ([2001:4830:134:3::10]:38866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=856724ab1=Alistair.Francis@wdc.com>)
	id 1gPb5L-00042Q-1r
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:35:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=856724ab1=Alistair.Francis@wdc.com>)
	id 1gPb5J-0002k4-W2
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:35:02 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Wed, 21 Nov 2018 22:34:44 +0000
Message-ID: <6559716eae4b53d2cad39ec6011cdd7b1b32138a.1542839652.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 1/1] riscv: virt: Cast the initrd start
 address to target bit length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "agraf@suse.de" <agraf@suse.de>

Ensure that the calculate initrd offset points to a valid address for
the architecture.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Suggested-by: Alexander Graf <agraf@suse.de>
Reported-by: Alexander Graf <agraf@suse.de>
---
 hw/riscv/virt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2b38f89070..4467195fac 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -85,7 +85,12 @@ static hwaddr load_initrd(const char *filename, uint64_t=
 mem_size,
      * halfway into RAM, and for boards with 256MB of RAM or more we put
      * the initrd at 128MB.
      */
-    *start =3D kernel_entry + MIN(mem_size / 2, 128 * MiB);
+    /* As hwaddr is a 64-bit number we need to cast it for 32-bit */
+#if defined(TARGET_RISCV32)
+    *start =3D (uint32_t) (kernel_entry + MIN(mem_size / 2, 128ULL * MiB))=
;
+#elif defined(TARGET_RISCV64)
+    *start =3D (uint64_t) (kernel_entry + MIN(mem_size / 2, 128 * MiB));
+#endif
=20
     size =3D load_ramdisk(filename, *start, mem_size - *start);
     if (size =3D=3D -1) {
--=20
2.19.1
