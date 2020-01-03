Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D59C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 06:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14128217F4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 06:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14128217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inGCz-0007BT-7E
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 01:13:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1inGCI-0006f0-I7
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 01:12:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1inGCE-0002mr-Cj
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 01:12:34 -0500
Received: from [107.174.27.60] (port=58842 helo=ozlabs.ru)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1inGCD-0002eP-Ss; Fri, 03 Jan 2020 01:12:30 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id E82FEAE80042;
 Fri,  3 Jan 2020 01:11:11 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH qemu] spapr: Kill SLOF
Date: Fri,  3 Jan 2020 17:12:17 +1100
Message-Id: <20200103061217.16396-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 107.174.27.60
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fabiano Rosas <farosas@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>, qemu-ppc@nongnu.org,
 Leonardo Bras <leonardo@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Petitboot bootloader is way more advanced than SLOF is ever going to
be as Petitboot comes with the full-featured Linux kernel with all
the drivers, and initramdisk with quite user friendly interface.
The problem with ditching SLOF is that an unmodified pseries kernel can
either start via:
1. kexec, this requires presence of RTAS and skips
ibm,client-architecture-support entirely;
2. normal boot, this heavily relies on the OF1275 client interface to
fetch the device tree and do early setup (claim memory).

This adds a new bios-less mode to the pseries machine: "bios=on|off".
When enabled, QEMU does not load SLOF and jumps to the kernel from
"-kernel".

This picks a page for the initial stack at 0xf0000000.

This implements a handful of client interface methods just to get going.
In particular, this implements the device tree fetching,
ibm,client-architecture-support and instantiate-rtas.
This does not implement changing properties, i.e. "setprop".

The client interface is implemented exactly as RTAS - a 20 bytes blob,
right next after the RTAS blob.

This assigns "phandles" to device tree nodes as there is no more SLOF
and OF nodes addresses of which served as phandle values.
This keeps predefined nodes (such as XICS/NVLINK/...) unchanged.
phandles are regenerated at every FDT rebuild.

When bios=off, this adds "/chosen" every time QEMU builds a tree.

This implements "claim" which the client (Linux) uses for memory
allocation; at the moment it only checks not to overwrite kernel or
initramdisk (the only two "roms" loaded); this requires proper fixing.

While at this, add a "kernel-addr" machine parameter to allow moving
the kernel in memory. This is useful for debugging if the kernel is
loaded at @0, although not necessary.

Limitations:
1. stack allocation is wrong;
2. petitboot does not boot the selected system:
"Must be root to change default boot option" (the message is likely
to be misleading).

The test command line:

qemu-system-ppc64 \
-nodefaults \
-chardev stdio,id=STDIO0,signal=off,mux=on \
-device spapr-vty,id=svty0,reg=0x71000110,chardev=STDIO0 \
-mon id=MON0,chardev=STDIO0,mode=readline \
-nographic \
-vga none \
-kernel vmldbg \
-machine pseries,bios=off \
-m 4G \
-enable-kvm \
-initrd pb/rootfs.cpio.xz \
img/u1804-64le.qcow2 \
-snapshot \
-smp 8,threads=8 \
-L /home/aik/t/qemu-ppc64-bios/ \
-trace events=qemu_trace_events \
-d guest_errors \
-chardev socket,id=SOCKET0,server,nowait,path=qemu.mon.ssh37874 \
-mon chardev=SOCKET0,mode=control

Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Fabiano Rosas <farosas@linux.ibm.com>
Cc: Leonardo Bras <leonardo@linux.ibm.com>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/Makefile.objs   |   1 +
 include/hw/loader.h    |   1 +
 include/hw/ppc/spapr.h |  16 +-
 hw/core/loader.c       |  20 +++
 hw/ppc/spapr.c         | 185 +++++++++++++++++---
 hw/ppc/spapr_client.c  | 371 +++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_hcall.c   |  47 ++++--
 hw/ppc/trace-events    |   7 +
 8 files changed, 613 insertions(+), 35 deletions(-)
 create mode 100644 hw/ppc/spapr_client.c

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 101e9fc59185..ce31c0acd2fb 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -6,6 +6,7 @@ obj-$(CONFIG_PSERIES) += spapr_hcall.o spapr_iommu.o spapr_rtas.o
 obj-$(CONFIG_PSERIES) += spapr_pci.o spapr_rtc.o spapr_drc.o
 obj-$(CONFIG_PSERIES) += spapr_cpu_core.o spapr_ovec.o spapr_irq.o
 obj-$(CONFIG_PSERIES) += spapr_tpm_proxy.o
