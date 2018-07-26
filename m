Received: from eggs.gnu.org ([2001:4830:134:3::10]:50798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1figL4-0004PB-Qq
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 09:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1figL1-0004If-Qk
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 09:29:54 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:40906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1figL1-0004G4-K7
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 09:29:51 -0400
Received: by mail-wm0-x236.google.com with SMTP id y9-v6so2037160wma.5
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 06:29:51 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 26 Jul 2018 14:29:47 +0100
Message-Id: <20180726132947.28538-3-alex.bennee@linaro.org>
In-Reply-To: <20180726132947.28538-1-alex.bennee@linaro.org>
References: <20180726132947.28538-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 for 3.0 2/2] tests: add check_invalid_maps
 to test-mmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, umarcor <1783362@bugs.launchpad.net>

This adds a test to make sure we fail properly for a 0 length mmap.
There are most likely other failure conditions we should also check.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: umarcor <1783362@bugs.launchpad.net>
---
 tests/tcg/multiarch/test-mmap.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test-mmap.c
index 5c0afe6e49..7f62eba4e9 100644
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
@@ -435,6 +435,19 @@ void checked_write(int fd, const void *buf, size_t count)
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
+    fprintf(stdout, " passed\n");
+}
+
 int main(int argc, char **argv)
 {
 	char tempname[] = "/tmp/.cmmapXXXXXX";
@@ -476,6 +489,7 @@ int main(int argc, char **argv)
 	check_file_fixed_mmaps();
 	check_file_fixed_eof_mmaps();
 	check_file_unfixed_eof_mmaps();
+	check_invalid_mmaps();
 
 	/* Fails at the moment.  */
 	/* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */
-- 
2.17.1
