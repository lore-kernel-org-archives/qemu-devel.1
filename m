Received: from eggs.gnu.org ([2001:4830:134:3::10]:56502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fqEAQ-00057x-En
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fqEAK-0002OO-Mk
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:02:06 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:41839)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fqEAI-0002Nd-MX
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:02:00 -0400
From: Simon Ruderich <simon@ruderich.org>
Date: Thu, 16 Aug 2018 11:01:50 +0200
Message-Id: <07cfe62acc1e955eaa626096e86b848092391a64.1534409363.git.simon@ruderich.org>
In-Reply-To: <cover.1534409363.git.simon@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1534409363.git.simon@ruderich.org>
Subject: [Qemu-devel] [PATCH v4 2/7] cpus: convert qmp_memsave/qmp_pmemsave
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
Cc: David Alan Gilbert <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Simon Ruderich <simon@ruderich.org>

qemu_open() allow passing file descriptors to qemu which is used in
restricted environments like libvirt where open() is prohibited.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
 cpus.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/cpus.c b/cpus.c
index 125adc4da4..dd8ba36d2f 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2293,7 +2293,7 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
 void qmp_memsave(int64_t addr, int64_t size, const char *filename,
                  bool has_cpu, int64_t cpu_index, Error **errp)
 {
-    FILE *f;
+    int fd;
     uint32_t l;
     CPUState *cpu;
     uint8_t buf[1024];
@@ -2310,8 +2310,8 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
         return;
     }
 
-    f = fopen(filename, "wb");
-    if (!f) {
+    fd = qemu_open(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0600);
+    if (fd < 0) {
         error_setg_file_open(errp, errno, filename);
         return;
     }
@@ -2326,7 +2326,7 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
                              " specified", orig_addr, orig_size);
             goto exit;
         }
-        if (fwrite(buf, 1, l, f) != l) {
+        if (qemu_write_full(fd, buf, l) != l) {
             error_setg(errp, QERR_IO_ERROR);
             goto exit;
         }
@@ -2335,18 +2335,18 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
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
@@ -2357,7 +2357,7 @@ void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
             l = size;
         }
         cpu_physical_memory_read(addr, buf, l);
-        if (fwrite(buf, 1, l, f) != l) {
+        if (qemu_write_full(fd, buf, l) != l) {
             error_setg(errp, QERR_IO_ERROR);
             goto exit;
         }
@@ -2366,7 +2366,7 @@ void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
     }
 
 exit:
-    fclose(f);
+    qemu_close(fd);
 }
 
 void qmp_inject_nmi(Error **errp)
-- 
2.17.1
