Received: from eggs.gnu.org ([2001:4830:134:3::10]:42961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHUB-0000i8-Vl
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHU9-0001Ye-VZ
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:35 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:40731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fLHU9-0001YA-LM
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:33 -0400
Received: by mail-pg0-x235.google.com with SMTP id l2-v6so8569274pgc.7
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 17:18:33 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 23 May 2018 12:15:16 +1200
Message-Id: <1527034517-7851-30-git-send-email-mjc@sifive.com>
In-Reply-To: <1527034517-7851-1-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 29/30] RISC-V: Don't add NULL bootargs to
 device-tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>

---
 hw/riscv/sifive_u.c | 4 +++-
 hw/riscv/spike.c    | 6 ++++--
 hw/riscv/virt.c     | 4 +++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 326b0f434cff..02721d43c474 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -206,7 +206,9 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
 
     qemu_fdt_add_subnode(fdt, "/chosen");
     qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
-    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    if (cmdline) {
+        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    }
     g_free(nodename);
 }
 
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index f94e2b670799..5dd7d28aed4e 100644
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
index 321fa6e8122a..c889aa3cd269 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -253,7 +253,9 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
 
     qemu_fdt_add_subnode(fdt, "/chosen");
     qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
-    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    if (cmdline) {
+        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    }
     g_free(nodename);
 
     return fdt;
-- 
2.7.0
