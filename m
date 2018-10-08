Received: from eggs.gnu.org ([2001:4830:134:3::10]:35112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=812b08464=Alistair.Francis@wdc.com>)
	id 1g9aEI-0004wS-23
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=812b08464=Alistair.Francis@wdc.com>)
	id 1g9aED-00086G-Eg
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:26:04 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:54562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=812b08464=Alistair.Francis@wdc.com>)
	id 1g9aEA-00082C-Re
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:26:00 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Mon, 8 Oct 2018 18:25:56 +0000
Message-ID: <17e897f16e0972da80a22d50b50293dc893731b0.1539023064.git.alistair.francis@wdc.com>
References: <cover.1539023064.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1539023064.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 5/5] RISC-V: Don't add NULL bootargs to
 device-tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

From: Michael Clark <mjc@sifive.com>

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 4 +++-
 hw/riscv/spike.c    | 6 ++++--
 hw/riscv/virt.c     | 4 +++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 862f8ff5f7..ef07df2442 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -230,7 +230,9 @@ static void create_fdt(SiFiveUState *s, const struct Me=
mmapEntry *memmap,
=20
     qemu_fdt_add_subnode(fdt, "/chosen");
     qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
-    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    if (cmdline) {
+        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    }
     g_free(nodename);
 }
=20
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index be5ef85e81..8a712ed490 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -156,8 +156,10 @@ static void create_fdt(SpikeState *s, const struct Mem=
mapEntry *memmap,
     g_free(cells);
     g_free(nodename);
=20
-    qemu_fdt_add_subnode(fdt, "/chosen");
-    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    if (cmdline) {
+        qemu_fdt_add_subnode(fdt, "/chosen");
+        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    }
  }
=20
 static void spike_v1_10_0_board_init(MachineState *machine)
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 6bd723dc3a..4a137a503c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -254,7 +254,9 @@ static void *create_fdt(RISCVVirtState *s, const struct=
 MemmapEntry *memmap,
=20
     qemu_fdt_add_subnode(fdt, "/chosen");
     qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
-    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    if (cmdline) {
+        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    }
     g_free(nodename);
=20
     return fdt;
--=20
2.17.1
