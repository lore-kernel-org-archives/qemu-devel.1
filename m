Received: from eggs.gnu.org ([2001:4830:134:3::10]:42770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1diTco-00082v-NE
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 18:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1diTcm-0002iw-Oj
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 18:50:50 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1diTcm-0002in-Fk
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 18:50:48 -0400
Received: by mail-pg0-x244.google.com with SMTP id t80so5810288pgb.2
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 15:50:48 -0700 (PDT)
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Thu, 17 Aug 2017 15:50:37 -0700
Message-Id: <20170817225039.28269-1-anatol.pomozov@gmail.com>
Subject: [Qemu-devel] [PATCH 1/3] multiboot: Change multiboot_info from
 array of bytes to a C struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Anatol Pomozov <anatol.pomozov@gmail.com>

Using C structs makes the code more readable and prevents type conversion
errors.

Borrow multiboot1 header from GRUB project.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 hw/i386/multiboot.c        | 124 +++++++++-------------
 hw/i386/multiboot_header.h | 254 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 304 insertions(+), 74 deletions(-)
 create mode 100644 hw/i386/multiboot_header.h

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index f13e23139b..19113c0fce 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -28,6 +28,7 @@
 #include "hw/hw.h"
 #include "hw/nvram/fw_cfg.h"
 #include "multiboot.h"
+#include "multiboot_header.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "sysemu/sysemu.h"
@@ -47,39 +48,9 @@
 #error multiboot struct needs to fit in 16 bit real mode
 #endif
 
-enum {
-    /* Multiboot info */
-    MBI_FLAGS       = 0,
-    MBI_MEM_LOWER   = 4,
-    MBI_MEM_UPPER   = 8,
-    MBI_BOOT_DEVICE = 12,
-    MBI_CMDLINE     = 16,
-    MBI_MODS_COUNT  = 20,
-    MBI_MODS_ADDR   = 24,
-    MBI_MMAP_ADDR   = 48,
-    MBI_BOOTLOADER  = 64,
-
-    MBI_SIZE        = 88,
-
-    /* Multiboot modules */
-    MB_MOD_START    = 0,
-    MB_MOD_END      = 4,
-    MB_MOD_CMDLINE  = 8,
-
-    MB_MOD_SIZE     = 16,
-
-    /* Region offsets */
-    ADDR_E820_MAP = MULTIBOOT_STRUCT_ADDR + 0,
-    ADDR_MBI      = ADDR_E820_MAP + 0x500,
-
-    /* Multiboot flags */
-    MULTIBOOT_FLAGS_MEMORY      = 1 << 0,
-    MULTIBOOT_FLAGS_BOOT_DEVICE = 1 << 1,
-    MULTIBOOT_FLAGS_CMDLINE     = 1 << 2,
-    MULTIBOOT_FLAGS_MODULES     = 1 << 3,
-    MULTIBOOT_FLAGS_MMAP        = 1 << 6,
-    MULTIBOOT_FLAGS_BOOTLOADER  = 1 << 9,
-};
+/* Region offsets */
+#define ADDR_E820_MAP MULTIBOOT_STRUCT_ADDR
+#define ADDR_MBI      (ADDR_E820_MAP + 0x500)
 
 typedef struct {
     /* buffer holding kernel, cmdlines and mb_infos */
@@ -128,14 +99,15 @@ static void mb_add_mod(MultibootState *s,
                        hwaddr start, hwaddr end,
                        hwaddr cmdline_phys)
 {
-    char *p;
+    multiboot_module_t *mod;
     assert(s->mb_mods_count < s->mb_mods_avail);
 
-    p = (char *)s->mb_buf + s->offset_mbinfo + MB_MOD_SIZE * s->mb_mods_count;
+    mod = s->mb_buf + s->offset_mbinfo +
+          sizeof(multiboot_module_t) * s->mb_mods_count;
 
-    stl_p(p + MB_MOD_START,   start);
-    stl_p(p + MB_MOD_END,     end);
-    stl_p(p + MB_MOD_CMDLINE, cmdline_phys);
+    stl_p(&mod->mod_start, start);
+    stl_p(&mod->mod_end,   end);
+    stl_p(&mod->cmdline,   cmdline_phys);
 
     mb_debug("mod%02d: "TARGET_FMT_plx" - "TARGET_FMT_plx"\n",
              s->mb_mods_count, start, end);
@@ -151,26 +123,29 @@ int load_multiboot(FWCfgState *fw_cfg,
                    int kernel_file_size,
                    uint8_t *header)
 {
-    int i, is_multiboot = 0;
+    int i;
+    bool is_multiboot = false;
     uint32_t flags = 0;
     uint32_t mh_entry_addr;
     uint32_t mh_load_addr;
     uint32_t mb_kernel_size;
     MultibootState mbs;
-    uint8_t bootinfo[MBI_SIZE];
+    multiboot_info_t bootinfo;
     uint8_t *mb_bootinfo_data;
     uint32_t cmdline_len;
+    struct multiboot_header *multiboot_header;
 
     /* Ok, let's see if it is a multiboot image.
        The header is 12x32bit long, so the latest entry may be 8192 - 48. */
     for (i = 0; i < (8192 - 48); i += 4) {
-        if (ldl_p(header+i) == 0x1BADB002) {
-            uint32_t checksum = ldl_p(header+i+8);
-            flags = ldl_p(header+i+4);
+        multiboot_header = (struct multiboot_header *)(header + i);
+        if (ldl_p(&multiboot_header->magic) == MULTIBOOT_HEADER_MAGIC) {
+            uint32_t checksum = ldl_p(&multiboot_header->checksum);
+            flags = ldl_p(&multiboot_header->flags);
             checksum += flags;
-            checksum += (uint32_t)0x1BADB002;
+            checksum += (uint32_t)MULTIBOOT_HEADER_MAGIC;
             if (!checksum) {
-                is_multiboot = 1;
+                is_multiboot = true;
                 break;
             }
         }
@@ -180,13 +155,13 @@ int load_multiboot(FWCfgState *fw_cfg,
         return 0; /* no multiboot */
 
     mb_debug("qemu: I believe we found a multiboot image!\n");
-    memset(bootinfo, 0, sizeof(bootinfo));
+    memset(&bootinfo, 0, sizeof(bootinfo));
     memset(&mbs, 0, sizeof(mbs));
 
-    if (flags & 0x00000004) { /* MULTIBOOT_HEADER_HAS_VBE */
+    if (flags & MULTIBOOT_VIDEO_MODE) {
         fprintf(stderr, "qemu: multiboot knows VBE. we don't.\n");
     }
-    if (!(flags & 0x00010000)) { /* MULTIBOOT_HEADER_HAS_ADDR */
+    if (!(flags & MULTIBOOT_AOUT_KLUDGE)) {
         uint64_t elf_entry;
         uint64_t elf_low, elf_high;
         int kernel_size;
@@ -217,14 +192,14 @@ int load_multiboot(FWCfgState *fw_cfg,
         mb_debug("qemu: loading multiboot-elf kernel (%#x bytes) with entry %#zx\n",
                   mb_kernel_size, (size_t)mh_entry_addr);
     } else {
-        /* Valid if mh_flags sets MULTIBOOT_HEADER_HAS_ADDR. */
-        uint32_t mh_header_addr = ldl_p(header+i+12);
-        uint32_t mh_load_end_addr = ldl_p(header+i+20);
-        uint32_t mh_bss_end_addr = ldl_p(header+i+24);
-        mh_load_addr = ldl_p(header+i+16);
+        /* Valid if mh_flags sets MULTIBOOT_AOUT_KLUDGE. */
+        uint32_t mh_header_addr = ldl_p(&multiboot_header->header_addr);
+        uint32_t mh_load_end_addr = ldl_p(&multiboot_header->load_end_addr);
+        uint32_t mh_bss_end_addr = ldl_p(&multiboot_header->bss_end_addr);
+        mh_load_addr = ldl_p(&multiboot_header->load_addr);
         uint32_t mb_kernel_text_offset = i - (mh_header_addr - mh_load_addr);
         uint32_t mb_load_size = 0;
-        mh_entry_addr = ldl_p(header+i+28);
+        mh_entry_addr = ldl_p(&multiboot_header->entry_addr);
 
         if (mh_load_end_addr) {
             mb_kernel_size = mh_bss_end_addr - mh_load_addr;
@@ -234,11 +209,11 @@ int load_multiboot(FWCfgState *fw_cfg,
             mb_load_size = mb_kernel_size;
         }
 
-        /* Valid if mh_flags sets MULTIBOOT_HEADER_HAS_VBE.
-        uint32_t mh_mode_type = ldl_p(header+i+32);
-        uint32_t mh_width = ldl_p(header+i+36);
-        uint32_t mh_height = ldl_p(header+i+40);
-        uint32_t mh_depth = ldl_p(header+i+44); */
+        /* Valid if mh_flags sets MULTIBOOT_VIDEO_MODE.
+        uint32_t mh_mode_type = ldl_p(&multiboot_header->mode_type);
+        uint32_t mh_width = ldl_p(&multiboot_header->width);
+        uint32_t mh_height = ldl_p(&multiboot_header->height);
+        uint32_t mh_depth = ldl_p(&multiboot_header->depth); */
 
         mb_debug("multiboot: mh_header_addr = %#x\n", mh_header_addr);
         mb_debug("multiboot: mh_load_addr = %#x\n", mh_load_addr);
@@ -276,14 +251,15 @@ int load_multiboot(FWCfgState *fw_cfg,
     }
 
     mbs.mb_buf_size += cmdline_len;
-    mbs.mb_buf_size += MB_MOD_SIZE * mbs.mb_mods_avail;
+    mbs.mb_buf_size += sizeof(multiboot_module_t) * mbs.mb_mods_avail;
     mbs.mb_buf_size += strlen(bootloader_name) + 1;
 
     mbs.mb_buf_size = TARGET_PAGE_ALIGN(mbs.mb_buf_size);
 
     /* enlarge mb_buf to hold cmdlines, bootloader, mb-info structs */
     mbs.mb_buf            = g_realloc(mbs.mb_buf, mbs.mb_buf_size);
-    mbs.offset_cmdlines   = mbs.offset_mbinfo + mbs.mb_mods_avail * MB_MOD_SIZE;
+    mbs.offset_cmdlines   = mbs.offset_mbinfo +
+        mbs.mb_mods_avail * sizeof(multiboot_module_t);
     mbs.offset_bootloader = mbs.offset_cmdlines + cmdline_len;
 
     if (initrd_filename) {
@@ -329,22 +305,22 @@ int load_multiboot(FWCfgState *fw_cfg,
     char kcmdline[strlen(kernel_filename) + strlen(kernel_cmdline) + 2];
     snprintf(kcmdline, sizeof(kcmdline), "%s %s",
              kernel_filename, kernel_cmdline);
-    stl_p(bootinfo + MBI_CMDLINE, mb_add_cmdline(&mbs, kcmdline));
+    stl_p(&bootinfo.cmdline, mb_add_cmdline(&mbs, kcmdline));
 
-    stl_p(bootinfo + MBI_BOOTLOADER, mb_add_bootloader(&mbs, bootloader_name));
+    stl_p(&bootinfo.boot_loader_name, mb_add_bootloader(&mbs, bootloader_name));
 
-    stl_p(bootinfo + MBI_MODS_ADDR,  mbs.mb_buf_phys + mbs.offset_mbinfo);
-    stl_p(bootinfo + MBI_MODS_COUNT, mbs.mb_mods_count); /* mods_count */
+    stl_p(&bootinfo.mods_addr,  mbs.mb_buf_phys + mbs.offset_mbinfo);
+    stl_p(&bootinfo.mods_count, mbs.mb_mods_count); /* mods_count */
 
     /* the kernel is where we want it to be now */
-    stl_p(bootinfo + MBI_FLAGS, MULTIBOOT_FLAGS_MEMORY
-                                | MULTIBOOT_FLAGS_BOOT_DEVICE
-                                | MULTIBOOT_FLAGS_CMDLINE
-                                | MULTIBOOT_FLAGS_MODULES
-                                | MULTIBOOT_FLAGS_MMAP
-                                | MULTIBOOT_FLAGS_BOOTLOADER);
-    stl_p(bootinfo + MBI_BOOT_DEVICE, 0x8000ffff); /* XXX: use the -boot switch? */
-    stl_p(bootinfo + MBI_MMAP_ADDR,   ADDR_E820_MAP);
+    stl_p(&bootinfo.flags, MULTIBOOT_INFO_MEMORY
+                           | MULTIBOOT_INFO_BOOTDEV
+                           | MULTIBOOT_INFO_CMDLINE
+                           | MULTIBOOT_INFO_MODS
+                           | MULTIBOOT_INFO_MEM_MAP
+                           | MULTIBOOT_INFO_BOOT_LOADER_NAME);
+    stl_p(&bootinfo.boot_device, 0x8000ffff); /* XXX: use the -boot switch? */
+    stl_p(&bootinfo.mmap_addr,   ADDR_E820_MAP);
 
     mb_debug("multiboot: mh_entry_addr = %#x\n", mh_entry_addr);
     mb_debug("           mb_buf_phys   = "TARGET_FMT_plx"\n", mbs.mb_buf_phys);
@@ -353,7 +329,7 @@ int load_multiboot(FWCfgState *fw_cfg,
 
     /* save bootinfo off the stack */
     mb_bootinfo_data = g_malloc(sizeof(bootinfo));
-    memcpy(mb_bootinfo_data, bootinfo, sizeof(bootinfo));
+    memcpy(mb_bootinfo_data, &bootinfo, sizeof(bootinfo));
 
     /* Pass variables to option rom */
     fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, mh_entry_addr);
diff --git a/hw/i386/multiboot_header.h b/hw/i386/multiboot_header.h
new file mode 100644
index 0000000000..2ed407060b
--- /dev/null
+++ b/hw/i386/multiboot_header.h
@@ -0,0 +1,254 @@
+/* multiboot.h - Multiboot header file.  */
+/* Copyright (C) 1999,2003,2007,2008,2009,2010  Free Software Foundation, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to
+ * deal in the Software without restriction, including without limitation the
+ * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
+ * sell copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL ANY
+ * DEVELOPER OR DISTRIBUTOR BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
+ * IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef MULTIBOOT_HEADER
+#define MULTIBOOT_HEADER 1
+
+/* How many bytes from the start of the file we search for the header.  */
+#define MULTIBOOT_SEARCH      8192
+#define MULTIBOOT_HEADER_ALIGN      4
+
+/* The magic field should contain this.  */
+#define MULTIBOOT_HEADER_MAGIC      0x1BADB002
+
+/* This should be in %eax.  */
+#define MULTIBOOT_BOOTLOADER_MAGIC    0x2BADB002
+
+/* Alignment of multiboot modules.  */
+#define MULTIBOOT_MOD_ALIGN      0x00001000
+
+/* Alignment of the multiboot info structure.  */
+#define MULTIBOOT_INFO_ALIGN      0x00000004
+
+/* Flags set in the 'flags' member of the multiboot header.  */
+
+/* Align all boot modules on i386 page (4KB) boundaries.  */
+#define MULTIBOOT_PAGE_ALIGN      0x00000001
+
+/* Must pass memory information to OS.  */
+#define MULTIBOOT_MEMORY_INFO      0x00000002
+
+/* Must pass video information to OS.  */
+#define MULTIBOOT_VIDEO_MODE      0x00000004
+
+/* This flag indicates the use of the address fields in the header.  */
+#define MULTIBOOT_AOUT_KLUDGE      0x00010000
+
+/* Flags to be set in the 'flags' member of the multiboot info structure.  */
+
+/* is there basic lower/upper memory information? */
+#define MULTIBOOT_INFO_MEMORY      0x00000001
+/* is there a boot device set? */
+#define MULTIBOOT_INFO_BOOTDEV      0x00000002
+/* is the command-line defined? */
+#define MULTIBOOT_INFO_CMDLINE      0x00000004
+/* are there modules to do something with? */
+#define MULTIBOOT_INFO_MODS      0x00000008
+
+/* These next two are mutually exclusive */
+
+/* is there a symbol table loaded? */
+#define MULTIBOOT_INFO_AOUT_SYMS    0x00000010
+/* is there an ELF section header table? */
+#define MULTIBOOT_INFO_ELF_SHDR      0X00000020
+
+/* is there a full memory map? */
+#define MULTIBOOT_INFO_MEM_MAP      0x00000040
+
+/* Is there drive info?  */
+#define MULTIBOOT_INFO_DRIVE_INFO    0x00000080
+
+/* Is there a config table?  */
+#define MULTIBOOT_INFO_CONFIG_TABLE    0x00000100
+
+/* Is there a boot loader name?  */
+#define MULTIBOOT_INFO_BOOT_LOADER_NAME    0x00000200
+
+/* Is there a APM table?  */
+#define MULTIBOOT_INFO_APM_TABLE    0x00000400
+
+/* Is there video information?  */
+#define MULTIBOOT_INFO_VBE_INFO            0x00000800
+#define MULTIBOOT_INFO_FRAMEBUFFER_INFO          0x00001000
+
+struct multiboot_header {
+  /* Must be MULTIBOOT_MAGIC - see above.  */
+  uint32_t magic;
+
+  /* Feature flags.  */
+  uint32_t flags;
+
+  /* The above fields plus this one must equal 0 mod 2^32. */
+  uint32_t checksum;
+
+  /* These are only valid if MULTIBOOT_AOUT_KLUDGE is set.  */
+  uint32_t header_addr;
+  uint32_t load_addr;
+  uint32_t load_end_addr;
+  uint32_t bss_end_addr;
+  uint32_t entry_addr;
+
+  /* These are only valid if MULTIBOOT_VIDEO_MODE is set.  */
+  uint32_t mode_type;
+  uint32_t width;
+  uint32_t height;
+  uint32_t depth;
+};
+
+/* The symbol table for a.out.  */
+struct multiboot_aout_symbol_table {
+  uint32_t tabsize;
+  uint32_t strsize;
+  uint32_t addr;
+  uint32_t reserved;
+};
+typedef struct multiboot_aout_symbol_table multiboot_aout_symbol_table_t;
+
+/* The section header table for ELF.  */
+struct multiboot_elf_section_header_table {
+  uint32_t num;
+  uint32_t size;
+  uint32_t addr;
+  uint32_t shndx;
+};
+typedef struct multiboot_elf_section_header_table
+   multiboot_elf_section_header_table_t;
+
+struct multiboot_info {
+  /* Multiboot info version number */
+  uint32_t flags;
+
+  /* Available memory from BIOS */
+  uint32_t mem_lower;
+  uint32_t mem_upper;
+
+  /* "root" partition */
+  uint32_t boot_device;
+
+  /* Kernel command line */
+  uint32_t cmdline;
+
+  /* Boot-Module list */
+  uint32_t mods_count;
+  uint32_t mods_addr;
+
+  union {
+    multiboot_aout_symbol_table_t aout_sym;
+    multiboot_elf_section_header_table_t elf_sec;
+  } u;
+
+  /* Memory Mapping buffer */
+  uint32_t mmap_length;
+  uint32_t mmap_addr;
+
+  /* Drive Info buffer */
+  uint32_t drives_length;
+  uint32_t drives_addr;
+
+  /* ROM configuration table */
+  uint32_t config_table;
+
+  /* Boot Loader Name */
+  uint32_t boot_loader_name;
+
+  /* APM table */
+  uint32_t apm_table;
+
+  /* Video */
+  uint32_t vbe_control_info;
+  uint32_t vbe_mode_info;
+  uint16_t vbe_mode;
+  uint16_t vbe_interface_seg;
+  uint16_t vbe_interface_off;
+  uint16_t vbe_interface_len;
+
+  uint64_t framebuffer_addr;
+  uint32_t framebuffer_pitch;
+  uint32_t framebuffer_width;
+  uint32_t framebuffer_height;
+  uint8_t framebuffer_bpp;
+#define MULTIBOOT_FRAMEBUFFER_TYPE_INDEXED   0
+#define MULTIBOOT_FRAMEBUFFER_TYPE_RGB       1
+#define MULTIBOOT_FRAMEBUFFER_TYPE_EGA_TEXT  2
+  uint8_t framebuffer_type;
+  union {
+    struct {
+      uint32_t framebuffer_palette_addr;
+      uint16_t framebuffer_palette_num_colors;
+    };
+    struct {
+      uint8_t framebuffer_red_field_position;
+      uint8_t framebuffer_red_mask_size;
+      uint8_t framebuffer_green_field_position;
+      uint8_t framebuffer_green_mask_size;
+      uint8_t framebuffer_blue_field_position;
+      uint8_t framebuffer_blue_mask_size;
+    };
+  };
+};
+typedef struct multiboot_info multiboot_info_t;
+
+struct multiboot_color {
+  uint8_t red;
+  uint8_t green;
+  uint8_t blue;
+};
+
+struct multiboot_mmap_entry {
+  uint32_t size;
+  uint64_t addr;
+  uint64_t len;
+#define MULTIBOOT_MEMORY_AVAILABLE         1
+#define MULTIBOOT_MEMORY_RESERVED          2
+#define MULTIBOOT_MEMORY_ACPI_RECLAIMABLE  3
+#define MULTIBOOT_MEMORY_NVS               4
+#define MULTIBOOT_MEMORY_BADRAM            5
+  uint32_t type;
+} QEMU_PACKED;
+typedef struct multiboot_mmap_entry multiboot_memory_map_t;
+
+struct multiboot_mod_list {
+  /* the memory used goes from bytes 'mod_start' to 'mod_end-1' inclusive */
+  uint32_t mod_start;
+  uint32_t mod_end;
+
+  /* Module command line */
+  uint32_t cmdline;
+
+  /* padding to take it to 16 bytes (must be zero) */
+  uint32_t pad;
+};
+typedef struct multiboot_mod_list multiboot_module_t;
+
+/* APM BIOS info.  */
+struct multiboot_apm_info {
+  uint16_t version;
+  uint16_t cseg;
+  uint32_t offset;
+  uint16_t cseg_16;
+  uint16_t dseg;
+  uint16_t flags;
+  uint16_t cseg_len;
+  uint16_t cseg_16_len;
+  uint16_t dseg_len;
+};
+
+#endif /* ! MULTIBOOT_HEADER */
-- 
2.14.1.480.gb18f417b89-goog
