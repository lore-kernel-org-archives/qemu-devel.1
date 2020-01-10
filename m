Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C3AC32771
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 02:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9C420678
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 02:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9C420678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipjlk-00008I-Gr
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 21:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1ipjkV-00074D-Uj
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 21:10:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1ipjkQ-0007Xv-V0
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 21:10:07 -0500
Received: from [107.174.27.60] (port=43364 helo=ozlabs.ru)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1ipjkQ-0007PF-F3; Thu, 09 Jan 2020 21:10:02 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 55F89AE80004;
 Thu,  9 Jan 2020 21:08:13 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH qemu v5] spapr: Kill SLOF
Date: Fri, 10 Jan 2020 13:09:25 +1100
Message-Id: <20200110020925.98711-1-aik@ozlabs.ru>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
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

The client interface is implemented exactly as RTAS - a 20 bytes blob,
right next after the RTAS blob. The entry point is passed to the kernel
via GPR5.

This implements a handful of client interface methods just to get going.
In particular, this implements the device tree fetching,
ibm,client-architecture-support and instantiate-rtas.

This implements changing FDT properties for RTAS (for vmlinux and zImage)
and initramdisk location (for zImage). To make this work, this skips
fdt_pack() when bios=off as not packing the blob leaves some room for
appending.

This assigns "phandles" to device tree nodes as there is no more SLOF
and OF nodes addresses of which served as phandle values.
This keeps predefined nodes (such as XICS/NVLINK/...) unchanged.
phandles are regenerated at every FDT rebuild.

When bios=off, this adds "/chosen" every time QEMU builds a tree.

This implements "claim" which the client (Linux) uses for memory
allocation; this is also  used by QEMU for claiming kernel/initrd images,
client interface entry point, RTAS and the initial stack.

While at this, add a "kernel-addr" machine parameter to allow moving
the kernel in memory. This is useful for debugging if the kernel is
loaded at @0, although not necessary.

This adds basic instances support which are managed by a hashmap
ihandle->[phandle, DeviceState, Chardev].

Note that a 64bit PCI fix is required for Linux:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=df5be5be8735e

The test command line:

qemu-system-ppc64 \
-nodefaults \
-chardev stdio,id=STDIO0,signal=off,mux=on \
-device spapr-vty,id=svty0,reg=0x71000110,chardev=STDIO0 \
-mon id=MON0,chardev=STDIO0,mode=readline \
-nographic \
-vga none \
-kernel pbuild/kernel-le-guest/arch/powerpc/boot/zImage.pseries \
-machine pseries,bios=off,cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken \
-m 4G \
-enable-kvm \
-initrd pb/rootfs.cpio.xz \
-device nec-usb-xhci,id=nec-usb-xhci0 \
-netdev tap,id=TAP0,helper=/home/aik/qemu-bridge-helper --br=br0 \
-device virtio-net-pci,id=vnet0,netdev=TAP0 img/f30le.qcow2 \
-snapshot \
-smp 8,threads=8 \
-trace events=qemu_trace_events \
-d guest_errors \
-chardev socket,id=SOCKET0,server,nowait,path=qemu.mon.ssh54088 \
-mon chardev=SOCKET0,mode=control

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v5:
* made instances keep device and chardev pointers
* removed VIO dependencies
* print error if RTAS memory is not claimed as it should have been
* pack FDT as "quiesce"

v4:
* fixed open
* validate ihandles in "call-method"

v3:
* fixed phandles allocation
* s/__be32/uint32_t/ as we do not normally have __be32 type in qemu
* fixed size of /chosen/stdout
* bunch of renames
* do not create rtas properties at all, let the client deal with it;
instead setprop allows changing these in the FDT
* no more packing FDT when bios=off - nobody needs it and getprop does not
work otherwise
* allow updating initramdisk device tree properties (for zImage)
* added instances
* fixed stdout on OF's "write"
* removed special handling for stdout in OF client, spapr-vty handles it
instead

v2:
* fixed claim()
* added "setprop"
* cleaner client interface and RTAS blobs management
* boots to petitboot and further to the target system
* more trace points
---
 hw/ppc/Makefile.objs     |   1 +
 include/hw/ppc/spapr.h   |  28 +-
 hw/ppc/spapr.c           | 266 ++++++++++++++--
 hw/ppc/spapr_hcall.c     |  74 +++--
 hw/ppc/spapr_of_client.c | 633 +++++++++++++++++++++++++++++++++++++++
 hw/ppc/trace-events      |  12 +
 6 files changed, 959 insertions(+), 55 deletions(-)
 create mode 100644 hw/ppc/spapr_of_client.c

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 101e9fc59185..20efc0aa6f9b 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -6,6 +6,7 @@ obj-$(CONFIG_PSERIES) += spapr_hcall.o spapr_iommu.o spapr_rtas.o
 obj-$(CONFIG_PSERIES) += spapr_pci.o spapr_rtc.o spapr_drc.o
 obj-$(CONFIG_PSERIES) += spapr_cpu_core.o spapr_ovec.o spapr_irq.o
 obj-$(CONFIG_PSERIES) += spapr_tpm_proxy.o
+obj-$(CONFIG_PSERIES) += spapr_of_client.o
 obj-$(CONFIG_SPAPR_RNG) +=  spapr_rng.o
 # IBM PowerNV
 obj-$(CONFIG_POWERNV) += pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_psi.o pnv_occ.o pnv_bmc.o
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 61f005c6f686..efc2c70abf99 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -105,6 +105,11 @@ struct SpaprCapabilities {
     uint8_t caps[SPAPR_CAP_NUM];
 };
 
