Received: from eggs.gnu.org ([2001:4830:134:3::10]:44577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gaRXb-0007gO-7c
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 15:37:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gaRXV-0006sj-GU
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 15:37:03 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gaR4I-00058Y-Hl
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 15:06:47 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Fri, 21 Dec 2018 20:03:52 +0000
Message-Id: <1545422632-24444-5-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1545422632-24444-1-git-send-email-liam.merwick@oracle.com>
References: <1545422632-24444-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [RFC v2 4/4] pvh: Boot uncompressed kernel using
 direct boot ABI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net, xen-devel@lists.xenproject.org, sgarzare@redhat.com, mst@redhat.com, stefanha@redhat.com, maran.wilson@oracle.com, george.kennedy@oracle.com, boris.ostrovsky@oracle.com, liam.merwick@oracle.com

These changes (along with corresponding Linux kernel and qboot changes)
enable a guest to be booted using the x86/HVM direct boot ABI.

This commit adds a load_elfboot() routine to pass the size and
location of the kernel entry point to qboot (which will fill in
the start_info struct information needed to to boot the guest).
Having loaded the ELF binary, load_linux() will run qboot
which continues the boot.

The address for the kernel entry point is read from an ELF Note
in the uncompressed kernel binary by a helper routine passed
to load_elf().

Co-developed-by: George Kennedy <George.Kennedy@oracle.com>
Signed-off-by: George Kennedy <George.Kennedy@oracle.com>
Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---
 hw/i386/pc.c  | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/elf.h |  10 +++++
 2 files changed, 145 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 115bc2825ce4..6d44a14da44d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -54,6 +54,7 @@
 #include "sysemu/qtest.h"
 #include "kvm_i386.h"
 #include "hw/xen/xen.h"
+#include "hw/xen/start_info.h"
 #include "ui/qemu-spice.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
@@ -109,6 +110,9 @@ static struct e820_entry *e820_table;
 static unsigned e820_entries;
 struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
 
+/* Physical Address of PVH entry point read from kernel ELF NOTE */
+static size_t pvh_start_addr;
+
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s = opaque;
@@ -834,6 +838,109 @@ struct setup_data {
     uint8_t data[0];
 } __attribute__((packed));
 
+
+/*
+ * The entry point into the kernel for PVH boot is different from
+ * the native entry point.  The PVH entry is defined by the x86/HVM
+ * direct boot ABI and is available in an ELFNOTE in the kernel binary.
+ *
+ * This function is passed to load_elf() when it is called from
+ * load_elfboot() which then additionally checks for an ELF Note of
+ * type XEN_ELFNOTE_PHYS32_ENTRY and passes it to this function to
+ * parse the PVH entry address from the ELF Note.
+ *
+ * Due to trickery in elf_opts.h, load_elf() is actually available as
+ * load_elf32() or load_elf64() and this routine needs to be able
+ * to deal with being called as 32 or 64 bit.
+ *
+ * The address of the PVH entry point is saved to the 'pvh_start_addr'
+ * global variable.  (although the entry point is 32-bit, the kernel
+ * binary can be either 32-bit or 64-bit).
+ */
+static uint64_t read_pvh_start_addr(void *arg1, void *arg2, bool is64)
+{
+    size_t *elf_note_data_addr;
+
+    /* Check if ELF Note header passed in is valid */
+    if (arg1 == NULL) {
+        return 0;
+    }
+
+    if (is64) {
+        struct elf64_note *nhdr64 = (struct elf64_note *)arg1;
+        uint64_t nhdr_size64 = sizeof(struct elf64_note);
+        uint64_t phdr_align = *(uint64_t *)arg2;
+        uint64_t nhdr_namesz = nhdr64->n_namesz;
+
+        elf_note_data_addr =
+            ((void *)nhdr64) + nhdr_size64 +
+            QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
+    } else {
+        struct elf32_note *nhdr32 = (struct elf32_note *)arg1;
+        uint32_t nhdr_size32 = sizeof(struct elf32_note);
+        uint32_t phdr_align = *(uint32_t *)arg2;
+        uint32_t nhdr_namesz = nhdr32->n_namesz;
+
+        elf_note_data_addr =
+            ((void *)nhdr32) + nhdr_size32 +
+            QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
+    }
+
+    pvh_start_addr = *elf_note_data_addr;
+
+    return pvh_start_addr;
+}
+
+static bool load_elfboot(const char *kernel_filename,
+                   int kernel_file_size,
+                   uint8_t *header,
+                   size_t pvh_xen_start_addr,
+                   FWCfgState *fw_cfg)
+{
+    uint32_t flags = 0;
+    uint32_t mh_load_addr = 0;
+    uint32_t elf_kernel_size = 0;
+    uint64_t elf_entry;
+    uint64_t elf_low, elf_high;
+    int kernel_size;
+
+    if (ldl_p(header) != 0x464c457f) {
+        return false; /* no elfboot */
+    }
+
+    bool elf_is64 = header[EI_CLASS] == ELFCLASS64;
+    flags = elf_is64 ?
+        ((Elf64_Ehdr *)header)->e_flags : ((Elf32_Ehdr *)header)->e_flags;
+
+    if (flags & 0x00010004) { /* LOAD_ELF_HEADER_HAS_ADDR */
+        error_report("elfboot unsupported flags = %x", flags);
+        exit(1);
+    }
+
+    uint64_t elf_note_type = XEN_ELFNOTE_PHYS32_ENTRY;
+    kernel_size = load_elf(kernel_filename, read_pvh_start_addr,
+                           NULL, &elf_note_type, &elf_entry,
+                           &elf_low, &elf_high, 0, I386_ELF_MACHINE,
+                           0, 0);
+
+    if (kernel_size < 0) {
+        error_report("Error while loading elf kernel");
+        exit(1);
+    }
+    mh_load_addr = elf_low;
+    elf_kernel_size = elf_high - elf_low;
+
+    if (pvh_start_addr == 0) {
+        error_report("Error loading uncompressed kernel without PVH ELF Note");
+        exit(1);
+    }
+    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, pvh_start_addr);
+    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, mh_load_addr);
+    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, elf_kernel_size);
+
+    return true;
+}
+
 static void load_linux(PCMachineState *pcms,
                        FWCfgState *fw_cfg)
 {
@@ -873,6 +980,33 @@ static void load_linux(PCMachineState *pcms,
     if (ldl_p(header+0x202) == 0x53726448) {
         protocol = lduw_p(header+0x206);
     } else {
+        /*
+         * If the kernel address for using the x86/HVM direct boot ABI has
+         * been saved then proceed with booting the uncompressed kernel
+         */
+        if (load_elfboot(kernel_filename, kernel_size,
+                         header, pvh_start_addr, fw_cfg)) {
+            struct hvm_modlist_entry ramdisk_mod = { 0 };
+
+            fclose(f);
+
+            fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
+                strlen(kernel_cmdline) + 1);
+            fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
+
+            assert(machine->device_memory != NULL);
+            ramdisk_mod.paddr = machine->device_memory->base;
+            ramdisk_mod.size =
+                memory_region_size(&machine->device_memory->mr);
+
+            fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, &ramdisk_mod,
+                             sizeof(ramdisk_mod));
+            fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, sizeof(header));
+            fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA,
+                             header, sizeof(header));
+
+            return;
+        }
         /* This looks like a multiboot kernel. If it is, let's stop
            treating it like a Linux kernel. */
         if (load_multiboot(fw_cfg, f, kernel_filename, initrd_filename,
@@ -1336,7 +1470,7 @@ void pc_memory_init(PCMachineState *pcms,
     int linux_boot, i;
     MemoryRegion *ram, *option_rom_mr;
     MemoryRegion *ram_below_4g, *ram_above_4g;
-    FWCfgState *fw_cfg;
+    FWCfgState *fw_cfg = NULL;
     MachineState *machine = MACHINE(pcms);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
 
diff --git a/include/elf.h b/include/elf.h
index c151164b63da..1f82c7a7124b 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -1585,6 +1585,16 @@ typedef struct elf64_shdr {
 #define NT_ARM_HW_WATCH 0x403           /* ARM hardware watchpoint registers */
 #define NT_ARM_SYSTEM_CALL      0x404   /* ARM system call number */
 
+/*
+ * Physical entry point into the kernel.
+ *
+ * 32bit entry point into the kernel. When requested to launch the
+ * guest kernel, use this entry point to launch the guest in 32-bit
+ * protected mode with paging disabled.
+ *
+ * [ Corresponding definition in Linux kernel: include/xen/interface/elfnote.h ]
+ */
+#define XEN_ELFNOTE_PHYS32_ENTRY    18  /* 0x12 */
 
 /* Note header in a PT_NOTE section */
 typedef struct elf32_note {
-- 
1.8.3.1
