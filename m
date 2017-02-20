Received: from eggs.gnu.org ([2001:4830:134:3::10]:48749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfoor-0006Ef-CQ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:20:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfoon-000784-9M
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:20:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cfoom-00077l-Vs
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:19:57 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEJL1r066562
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:19:55 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28pp6msjyb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:19:55 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 20 Feb 2017 14:19:52 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Mon, 20 Feb 2017 15:19:39 +0100
In-Reply-To: <20170220141943.8426-1-cornelia.huck@de.ibm.com>
References: <20170220141943.8426-1-cornelia.huck@de.ibm.com>
Message-Id: <20170220141943.8426-2-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 1/5] elf-loader: Allow late loading of elf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, Farhan Ali <alifm@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

The current QEMU ROM infrastructure rejects late loading of ROMs.
And ELFs are currently loaded as ROM, this prevents delayed loading
of ELFs. So when loading ELF, allow the user to specify if ELF should
be loaded as ROM or not.

If an ELF is not loaded as ROM, then they are not restored on a
guest reboot/reset and so its upto the user to handle the reloading.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/core/loader.c     | 17 +++++++++++++++--
 include/hw/elf_ops.h | 13 +++++++++----
 include/hw/loader.h  | 13 ++++++++++++-
 3 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index ee5abd6eb7..9d1af1f6f3 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -435,6 +435,19 @@ int load_elf_as(const char *filename,
                 uint64_t *highaddr, int big_endian, int elf_machine,
                 int clear_lsb, int data_swab, AddressSpace *as)
 {
+    return load_elf_ram(filename, translate_fn, translate_opaque,
+                        pentry, lowaddr, highaddr, big_endian, elf_machine,
+                        clear_lsb, data_swab, as, true);
+}
+
+/* return < 0 if error, otherwise the number of bytes loaded in memory */
+int load_elf_ram(const char *filename,
+                 uint64_t (*translate_fn)(void *, uint64_t),
+                 void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr,
+                 uint64_t *highaddr, int big_endian, int elf_machine,
+                 int clear_lsb, int data_swab, AddressSpace *as,
+                 bool load_rom)
+{
     int fd, data_order, target_data_order, must_swab, ret = ELF_LOAD_FAILED;
     uint8_t e_ident[EI_NIDENT];
 
@@ -473,11 +486,11 @@ int load_elf_as(const char *filename,
     if (e_ident[EI_CLASS] == ELFCLASS64) {
         ret = load_elf64(filename, fd, translate_fn, translate_opaque, must_swab,
                          pentry, lowaddr, highaddr, elf_machine, clear_lsb,
-                         data_swab, as);
+                         data_swab, as, load_rom);
     } else {
         ret = load_elf32(filename, fd, translate_fn, translate_opaque, must_swab,
                          pentry, lowaddr, highaddr, elf_machine, clear_lsb,
-                         data_swab, as);
+                         data_swab, as, load_rom);
     }
 
  fail:
diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index 25659b93be..a172a6068a 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -264,7 +264,7 @@ static int glue(load_elf, SZ)(const char *name, int fd,
                               int must_swab, uint64_t *pentry,
                               uint64_t *lowaddr, uint64_t *highaddr,
                               int elf_machine, int clear_lsb, int data_swab,
-                              AddressSpace *as)
+                              AddressSpace *as, bool load_rom)
 {
     struct elfhdr ehdr;
     struct elf_phdr *phdr = NULL, *ph;
@@ -403,10 +403,15 @@ static int glue(load_elf, SZ)(const char *name, int fd,
                 *pentry = ehdr.e_entry - ph->p_vaddr + ph->p_paddr;
             }
 
-            snprintf(label, sizeof(label), "phdr #%d: %s", i, name);
+            if (load_rom) {
+                snprintf(label, sizeof(label), "phdr #%d: %s", i, name);
 
-            /* rom_add_elf_program() seize the ownership of 'data' */
-            rom_add_elf_program(label, data, file_size, mem_size, addr, as);
+                /* rom_add_elf_program() seize the ownership of 'data' */
+                rom_add_elf_program(label, data, file_size, mem_size, addr, as);
+            } else {
+                cpu_physical_memory_write(addr, data, file_size);
+                g_free(data);
+            }
 
             total_size += mem_size;
             if (addr < low)
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 0dbd8d6bf3..3df4d73398 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -65,7 +65,7 @@ int load_image_gzipped(const char *filename, hwaddr addr, uint64_t max_sz);
 #define ELF_LOAD_WRONG_ENDIAN -4
 const char *load_elf_strerror(int error);
 
-/** load_elf_as:
+/** load_elf_ram:
  * @filename: Path of ELF file
  * @translate_fn: optional function to translate load addresses
  * @translate_opaque: opaque data passed to @translate_fn
@@ -81,6 +81,7 @@ const char *load_elf_strerror(int error);
  *             words and 3 for within doublewords.
  * @as: The AddressSpace to load the ELF to. The value of address_space_memory
  *      is used if nothing is supplied here.
+ * @load_rom : Load ELF binary as ROM
  *
  * Load an ELF file's contents to the emulated system's address space.
  * Clients may optionally specify a callback to perform address
@@ -93,6 +94,16 @@ const char *load_elf_strerror(int error);
  * If @elf_machine is EM_NONE then the machine type will be read from the
  * ELF header and no checks will be carried out against the machine type.
  */
+int load_elf_ram(const char *filename,
+                 uint64_t (*translate_fn)(void *, uint64_t),
+                 void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr,
+                 uint64_t *highaddr, int big_endian, int elf_machine,
+                 int clear_lsb, int data_swab, AddressSpace *as,
+                 bool load_rom);
+
+/** load_elf_as:
+ * Same as load_elf_ram(), but always loads the elf as ROM
+ */
 int load_elf_as(const char *filename,
                 uint64_t (*translate_fn)(void *, uint64_t),
                 void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr,
-- 
2.11.0