+typedef struct {
+    uint64_t start;
+    uint64_t size;
+} SpaprOfClaimed;
+
 /**
  * SpaprMachineClass:
  */
@@ -160,6 +165,13 @@ struct SpaprMachineState {
     void *fdt_blob;
     long kernel_size;
     bool kernel_le;
+    uint64_t kernel_addr;
+    bool bios_enabled;
+    uint32_t rtas_base;
+    GArray *claimed; /* array of SpaprOfClaimed */
+    uint64_t claimed_base;
+    GHashTable *of_instances; /* ihandle -> SpaprOfInstance */
+    uint32_t of_instance_last;
     uint32_t initrd_base;
     long initrd_size;
     uint64_t rtc_offset; /* Now used only during incoming migration */
@@ -510,7 +522,8 @@ struct SpaprMachineState {
 /* Client Architecture support */
 #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
 #define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
-#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
+#define KVMPPC_H_CLIENT         (KVMPPC_HCALL_BASE + 0x5)
+#define KVMPPC_HCALL_MAX        KVMPPC_H_CLIENT
 
 /*
  * The hcall range 0xEF00 to 0xEF80 is reserved for use in facilitating
@@ -538,6 +551,11 @@ void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn);
 target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
                              target_ulong *args);
 
+target_ulong do_client_architecture_support(PowerPCCPU *cpu,
+                                            SpaprMachineState *spapr,
+                                            target_ulong addr,
+                                            target_ulong fdt_bufsize);
+
 /* Virtual Processor Area structure constants */
 #define VPA_MIN_SIZE           640
 #define VPA_SIZE_OFFSET        0x4
@@ -769,6 +787,11 @@ struct SpaprEventLogEntry {
 void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space);
 void spapr_events_init(SpaprMachineState *sm);
 void spapr_dt_events(SpaprMachineState *sm, void *fdt);
+uint64_t spapr_do_of_client_claim(SpaprMachineState *spapr, uint64_t virt,
+                                  uint64_t size, uint64_t align);
+
+uint32_t spapr_of_client_open(SpaprMachineState *spapr, const char *path);
+int spapr_h_client(SpaprMachineState *spapr, target_ulong client_args);
 void close_htab_fd(SpaprMachineState *spapr);
 void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr);
 void spapr_free_hpt(SpaprMachineState *spapr);
@@ -891,4 +914,7 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
 #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the platform */
 
 void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
+
+void spapr_instantiate_rtas(SpaprMachineState *spapr, uint32_t base);
+
 #endif /* HW_SPAPR_H */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e62c89b3dd40..76ce8b973082 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -896,6 +896,55 @@ out:
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
+    if (spapr_do_of_client_claim(spapr, base, sizeof(rtas_client_blob.rtas),
+                                 0) != -1) {
+        error_report("The OF client did not claim RTAS memory at 0x%x", base);
+    }
+    spapr->rtas_base = base;
+    cpu_physical_memory_write(base, rtas_client_blob.rtas,
+                              sizeof(rtas_client_blob.rtas));
+}
+
 static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *ms = MACHINE(spapr);
@@ -980,6 +1029,11 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
     _FDT(fdt_setprop(fdt, rtas, "ibm,lrdr-capacity",
                      lrdr_capacity, sizeof(lrdr_capacity)));
 
+    if (!spapr->bios_enabled) {
+        _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size",
+                              sizeof(rtas_client_blob.rtas)));
+    }
+
     spapr_dt_rtas_tokens(fdt, rtas);
 }
 
