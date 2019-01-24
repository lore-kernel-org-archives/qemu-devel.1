Received: from eggs.gnu.org ([209.51.188.92]:39593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=920fe819b=Alistair.Francis@wdc.com>)
	id 1gmiwz-0003Er-0z
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:38:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=920fe819b=Alistair.Francis@wdc.com>)
	id 1gmiwx-00024K-0y
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:38:00 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 24 Jan 2019 17:37:47 +0000
Message-ID: <2b9ba958f8b317df83c37b348ad543fef2113528.1548351450.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v3 1/1] riscv: Ensure the kernel start address
 is correctly cast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

Cast the kernel start address to the target bit length.

This ensures that we calculate the initrd offset to a valid address for
the architecture.

Steps to reproduce the original problem (reported by Alex):
  Build U-Boot for the virt machine for riscv32. Then run it with

    $ qemu-system-riscv32 -M virt -kernel u-boot -nographic -initrd <a file=
>

  You can find the initrd address with

    U-Boot# fdt addr $fdtcontroladdr
    U-Boot# fdt ls /chosen

  Then take a peek at that address:

    U-Boot# md.b <addr>

  and you will see that there is nothing there without this patch. The
  reason is that the binary was loaded to a negative address.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Suggested-by: Alexander Graf <agraf@suse.de>
Reported-by: Alexander Graf <agraf@suse.de>
---
v3:
 - Add steps to reproduce
v2:
 - Remove old comment
 hw/riscv/sifive_e.c | 2 +-
 hw/riscv/sifive_u.c | 2 +-
 hw/riscv/spike.c    | 2 +-
 hw/riscv/virt.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 5d9d65ff29..e5d7fc548e 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -74,7 +74,7 @@ static const struct MemmapEntry {
     [SIFIVE_E_DTIM] =3D     { 0x80000000,     0x4000 }
 };
=20
-static uint64_t load_kernel(const char *kernel_filename)
+static target_ulong load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
=20
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 3bd3b67507..3b3acec377 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -65,7 +65,7 @@ static const struct MemmapEntry {
=20
 #define GEM_REVISION        0x10070109
=20
-static uint64_t load_kernel(const char *kernel_filename)
+static target_ulong load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
=20
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 268df04c3c..79cb4c1282 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -53,7 +53,7 @@ static const struct MemmapEntry {
     [SPIKE_DRAM] =3D     { 0x80000000,        0x0 },
 };
=20
-static uint64_t load_kernel(const char *kernel_filename)
+static target_ulong load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
=20
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e7f0716fb6..648462b18c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -62,7 +62,7 @@ static const struct MemmapEntry {
     [VIRT_PCIE_ECAM] =3D   { 0x30000000,    0x10000000 },
 };
=20
-static uint64_t load_kernel(const char *kernel_filename)
+static target_ulong load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
=20
--=20
2.19.1
