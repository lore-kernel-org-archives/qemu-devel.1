Received: from eggs.gnu.org ([2001:4830:134:3::10]:38973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gPcKw-0006Tx-Rh
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 18:55:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gPcKs-000588-U5
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 18:55:14 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:32785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gPcKq-00051k-QO
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 18:55:10 -0500
Received: by mail-pl1-x642.google.com with SMTP id z23so7680077plo.0
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 15:54:59 -0800 (PST)
Date: Wed, 21 Nov 2018 15:31:23 -0800
Message-Id: <20181121233123.6408-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PATCH for-3.2] RISC-V: Deprecate hifive_e and
 hifive_u machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@sifive.com>

These machines had names that were too general: there are many E
and U machines, and it's easy for users to get confused about which one
is which.  The one configuration that can faithfully match an existing
ASIC-based board has been renamed to 'sifive-hifive1', we'll work
through the emulation fidelity issues apparent in the other targets
before adding machines for those.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_e.c  | 26 ++++++++++++++++++++++++--
 hw/riscv/sifive_u.c  |  2 ++
 qemu-deprecated.texi |  7 +++++++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index cb513cc3bb50..439d20e0efe7 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -95,7 +95,7 @@ static void sifive_mmio_emulate(MemoryRegion *parent, const char *name,
     memory_region_add_subregion(parent, offset, mock_mmio);
 }
 
-static void riscv_sifive_e_init(MachineState *machine)
+static void riscv_sifive_hifive1_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = sifive_e_memmap;
 
@@ -135,6 +135,17 @@ static void riscv_sifive_e_init(MachineState *machine)
     }
 }
 
+static void riscv_sifive_e_init(MachineState *machine)
+{
+#if defined(TARGET_RISCV32)
+    warn_report("The sifive_e machine is deprecated in favor of sifive-hifive1");
+#else
+    warn_report("The sifive_e machine is deprecated.");
+#endif
+
+    return riscv_sifive_hifive1_init(machine);
+}
+
 static void riscv_sifive_e_soc_init(Object *obj)
 {
     SiFiveESoCState *s = RISCV_E_SOC(obj);
@@ -213,13 +224,24 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
 
 static void riscv_sifive_e_machine_init(MachineClass *mc)
 {
-    mc->desc = "RISC-V Board compatible with SiFive E SDK";
+    mc->desc = "(deprecated) RISC-V Board compatible with SiFive E SDK";
     mc->init = riscv_sifive_e_init;
     mc->max_cpus = 1;
 }
 
 DEFINE_MACHINE("sifive_e", riscv_sifive_e_machine_init)
 
+#if defined(TARGET_RISCV32)
+static void riscv_sifive_hifive1_machine_init(MachineClass *mc)
+{
+    mc->desc = "SiFive's HiFive1 Development Board";
+    mc->init = riscv_sifive_hifive1_init;
+    mc->max_cpus = 1;
+}
+
+DEFINE_MACHINE("sifive-hifive1", riscv_sifive_hifive1_machine_init)
+#endif
+
 static void riscv_sifive_e_soc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ef07df244241..0ce6a9dd2609 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -238,6 +238,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
 
 static void riscv_sifive_u_init(MachineState *machine)
 {
+    warn_report("The sifive_u machine is deprecated.");
+
     const struct MemmapEntry *memmap = sifive_u_memmap;
 
     SiFiveUState *s = g_new0(SiFiveUState, 1);
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index cb4291f1e5bc..f50696d3dc53 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -148,6 +148,13 @@ This machine type uses an unmaintained firmware, broken in lots of ways,
 and unable to start post-2004 operating systems. 40p machine type should be
 used instead.
 
+@subsection sifive_e and sifive_u (RISC-V) (since 3.2)
+
+The names for these machine types are a bit too ambiguous.  The 32-bit sifive_e
+machine has been replaced by the 'sifive-hifive1' machine, which closely
+matches that hardware.  The 'virt' machine type should be used instead of all
+others.
+
 @section Device options
 
 @subsection Block device options
-- 
2.18.1