+obj-$(CONFIG_PSERIES) += spapr_client.o
 obj-$(CONFIG_SPAPR_RNG) +=  spapr_rng.o
 # IBM PowerNV
 obj-$(CONFIG_POWERNV) += pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_psi.o pnv_occ.o pnv_bmc.o
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 48a96cd55904..a2f58077a47e 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -262,6 +262,7 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
 int rom_add_elf_program(const char *name, GMappedFile *mapped_file, void *data,
                         size_t datasize, size_t romsize, hwaddr addr,
                         AddressSpace *as);
+bool rom_intersect(uint64_t start, uint64_t size);
 int rom_check_and_register_reset(void);
 void rom_set_fw(FWCfgState *f);
 void rom_set_order_override(int order);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 61f005c6f686..a922b19fa6d3 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -158,8 +158,11 @@ struct SpaprMachineState {
     uint32_t fdt_size;
     uint32_t fdt_initial_size;
     void *fdt_blob;
+    uint32_t rtas_base;
     long kernel_size;
     bool kernel_le;
+    uint64_t kernel_addr;
+    bool bios_enabled;
     uint32_t initrd_base;
     long initrd_size;
     uint64_t rtc_offset; /* Now used only during incoming migration */
@@ -510,7 +513,8 @@ struct SpaprMachineState {
 /* Client Architecture support */
 #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
 #define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
-#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
+#define KVMPPC_H_CLIENT         (KVMPPC_HCALL_BASE + 0x5)
+#define KVMPPC_HCALL_MAX        KVMPPC_H_CLIENT
 
 /*
  * The hcall range 0xEF00 to 0xEF80 is reserved for use in facilitating
@@ -538,6 +542,12 @@ void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn);
 target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
                              target_ulong *args);
 
+target_ulong do_client_architecture_support(PowerPCCPU *cpu,
+                                            SpaprMachineState *spapr,
+                                            target_ulong addr,
+                                            target_ulong fdt_buf,
+                                            target_ulong fdt_bufsize);
+
 /* Virtual Processor Area structure constants */
 #define VPA_MIN_SIZE           640
 #define VPA_SIZE_OFFSET        0x4
@@ -769,6 +779,7 @@ struct SpaprEventLogEntry {
 void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space);
 void spapr_events_init(SpaprMachineState *sm);
 void spapr_dt_events(SpaprMachineState *sm, void *fdt);
+int spapr_h_client(SpaprMachineState *sm, target_ulong client_args);
 void close_htab_fd(SpaprMachineState *spapr);
 void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr);
 void spapr_free_hpt(SpaprMachineState *spapr);
@@ -891,4 +902,7 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
 #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the platform */
 
 void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
+
+void spapr_instantiate_rtas(SpaprMachineState *spapr, uint32_t base);
+
 #endif /* HW_SPAPR_H */
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 5099f27dc8f8..cf9fc746e101 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1157,6 +1157,26 @@ static void rom_reset(void *unused)
     }
 }
 
