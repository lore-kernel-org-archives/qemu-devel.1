Received: from eggs.gnu.org ([2001:4830:134:3::10]:42805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1diTct-00085C-RY
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 18:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1diTcs-0002nZ-4t
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 18:50:55 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1diTcr-0002nJ-SO
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 18:50:54 -0400
Received: by mail-pg0-x243.google.com with SMTP id 83so11944302pgb.4
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 15:50:53 -0700 (PDT)
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Thu, 17 Aug 2017 15:50:39 -0700
Message-Id: <20170817225039.28269-3-anatol.pomozov@gmail.com>
In-Reply-To: <20170817225039.28269-1-anatol.pomozov@gmail.com>
References: <20170817225039.28269-1-anatol.pomozov@gmail.com>
Subject: [Qemu-devel] [PATCH 3/3] multiboot: load elf sections and section
 headers
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

Multiboot may load section headers and all sections (even those that are
not part of any segment) to target memory.

Tested with an ELF application that uses data from strings table
section.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 hw/core/loader.c     |   8 ++--
 hw/i386/multiboot.c  |  83 ++++++++++++++++++++-------------------
 hw/s390x/ipl.c       |   2 +-
 include/hw/elf_ops.h | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/hw/loader.h  |  11 +++++-
 5 files changed, 164 insertions(+), 47 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index ebe574c7ea..c7e3608e7a 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -439,7 +439,7 @@ int load_elf_as(const char *filename,
 {
     return load_elf_ram(filename, translate_fn, translate_opaque,
                         pentry, lowaddr, highaddr, big_endian, elf_machine,
-                        clear_lsb, data_swab, as, true);
+                        clear_lsb, data_swab, as, true, NULL);
 }
 
 /* return < 0 if error, otherwise the number of bytes loaded in memory */
@@ -448,7 +448,7 @@ int load_elf_ram(const char *filename,
                  void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr,
                  uint64_t *highaddr, int big_endian, int elf_machine,
                  int clear_lsb, int data_swab, AddressSpace *as,
-                 bool load_rom)
+                 bool load_rom, struct sections_data *sections)
 {
     int fd, data_order, target_data_order, must_swab, ret = ELF_LOAD_FAILED;
     uint8_t e_ident[EI_NIDENT];
@@ -488,11 +488,11 @@ int load_elf_ram(const char *filename,
     if (e_ident[EI_CLASS] == ELFCLASS64) {
         ret = load_elf64(filename, fd, translate_fn, translate_opaque, must_swab,
                          pentry, lowaddr, highaddr, elf_machine, clear_lsb,
-                         data_swab, as, load_rom);
+                         data_swab, as, load_rom, sections);
     } else {
         ret = load_elf32(filename, fd, translate_fn, translate_opaque, must_swab,
                          pentry, lowaddr, highaddr, elf_machine, clear_lsb,
-                         data_swab, as, load_rom);
+                         data_swab, as, load_rom, sections);
     }
 
  fail:
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index a49217ac62..7f7630f92d 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -125,7 +125,7 @@ int load_multiboot(FWCfgState *fw_cfg,
 {
     int i;
     bool is_multiboot = false;
-    uint32_t flags = 0;
+    uint32_t flags = 0, bootinfo_flags = 0;
     uint32_t mh_entry_addr;
     uint32_t mh_load_addr;
     uint32_t mb_kernel_size;
@@ -134,6 +134,7 @@ int load_multiboot(FWCfgState *fw_cfg,
     uint8_t *mb_bootinfo_data;
     uint32_t cmdline_len;
     struct multiboot_header *multiboot_header;
+    struct sections_data sections;
 
     /* Ok, let's see if it is a multiboot image.
        The header is 12x32bit long, so the latest entry may be 8192 - 48. */
@@ -161,37 +162,8 @@ int load_multiboot(FWCfgState *fw_cfg,
     if (flags & MULTIBOOT_VIDEO_MODE) {
         fprintf(stderr, "qemu: multiboot knows VBE. we don't.\n");
     }
-    if (!(flags & MULTIBOOT_AOUT_KLUDGE)) {
-        uint64_t elf_entry;
-        uint64_t elf_low, elf_high;
-        int kernel_size;
-        fclose(f);
 
-        if (((struct elf64_hdr*)header)->e_machine == EM_X86_64) {
-            fprintf(stderr, "Cannot load x86-64 image, give a 32bit one.\n");
-            exit(1);
-        }
-
-        kernel_size = load_elf(kernel_filename, NULL, NULL, &elf_entry,
-                               &elf_low, &elf_high, 0, EM_NONE,
-                               0, 0);
-        if (kernel_size < 0) {
-            fprintf(stderr, "Error while loading elf kernel\n");
-            exit(1);
-        }
-        mh_load_addr = elf_low;
-        mb_kernel_size = elf_high - elf_low;
-        mh_entry_addr = elf_entry;
-
-        mbs.mb_buf = g_malloc(mb_kernel_size);
-        if (rom_copy(mbs.mb_buf, mh_load_addr, mb_kernel_size) != mb_kernel_size) {
-            fprintf(stderr, "Error while fetching elf kernel from rom\n");
-            exit(1);
-        }
-
-        mb_debug("qemu: loading multiboot-elf kernel (%#x bytes) with entry %#zx\n",
-                  mb_kernel_size, (size_t)mh_entry_addr);
-    } else {
+    if (flags & MULTIBOOT_AOUT_KLUDGE) {
         /* Valid if mh_flags sets MULTIBOOT_AOUT_KLUDGE. */
         uint32_t mh_header_addr = ldl_p(&multiboot_header->header_addr);
         uint32_t mh_load_end_addr = ldl_p(&multiboot_header->load_end_addr);
@@ -209,12 +181,6 @@ int load_multiboot(FWCfgState *fw_cfg,
             mb_load_size = mb_kernel_size;
         }
 
-        /* Valid if mh_flags sets MULTIBOOT_VIDEO_MODE.
-        uint32_t mh_mode_type = ldl_p(&multiboot_header->mode_type);
-        uint32_t mh_width = ldl_p(&multiboot_header->width);
-        uint32_t mh_height = ldl_p(&multiboot_header->height);
-        uint32_t mh_depth = ldl_p(&multiboot_header->depth); */
-
         mb_debug("multiboot: mh_header_addr = %#x\n", mh_header_addr);
         mb_debug("multiboot: mh_load_addr = %#x\n", mh_load_addr);
         mb_debug("multiboot: mh_load_end_addr = %#x\n", mh_load_end_addr);
@@ -229,9 +195,45 @@ int load_multiboot(FWCfgState *fw_cfg,
             exit(1);
         }
         memset(mbs.mb_buf + mb_load_size, 0, mb_kernel_size - mb_load_size);
-        fclose(f);
+    } else {
+        uint64_t elf_entry;
+        uint64_t elf_low, elf_high;
+        int kernel_size;
+
+        bootinfo_flags |= MULTIBOOT_INFO_ELF_SHDR;
+
+        kernel_size = load_elf_ram(kernel_filename, NULL, NULL, &elf_entry,
+                               &elf_low, &elf_high, 0, I386_ELF_MACHINE,
+                               0, 0, NULL, true, &sections);
+        if (kernel_size < 0) {
+            fprintf(stderr, "Error while loading elf kernel\n");
+            exit(1);
+        }
+        mh_load_addr = elf_low;
+        mb_kernel_size = elf_high - elf_low;
+        mh_entry_addr = elf_entry;
+
+        mbs.mb_buf = g_malloc(mb_kernel_size);
+        if (rom_copy(mbs.mb_buf, mh_load_addr, mb_kernel_size) != mb_kernel_size) {
+            fprintf(stderr, "Error while fetching elf kernel from rom\n");
+            exit(1);
+        }
+
+        mb_debug("qemu: loading multiboot-elf kernel (%#x bytes) with entry %#zx\n",
+                  mb_kernel_size, (size_t)mh_entry_addr);
+
+        stl_p(&bootinfo.u.elf_sec.num, sections.num);
+        stl_p(&bootinfo.u.elf_sec.size, sections.size);
+        stl_p(&bootinfo.u.elf_sec.addr, sections.addr);
+        stl_p(&bootinfo.u.elf_sec.shndx, sections.shndx);
     }
 
+    /* Valid if mh_flags sets MULTIBOOT_VIDEO_MODE.
+    uint32_t mh_mode_type = ldl_p(&multiboot_header->mode_type);
+    uint32_t mh_width = ldl_p(&multiboot_header->width);
+    uint32_t mh_height = ldl_p(&multiboot_header->height);
+    uint32_t mh_depth = ldl_p(&multiboot_header->depth); */
+
     mbs.mb_buf_phys = mh_load_addr;
 
     mbs.mb_buf_size = TARGET_PAGE_ALIGN(mb_kernel_size);
@@ -313,7 +315,8 @@ int load_multiboot(FWCfgState *fw_cfg,
     stl_p(&bootinfo.mods_count, mbs.mb_mods_count); /* mods_count */
 
     /* the kernel is where we want it to be now */
-    stl_p(&bootinfo.flags, MULTIBOOT_INFO_MEMORY
+    stl_p(&bootinfo.flags, bootinfo_flags
+                           | MULTIBOOT_INFO_MEMORY
                            | MULTIBOOT_INFO_BOOTDEV
                            | MULTIBOOT_INFO_CMDLINE
                            | MULTIBOOT_INFO_MODS
@@ -347,5 +350,7 @@ int load_multiboot(FWCfgState *fw_cfg,
     option_rom[nb_option_roms].bootindex = 0;
     nb_option_roms++;
 
+    fclose(f);
+
     return 1; /* yes, we are multiboot */
 }
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index cc360031ef..32afae9f1f 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -327,7 +327,7 @@ static int load_netboot_image(Error **errp)
     }
 
     img_size = load_elf_ram(netboot_filename, NULL, NULL, &ipl->start_addr,
-                            NULL, NULL, 1, EM_S390, 0, 0, NULL, false);
+                            NULL, NULL, 1, EM_S390, 0, 0, NULL, false, NULL);
 
     if (img_size < 0) {
         img_size = load_image_size(netboot_filename, ram_ptr, ram_size);
diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index a172a6068a..be131b1c19 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -264,12 +264,13 @@ static int glue(load_elf, SZ)(const char *name, int fd,
                               int must_swab, uint64_t *pentry,
                               uint64_t *lowaddr, uint64_t *highaddr,
                               int elf_machine, int clear_lsb, int data_swab,
-                              AddressSpace *as, bool load_rom)
+                              AddressSpace *as, bool load_rom,
+                              struct sections_data *sections)
 {
     struct elfhdr ehdr;
     struct elf_phdr *phdr = NULL, *ph;
     int size, i, total_size;
-    elf_word mem_size, file_size;
+    elf_word mem_size, file_size, sec_size;
     uint64_t addr, low = (uint64_t)-1, high = 0;
     uint8_t *data = NULL;
     char label[128];
@@ -423,6 +424,108 @@ static int glue(load_elf, SZ)(const char *name, int fd,
         }
     }
     g_free(phdr);
+
+    if (sections) {
+        struct elf_shdr *shdr = NULL, *sh;
+        int shsize;
+
+        // user requested loading all ELF sections
+        shsize = ehdr.e_shnum * sizeof(shdr[0]);
+        if (lseek(fd, ehdr.e_shoff, SEEK_SET) != ehdr.e_shoff) {
+            goto fail;
+        }
+        shdr = g_malloc0(shsize);
+        if (!shdr)
+            goto fail;
+        if (read(fd, shdr, shsize) != shsize)
+            goto fail;
+        if (must_swab) {
+            for (i = 0; i < ehdr.e_shnum; i++) {
+                sh = &shdr[i];
+                glue(bswap_shdr, SZ)(sh);
+            }
+        }
+
+        for(i = 0; i < ehdr.e_shnum; i++) {
+            sh = &shdr[i];
+            if (sh->sh_type == SHT_NULL)
+                continue;
+            // if section has address then it is loaded (XXX: is it true?), no need to load it again
+            if (sh->sh_addr)
+                continue;
+
+            // append section data at the end of the loaded segments
+            addr = ROUND_UP(high, sh->sh_addralign);
+            sh->sh_addr = addr;
+
+            sec_size = sh->sh_size; /* Size of the section data */
+            data = g_malloc0(sec_size);
+            if (sec_size > 0) {
+                if (lseek(fd, sh->sh_offset, SEEK_SET) < 0) {
+                    goto fail;
+                }
+                if (read(fd, data, sec_size) != sec_size) {
+                    goto fail;
+                }
+            }
+
+            // As these sections are not loadable no need to perform reloaction
+            // using translate_fn()
+
+            if (data_swab) {
+                int j;
+                for (j = 0; j < sec_size; j += (1 << data_swab)) {
+                    uint8_t *dp = data + j;
+                    switch (data_swab) {
+                    case (1):
+                        *(uint16_t *)dp = bswap16(*(uint16_t *)dp);
+                        break;
+                    case (2):
+                        *(uint32_t *)dp = bswap32(*(uint32_t *)dp);
+                        break;
+                    case (3):
+                        *(uint64_t *)dp = bswap64(*(uint64_t *)dp);
+                        break;
+                    default:
+                        g_assert_not_reached();
+                    }
+                }
+            }
+
+            if (load_rom) {
+                snprintf(label, sizeof(label), "shdr #%d: %s", i, name);
+
+                /* rom_add_elf_program() seize the ownership of 'data' */
+                rom_add_elf_program(label, data, sec_size, sec_size, addr, as);
+            } else {
+                cpu_physical_memory_write(addr, data, sec_size);
+                g_free(data);
+            }
+
+            total_size += sec_size;
+            high = addr + sec_size;
+
+            data = NULL;
+        }
+
+        sections->num = ehdr.e_shnum;
+        sections->size = ehdr.e_shentsize;
+        sections->addr = high; // Address where we load the sections header
+        sections->shndx = ehdr.e_shstrndx;
+
+        // Append section headers at the end of loaded segments/sections
+        if (load_rom) {
+            snprintf(label, sizeof(label), "shdrs");
+
+            /* rom_add_elf_program() seize the ownership of 'shdr' */
+            rom_add_elf_program(label, shdr, shsize, shsize, high, as);
+        } else {
+            cpu_physical_memory_write(high, shdr, shsize);
+            g_free(shdr);
+        }
+        high += shsize;
+    }
+
     if (lowaddr)
         *lowaddr = (uint64_t)(elf_sword)low;
     if (highaddr)
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 490c9ff8e6..6bd42db675 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -65,6 +65,13 @@ int load_image_gzipped(const char *filename, hwaddr addr, uint64_t max_sz);
 #define ELF_LOAD_WRONG_ENDIAN -4
 const char *load_elf_strerror(int error);
 
+struct sections_data {
+    uint32_t num; // number of loaded sections
+    uint32_t size; // size of entry in sections header list
+    uint32_t addr; // address of loaded sections header
+    uint32_t shndx; // number of section that contains string table
+};
+
 /** load_elf_ram:
  * @filename: Path of ELF file
  * @translate_fn: optional function to translate load addresses
@@ -82,6 +89,8 @@ const char *load_elf_strerror(int error);
  * @as: The AddressSpace to load the ELF to. The value of address_space_memory
  *      is used if nothing is supplied here.
  * @load_rom : Load ELF binary as ROM
+ * @sections: If parameter is non-NULL then all ELF sections loaded into memory
+ *      and this structure is populated.
  *
  * Load an ELF file's contents to the emulated system's address space.
  * Clients may optionally specify a callback to perform address
@@ -99,7 +108,7 @@ int load_elf_ram(const char *filename,
                  void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr,
                  uint64_t *highaddr, int big_endian, int elf_machine,
                  int clear_lsb, int data_swab, AddressSpace *as,
-                 bool load_rom);
+                 bool load_rom, struct sections_data *sections);
 
 /** load_elf_as:
  * Same as load_elf_ram(), but always loads the elf as ROM
-- 
2.14.1.480.gb18f417b89-goog
