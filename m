Received: from eggs.gnu.org ([2001:4830:134:3::10]:34841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1gINKU-000637-Hd
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 20:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1gINKQ-0003iA-AB
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 20:28:50 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:46867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <viktor.prutyanov@phystech.edu>)
	id 1gINKP-0003ha-V5
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 20:28:46 -0400
Received: by mail-lf1-x143.google.com with SMTP id o2-v6so160725lfl.13
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 17:28:45 -0700 (PDT)
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Date: Fri,  2 Nov 2018 03:28:17 +0300
Message-Id: <20181102002818.8568-2-viktor.prutyanov@phystech.edu>
In-Reply-To: <20181102002818.8568-1-viktor.prutyanov@phystech.edu>
References: <20181102002818.8568-1-viktor.prutyanov@phystech.edu>
Subject: [Qemu-devel] [PATCH 1/2] contrib/elf2dmp: use GLib file mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rkagan@virtuozzo.com
Cc: qemu-devel@nongnu.org, Viktor Prutyanov <viktor.prutyanov@phystech.edu>

Replace POSIX mmap with GLib g_mapped_file_new to make elf2dmp
cross-paltform. After this patch there are no direct POSIX calls.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
---
 Makefile                      |  2 +-
 contrib/elf2dmp/Makefile.objs |  2 +-
 contrib/elf2dmp/addrspace.c   |  7 ++++---
 contrib/elf2dmp/file_map.c    | 30 ++++++++++++++++++++++++++++++
 contrib/elf2dmp/file_map.h    | 21 +++++++++++++++++++++
 contrib/elf2dmp/pdb.c         | 28 +++++-----------------------
 contrib/elf2dmp/pdb.h         |  5 +++--
 contrib/elf2dmp/qemu_elf.c    | 34 ++++++++++++----------------------
 contrib/elf2dmp/qemu_elf.h    | 15 ++++++++-------
 9 files changed, 85 insertions(+), 59 deletions(-)
 create mode 100644 contrib/elf2dmp/file_map.c
 create mode 100644 contrib/elf2dmp/file_map.h

diff --git a/Makefile b/Makefile
index f2947186a4..ef53dd2a97 100644
--- a/Makefile
+++ b/Makefile
@@ -711,7 +711,7 @@ ifneq ($(EXESUF),)
 qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
 endif
 
-elf2dmp: LIBS = $(CURL_LIBS)
+elf2dmp: LIBS += $(CURL_LIBS)
 elf2dmp: $(elf2dmp-obj-y)
 	$(call LINK, $^)
 
