Received: from eggs.gnu.org ([2001:4830:134:3::10]:37498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fkQEj-0003B9-3c
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fkQEg-0005pm-12
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:42:33 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:59171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fkQEf-0005ns-Ix
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:42:29 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 31 Jul 2018 10:42:02 +0200
Message-Id: <20180731084203.29959-3-laurent@vivier.eu>
In-Reply-To: <20180731084203.29959-1-laurent@vivier.eu>
References: <20180731084203.29959-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/3] tests: add check_invalid_maps to test-mmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, umarcor <1783362@bugs.launchpad.net>

From: Alex Bennée <alex.bennee@linaro.org>

This adds a test to make sure we fail properly for a 0 length mmap.
There are most likely other failure conditions we should also check.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: umarcor <1783362@bugs.launchpad.net>
Message-Id: <20180730134321.19898-3-alex.bennee@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/tcg/multiarch/test-mmap.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test-mmap.c
index 5c0afe6e49..11d0e777b1 100644
--- a/tests/tcg/multiarch/test-mmap.c
+++ b/tests/tcg/multiarch/test-mmap.c
@@ -27,7 +27,7 @@
 #include <stdint.h>
 #include <string.h>
 #include <unistd.h>
-
+#include <errno.h>
 #include <sys/mman.h>
 
 #define D(x)
@@ -435,6 +435,25 @@ void checked_write(int fd, const void *buf, size_t count)
     fail_unless(rc == count);
 }
 
+void check_invalid_mmaps(void)
+{
+    unsigned char *addr;
+
+    /* Attempt to map a zero length page.  */
+    addr = mmap(NULL, 0, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    fprintf(stdout, "%s addr=%p", __func__, (void *)addr);
+    fail_unless(addr == MAP_FAILED);
+    fail_unless(errno == EINVAL);
+
+    /* Attempt to map a over length page.  */
+    addr = mmap(NULL, -4, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    fprintf(stdout, "%s addr=%p", __func__, (void *)addr);
+    fail_unless(addr == MAP_FAILED);
+    fail_unless(errno == ENOMEM);
+
+    fprintf(stdout, " passed\n");
+}
+
 int main(int argc, char **argv)
 {
 	char tempname[] = "/tmp/.cmmapXXXXXX";
@@ -476,6 +495,7 @@ int main(int argc, char **argv)
 	check_file_fixed_mmaps();
 	check_file_fixed_eof_mmaps();
 	check_file_unfixed_eof_mmaps();
+	check_invalid_mmaps();
 
 	/* Fails at the moment.  */
 	/* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */
-- 
2.17.1
