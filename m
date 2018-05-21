Received: from eggs.gnu.org ([2001:4830:134:3::10]:34557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fKmrj-0001rL-13
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fKmrf-0005Jx-TN
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:36:51 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:50069)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fKmrf-0005J9-N2
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:36:47 -0400
From: Simon Ruderich <simon@ruderich.org>
Date: Mon, 21 May 2018 17:36:41 +0200
Message-Id: <e2fd61ed81b74490e4e6582458312d6643018d4b.1526916378.git.simon@ruderich.org>
In-Reply-To: <cover.1526916378.git.simon@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1526916378.git.simon@ruderich.org>
In-Reply-To: <cover.1526916378.git.simon@ruderich.org>
References: <cover.1526916378.git.simon@ruderich.org>
Subject: [Qemu-devel] [PATCH v3 2/5] cpus: convert qmp_memsave/qmp_pmemsave
 to use qemu_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Simon Ruderich <simon@ruderich.org>

qemu_open() allows passing file descriptors to qemu which is used in
restricted environments like libvirt where open() is prohibited.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Simon Ruderich <simon@ruderich.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 cpus.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/cpus.c b/cpus.c
index 4b1609fe90..7fd8d3c32e 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2291,7 +2291,7 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
 void qmp_memsave(int64_t addr, int64_t size, const char *filename,
                  bool has_cpu, int64_t cpu_index, Error **errp)
 {
-    FILE *f;
+    int fd;
     uint32_t l;
     CPUState *cpu;
     uint8_t buf[1024];
@@ -2308,8 +2308,8 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
         return;
     }
 
-    f = fopen(filename, "wb");
-    if (!f) {
+    fd = qemu_open(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0600);
+    if (fd < 0) {
         error_setg_file_open(errp, errno, filename);
         return;
     }
@@ -2324,7 +2324,7 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
                              " specified", orig_addr, orig_size);
             goto exit;
         }
-        if (fwrite(buf, 1, l, f) != l) {
+        if (qemu_write_full(fd, buf, l) != l) {
             error_setg(errp, QERR_IO_ERROR);
             goto exit;
         }
@@ -2333,18 +2333,18 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
     }
 
 exit:
-    fclose(f);
+    qemu_close(fd);
 }
 
 void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
                   Error **errp)
 {
-    FILE *f;
+    int fd;
     uint32_t l;
     uint8_t buf[1024];
 
-    f = fopen(filename, "wb");
-    if (!f) {
+    fd = qemu_open(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0600);
+    if (fd < 0) {
         error_setg_file_open(errp, errno, filename);
         return;
     }
@@ -2355,7 +2355,7 @@ void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
             l = size;
         }
         cpu_physical_memory_read(addr, buf, l);
-        if (fwrite(buf, 1, l, f) != l) {
+        if (qemu_write_full(fd, buf, l) != l) {
             error_setg(errp, QERR_IO_ERROR);
             goto exit;
         }
@@ -2364,7 +2364,7 @@ void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
     }
 
 exit:
-    fclose(f);
+    qemu_close(fd);
 }
 
 void qmp_inject_nmi(Error **errp)
-- 
2.15.0