+bool rom_intersect(uint64_t start, uint64_t size)
+{
+    Rom *rom;
+
+    QTAILQ_FOREACH(rom, &roms, next) {
+        if (rom->fw_file) {
+            continue;
+        }
+        if (rom->data == NULL) {
+            continue;
+        }
+        if ((rom->addr <= start && start < rom->addr + rom->datasize) ||
+            (start <= rom->addr && rom->addr < start + size)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 int rom_check_and_register_reset(void)
 {
     hwaddr addr = 0;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e62c89b3dd40..36047c058da6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -896,6 +896,51 @@ out:
     return ret;
 }
 
+/*
+ * Below is a compiled version of RTAS blob and OF client interface entry point.
+ *
+ * gcc -nostdlib  -mbig -o spapr-rtas.img spapr-rtas.S
+ * objcopy  -O binary -j .text  spapr-rtas.img spapr-rtas.bin
+ *
+ *   .globl  _start
+ *   _start:
+ *           mr      4,3
+ *           lis     3,KVMPPC_H_RTAS@h
+ *           ori     3,3,KVMPPC_H_RTAS@l
+ *           sc      1
+ *           blr
+ *           mr      4,3
+ *           lis     3,KVMPPC_H_CLIENT@h
+ *           ori     3,3,KVMPPC_H_CLIENT@l
+ *           sc      1
+ *           blr
+ */
+static struct {
+    uint8_t rtas[20], client[20];
+} QEMU_PACKED rtas_client_blob = {
+    .rtas = {
+        0x7c, 0x64, 0x1b, 0x78,
+        0x3c, 0x60, 0x00, 0x00,
+        0x60, 0x63, 0xf0, 0x00,
+        0x44, 0x00, 0x00, 0x22,
+        0x4e, 0x80, 0x00, 0x20
+    },
+    .client = {
+        0x7c, 0x64, 0x1b, 0x78,
+        0x3c, 0x60, 0x00, 0x00,
+        0x60, 0x63, 0xf0, 0x05,
+        0x44, 0x00, 0x00, 0x22,
+        0x4e, 0x80, 0x00, 0x20
+    }
+};
+
+void spapr_instantiate_rtas(SpaprMachineState *spapr, uint32_t base)
+{
+    spapr->rtas_base = base;
+    cpu_physical_memory_write(base, &rtas_client_blob.rtas,
+                              sizeof(rtas_client_blob.rtas));
+}
+
 static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *ms = MACHINE(spapr);
@@ -980,6 +1025,12 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
     _FDT(fdt_setprop(fdt, rtas, "ibm,lrdr-capacity",
                      lrdr_capacity, sizeof(lrdr_capacity)));
 
+    /* These are to make kexec-lite happy */
+    _FDT(fdt_setprop_cell(fdt, rtas, "linux,rtas-base", spapr->rtas_base));
+    _FDT(fdt_setprop_cell(fdt, rtas, "linux,rtas-entry", spapr->rtas_base));
+    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size", sizeof(rtas_client_blob)));
+    _FDT(fdt_add_mem_rsv(fdt, spapr->rtas_base, sizeof(rtas_client_blob)));
+
     spapr_dt_rtas_tokens(fdt, rtas);
 }
 
@@ -1057,7 +1108,7 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
     }
 
     if (spapr->kernel_size) {
-        uint64_t kprop[2] = { cpu_to_be64(KERNEL_LOAD_ADDR),
+        uint64_t kprop[2] = { cpu_to_be64(spapr->kernel_addr),
                               cpu_to_be64(spapr->kernel_size) };
 
         _FDT(fdt_setprop(fdt, chosen, "qemu,boot-kernel",
@@ -1104,6 +1155,9 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
         _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", 0));
     }
 
+    if (!spapr->bios_enabled) {
+        _FDT(fdt_setprop_cell(fdt, chosen, "cpu", 0));
+    }
     spapr_dt_ov5_platform_support(spapr, fdt, chosen);
 
     g_free(stdout_path);
@@ -1133,6 +1187,28 @@ static void spapr_dt_hypervisor(SpaprMachineState *spapr, void *fdt)
     }
 }
 
+static void spapr_fdt_add_phandles(void *fdt, int parent, uint32_t *phandle)
+{
+    int proplen = 0, node;
+    const void *prop;
+    char tmp[256] = "BAAD";
+
+    fdt_get_path(fdt, parent, tmp, sizeof(tmp));
+    prop = fdt_getprop_namelen(fdt, parent, "phandle", 7, &proplen);
+    if (!prop) {
+        _FDT(fdt_setprop_cell(fdt, parent, "phandle", *phandle));
+        while (1) {
+            ++*phandle;
+            if (fdt_node_offset_by_phandle(fdt, *phandle) < 0) {
+                break;
+            }
+        }
+    }
+    fdt_for_each_subnode(node, fdt, parent) {
+        spapr_fdt_add_phandles(fdt, node, phandle);
+    }
+}
+
 void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
 {
     MachineState *machine = MACHINE(spapr);
@@ -1233,7 +1309,7 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
     spapr_dt_rtas(spapr, fdt);
 
     /* /chosen */
-    if (reset) {
+    if (reset || !spapr->bios_enabled) {
         spapr_dt_chosen(spapr, fdt);
     }
 
@@ -1245,7 +1321,8 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
     /* Build memory reserve map */
     if (reset) {
         if (spapr->kernel_size) {
-            _FDT((fdt_add_mem_rsv(fdt, KERNEL_LOAD_ADDR, spapr->kernel_size)));
+            _FDT((fdt_add_mem_rsv(fdt, spapr->kernel_addr,
+                                  spapr->kernel_size)));
         }
         if (spapr->initrd_size) {
             _FDT((fdt_add_mem_rsv(fdt, spapr->initrd_base,
@@ -1268,12 +1345,19 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
         }
     }
 
+    if (!spapr->bios_enabled) {
+        uint32_t phandle = 1;
+
+        spapr_fdt_add_phandles(fdt, fdt_path_offset(fdt, "/"), &phandle);
+    }
+
     return fdt;
 }
 
 static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
 {
-    return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
+    SpaprMachineState *spapr = opaque;
+    return (addr & 0x0fffffff) + spapr->kernel_addr;
 }
 
 static void emulate_spapr_hypercall(PPCVirtualHypervisor *vhyp,
@@ -1659,6 +1743,9 @@ static void spapr_machine_reset(MachineState *machine)
      * processed with 32-bit real mode code if necessary
      */
     fdt_addr = MIN(spapr->rma_size, RTAS_MAX_ADDR) - FDT_MAX_SIZE;
+    fdt_addr -= sizeof(rtas_client_blob);
+    spapr->rtas_base = MIN(spapr->rma_size, RTAS_MAX_ADDR) -
+        sizeof(rtas_client_blob);
 
     fdt = spapr_build_fdt(spapr, true, FDT_MAX_SIZE);
 
@@ -1675,9 +1762,21 @@ static void spapr_machine_reset(MachineState *machine)
     spapr->fdt_initial_size = spapr->fdt_size;
     spapr->fdt_blob = fdt;
 
+    /* RTAS and client blob */
+    cpu_physical_memory_write(MIN(spapr->rma_size, RTAS_MAX_ADDR) -
+                              sizeof(rtas_client_blob),
+                              &rtas_client_blob.rtas, sizeof(rtas_client_blob));
+
     /* Set up the entry state */
-    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
-    first_ppc_cpu->env.gpr[5] = 0;
+    if (!spapr->bios_enabled) {
+        spapr_cpu_set_entry_state(first_ppc_cpu, spapr->kernel_addr, fdt_addr);
+        first_ppc_cpu->env.gpr[5] = MIN(spapr->rma_size, RTAS_MAX_ADDR) -
+            sizeof(rtas_client_blob.client);
+        first_ppc_cpu->env.gpr[1] = 0xf0000000;
+    } else {
+        spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
+        first_ppc_cpu->env.gpr[5] = 0; /* 0 = kexec !0 = prom_init */
+    }
 
     spapr->cas_reboot = false;
 }
@@ -2897,12 +2996,12 @@ static void spapr_machine_init(MachineState *machine)
         uint64_t lowaddr = 0;
 
         spapr->kernel_size = load_elf(kernel_filename, NULL,
-                                      translate_kernel_address, NULL,
+                                      translate_kernel_address, spapr,
                                       NULL, &lowaddr, NULL, 1,
                                       PPC_ELF_MACHINE, 0, 0);
         if (spapr->kernel_size == ELF_LOAD_WRONG_ENDIAN) {
             spapr->kernel_size = load_elf(kernel_filename, NULL,
-                                          translate_kernel_address, NULL, NULL,
+                                          translate_kernel_address, spapr, NULL,
                                           &lowaddr, NULL, 0, PPC_ELF_MACHINE,
                                           0, 0);
             spapr->kernel_le = spapr->kernel_size > 0;
@@ -2918,7 +3017,7 @@ static void spapr_machine_init(MachineState *machine)
             /* Try to locate the initrd in the gap between the kernel
              * and the firmware. Add a bit of space just in case
              */
-            spapr->initrd_base = (KERNEL_LOAD_ADDR + spapr->kernel_size
+            spapr->initrd_base = (spapr->kernel_addr + spapr->kernel_size
                                   + 0x1ffff) & ~0xffff;
             spapr->initrd_size = load_image_targphys(initrd_filename,
                                                      spapr->initrd_base,
@@ -2932,20 +3031,22 @@ static void spapr_machine_init(MachineState *machine)
         }
     }
 
-    if (bios_name == NULL) {
-        bios_name = FW_FILE_NAME;
+    if (spapr->bios_enabled) {
+        if (bios_name == NULL) {
+            bios_name = FW_FILE_NAME;
+        }
+        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+        if (!filename) {
+            error_report("Could not find LPAR firmware '%s'", bios_name);
+            exit(1);
+        }
+        fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE);
+        if (fw_size <= 0) {
+            error_report("Could not load LPAR firmware '%s'", filename);
+            exit(1);
+        }
+        g_free(filename);
     }
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-    if (!filename) {
-        error_report("Could not find LPAR firmware '%s'", bios_name);
-        exit(1);
-    }
-    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE);
-    if (fw_size <= 0) {
-        error_report("Could not load LPAR firmware '%s'", filename);
-        exit(1);
-    }
-    g_free(filename);
 
     /* FIXME: Should register things through the MachineState's qdev
      * interface, this is a legacy from the sPAPREnvironment structure
@@ -3162,6 +3263,32 @@ static void spapr_set_vsmt(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, (uint32_t *)opaque, errp);
 }
 
+static void spapr_get_kernel_addr(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
+}
+
+static void spapr_set_kernel_addr(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
+}
+
+static bool spapr_get_bios_enabled(Object *obj, Error **errp)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(obj);
+
+    return spapr->bios_enabled;
+}
+
+static void spapr_set_bios_enabled(Object *obj, bool value, Error **errp)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(obj);
+
+    spapr->bios_enabled = value;
+}
+
 static char *spapr_get_ic_mode(Object *obj, Error **errp)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
@@ -3267,6 +3394,20 @@ static void spapr_instance_init(Object *obj)
     object_property_add_bool(obj, "vfio-no-msix-emulation",
                              spapr_get_msix_emulation, NULL, NULL);
 
+    object_property_add(obj, "kernel-addr", "uint64", spapr_get_kernel_addr,
+                        spapr_set_kernel_addr, NULL, &spapr->kernel_addr,
+                        &error_abort);
+    object_property_set_description(obj, "kernel-addr",
+                                    stringify(KERNEL_LOAD_ADDR)
+                                    " for -kernel is the default",
+                                    NULL);
+    spapr->kernel_addr = KERNEL_LOAD_ADDR;
+    object_property_add_bool(obj, "bios", spapr_get_bios_enabled,
+                            spapr_set_bios_enabled, NULL);
+    object_property_set_description(obj, "bios", "Conrols whether to load bios",
+                                    NULL);
+    spapr->bios_enabled = true;
+
     /* The machine class defines the default interrupt controller mode */
     spapr->irq = smc->irq;
     object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
diff --git a/hw/ppc/spapr_client.c b/hw/ppc/spapr_client.c
new file mode 100644
index 000000000000..85facbb83532
--- /dev/null
+++ b/hw/ppc/spapr_client.c
@@ -0,0 +1,371 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "exec/memory.h"
+#include "hw/ppc/spapr.h"
+#include "hw/loader.h"
+#include "trace.h"
+
+struct prom_args {
+        __be32 service;
+        __be32 nargs;
+        __be32 nret;
+        __be32 args[10];
+};
+
+#define CLI_PH_MASK     0x0FFFFFFF
+#define CLI_INST_PREFIX 0x20000000
+
+#define readstr(pa, buf) cpu_physical_memory_read((pa), (buf), sizeof(buf))
+
+static bool _cmpservice(const char *s, size_t len,
+                        unsigned nargs, unsigned nret,
+                        const char *s1, size_t len1,
+                        unsigned nargscheck, unsigned nretcheck)
+{
+    if (strncmp(s, s1, MAX(len, len1))) {
+        return false;
+    }
+
+    if (nargscheck == 0 && nretcheck == 0) {
+        return true;
+    }
+    if (nargs != nargscheck || nret != nretcheck) {
+        trace_spapr_client_error_param(s, nargscheck, nretcheck, nargs, nret);
+        return false;
+    }
+
+    return true;
+}
+
+static uint32_t client_finddevice(const void *fdt, uint32_t nodeaddr)
+{
+    char node[256];
+    int ret;
+
+    readstr(nodeaddr, node);
+    ret = fdt_path_offset(fdt, node);
+    if (ret >= 0) {
+        ret = fdt_get_phandle(fdt, ret);
+    }
+
+    return (uint32_t) ret;
+}
+
+static uint32_t client_getprop(const void *fdt, uint32_t nodeph, uint32_t pname,
+            uint32_t valaddr, uint32_t vallen)
+{
+    char propname[64];
+    uint32_t ret = 0;
+    int proplen = 0;
+    const void *prop;
+
+    readstr(pname, propname);
+
+    prop = fdt_getprop_namelen(fdt, fdt_node_offset_by_phandle(fdt, nodeph),
+                               propname, strlen(propname), &proplen);
+    if (prop) {
+        int cb = MIN(proplen, vallen);
+
+        cpu_physical_memory_write(valaddr, prop, cb);
+        ret = cb;
+    } else if (strncmp(propname, "stdout", 6) == 0 && vallen == sizeof(ret)) {
+        ret = cpu_to_be32(1);
+        cpu_physical_memory_write(valaddr, &ret, MIN(vallen, sizeof(ret)));
+    } else {
+        ret = -1;
+    }
+
+    return ret;
+}
+
+static uint32_t client_getproplen(const void *fdt, uint32_t nodeph,
+                                  uint32_t pname)
+{
+    char propname[64];
+    uint32_t ret = 0;
+    int proplen = 0;
+    const void *prop;
+
+    readstr(pname, propname);
+
+    prop = fdt_getprop_namelen(fdt, fdt_node_offset_by_phandle(fdt, nodeph),
+                               propname, strlen(propname), &proplen);
+    if (prop) {
+        ret = proplen;
+    } else if (strncmp(propname, "stdout", 6) == 0) {
+        ret = 4;
+    } else {
+        ret = -1;
+    }
+
+    return ret;
+}
+
+static uint32_t client_peer(const void *fdt, uint32_t phandle)
+{
+    int ret;
+
+    if (phandle == 0) {
+        ret = fdt_path_offset(fdt, "/");
+    } else {
+        ret = fdt_next_subnode(fdt, fdt_node_offset_by_phandle(fdt, phandle));
+    }
+
+    if (ret < 0) {
+        ret = 0;
+    } else {
+        ret = fdt_get_phandle(fdt, ret);
+    }
+
+    return ret;
+}
+
+static uint32_t client_child(const void *fdt, uint32_t phandle)
+{
+    int ret = fdt_first_subnode(fdt, fdt_node_offset_by_phandle(fdt, phandle));
+
+    if (ret < 0) {
+        ret = 0;
+    } else {
+        ret = fdt_get_phandle(fdt, ret);
+    }
+
+    return ret;
+}
+
+static uint32_t client_parent(const void *fdt, uint32_t phandle)
+{
+    int ret = fdt_parent_offset(fdt, fdt_node_offset_by_phandle(fdt, phandle));
+
+    if (ret < 0) {
+        ret = 0;
+    } else {
+        ret = fdt_get_phandle(fdt, ret);
+    }
+
+    return ret;
+}
+
+static uint32_t client_open(uint32_t phandle)
+{
+    uint32_t ret = (phandle & CLI_PH_MASK) | CLI_INST_PREFIX;
+
+    return ret;
+}
+
+static uint32_t client_instance_to_path(uint32_t instance, uint32_t buf,
+                                        uint32_t len)
+{
+    return 0;
+}
+
+static uint32_t client_package_to_path(const void *fdt, uint32_t phandle,
+                                       uint32_t buf, uint32_t len)
+{
+    char tmp[256];
+
+    if (0 == fdt_get_path(fdt, fdt_node_offset_by_phandle(fdt, phandle), tmp,
+                          sizeof(tmp))) {
+        tmp[sizeof(tmp) - 1] = 0;
+        cpu_physical_memory_write(buf, tmp, MIN(len, strlen(tmp)));
+    }
+    return len;
+}
+
+static uint32_t client_write(uint32_t instance, uint32_t buf, uint32_t len)
+{
+    char tmp[len + 1]; /* TODO: do a loop as len might be enourmous*/
+
+    readstr(buf, tmp);
+    tmp[len] = 0;
+    printf("%s", tmp);
+
+    return len;
+}
+
+static uint32_t client_claim(uint32_t virt, uint32_t size, uint32_t align)
+{
+    uint32_t ret;
+    static uint32_t cur = 0xe0000000;
+
+    if (align == 0) {
+        if (rom_intersect(virt, size)) {
+            ret = -1;
+        } else {
+            ret = virt;
+        }
+    } else {
+        cur = (cur + align - 1) & ~(align - 1);
+        ret = cur;
+        cur += align;
+    }
+    trace_spapr_client_claim(virt, size, align, ret);
+
+    return ret;
+}
+
+static uint32_t client_nextprop(const void *fdt, uint32_t phandle,
+                                uint32_t prevaddr, uint32_t nameaddr)
+{
+    int namelen = 0;
+    int offset = fdt_node_offset_by_phandle(fdt, phandle);
+    char prev[256];
+    const struct fdt_property *prop;
+    const char *tmp;
+
+    readstr(prevaddr, prev);
+    for (offset = fdt_first_property_offset(fdt, offset);
+         (offset >= 0);
+         (offset = fdt_next_property_offset(fdt, offset))) {
+
+        prop = fdt_get_property_by_offset(fdt, offset, &namelen);
+        if (!prop) {
+            return 0;
+        }
+
+        tmp = fdt_get_string(fdt, fdt32_ld(&prop->nameoff), &namelen);
+        if (prev[0] == 0 ||
+            strncmp(prev, tmp, MAX(namelen, strlen(prev))) == 0) {
+
+            if (prev[0]) {
+                offset = fdt_next_property_offset(fdt, offset);
+                if (offset < 0) {
+                    return 0;
+                }
+            }
+            prop = fdt_get_property_by_offset(fdt, offset, &namelen);
+            if (!prop) {
+                return 0;
+            }
+
+            tmp = fdt_get_string(fdt, fdt32_ld(&prop->nameoff), &namelen);
+            cpu_physical_memory_write(nameaddr, tmp, namelen + 1);
+            return 1;
+        }
+    }
+
+    return 0;
+}
+
+static uint32_t client_call_method(SpaprMachineState *sm, uint32_t methodaddr,
+                                   uint32_t param1, uint32_t param2,
+                                   uint32_t *ret2)
+{
+    uint32_t ret = 0;
+    char method[256];
+
+    readstr(methodaddr, method);
+    if (strncmp(method, "ibm,client-architecture-support", 31) == 0) {
+
+#define FDT_MAX_SIZE            0x100000
+        ret = do_client_architecture_support(POWERPC_CPU(first_cpu), sm, param2,
+                                             0, FDT_MAX_SIZE);
+        *ret2 = 0;
+    } else if (strncmp(method, "instantiate-rtas", 16) == 0) {
+        uint32_t rtasbase = param2;
+
+        spapr_instantiate_rtas(sm, rtasbase);
+        *ret2 = rtasbase;
+    } else {
+        trace_spapr_client_error_unknown_method(method);
+        return -1;
+    }
+
+    trace_spapr_client_method(method, param1, param2, ret);
+
+    return ret;
+}
+
+static void client_quiesce(SpaprMachineState *sm)
+{
+}
+
+int spapr_h_client(SpaprMachineState *sm, target_ulong client_args)
+{
+    struct prom_args args = { 0 };
+    char service[64];
+    unsigned nargs, nret;
+    int i, servicelen;
+
+    cpu_physical_memory_read(client_args, &args, sizeof(args));
+    nargs = be32_to_cpu(args.nargs);
+    nret = be32_to_cpu(args.nret);
+    readstr(be32_to_cpu(args.service), service);
+    servicelen = strlen(service);
+
+#define cmpservice(s, a, r) \
+        _cmpservice(service, servicelen, nargs, nret, (s), sizeof(s), (a), (r))
+
+    if (cmpservice("finddevice", 1, 1)) {
+        args.args[nargs] = client_finddevice(sm->fdt_blob,
+                                             be32_to_cpu(args.args[0]));
+    } else if (cmpservice("getprop", 4, 1)) {
+        args.args[nargs] = client_getprop(sm->fdt_blob,
+                                          be32_to_cpu(args.args[0]),
+                                          be32_to_cpu(args.args[1]),
+                                          be32_to_cpu(args.args[2]),
+                                          be32_to_cpu(args.args[3]));
+    } else if (cmpservice("getproplen", 2, 1)) {
+        args.args[nargs] = client_getproplen(sm->fdt_blob,
+                                             be32_to_cpu(args.args[0]),
+                                             be32_to_cpu(args.args[1]));
+    } else if (cmpservice("instance-to-path", 3, 1)) {
+        args.args[nargs] = client_instance_to_path(be32_to_cpu(args.args[0]),
+                                                   be32_to_cpu(args.args[1]),
+                                                   be32_to_cpu(args.args[2]));
+    } else if (cmpservice("package-to-path", 3, 1)) {
+        args.args[nargs] = client_package_to_path(sm->fdt_blob,
+                                                  be32_to_cpu(args.args[0]),
+                                                  be32_to_cpu(args.args[1]),
+                                                  be32_to_cpu(args.args[2]));
+    } else if (cmpservice("write", 3, 1)) {
+        args.args[nargs] = client_write(be32_to_cpu(args.args[0]),
+                                        be32_to_cpu(args.args[1]),
+                                        be32_to_cpu(args.args[2]));
+    } else if (cmpservice("peer", 1, 1)) {
+        args.args[nargs] = client_peer(sm->fdt_blob,
+                                       be32_to_cpu(args.args[0]));
+    } else if (cmpservice("child", 1, 1)) {
+        args.args[nargs] = client_child(sm->fdt_blob,
+                                        be32_to_cpu(args.args[0]));
+    } else if (cmpservice("parent", 1, 1)) {
+        args.args[nargs] = client_parent(sm->fdt_blob,
+                                         be32_to_cpu(args.args[0]));
+    } else if (cmpservice("open", 1, 1)) {
+        args.args[nargs] = client_open(be32_to_cpu(args.args[0]));
+    } else if (cmpservice("call-method", 3, 2)) {
+        uint32_t ret2 = 0;
+
+        args.args[nargs] = client_call_method(sm,
+                                              be32_to_cpu(args.args[0]),
+                                              be32_to_cpu(args.args[1]),
+                                              be32_to_cpu(args.args[2]),
+                                              &ret2);
+        args.args[nargs + 1] = ret2;
+    } else if (cmpservice("claim", 3, 1)) {
+        args.args[nargs] = client_claim(be32_to_cpu(args.args[0]),
+                                        be32_to_cpu(args.args[1]),
+                                        be32_to_cpu(args.args[2]));
+    } else if (cmpservice("nextprop", 3, 1)) {
+        args.args[nargs] = client_nextprop(sm->fdt_blob,
+                                           be32_to_cpu(args.args[0]),
+                                           be32_to_cpu(args.args[1]),
+                                           be32_to_cpu(args.args[2]));
+    } else if (cmpservice("quiesce", 0, 0)) {
+        client_quiesce(sm);
+    } else if (cmpservice("exit", 0, 0)) {
+        error_report("Stopped as the VM requested \"exit\"");
+        vm_stop(RUN_STATE_PAUSED);
+    } else {
+        trace_spapr_client_error_unknown_service(service, nargs, nret);
+        args.args[nargs] = -1;
+    }
+
+    for (i = 0; i < nret; ++i) {
+        args.args[nargs + i] = be32_to_cpu(args.args[nargs + i]);
+    }
+    cpu_physical_memory_write(client_args, &args, sizeof(args));
+
+    return H_SUCCESS;
+}
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index f1799b1b707d..ea350389424a 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1660,15 +1660,12 @@ static bool spapr_hotplugged_dev_before_cas(void)
     return false;
 }
 
-static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
-                                                  SpaprMachineState *spapr,
-                                                  target_ulong opcode,
-                                                  target_ulong *args)
+target_ulong do_client_architecture_support(PowerPCCPU *cpu,
+                                            SpaprMachineState *spapr,
+                                            target_ulong addr,
+                                            target_ulong fdt_buf,
+                                            target_ulong fdt_bufsize)
 {
-    /* Working address in data buffer */
-    target_ulong addr = ppc64_phys_to_real(args[0]);
-    target_ulong fdt_buf = args[1];
-    target_ulong fdt_bufsize = args[2];
     target_ulong ov_table;
     uint32_t cas_pvr;
     SpaprOptionVector *ov1_guest, *ov5_guest, *ov5_cas_old;
@@ -1836,10 +1833,12 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
         fdt = spapr_build_fdt(spapr, false, fdt_bufsize);
         _FDT((fdt_pack(fdt)));
 
-        cpu_physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
-        cpu_physical_memory_write(fdt_buf + sizeof(hdr), fdt,
-                                  fdt_totalsize(fdt));
-        trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr));
+        if (spapr->bios_enabled) {
+            cpu_physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
+            cpu_physical_memory_write(fdt_buf + sizeof(hdr), fdt,
+                                      fdt_totalsize(fdt));
+            trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr));
+        }
 
         g_free(spapr->fdt_blob);
         spapr->fdt_size = fdt_totalsize(fdt);
@@ -1854,6 +1853,20 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
+static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
+                                                  SpaprMachineState *spapr,
+                                                  target_ulong opcode,
+                                                  target_ulong *args)
+{
+    /* Working address in data buffer */
+    target_ulong addr = ppc64_phys_to_real(args[0]);
+    target_ulong fdt_buf = args[1];
+    target_ulong fdt_bufsize = args[2];
+
+    return do_client_architecture_support(cpu, spapr, addr, fdt_buf,
+                                          fdt_bufsize);
+}
+
 static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
                                               SpaprMachineState *spapr,
                                               target_ulong opcode,
