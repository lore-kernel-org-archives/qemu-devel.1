Received: from eggs.gnu.org ([2001:4830:134:3::10]:46567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1gZn5U-0005mH-4C
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1gZn5T-0002wG-6S
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:25:19 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:33526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <viktor.prutyanov@phystech.edu>)
	id 1gZn5Q-0002fI-EH
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:25:17 -0500
Received: by mail-lf1-x144.google.com with SMTP id i26so77351lfc.0
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 17:25:06 -0800 (PST)
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Date: Thu, 20 Dec 2018 04:24:37 +0300
Message-Id: <20181220012441.13694-3-viktor.prutyanov@phystech.edu>
In-Reply-To: <20181220012441.13694-1-viktor.prutyanov@phystech.edu>
References: <20181220012441.13694-1-viktor.prutyanov@phystech.edu>
Subject: [Qemu-devel] [PATCH v2 2/6] contrib/elf2dmp: use GLib in ELF
 processing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rkagan@virtuozzo.com
Cc: eblake@redhat.com, qemu-devel@nongnu.org, Viktor Prutyanov <viktor.prutyanov@phystech.edu>

Replace POSIX mmap with GLib g_mapped_file_new in ELF processing module
to make elf2dmp cross-platform.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
---
 contrib/elf2dmp/qemu_elf.c | 27 ++++++++-------------------
 contrib/elf2dmp/qemu_elf.h |  2 +-
 2 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index e9c0d2534a..0db7816586 100644
--- a/contrib/elf2dmp/qemu_elf.c
+++ b/contrib/elf2dmp/qemu_elf.c
@@ -120,25 +120,17 @@ static void exit_states(QEMU_Elf *qe)
 
 int QEMU_Elf_init(QEMU_Elf *qe, const char *filename)
 {
+    GError *gerr = NULL;
     int err = 0;
-    struct stat st;
 
-    qe->fd = open(filename, O_RDONLY, 0);
-    if (qe->fd == -1) {
-        eprintf("Failed to open ELF dump file \'%s\'\n", filename);
+    qe->gmf = g_mapped_file_new(filename, TRUE, &gerr);
+    if (gerr) {
+        eprintf("Failed to map ELF dump file \'%s\'\n", filename);
         return 1;
     }
 
-    fstat(qe->fd, &st);
-    qe->size = st.st_size;
-
-    qe->map = mmap(NULL, qe->size, PROT_READ | PROT_WRITE,
-            MAP_PRIVATE, qe->fd, 0);
-    if (qe->map == MAP_FAILED) {
-        eprintf("Failed to map ELF file\n");
-        err = 1;
-        goto out_fd;
-    }
+    qe->map = g_mapped_file_get_contents(qe->gmf);
+    qe->size = g_mapped_file_get_length(qe->gmf);
 
     if (init_states(qe)) {
         eprintf("Failed to extract QEMU CPU states\n");
@@ -149,9 +141,7 @@ int QEMU_Elf_init(QEMU_Elf *qe, const char *filename)
     return 0;
 
 out_unmap:
-    munmap(qe->map, qe->size);
-out_fd:
-    close(qe->fd);
+    g_mapped_file_unref(qe->gmf);
 
     return err;
 }
@@ -159,6 +149,5 @@ out_fd:
 void QEMU_Elf_exit(QEMU_Elf *qe)
 {
     exit_states(qe);
-    munmap(qe->map, qe->size);
-    close(qe->fd);
+    g_mapped_file_unref(qe->gmf);
 }
diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
index 19d1299954..fc69606d00 100644
--- a/contrib/elf2dmp/qemu_elf.h
+++ b/contrib/elf2dmp/qemu_elf.h
@@ -34,7 +34,7 @@ typedef struct QEMUCPUState {
 int is_system(QEMUCPUState *s);
 
 typedef struct QEMU_Elf {
-    int fd;
+    GMappedFile *gmf;
     size_t size;
     void *map;
     QEMUCPUState **state;
-- 
2.17.2
