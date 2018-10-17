Received: from eggs.gnu.org ([2001:4830:134:3::10]:58527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gCttn-0006QL-Q1
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 18:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gCttk-0005gU-76
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 18:02:39 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:44884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gCtti-0005c1-9U
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 18:02:34 -0400
Received: by mail-pf1-x42b.google.com with SMTP id r9-v6so13831963pff.11
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 15:02:31 -0700 (PDT)
Date: Wed, 17 Oct 2018 14:54:22 -0700
Message-Id: <20181017215422.3973-6-palmer@sifive.com>
In-Reply-To: <20181017215422.3973-1-palmer@sifive.com>
References: <20181017215422.3973-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 5/5] RISC-V: Don't add NULL bootargs to
 device-tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.orgMichael Clark <mjc@sifive.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

From: Michael Clark <mjc@sifive.com>

Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c | 4 +++-
 hw/riscv/spike.c    | 6 ++++--
 hw/riscv/virt.c     | 4 +++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 862f8ff5f758..ef07df244241 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -230,7 +230,9 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
 
     qemu_fdt_add_subnode(fdt, "/chosen");
     qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
-    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    if (cmdline) {
+        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    }
     g_free(nodename);
 }
 
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index be5ef85e8109..8a712ed49026 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -156,8 +156,10 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
     g_free(cells);
     g_free(nodename);
 
-    qemu_fdt_add_subnode(fdt, "/chosen");
-    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    if (cmdline) {
+        qemu_fdt_add_subnode(fdt, "/chosen");
+        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    }
  }
 
 static void spike_v1_10_0_board_init(MachineState *machine)
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 6bd723dc3ad9..4a137a503c8a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -254,7 +254,9 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
 
     qemu_fdt_add_subnode(fdt, "/chosen");
     qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
-    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    if (cmdline) {
+        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    }
     g_free(nodename);
 
     return fdt;
-- 
2.18.1