@@ -1998,6 +2011,14 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+static target_ulong h_client(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                             target_ulong opcode, target_ulong *args)
+{
+    target_ulong client_args = ppc64_phys_to_real(args[0]);
+
+    return spapr_h_client(spapr, client_args);
+}
+
 static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
 static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_HCALL_BASE + 1];
 static spapr_hcall_fn svm_hypercall_table[(SVM_HCALL_MAX - SVM_HCALL_BASE) / 4 + 1];
@@ -2121,6 +2142,8 @@ static void hypercall_register_types(void)
 
     spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
 
+    spapr_register_hypercall(KVMPPC_H_CLIENT, h_client);
+
     /* Virtual Processor Home Node */
     spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
                              h_home_node_associativity);
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 9ea620f23c85..394963b52d27 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -21,6 +21,13 @@ spapr_update_dt(unsigned cb) "New blob %u bytes"
 spapr_update_dt_failed_size(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
 spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
 
+# spapr_client.c
+spapr_client_error_param(const char *method, int nargscheck, int nretcheck, int nargs, int nret) "%s takes/returns %d/%d, not %d/%d"
+spapr_client_error_unknown_service(const char *service, int nargs, int nret) "%s args=%d rets=%d"
+spapr_client_error_unknown_method(const char *method) "%s"
+spapr_client_claim(uint32_t virt, uint32_t size, uint32_t align, uint32_t ret) "virt=0x%x size=0x%x align=0x%x => 0x%x"
+spapr_client_method(const char *method, uint32_t param1, uint32_t param2, uint32_t ret) "%s(0x%x, 0x%x) => 0x%x"
+
 # spapr_hcall_tpm.c
 spapr_h_tpm_comm(const char *device_path, uint64_t operation) "tpm_device_path=%s operation=0x%"PRIu64
 spapr_tpm_execute(uint64_t data_in, uint64_t data_in_sz, uint64_t data_out, uint64_t data_out_sz) "data_in=0x%"PRIx64", data_in_sz=%"PRIu64", data_out=0x%"PRIx64", data_out_sz=%"PRIu64
-- 
2.17.1


