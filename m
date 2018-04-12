Received: from eggs.gnu.org ([2001:4830:134:3::10]:48985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1f6bgW-00048J-R8
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1f6bgV-0005mL-Uo
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:50:40 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:36909)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1f6bgV-0005li-MU
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:50:39 -0400
From: Simon Ruderich <simon@ruderich.org>
Date: Thu, 12 Apr 2018 14:50:35 +0200
Message-Id: <6ec4d227d2f4614fc79ee3411a5e447ead2d2a71.1523537181.git.simon@ruderich.org>
In-Reply-To: <68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
References: <20180412124834.GA2025@ruderich.org>
	<68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
In-Reply-To: <68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
References: <68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
Subject: [Qemu-devel] [PATCH v2 2/5] cpus: convert qmp_memsave/qmp_pmemsave
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

qemu_open() allow passing file descriptors to qemu which is used in
restricted environments like libvirt where open() is prohibited.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
 cpus.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/cpus.c b/cpus.c
index c78f430532..292d5b94b1 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2238,7 +2238,7 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
 void qmp_memsave(int64_t addr, int64_t size, const char *filename,
                  bool has_cpu, int64_t cpu_index, Error **errp)
 {
-    FILE *f;
+    int fd;
     uint32_t l;
     CPUState *cpu;
     uint8_t buf[1024];
@@ -2255,8 +2255,8 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
         return;
     }
 
-    f = fopen(filename, "wb");
-    if (!f) {
+    fd = qemu_open(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0600);
+    if (fd < 0) {
         error_setg_file_open(errp, errno, filename);
         return;
     }
@@ -2271,7 +2271,7 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
                              " specified", orig_addr, orig_size);
             goto exit;
         }
-        if (fwrite(buf, 1, l, f) != l) {
+        if (qemu_write_full(fd, buf, l) != l) {
             error_setg(errp, QERR_IO_ERROR);
             goto exit;
         }
@@ -2280,18 +2280,18 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
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
@@ -2302,7 +2302,7 @@ void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
             l = size;
         }
         cpu_physical_memory_read(addr, buf, l);
-        if (fwrite(buf, 1, l, f) != l) {
+        if (qemu_write_full(fd, buf, l) != l) {
             error_setg(errp, QERR_IO_ERROR);
             goto exit;
         }
@@ -2311,7 +2311,7 @@ void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
     }
 
 exit:
-    fclose(f);
+    qemu_close(fd);
 }
 
 void qmp_inject_nmi(Error **errp)
-- 
2.15.0
