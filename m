Received: from eggs.gnu.org ([2001:4830:134:3::10]:60041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ep114-0001AI-Di
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 19:16:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ep109-0005xD-Lo
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 19:15:10 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ep109-0005v5-5H
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 19:14:13 -0500
Received: by mail-pf0-x244.google.com with SMTP id 68so2782252pfx.3
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 16:14:13 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Fri, 23 Feb 2018 13:11:57 +1300
Message-Id: <1519344729-73482-12-git-send-email-mjc@sifive.com>
In-Reply-To: <1519344729-73482-1-git-send-email-mjc@sifive.com>
References: <1519344729-73482-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v6 11/23] Add symbol table callback function
 interface to load_elf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

The RISC-V HTIF (Host Target Interface) console device requires access
to the symbol table to locate the 'tohost' and 'fromhost' symbols.

Signed-off-by: Michael Clark <mjc@sifive.com>
---
 hw/core/loader.c     | 18 ++++++++++++++++--
 include/hw/elf_ops.h | 34 +++++++++++++++++++++-------------
 include/hw/loader.h  | 17 ++++++++++++++++-
 3 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 91669d6..80b69ea 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -450,6 +450,20 @@ int load_elf_ram(const char *filename,
                  int clear_lsb, int data_swab, AddressSpace *as,
                  bool load_rom)
 {
+    return load_elf_ram_sym(filename, translate_fn, translate_opaque,
+                            pentry, lowaddr, highaddr, big_endian,
+                            elf_machine, clear_lsb, data_swab, as,
+                            load_rom, NULL);
+}
+
+/* return < 0 if error, otherwise the number of bytes loaded in memory */
+int load_elf_ram_sym(const char *filename,
+                     uint64_t (*translate_fn)(void *, uint64_t),
+                     void *translate_opaque, uint64_t *pentry,
+                     uint64_t *lowaddr, uint64_t *highaddr, int big_endian,
+                     int elf_machine, int clear_lsb, int data_swab,
+                     AddressSpace *as, bool load_rom, symbol_fn_t sym_cb)
+{
     int fd, data_order, target_data_order, must_swab, ret = ELF_LOAD_FAILED;
     uint8_t e_ident[EI_NIDENT];
 
@@ -488,11 +502,11 @@ int load_elf_ram(const char *filename,
     if (e_ident[EI_CLASS] == ELFCLASS64) {
         ret = load_elf64(filename, fd, translate_fn, translate_opaque, must_swab,
                          pentry, lowaddr, highaddr, elf_machine, clear_lsb,
-                         data_swab, as, load_rom);
+                         data_swab, as, load_rom, sym_cb);
     } else {
         ret = load_elf32(filename, fd, translate_fn, translate_opaque, must_swab,
                          pentry, lowaddr, highaddr, elf_machine, clear_lsb,
-                         data_swab, as, load_rom);
+                         data_swab, as, load_rom, sym_cb);
     }
 
  fail:
diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index d192e7e..b6e19e3 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -105,7 +105,7 @@ static int glue(symcmp, SZ)(const void *s0, const void *s1)
 }
 
 static int glue(load_symbols, SZ)(struct elfhdr *ehdr, int fd, int must_swab,
-                                  int clear_lsb)
+                                  int clear_lsb, symbol_fn_t sym_cb)
 {
     struct elf_shdr *symtab, *strtab, *shdr_table = NULL;
     struct elf_sym *syms = NULL;
@@ -133,10 +133,26 @@ static int glue(load_symbols, SZ)(struct elfhdr *ehdr, int fd, int must_swab,
 
     nsyms = symtab->sh_size / sizeof(struct elf_sym);
 
+    /* String table */
+    if (symtab->sh_link >= ehdr->e_shnum) {
+        goto fail;
+    }
+    strtab = &shdr_table[symtab->sh_link];
+
+    str = load_at(fd, strtab->sh_offset, strtab->sh_size);
+    if (!str) {
+        goto fail;
+    }
+
     i = 0;
     while (i < nsyms) {
-        if (must_swab)
+        if (must_swab) {
             glue(bswap_sym, SZ)(&syms[i]);
+        }
+        if (sym_cb) {
+            sym_cb(str + syms[i].st_name, syms[i].st_info,
+                   syms[i].st_value, syms[i].st_size);
+        }
         /* We are only interested in function symbols.
            Throw everything else away.  */
         if (syms[i].st_shndx == SHN_UNDEF ||
@@ -163,15 +179,6 @@ static int glue(load_symbols, SZ)(struct elfhdr *ehdr, int fd, int must_swab,
         }
     }
 
-    /* String table */
-    if (symtab->sh_link >= ehdr->e_shnum)
-        goto fail;
-    strtab = &shdr_table[symtab->sh_link];
-
-    str = load_at(fd, strtab->sh_offset, strtab->sh_size);
-    if (!str)
-        goto fail;
-
     /* Commit */
     s = g_malloc0(sizeof(*s));
     s->lookup_symbol = glue(lookup_symbol, SZ);
@@ -264,7 +271,8 @@ static int glue(load_elf, SZ)(const char *name, int fd,
                               int must_swab, uint64_t *pentry,
                               uint64_t *lowaddr, uint64_t *highaddr,
                               int elf_machine, int clear_lsb, int data_swab,
-                              AddressSpace *as, bool load_rom)
+                              AddressSpace *as, bool load_rom,
+                              symbol_fn_t sym_cb)
 {
     struct elfhdr ehdr;
     struct elf_phdr *phdr = NULL, *ph;
@@ -329,7 +337,7 @@ static int glue(load_elf, SZ)(const char *name, int fd,
     if (pentry)
    	*pentry = (uint64_t)(elf_sword)ehdr.e_entry;
 
-    glue(load_symbols, SZ)(&ehdr, fd, must_swab, clear_lsb);
+    glue(load_symbols, SZ)(&ehdr, fd, must_swab, clear_lsb, sym_cb);
 
     size = ehdr.e_phnum * sizeof(phdr[0]);
     if (lseek(fd, ehdr.e_phoff, SEEK_SET) != ehdr.e_phoff) {
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 5edbe02..7b05e8b 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -64,7 +64,7 @@ int load_image_gzipped(const char *filename, hwaddr addr, uint64_t max_sz);
 #define ELF_LOAD_WRONG_ENDIAN -4
 const char *load_elf_strerror(int error);
 
-/** load_elf_ram:
+/** load_elf_ram_sym:
  * @filename: Path of ELF file
  * @translate_fn: optional function to translate load addresses
  * @translate_opaque: opaque data passed to @translate_fn
@@ -81,6 +81,7 @@ const char *load_elf_strerror(int error);
  * @as: The AddressSpace to load the ELF to. The value of address_space_memory
  *      is used if nothing is supplied here.
  * @load_rom : Load ELF binary as ROM
+ * @sym_cb: Callback function for symbol table entries
  *
  * Load an ELF file's contents to the emulated system's address space.
  * Clients may optionally specify a callback to perform address
@@ -93,6 +94,20 @@ const char *load_elf_strerror(int error);
  * If @elf_machine is EM_NONE then the machine type will be read from the
  * ELF header and no checks will be carried out against the machine type.
  */
+typedef void (*symbol_fn_t)(const char *st_name, int st_info,
+                            uint64_t st_value, uint64_t st_size);
+
+int load_elf_ram_sym(const char *filename,
+                     uint64_t (*translate_fn)(void *, uint64_t),
+                     void *translate_opaque, uint64_t *pentry,
+                     uint64_t *lowaddr, uint64_t *highaddr, int big_endian,
+                     int elf_machine, int clear_lsb, int data_swab,
+                     AddressSpace *as, bool load_rom, symbol_fn_t sym_cb);
+
+/** load_elf_ram:
+ * Same as load_elf_ram_sym(), but doesn't allow the caller to specify a
+ * symbol callback function
+ */
 int load_elf_ram(const char *filename,
                  uint64_t (*translate_fn)(void *, uint64_t),
                  void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr,
-- 
2.7.0
