Received: from eggs.gnu.org ([209.51.188.92]:42748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFb-0000VS-CG
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFa-0007PO-Bj
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:51 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzSFa-0007Oe-31
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:50 -0500
Received: by mail-wr1-x443.google.com with SMTP id w2so23414163wrt.11
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:25:50 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 28 Feb 2019 20:25:32 +0000
Message-Id: <20190228202537.4638-12-alex.bennee@linaro.org>
In-Reply-To: <20190228202537.4638-1-alex.bennee@linaro.org>
References: <20190228202537.4638-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v2 11/16] tests/tcg/cris: cleanup sys.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, edgar.iglesias@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This is a mini library which provides helper functions to the tests
which are all currently written in assembly. A bunch of minor changes:

      - removed libc related headers (fedora-cris-cross is a system compiler)
      - re-organised the functions to avoid forward declarations
      - cleaned up brace usage
      - restored exit for _fail case
      - removed tabs and fixed indentation

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/cris/bare/sys.c | 96 +++++++++++++++++++--------------------
 tests/tcg/cris/libc/sys.c | 23 ++++++----
 2 files changed, 62 insertions(+), 57 deletions(-)

diff --git a/tests/tcg/cris/bare/sys.c b/tests/tcg/cris/bare/sys.c
index 21f08c0747..aa342335d6 100644
--- a/tests/tcg/cris/bare/sys.c
+++ b/tests/tcg/cris/bare/sys.c
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
diff --git a/tests/tcg/cris/libc/sys.c b/tests/tcg/cris/libc/sys.c
index b8e759eee3..6ec4e77b22 100644
--- a/tests/tcg/cris/libc/sys.c
+++ b/tests/tcg/cris/libc/sys.c
@@ -3,16 +3,18 @@
  */
 
 
-void exit (int status) {
+void exit(int status)
+{
 	register unsigned int callno asm ("r9") = 1; /* NR_exit */
 	asm volatile ("break 13\n"
 		      :
 		      : "r" (callno)
-		      : "memory" );
+		      : "memory");
 	while(1);
 }
 
-ssize_t write (int fd, const void *buf, size_t count) {
+ssize_t write(int fd, const void *buf, size_t count)
+{
 	register unsigned int callno asm ("r9") = 4; /* NR_write */
 	register unsigned int r10 asm ("r10") = fd;
 	register const void *r11 asm ("r11") = buf;
@@ -27,29 +29,32 @@ ssize_t write (int fd, const void *buf, size_t count) {
 	return r;
 }
 
-static inline int mystrlen(char *s) {
+static inline int mystrlen(char *s)
+{
 	int i = 0;
 	while (s[i])
 		i++;
 	return i;
 }
 
-void pass(void) {
+void pass(void)
+{
 	char s[] = "passed.\n";
-	write (1, s, sizeof (s) - 1);
+	write (1, s, sizeof(s) - 1);
 	exit (0);
 }
 
-void _fail(char *reason) {
+void _fail(char *reason)
+{
 	char s[] = "\nfailed: ";
 	int len = mystrlen(reason);
 	write (1, s, sizeof (s) - 1);
 	write (1, reason, len);
 	write (1, "\n", 1);
-//	exit (1);
 }
 
-void *memset (void *s, int c, size_t n) {
+void *memset(void *s, int c, size_t n)
+{
 	char *p = s;
 	int i;
 	for (i = 0; i < n; i++)
-- 
2.20.1