@@ -1057,7 +1111,7 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
     }
 
     if (spapr->kernel_size) {
-        uint64_t kprop[2] = { cpu_to_be64(KERNEL_LOAD_ADDR),
+        uint64_t kprop[2] = { cpu_to_be64(spapr->kernel_addr),
                               cpu_to_be64(spapr->kernel_size) };
 
         _FDT(fdt_setprop(fdt, chosen, "qemu,boot-kernel",
@@ -1245,7 +1299,8 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
     /* Build memory reserve map */
     if (reset) {
         if (spapr->kernel_size) {
-            _FDT((fdt_add_mem_rsv(fdt, KERNEL_LOAD_ADDR, spapr->kernel_size)));
+            _FDT((fdt_add_mem_rsv(fdt, spapr->kernel_addr,
+                                  spapr->kernel_size)));
         }
         if (spapr->initrd_size) {
             _FDT((fdt_add_mem_rsv(fdt, spapr->initrd_base,
@@ -1268,12 +1323,56 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
         }
     }
 
+    if (!spapr->bios_enabled) {
+        uint32_t phandle;
+        int i, offset, proplen = 0;
+        const void *prop;
+        bool found = false;
+        GArray *phandles = g_array_new(false, false, sizeof(uint32_t));
+
+        /* Find all predefined phandles */
+        for (offset = fdt_next_node(fdt, -1, NULL);
+             offset >= 0;
+             offset = fdt_next_node(fdt, offset, NULL)) {
+            prop = fdt_getprop_namelen(fdt, offset, "phandle", 7, &proplen);
+            if (prop && proplen == sizeof(uint32_t)) {
+                phandle = fdt32_ld(prop);
+                g_array_append_val(phandles, phandle);
+            }
+        }
+
+        /* Assign phandles skipping the predefined ones */
+        for (offset = fdt_next_node(fdt, -1, NULL), phandle = 1;
+             offset >= 0;
+             offset = fdt_next_node(fdt, offset, NULL), ++phandle) {
+            prop = fdt_getprop_namelen(fdt, offset, "phandle", 7, &proplen);
+            if (prop) {
+                continue;
+            }
+            /* Check if the current phandle is not allocated already */
+            for ( ; ; ++phandle) {
+                for (i = 0, found = false; i < phandles->len; ++i) {
+                    if (phandle == g_array_index(phandles, uint32_t, i)) {
+                        found = true;
+                        break;
+                    }
+                }
+                if (!found) {
+                    break;
+                }
+            }
+            _FDT(fdt_setprop_cell(fdt, offset, "phandle", phandle));
+        }
+        g_array_unref(phandles);
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
@@ -1660,24 +1759,89 @@ static void spapr_machine_reset(MachineState *machine)
      */
     fdt_addr = MIN(spapr->rma_size, RTAS_MAX_ADDR) - FDT_MAX_SIZE;
 
+    /* Set up the entry state */
+    if (!spapr->bios_enabled) {
+        if (spapr->claimed) {
+            g_array_unref(spapr->claimed);
+        }
+        if (spapr->of_instances) {
+            g_hash_table_unref(spapr->of_instances);
+        }
+
+        spapr->claimed = g_array_new(false, false, sizeof(SpaprOfClaimed));
+        spapr->of_instances = g_hash_table_new(g_direct_hash, g_direct_equal);
+
+        spapr->claimed_base = 0x10000; /* Avoid using the first system page */
+
+        spapr_cpu_set_entry_state(first_ppc_cpu, spapr->kernel_addr,
+                                  spapr->initrd_base);
+        first_ppc_cpu->env.gpr[4] = spapr->initrd_size;
+
+        if (spapr_do_of_client_claim(spapr, spapr->kernel_addr,
+                                  spapr->kernel_size, 0) == -1) {
+            error_report("Memory for kernel is in use");
+            exit(1);
+        }
+        if (spapr_do_of_client_claim(spapr, spapr->initrd_base,
+                                  spapr->initrd_size, 0) == -1) {
+            error_report("Memory for initramdisk is in use");
+            exit(1);
+        }
+        first_ppc_cpu->env.gpr[1] = spapr_do_of_client_claim(spapr, 0, 0x40000,
+                                                             0x10000);
+        if (first_ppc_cpu->env.gpr[1] == -1) {
+            error_report("Memory allocation for stack failed");
+            exit(1);
+        }
+
+        first_ppc_cpu->env.gpr[5] =
+            spapr_do_of_client_claim(spapr, 0, sizeof(rtas_client_blob.client),
+                                     sizeof(rtas_client_blob.client));
+        if (first_ppc_cpu->env.gpr[5] == -1) {
+            error_report("Memory allocation for OF client failed");
+            exit(1);
+        }
+        cpu_physical_memory_write(first_ppc_cpu->env.gpr[5],
+                                  rtas_client_blob.client,
+                                  sizeof(rtas_client_blob.client));
+    } else {
+        spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
+        first_ppc_cpu->env.gpr[5] = 0; /* 0 = kexec !0 = prom_init */
+    }
+
     fdt = spapr_build_fdt(spapr, true, FDT_MAX_SIZE);
 
-    rc = fdt_pack(fdt);
-
-    /* Should only fail if we've built a corrupted tree */
-    assert(rc == 0);
-
-    /* Load the fdt */
-    qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
-    cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
     g_free(spapr->fdt_blob);
     spapr->fdt_size = fdt_totalsize(fdt);
     spapr->fdt_initial_size = spapr->fdt_size;
     spapr->fdt_blob = fdt;
 
-    /* Set up the entry state */
-    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
-    first_ppc_cpu->env.gpr[5] = 0;
+    if (spapr->bios_enabled) {
+        /* Load the fdt */
+        rc = fdt_pack(spapr->fdt_blob);
+        /* Should only fail if we've built a corrupted tree */
+        assert(rc == 0);
+
+        spapr->fdt_size = fdt_totalsize(spapr->fdt_blob);
+        spapr->fdt_initial_size = spapr->fdt_size;
+        qemu_fdt_dumpdtb(spapr->fdt_blob, spapr->fdt_size);
+        cpu_physical_memory_write(fdt_addr, spapr->fdt_blob, spapr->fdt_size);
+    } else {
+        char *stdout_path = spapr_vio_stdout_path(spapr->vio_bus);
+        int offset = fdt_path_offset(fdt, "/chosen");
+
+        /*
+         * SLOF-less setup requires an open instance of stdout for early
+         * kernel printk. By now all phandles are settled so we can open
+         * the default serial console.
+         * We skip writing FDT as nothing expects it; OF client interface is
+         * going to be used for reading the device tree.
+         */
+        if (stdout_path) {
+            _FDT(fdt_setprop_cell(fdt, offset, "stdout",
+                                  spapr_of_client_open(spapr, stdout_path)));
+        }
+    }
 
     spapr->cas_reboot = false;
 }
@@ -2897,12 +3061,12 @@ static void spapr_machine_init(MachineState *machine)
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
@@ -2918,7 +3082,7 @@ static void spapr_machine_init(MachineState *machine)
             /* Try to locate the initrd in the gap between the kernel
              * and the firmware. Add a bit of space just in case
              */
-            spapr->initrd_base = (KERNEL_LOAD_ADDR + spapr->kernel_size
+            spapr->initrd_base = (spapr->kernel_addr + spapr->kernel_size
                                   + 0x1ffff) & ~0xffff;
             spapr->initrd_size = load_image_targphys(initrd_filename,
                                                      spapr->initrd_base,
@@ -2932,20 +3096,22 @@ static void spapr_machine_init(MachineState *machine)
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
@@ -3162,6 +3328,32 @@ static void spapr_set_vsmt(Object *obj, Visitor *v, const char *name,
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
@@ -3267,6 +3459,20 @@ static void spapr_instance_init(Object *obj)
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
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index f1799b1b707d..f2d8823d2c3a 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1660,15 +1660,11 @@ static bool spapr_hotplugged_dev_before_cas(void)
     return false;
 }
 
-static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
-                                                  SpaprMachineState *spapr,
-                                                  target_ulong opcode,
-                                                  target_ulong *args)
+target_ulong do_client_architecture_support(PowerPCCPU *cpu,
+                                            SpaprMachineState *spapr,
+                                            target_ulong addr,
+                                            target_ulong fdt_bufsize)
 {
-    /* Working address in data buffer */
-    target_ulong addr = ppc64_phys_to_real(args[0]);
-    target_ulong fdt_buf = args[1];
-    target_ulong fdt_bufsize = args[2];
     target_ulong ov_table;
     uint32_t cas_pvr;
     SpaprOptionVector *ov1_guest, *ov5_guest, *ov5_cas_old;
@@ -1816,7 +1812,6 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
 
     if (!spapr->cas_reboot) {
         void *fdt;
-        SpaprDeviceTreeUpdateHeader hdr = { .version_id = 1 };
 
         /* If spapr_machine_reset() did not set up a HPT but one is necessary
          * (because the guest isn't going to use radix) then set it up here. */
@@ -1825,21 +1820,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
             spapr_setup_hpt_and_vrma(spapr);
         }
 
-        if (fdt_bufsize < sizeof(hdr)) {
-            error_report("SLOF provided insufficient CAS buffer "
-                         TARGET_FMT_lu " (min: %zu)", fdt_bufsize, sizeof(hdr));
-            exit(EXIT_FAILURE);
-        }
-
-        fdt_bufsize -= sizeof(hdr);
-
-        fdt = spapr_build_fdt(spapr, false, fdt_bufsize);
-        _FDT((fdt_pack(fdt)));
-
-        cpu_physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
-        cpu_physical_memory_write(fdt_buf + sizeof(hdr), fdt,
-                                  fdt_totalsize(fdt));
-        trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr));
+        fdt = spapr_build_fdt(spapr, !spapr->bios_enabled, fdt_bufsize);
 
         g_free(spapr->fdt_blob);
         spapr->fdt_size = fdt_totalsize(fdt);
@@ -1854,6 +1835,41 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
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
+    target_ulong ret;
+    SpaprDeviceTreeUpdateHeader hdr = { .version_id = 1 };
+
+    if (fdt_bufsize < sizeof(hdr)) {
+        error_report("SLOF provided insufficient CAS buffer "
+                     TARGET_FMT_lu " (min: %zu)", fdt_bufsize, sizeof(hdr));
+        exit(EXIT_FAILURE);
+    }
+
+    fdt_bufsize -= sizeof(hdr);
+
+    ret = do_client_architecture_support(cpu, spapr, addr, fdt_bufsize);
+    if (ret == H_SUCCESS) {
+        _FDT((fdt_pack(spapr->fdt_blob)));
+        spapr->fdt_size = fdt_totalsize(spapr->fdt_blob);
+        spapr->fdt_initial_size = spapr->fdt_size;
+
+        cpu_physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
+        cpu_physical_memory_write(fdt_buf + sizeof(hdr), spapr->fdt_blob,
+                                  spapr->fdt_size);
+        trace_spapr_cas_continue(spapr->fdt_size + sizeof(hdr));
+    }
+
+    return ret;
+}
+
 static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
                                               SpaprMachineState *spapr,
                                               target_ulong opcode,
@@ -1998,6 +2014,14 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
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
@@ -2121,6 +2145,8 @@ static void hypercall_register_types(void)
 
     spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
 
+    spapr_register_hypercall(KVMPPC_H_CLIENT, h_client);
+
     /* Virtual Processor Home Node */
     spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
                              h_home_node_associativity);
diff --git a/hw/ppc/spapr_of_client.c b/hw/ppc/spapr_of_client.c
new file mode 100644
index 000000000000..24d854b76e51
--- /dev/null
+++ b/hw/ppc/spapr_of_client.c
@@ -0,0 +1,633 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "exec/memory.h"
+#include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_vio.h"
+#include "chardev/char.h"
+#include "qom/qom-qobject.h"
+#include "trace.h"
+
+typedef struct {
+    DeviceState *dev;
+    Chardev *cdev;
+    uint32_t phandle;
+} SpaprOfInstance;
+
+/*
+ * OF 1275 "nextprop" description suggests is it 32 bytes max but
+ * LoPAPR defines "ibm,query-interrupt-source-number" which is 33 chars long.
+ */
+#define OF_PROPNAME_LEN_MAX 64
+
+/* Defined as Big Endian */
+struct prom_args {
+    uint32_t service;
+    uint32_t nargs;
+    uint32_t nret;
+    uint32_t args[10];
+};
+
+static void readstr(hwaddr pa, char *buf, int size)
+{
+    cpu_physical_memory_read(pa, buf, size - 1);
+    buf[size - 1] = 0;
+}
+
+static bool _cmpservice(const char *s, size_t len,
+                        unsigned nargs, unsigned nret,
+                        const char *s1, size_t len1,
+                        unsigned nargscheck, unsigned nretcheck)
+{
+    if (strcmp(s, s1)) {
+        return false;
+    }
+    if (nargscheck == 0 && nretcheck == 0) {
+        return true;
+    }
+    if (nargs != nargscheck || nret != nretcheck) {
+        trace_spapr_of_client_error_param(s, nargscheck, nretcheck, nargs,
+                                          nret);
+        return false;
+    }
+
+    return true;
+}
+
+static uint32_t of_client_finddevice(const void *fdt, uint32_t nodeaddr)
+{
+    char node[256];
+    int ret;
+
+    readstr(nodeaddr, node, sizeof(node));
+    ret = fdt_path_offset(fdt, node);
+    if (ret >= 0) {
+        ret = fdt_get_phandle(fdt, ret);
+    }
+
+    return (uint32_t) ret;
+}
+
+static uint32_t of_client_getprop(const void *fdt, uint32_t nodeph,
+                                  uint32_t pname, uint32_t valaddr,
+                                  uint32_t vallen)
+{
+    char propname[OF_PROPNAME_LEN_MAX + 1];
+    uint32_t ret = 0;
+    int proplen = 0;
+    const void *prop;
+
+    readstr(pname, propname, sizeof(propname));
+    prop = fdt_getprop_namelen(fdt, fdt_node_offset_by_phandle(fdt, nodeph),
+                               propname, strlen(propname), &proplen);
+    if (prop) {
+        int cb = MIN(proplen, vallen);
+
+        cpu_physical_memory_write(valaddr, prop, cb);
+        ret = cb;
+    } else {
+        ret = -1;
+    }
+    trace_spapr_of_client_getprop(nodeph, propname, ret);
+
+    return ret;
+}
+
+static uint32_t of_client_getproplen(const void *fdt, uint32_t nodeph,
+                                     uint32_t pname)
+{
+    char propname[OF_PROPNAME_LEN_MAX + 1];
+    uint32_t ret = 0;
+    int proplen = 0;
+    const void *prop;
+
+    readstr(pname, propname, sizeof(propname));
+
+    prop = fdt_getprop_namelen(fdt, fdt_node_offset_by_phandle(fdt, nodeph),
+                               propname, strlen(propname), &proplen);
+    if (prop) {
+        ret = proplen;
+    } else {
+        ret = -1;
+    }
+
+    return ret;
+}
+
+static uint32_t of_client_setprop(SpaprMachineState *spapr,
+                                  uint32_t nodeph, uint32_t pname,
+                                  uint32_t valaddr, uint32_t vallen)
+{
+    char propname[OF_PROPNAME_LEN_MAX + 1];
+    uint32_t ret = -1;
+    int offset;
+
+    readstr(pname, propname, sizeof(propname));
+    if (vallen == sizeof(uint32_t)) {
+        uint32_t val32 = ldl_be_phys(first_cpu->as, valaddr);
+
+        if ((strcmp(propname, "linux,rtas-base") == 0) ||
+            (strcmp(propname, "linux,rtas-entry") == 0)) {
+            spapr->rtas_base = val32;
+        } else if (strcmp(propname, "linux,initrd-start") == 0) {
+            spapr->initrd_base = val32;
+        } else if (strcmp(propname, "linux,initrd-end") == 0) {
+            spapr->initrd_size = val32 - spapr->initrd_base;
+        } else {
+            goto trace_exit;
+        }
+    } else if (vallen == sizeof(uint64_t)) {
+        uint64_t val64 = ldq_be_phys(first_cpu->as, valaddr);
+
+        if (strcmp(propname, "linux,initrd-start") == 0) {
+            spapr->initrd_base = val64;
+        } else if (strcmp(propname, "linux,initrd-end") == 0) {
+            spapr->initrd_size = val64 - spapr->initrd_base;
+        } else {
+            goto trace_exit;
+        }
+    } else {
+        goto trace_exit;
+    }
+
+    offset = fdt_node_offset_by_phandle(spapr->fdt_blob, nodeph);
+    if (offset >= 0) {
+        uint8_t data[vallen];
+
+        cpu_physical_memory_read(valaddr, data, vallen);
+        if (!fdt_setprop(spapr->fdt_blob, offset, propname, data, vallen)) {
+            ret = vallen;
+        }
+    }
+
+trace_exit:
+    trace_spapr_of_client_setprop(nodeph, propname, ret);
+
+    return ret;
+}
+
+static uint32_t of_client_nextprop(const void *fdt, uint32_t phandle,
+                                   uint32_t prevaddr, uint32_t nameaddr)
+{
+    int offset = fdt_node_offset_by_phandle(fdt, phandle);
+    char prev[OF_PROPNAME_LEN_MAX + 1];
+    const char *tmp;
+
+    readstr(prevaddr, prev, sizeof(prev));
+    for (offset = fdt_first_property_offset(fdt, offset);
+         offset >= 0;
+         offset = fdt_next_property_offset(fdt, offset)) {
+
+        if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
+            return 0;
+        }
+        if (prev[0] == '\0' || strcmp(prev, tmp) == 0) {
+            if (prev[0] != '\0') {
+                offset = fdt_next_property_offset(fdt, offset);
+                if (offset < 0) {
+                    return 0;
+                }
+            }
+            if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
+                return 0;
+            }
+            cpu_physical_memory_write(nameaddr, tmp, strlen(tmp) + 1);
+            return 1;
+        }
+    }
+
+    return 0;
+}
+
+static uint32_t of_client_peer(const void *fdt, uint32_t phandle)
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
+static uint32_t of_client_child(const void *fdt, uint32_t phandle)
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
+static uint32_t of_client_parent(const void *fdt, uint32_t phandle)
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
+static DeviceState *of_client_find_qom_dev(BusState *bus, const char *path)
+{
+    BusChild *kid;
+
+    QTAILQ_FOREACH(kid, &bus->children, sibling) {
+        const char *p = qdev_get_fw_dev_path(kid->child);
+        BusState *child;
+
+        if (p && strcmp(path, p) == 0) {
+            return kid->child;
+        }
+        QLIST_FOREACH(child, &kid->child->child_bus, sibling) {
+            DeviceState *d = of_client_find_qom_dev(child, path);
+
+            if (d) {
+                return d;
+            }
+        }
+    }
+    return NULL;
+}
+
+uint32_t spapr_of_client_open(SpaprMachineState *spapr, const char *path)
+{
+    int offset;
+    uint32_t ret = 0;
+    SpaprOfInstance *inst;
+
+    if (spapr->of_instance_last == 0xFFFFFFFF) {
+        /* We do not recycle ihandles yet */
+        goto trace_exit;
+    }
+    offset = fdt_path_offset(spapr->fdt_blob, path);
+    if (offset < 0) {
+        trace_spapr_of_client_error_unknown_path(path);
+        goto trace_exit;
+    }
+
+    inst = g_new(SpaprOfInstance, 1);
+    inst->phandle = fdt_get_phandle(spapr->fdt_blob, offset);
+    g_assert(inst->phandle);
+    ++spapr->of_instance_last;
+    inst->dev = of_client_find_qom_dev(sysbus_get_default(), path);
+    g_hash_table_insert(spapr->of_instances,
+                        GINT_TO_POINTER(spapr->of_instance_last),
+                        inst);
+    ret = spapr->of_instance_last;
+
+    if (inst->dev) {
+        const char *cdevstr = object_property_get_str(OBJECT(inst->dev),
+                                                      "chardev", NULL);
+
+        if (cdevstr) {
+            inst->cdev = qemu_chr_find(cdevstr);
+        }
+    }
+
+trace_exit:
+    trace_spapr_of_client_open(path, inst ? inst->phandle : 0, ret);
+
+    return ret;
+}
+
+static uint32_t of_client_open(SpaprMachineState *spapr, uint32_t pathaddr)
+{
+    char path[256];
+
+    readstr(pathaddr, path, sizeof(path));
+
+    return spapr_of_client_open(spapr, path);
+}
+
+static void of_client_close(SpaprMachineState *spapr, uint32_t ihandle)
+{
+    if (!g_hash_table_remove(spapr->of_instances, GINT_TO_POINTER(ihandle))) {
+        trace_spapr_of_client_error_unknown_ihandle_close(ihandle);
+    }
+}
+
+static uint32_t of_client_instance_to_package(SpaprMachineState *spapr,
+                                              uint32_t ihandle)
+{
+    gpointer instp = g_hash_table_lookup(spapr->of_instances,
+                                        GINT_TO_POINTER(ihandle));
+
+    if (!instp) {
+        return -1;
+    }
+
+    return ((SpaprOfInstance *)instp)->phandle;
+}
+
+static uint32_t of_client_package_to_path(const void *fdt, uint32_t phandle,
+                                          uint32_t buf, uint32_t len)
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
+static uint32_t of_client_instance_to_path(SpaprMachineState *spapr,
+                                           uint32_t ihandle, uint32_t buf,
+                                           uint32_t len)
+{
+    uint32_t phandle = of_client_instance_to_package(spapr, ihandle);
+
+    if (phandle != -1) {
+        return of_client_package_to_path(spapr->fdt_blob, phandle, buf, len);
+    }
+
+    return 0;
+}
+
+static uint32_t of_client_write(SpaprMachineState *spapr, uint32_t ihandle,
+                                uint32_t buf, uint32_t len)
+{
+    char tmp[256];
+    int toread, toprint, cb = MIN(len, 1024);
+    SpaprOfInstance *inst = (SpaprOfInstance *)
+        g_hash_table_lookup(spapr->of_instances, GINT_TO_POINTER(ihandle));
+
+    while (cb > 0) {
+        toread = MIN(cb + 1, sizeof(tmp));
+        readstr(buf, tmp, toread);
+        toprint = strlen(tmp);
+        if (inst && inst->cdev) {
+            toprint = qemu_chr_write(inst->cdev, (uint8_t *) tmp, toprint,
+                                     true);
+        } else {
+            /* We normally open stdout so this is fallback */
+            printf("DBG[%d]%s", ihandle, tmp);
+        }
+        buf += toprint;
+        cb -= toprint;
+    }
+
+    return len;
+}
+
+static bool of_client_claim_avail(GArray *claimed, uint64_t virt, uint64_t size)
+{
+    int i;
+    SpaprOfClaimed *c;
+
+    for (i = 0; i < claimed->len; ++i) {
+        c = &g_array_index(claimed, SpaprOfClaimed, i);
+        if ((c->start <= virt && virt < c->start + c->size) ||
+            (virt <= c->start && c->start < virt + size)) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+static void of_client_claim_add(GArray *claimed, uint64_t virt, uint64_t size)
+{
+    SpaprOfClaimed newclaim;
+
+    newclaim.start = virt;
+    newclaim.size = size;
+    g_array_append_val(claimed, newclaim);
+}
+
+/*
+ * "claim" claims memory at @virt if @align==0; otherwise it allocates
+ * memory at the requested alignment.
+ */
+uint64_t spapr_do_of_client_claim(SpaprMachineState *spapr, uint64_t virt,
+                                  uint64_t size, uint64_t align)
+{
+    uint32_t ret;
+
+    if (align == 0) {
+        if (!of_client_claim_avail(spapr->claimed, virt, size)) {
+            return -1;
+        }
+        ret = virt;
+    } else {
+        align = pow2ceil(align);
+        spapr->claimed_base = (spapr->claimed_base + align - 1) & ~(align - 1);
+        while (1) {
+            if (spapr->claimed_base >= spapr->rma_size) {
+                perror("Out of memory");
+                return -1;
+            }
+            if (of_client_claim_avail(spapr->claimed, spapr->claimed_base,
+                                      size)) {
+                break;
+            }
+            spapr->claimed_base += size;
+        }
+        ret = spapr->claimed_base;
+    }
+
+    spapr->claimed_base = MAX(spapr->claimed_base, ret + size);
+    of_client_claim_add(spapr->claimed, virt, size);
+    trace_spapr_of_client_claim(virt, size, align, ret);
+
+    return ret;
+}
+
+static uint32_t of_client_claim(SpaprMachineState *spapr, uint32_t virt,
+                                uint32_t size, uint32_t align)
+{
+    if (align) {
+        return -1;
+    }
+    if (!of_client_claim_avail(spapr->claimed, virt, size)) {
+        return -1;
+    }
+
+    spapr->claimed_base = MAX(spapr->claimed_base, virt + size);
+    of_client_claim_add(spapr->claimed, virt, size);
+    trace_spapr_of_client_claim(virt, size, align, virt);
+
+    return virt;
+}
+
+static uint32_t of_client_call_method(SpaprMachineState *spapr,
+                                      uint32_t methodaddr, uint32_t ihandle,
+                                      uint32_t param, uint32_t *ret2)
+{
+    uint32_t ret = -1;
+    char path[256] = "", method[256] = "";
+    uint32_t phandle = of_client_instance_to_package(spapr, ihandle);
+    int offset;
+
+    if (!ihandle) {
+        goto trace_exit;
+    }
+
+    readstr(methodaddr, method, sizeof(method));
+    phandle = of_client_instance_to_package(spapr, ihandle);
+    if (!phandle) {
+        goto trace_exit;
+    }
+
+    offset = fdt_node_offset_by_phandle(spapr->fdt_blob, phandle);
+    if (offset < 0) {
+        goto trace_exit;
+    }
+
+    if (fdt_get_path(spapr->fdt_blob, offset, path, sizeof(path))) {
+        goto trace_exit;
+    }
+
+    if (strcmp(path, "/") == 0) {
+        if (strcmp(method, "ibm,client-architecture-support") == 0) {
+
+#define FDT_MAX_SIZE            0x100000
+            ret = do_client_architecture_support(POWERPC_CPU(first_cpu), spapr,
+                                                 param, FDT_MAX_SIZE);
+            *ret2 = 0;
+        }
+    } else if (strcmp(path, "/rtas") == 0) {
+        if (strcmp(method, "instantiate-rtas") == 0) {
+            spapr_instantiate_rtas(spapr, param);
+            ret = 0;
+            *ret2 = param; /* rtasbase */
+        }
+    } else {
+        trace_spapr_of_client_error_unknown_method(method);
+    }
+
+trace_exit:
+    trace_spapr_of_client_method(ihandle, method, param, phandle, path, ret);
+
+    return ret;
+}
+
+static void of_client_quiesce(SpaprMachineState *spapr)
+{
+    int rc = fdt_pack(spapr->fdt_blob);
+    /* Should only fail if we've built a corrupted tree */
+    assert(rc == 0);
+
+    spapr->fdt_size = fdt_totalsize(spapr->fdt_blob);
+    spapr->fdt_initial_size = spapr->fdt_size;
+}
+
+int spapr_h_client(SpaprMachineState *spapr, target_ulong of_client_args)
+{
+    struct prom_args args = { 0 };
+    char service[64];
+    unsigned nargs, nret;
+    int i, servicelen;
+
+    cpu_physical_memory_read(of_client_args, &args, sizeof(args));
+    nargs = be32_to_cpu(args.nargs);
+    nret = be32_to_cpu(args.nret);
+    readstr(be32_to_cpu(args.service), service, sizeof(service));
+    servicelen = strlen(service);
+
+#define cmpservice(s, a, r) \
+    _cmpservice(service, servicelen, nargs, nret, (s), sizeof(s), (a), (r))
+
+    if (cmpservice("finddevice", 1, 1)) {
+        args.args[nargs] = of_client_finddevice(spapr->fdt_blob,
+                                                be32_to_cpu(args.args[0]));
+    } else if (cmpservice("getprop", 4, 1)) {
+        args.args[nargs] = of_client_getprop(spapr->fdt_blob,
+                                             be32_to_cpu(args.args[0]),
+                                             be32_to_cpu(args.args[1]),
+                                             be32_to_cpu(args.args[2]),
+                                             be32_to_cpu(args.args[3]));
+    } else if (cmpservice("getproplen", 2, 1)) {
+        args.args[nargs] = of_client_getproplen(spapr->fdt_blob,
+                                                be32_to_cpu(args.args[0]),
+                                                be32_to_cpu(args.args[1]));
+    } else if (cmpservice("setprop", 4, 1)) {
+        args.args[nargs] = of_client_setprop(spapr,
+                                             be32_to_cpu(args.args[0]),
+                                             be32_to_cpu(args.args[1]),
+                                             be32_to_cpu(args.args[2]),
+                                             be32_to_cpu(args.args[3]));
+    } else if (cmpservice("nextprop", 3, 1)) {
+        args.args[nargs] = of_client_nextprop(spapr->fdt_blob,
+                                              be32_to_cpu(args.args[0]),
+                                              be32_to_cpu(args.args[1]),
+                                              be32_to_cpu(args.args[2]));
+    } else if (cmpservice("peer", 1, 1)) {
+        args.args[nargs] = of_client_peer(spapr->fdt_blob,
+                                          be32_to_cpu(args.args[0]));
+    } else if (cmpservice("child", 1, 1)) {
+        args.args[nargs] = of_client_child(spapr->fdt_blob,
+                                           be32_to_cpu(args.args[0]));
+    } else if (cmpservice("parent", 1, 1)) {
+        args.args[nargs] = of_client_parent(spapr->fdt_blob,
+                                            be32_to_cpu(args.args[0]));
+    } else if (cmpservice("open", 1, 1)) {
+        args.args[nargs] = of_client_open(spapr, be32_to_cpu(args.args[0]));
+    } else if (cmpservice("close", 1, 0)) {
+        of_client_close(spapr, be32_to_cpu(args.args[0]));
+    } else if (cmpservice("instance-to-package", 1, 1)) {
+        args.args[nargs] =
+            of_client_instance_to_package(spapr,
+                                          be32_to_cpu(args.args[0]));
+    } else if (cmpservice("package-to-path", 3, 1)) {
+        args.args[nargs] = of_client_package_to_path(spapr->fdt_blob,
+                                                     be32_to_cpu(args.args[0]),
+                                                     be32_to_cpu(args.args[1]),
+                                                     be32_to_cpu(args.args[2]));
+    } else if (cmpservice("instance-to-path", 3, 1)) {
+        args.args[nargs] =
+            of_client_instance_to_path(spapr,
+                                       be32_to_cpu(args.args[0]),
+                                       be32_to_cpu(args.args[1]),
+                                       be32_to_cpu(args.args[2]));
+    } else if (cmpservice("write", 3, 1)) {
+        args.args[nargs] = of_client_write(spapr,
+                                           be32_to_cpu(args.args[0]),
+                                           be32_to_cpu(args.args[1]),
+                                           be32_to_cpu(args.args[2]));
+    } else if (cmpservice("claim", 3, 1)) {
+        args.args[nargs] = of_client_claim(spapr,
+                                           be32_to_cpu(args.args[0]),
+                                           be32_to_cpu(args.args[1]),
+                                           be32_to_cpu(args.args[2]));
+    } else if (cmpservice("call-method", 3, 2)) {
+        args.args[nargs] = of_client_call_method(spapr,
+                                                 be32_to_cpu(args.args[0]),
+                                                 be32_to_cpu(args.args[1]),
+                                                 be32_to_cpu(args.args[2]),
+                                                 &args.args[nargs + 1]);
+    } else if (cmpservice("quiesce", 0, 0)) {
+        of_client_quiesce(spapr);
+    } else if (cmpservice("exit", 0, 0)) {
+        error_report("Stopped as the VM requested \"exit\"");
+        vm_stop(RUN_STATE_PAUSED);
+    } else {
+        trace_spapr_of_client_error_unknown_service(service, nargs, nret);
+        args.args[nargs] = -1;
+    }
+
+    for (i = 0; i < nret; ++i) {
+        args.args[nargs + i] = be32_to_cpu(args.args[nargs + i]);
+    }
+    cpu_physical_memory_write(of_client_args, &args, sizeof(args));
+
+    return H_SUCCESS;
+}
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 9ea620f23c85..e2d1e58d07c3 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -21,6 +21,18 @@ spapr_update_dt(unsigned cb) "New blob %u bytes"
 spapr_update_dt_failed_size(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
 spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
 
+# spapr_client.c
+spapr_of_client_error_param(const char *method, int nargscheck, int nretcheck, int nargs, int nret) "%s takes/returns %d/%d, not %d/%d"
+spapr_of_client_error_unknown_service(const char *service, int nargs, int nret) "%s args=%d rets=%d"
+spapr_of_client_error_unknown_method(const char *method) "%s"
+spapr_of_client_error_unknown_ihandle_close(uint32_t ihandle) "0x%x"
+spapr_of_client_error_unknown_path(const char *path) "%s"
+spapr_of_client_claim(uint32_t virt, uint32_t size, uint32_t align, uint32_t ret) "virt=0x%x size=0x%x align=0x%x => 0x%x"
+spapr_of_client_method(uint32_t ihandle, const char *method, uint32_t param, uint32_t phandle, const char *path, uint32_t ret) "0x%x \"%s\" param=0x%x ph=0x%x \"%s\" => 0x%x"
+spapr_of_client_getprop(uint32_t ph, const char *prop, uint32_t ret) "phandle=0x%x \"%s\" => 0x%x"
+spapr_of_client_setprop(uint32_t ph, const char *prop, uint32_t ret) "phandle=0x%x \"%s\" => 0x%x"
+spapr_of_client_open(const char *path, uint32_t phandle, uint32_t ihandle) "%s 0x%x => 0x%x"
+
 # spapr_hcall_tpm.c
 spapr_h_tpm_comm(const char *device_path, uint64_t operation) "tpm_device_path=%s operation=0x%"PRIu64
 spapr_tpm_execute(uint64_t data_in, uint64_t data_in_sz, uint64_t data_out, uint64_t data_out_sz) "data_in=0x%"PRIx64", data_in_sz=%"PRIu64", data_out=0x%"PRIx64", data_out_sz=%"PRIu64
-- 
2.17.1