diff --git a/contrib/elf2dmp/Makefile.objs b/contrib/elf2dmp/Makefile.objs
index e3140f58cf..04d4bbb189 100644
--- a/contrib/elf2dmp/Makefile.objs
+++ b/contrib/elf2dmp/Makefile.objs
@@ -1 +1 @@
-elf2dmp-obj-y = main.o addrspace.o download.o pdb.o qemu_elf.o
+elf2dmp-obj-y = main.o addrspace.o download.o pdb.o qemu_elf.o file_map.o
diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
index 8a76069cb5..851373b7b7 100644
--- a/contrib/elf2dmp/addrspace.c
+++ b/contrib/elf2dmp/addrspace.c
@@ -34,8 +34,9 @@ static uint8_t *pa_space_resolve(struct pa_space *ps, uint64_t pa)
 
 int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
 {
-    Elf64_Half phdr_nr = elf_getphdrnum(qemu_elf->map);
-    Elf64_Phdr *phdr = elf64_getphdr(qemu_elf->map);
+    void *map = QEMU_Elf_get_map(qemu_elf);
+    Elf64_Half phdr_nr = elf_getphdrnum(map);
+    Elf64_Phdr *phdr = elf64_getphdr(map);
     size_t block_i = 0;
     size_t i;
 
@@ -55,7 +56,7 @@ int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
     for (i = 0; i < phdr_nr; i++) {
         if (phdr[i].p_type == PT_LOAD) {
             ps->block[block_i] = (struct pa_block) {
-                .addr = (uint8_t *)qemu_elf->map + phdr[i].p_offset,
+                .addr = (uint8_t *)map + phdr[i].p_offset,
                 .paddr = phdr[i].p_paddr,
                 .size = phdr[i].p_filesz,
             };
diff --git a/contrib/elf2dmp/file_map.c b/contrib/elf2dmp/file_map.c
new file mode 100644
index 0000000000..08152044d6
--- /dev/null
+++ b/contrib/elf2dmp/file_map.c
@@ -0,0 +1,30 @@
+/*
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ *
+ */
+
+#include <stdio.h>
+#include <glib.h>
+
+#include "err.h"
+#include "file_map.h"
+
+int file_map(const char *name, mapped_file *mf)
+{
+    GError *err = NULL;
+
+    mf->gmf = g_mapped_file_new(name, TRUE, &err);
+    if (err) {
+        eprintf("Failed to map file \'%s\'\n", name);
+        return 1;
+    }
+    mf->map = g_mapped_file_get_contents(mf->gmf);
+    mf->size = g_mapped_file_get_length(mf->gmf);
+
+    return 0;
+}
+
+void file_unmap(mapped_file *mf)
+{
+    g_mapped_file_unref(mf->gmf);
+}
diff --git a/contrib/elf2dmp/file_map.h b/contrib/elf2dmp/file_map.h
new file mode 100644
index 0000000000..1a0ea120e9
--- /dev/null
+++ b/contrib/elf2dmp/file_map.h
@@ -0,0 +1,21 @@
+/*
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ *
+ */
+
+#ifndef FILE_MAP_H
+#define FILE_MAP_H
+
+#include <stdio.h>
+#include <glib.h>
+
+typedef struct mapped_file {
+    GMappedFile *gmf;
+    void *map;
+    size_t size;
+} mapped_file;
+
+int file_map(const char *name, mapped_file *mf);
+void file_unmap(mapped_file *mf);
+
+#endif /* FILE_MAP_H */
diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index bcb01b414f..8fa5d71c66 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -278,28 +278,13 @@ static void pdb_reader_exit(struct pdb_reader *r)
 int pdb_init_from_file(const char *name, struct pdb_reader *reader)
 {
     int err = 0;
-    int fd;
-    void *map;
-    struct stat st;
 
-    fd = open(name, O_RDONLY, 0);
-    if (fd == -1) {
-        eprintf("Failed to open PDB file \'%s\'\n", name);
-        return 1;
-    }
-    reader->fd = fd;
-
-    fstat(fd, &st);
-    reader->file_size = st.st_size;
-
-    map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
-    if (map == MAP_FAILED) {
+    if (file_map(name, &reader->mf)) {
         eprintf("Failed to map PDB file\n");
-        err = 1;
-        goto out_fd;
+        return 1;
     }
 
-    if (pdb_reader_init(reader, map)) {
+    if (pdb_reader_init(reader, reader->mf.map)) {
         err = 1;
         goto out_unmap;
     }
@@ -307,16 +292,13 @@ int pdb_init_from_file(const char *name, struct pdb_reader *reader)
     return 0;
 
 out_unmap:
-    munmap(map, st.st_size);
-out_fd:
-    close(fd);
+    file_unmap(&reader->mf);
 
     return err;
 }
 
 void pdb_exit(struct pdb_reader *reader)
 {
-    munmap(reader->ds.header, reader->file_size);
-    close(reader->fd);
+    file_unmap(&reader->mf);
     pdb_reader_exit(reader);
 }
diff --git a/contrib/elf2dmp/pdb.h b/contrib/elf2dmp/pdb.h
index 4351a2dd61..21c0a0e833 100644
--- a/contrib/elf2dmp/pdb.h
+++ b/contrib/elf2dmp/pdb.h
@@ -11,6 +11,8 @@
 #include <stdint.h>
 #include <stdlib.h>
 
+#include "file_map.h"
+
 typedef struct GUID {
     unsigned int Data1;
     unsigned short Data2;
@@ -218,8 +220,7 @@ typedef struct pdb_seg {
 #define IMAGE_FILE_MACHINE_AMD64 0x8664
 
 struct pdb_reader {
-    int fd;
-    size_t file_size;
+    mapped_file mf;
     struct {
         PDB_DS_HEADER *header;
         PDB_DS_TOC *toc;
diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index e9c0d2534a..8a6246fb4e 100644
--- a/contrib/elf2dmp/qemu_elf.c
+++ b/contrib/elf2dmp/qemu_elf.c
@@ -60,10 +60,16 @@ Elf64_Half elf_getphdrnum(void *map)
     return ehdr->e_phnum;
 }
 
+void *QEMU_Elf_get_map(QEMU_Elf *qe)
+{
+    return qe->mf.map;
+}
+
 static int init_states(QEMU_Elf *qe)
 {
-    Elf64_Phdr *phdr = elf64_getphdr(qe->map);
-    Elf64_Nhdr *start = (void *)((uint8_t *)qe->map + phdr[0].p_offset);
+    void *map = QEMU_Elf_get_map(qe);
+    Elf64_Phdr *phdr = elf64_getphdr(map);
+    Elf64_Nhdr *start = (void *)((uint8_t *)map + phdr[0].p_offset);
     Elf64_Nhdr *end = (void *)((uint8_t *)start + phdr[0].p_memsz);
     Elf64_Nhdr *nhdr;
     size_t cpu_nr = 0;
@@ -121,23 +127,10 @@ static void exit_states(QEMU_Elf *qe)
 int QEMU_Elf_init(QEMU_Elf *qe, const char *filename)
 {
     int err = 0;
-    struct stat st;
 
-    qe->fd = open(filename, O_RDONLY, 0);
-    if (qe->fd == -1) {
-        eprintf("Failed to open ELF dump file \'%s\'\n", filename);
-        return 1;
-    }
-
-    fstat(qe->fd, &st);
-    qe->size = st.st_size;
-
-    qe->map = mmap(NULL, qe->size, PROT_READ | PROT_WRITE,
-            MAP_PRIVATE, qe->fd, 0);
-    if (qe->map == MAP_FAILED) {
+    if (file_map(filename, &qe->mf)) {
         eprintf("Failed to map ELF file\n");
-        err = 1;
-        goto out_fd;
+        return 1;
     }
 
     if (init_states(qe)) {
@@ -149,9 +142,7 @@ int QEMU_Elf_init(QEMU_Elf *qe, const char *filename)
     return 0;
 
 out_unmap:
-    munmap(qe->map, qe->size);
-out_fd:
-    close(qe->fd);
+    file_unmap(&qe->mf);
 
     return err;
 }
@@ -159,6 +150,5 @@ out_fd:
 void QEMU_Elf_exit(QEMU_Elf *qe)
 {
     exit_states(qe);
-    munmap(qe->map, qe->size);
-    close(qe->fd);
+    file_unmap(&qe->mf);
 }
diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
index d85d6558fa..565f6f810c 100644
--- a/contrib/elf2dmp/qemu_elf.h
+++ b/contrib/elf2dmp/qemu_elf.h
@@ -5,11 +5,13 @@
  *
  */
 
-#ifndef QEMU_ELF_H
-#define QEMU_ELF_H
+#ifndef ELF2DMP_ELF_H
+#define ELF2DMP_ELF_H
 
 #include <stdint.h>
-#include <elf.h>
+#include "elf.h"
+
+#include "file_map.h"
 
 typedef struct QEMUCPUSegment {
     uint32_t selector;
@@ -34,9 +36,7 @@ typedef struct QEMUCPUState {
 int is_system(QEMUCPUState *s);
 
 typedef struct QEMU_Elf {
-    int fd;
-    size_t size;
-    void *map;
+    mapped_file mf;
     QEMUCPUState **state;
     size_t state_nr;
     int has_kernel_gs_base;
@@ -47,5 +47,6 @@ void QEMU_Elf_exit(QEMU_Elf *qe);
 
 Elf64_Phdr *elf64_getphdr(void *map);
 Elf64_Half elf_getphdrnum(void *map);
+void *QEMU_Elf_get_map(QEMU_Elf *qe);
 
-#endif /* QEMU_ELF_H */
+#endif /* ELF2DMP_ELF_H */
-- 
2.17.2
