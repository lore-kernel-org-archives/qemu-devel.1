Received: from eggs.gnu.org ([2001:4830:134:3::10]:43353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNU9-00089R-S0
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNU8-0000Xd-DW
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:41 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gWNU8-0000XE-45
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:40 -0500
Received: by mail-wr1-x444.google.com with SMTP id p4so10896736wrt.7
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 07:28:40 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Dec 2018 15:28:26 +0000
Message-Id: <20181210152829.29271-11-alex.bennee@linaro.org>
In-Reply-To: <20181210152829.29271-1-alex.bennee@linaro.org>
References: <20181210152829.29271-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH  10/13] tests/tcg/cris: cleanup sys.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, michael@walle.cc, aurelien@aurel32.net, amarkovic@wavecomp.com, shorne@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This is a mini library which provides helper functions to the tests
which are all currently written in assembly. A bunch of minor changes:

      - removed libc related headers (fedora-cris-cross is a system compiler)
      - re-organised the functions to avoid forward declarations
      - cleaned up brace usage
      - restored exit for _fail case
      - removed tabs and fixed indentation

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/cris/system/sys.c | 96 ++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/tests/tcg/cris/system/sys.c b/tests/tcg/cris/system/sys.c
index 21f08c0747..aa342335d6 100644
--- a/tests/tcg/cris/system/sys.c
+++ b/tests/tcg/cris/system/sys.c
@@ -1,59 +1,59 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-
-static inline int mystrlen(char *s) {
-	int i = 0;
-	while (s[i])
-		i++;
-	return i;
+/*
+ * Helper functions for CRIS system tests
+ *
+ * There is no libc and only a limited set of headers.
+ */
+
+#include <stddef.h>
+
+void exit(int status)
+{
+    register unsigned int callno asm ("r9") = 1; /* NR_exit */
+
+    asm volatile ("break 13\n"
+                  : /* no outputs */
+                  : "r" (callno)
+                  : "memory" );
+    while(1);
 }
 
-void pass(void) {
-	char s[] = "passed.\n";
-	write (1, s, sizeof (s) - 1);
-	exit (0);
-}
+size_t write(int fd, const void *buf, size_t count)
+{
+    register unsigned int callno asm ("r9") = 4; /* NR_write */
+    register unsigned int r10 asm ("r10") = fd;
+    register const void *r11 asm ("r11") = buf;
+    register size_t r12 asm ("r12") = count;
+    register unsigned int r asm ("r10");
 
-void _fail(char *reason) {
-	char s[] = "\nfailed: ";
-	int len = mystrlen(reason);
-	write (1, s, sizeof (s) - 1);
-	write (1, reason, len);
-	write (1, "\n", 1);
-//	exit (1);
-}
+    asm volatile ("break 13\n"
+                  : "=r" (r)
+                  : "r" (callno), "0" (r10), "r" (r11), "r" (r12)
+                  : "memory");
 
-void *memset (void *s, int c, size_t n) {
-	char *p = s;
-	int i;
-	for (i = 0; i < n; i++)
-		p[i] = c;
-	return p;
+    return r;
 }
 
-void exit (int status) {
-	register unsigned int callno asm ("r9") = 1; /* NR_exit */
-
-	asm volatile ("break 13\n"
-		      :
-		      : "r" (callno)
-		      : "memory" );
-	while(1)
-		;
+static inline int mystrlen(char *s)
+{
+    int i = 0;
+    while (s[i]) {
+        i++;
+    }
+    return i;
 }
 
-ssize_t write (int fd, const void *buf, size_t count) {
-	register unsigned int callno asm ("r9") = 4; /* NR_write */
-	register unsigned int r10 asm ("r10") = fd;
-	register const void *r11 asm ("r11") = buf;
-	register size_t r12 asm ("r12") = count;
-	register unsigned int r asm ("r10");
 
-	asm volatile ("break 13\n"
-	     : "=r" (r)
-	     : "r" (callno), "0" (r10), "r" (r11), "r" (r12)
-	     : "memory");
+void pass(void) {
+    char s[] = "passed.\n";
+    write(1, s, sizeof (s) - 1);
+    exit(0);
+}
 
-	return r;
+void _fail(char *reason) {
+    char s[] = "\nfailed: ";
+    int len = mystrlen(reason);
+    write(1, s, sizeof (s) - 1);
+    write(1, reason, len);
+    write(1, "\n", 1);
+    exit(1);
 }
-- 
2.17.1
