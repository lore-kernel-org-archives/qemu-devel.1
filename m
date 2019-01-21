Received: from eggs.gnu.org ([209.51.188.92]:52003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyQ-0004eR-Jm
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyP-0004Wc-PW
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:02 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:37626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldyP-0004UW-J5
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:01 -0500
Received: by mail-wr1-x42f.google.com with SMTP id s12so24495418wrt.4
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:07:01 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:06:09 +0100
Message-Id: <1548093980-43088-39-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 38/49] contrib/elf2dmp: use GLib in PDB
 processing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>

From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>

Replace POSIX mmap with GLib g_mapped_file_new in PDB processing stage
to make elf2dmp cross-platform. There are no direct POSIX in elf2dmp
after this patch.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Message-Id: <20181220012441.13694-4-viktor.prutyanov@phystech.edu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/elf2dmp/pdb.c | 29 ++++++++---------------------
 contrib/elf2dmp/pdb.h |  2 +-
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index bcb01b4..52e352d 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -277,28 +277,18 @@ static void pdb_reader_exit(struct pdb_reader *r)
 
 int pdb_init_from_file(const char *name, struct pdb_reader *reader)
 {
+    GError *gerr = NULL;
     int err = 0;
-    int fd;
     void *map;
-    struct stat st;
 
-    fd = open(name, O_RDONLY, 0);
-    if (fd == -1) {
-        eprintf("Failed to open PDB file \'%s\'\n", name);
+    reader->gmf = g_mapped_file_new(name, TRUE, &gerr);
+    if (gerr) {
+        eprintf("Failed to map PDB file \'%s\'\n", name);
         return 1;
     }
-    reader->fd = fd;
-
-    fstat(fd, &st);
-    reader->file_size = st.st_size;
-
-    map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
-    if (map == MAP_FAILED) {
-        eprintf("Failed to map PDB file\n");
-        err = 1;
-        goto out_fd;
-    }
 
+    reader->file_size = g_mapped_file_get_length(reader->gmf);
+    map = g_mapped_file_get_contents(reader->gmf);
     if (pdb_reader_init(reader, map)) {
         err = 1;
         goto out_unmap;
@@ -307,16 +297,13 @@ int pdb_init_from_file(const char *name, struct pdb_reader *reader)
     return 0;
 
 out_unmap:
-    munmap(map, st.st_size);
-out_fd:
-    close(fd);
+    g_mapped_file_unref(reader->gmf);
 
     return err;
 }
 
 void pdb_exit(struct pdb_reader *reader)
 {
-    munmap(reader->ds.header, reader->file_size);
-    close(reader->fd);
+    g_mapped_file_unref(reader->gmf);
     pdb_reader_exit(reader);
 }
diff --git a/contrib/elf2dmp/pdb.h b/contrib/elf2dmp/pdb.h
index a3a3cac..1640d54 100644
--- a/contrib/elf2dmp/pdb.h
+++ b/contrib/elf2dmp/pdb.h
@@ -216,7 +216,7 @@ typedef struct pdb_seg {
 #define IMAGE_FILE_MACHINE_AMD64 0x8664
 
 struct pdb_reader {
-    int fd;
+    GMappedFile *gmf;
     size_t file_size;
     struct {
         PDB_DS_HEADER *header;
-- 
1.8.3.1
