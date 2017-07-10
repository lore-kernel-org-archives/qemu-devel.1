Received: from eggs.gnu.org ([2001:4830:134:3::10]:37612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tblodt@icloud.com>) id 1dUfkD-0007uf-75
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:57:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tblodt@icloud.com>) id 1dUfkA-0000QQ-3E
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:57:25 -0400
Received: from st13p21im-asmtp003.me.com ([17.164.152.25]:64874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tblodt@icloud.com>) id 1dUfk9-0000Q0-U0
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:57:22 -0400
Received: from process-dkim-sign-daemon.st13p21im-asmtp003.me.com by
	st13p21im-asmtp003.me.com
	(Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26
	2016)) id <0OSW0100076FTB00@st13p21im-asmtp003.me.com> for
	qemu-devel@nongnu.org; Mon, 10 Jul 2017 20:57:19 +0000 (GMT)
Received: from icloud.com ([127.0.0.1]) by st13p21im-asmtp003.me.com
	(Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26
	2016))
	with ESMTPSA id <0OSW00RJS7JGGY30@st13p21im-asmtp003.me.com> for
	qemu-devel@nongnu.org; Mon, 10 Jul 2017 20:57:19 +0000 (GMT)
From: Theodore Dubois <tblodt@icloud.com>
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
MIME-version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-id: <D5741445-7EFD-4AF1-8DB2-E4AFA93CBB1A@icloud.com>
Date: Mon, 10 Jul 2017 13:57:12 -0700
Subject: [Qemu-devel] [PATCH] test-i386: Make x86 test program compile on
 clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Clang's assembler is slightly incompatible with GCC's assembler, which
caused the program to not compile on Clang for these reasons:

  - The "q" constraint was specified for an argument to the set
    instruction, which didn't work because Clang chose the esi register,
    which has no 8-bit form on i386.
  - Clang doesn't support size suffixes on the loop instructions.
  - Clang requires a size suffix on the fist instruction.
  - Clang doesn't support specifying segment prefixes before the
    instruction, and requires specifying them on the address.
  - The arguments to the bound instruction are in the wrong order on
    Clang. https://bugs.llvm.org/show_bug.cgi?id=27653

Signed-off-by: Theodore Dubois <tblodt@icloud.com>
---
 tests/tcg/test-i386.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/test-i386.c b/tests/tcg/test-i386.c
index 0f7b943b0c..dcb8e4876e 100644
--- a/tests/tcg/test-i386.c
+++ b/tests/tcg/test-i386.c
@@ -369,7 +369,7 @@ void test_lea(void)
     asm("movl $0, %0\n\t"\
         "cmpl %2, %1\n\t"\
         "set" JCC " %b0\n\t"\
-        : "=r" (res)\
+        : "=q" (res)\
         : "r" (v1), "r" (v2));\
     printf("%-10s %d\n", "set" JCC, res);\
  if (TEST_CMOV) {\
@@ -491,15 +491,23 @@ void test_loop(void)
 
 #if !defined(__x86_64__)
     TEST_LOOP("jcxz");
+#if !defined(__clang__)
     TEST_LOOP("loopw");
     TEST_LOOP("loopzw");
     TEST_LOOP("loopnzw");
 #endif
+#endif
 
     TEST_LOOP("jecxz");
+#if !defined(__clang__)
     TEST_LOOP("loopl");
     TEST_LOOP("loopzl");
     TEST_LOOP("loopnzl");
+#else
+    TEST_LOOP("loop");
+    TEST_LOOP("loopz");
+    TEST_LOOP("loopnz");
+#endif
 }
 
 #undef CC_MASK
@@ -867,7 +875,7 @@ void test_fcvt(double a)
         uint16_t val16;
         val16 = (fpuc & ~0x0c00) | (i << 10);
         asm volatile ("fldcw %0" : : "m" (val16));
-        asm volatile ("fist %0" : "=m" (wa) : "t" (a));
+        asm volatile ("fists %0" : "=m" (wa) : "t" (a));
         asm volatile ("fistl %0" : "=m" (ia) : "t" (a));
         asm volatile ("fistpll %0" : "=m" (lla) : "t" (a) : "st");
         asm volatile ("frndint ; fstl %0" : "=m" (ra) : "t" (a));
@@ -1318,12 +1326,12 @@ void test_segs(void)
     seg_data1[1] = 0xaa;
     seg_data2[1] = 0x55;
 
-    asm volatile ("fs movzbl 0x1, %0" : "=r" (res));
+    asm volatile ("movzbl %%fs:0x1, %0" : "=r" (res));
     printf("FS[1] = %02x\n", res);
 
     asm volatile ("pushl %%gs\n"
                   "movl %1, %%gs\n"
-                  "gs movzbl 0x1, %0\n"
+                  "movzbl %%gs:0x1, %0\n"
                   "popl %%gs\n"
                   : "=r" (res)
                   : "r" (MK_SEL(2)));
@@ -1764,7 +1772,11 @@ void test_exceptions(void)
         /* bound exception */
         tab[0] = 1;
         tab[1] = 10;
+#if defined(__clang__)
+        asm volatile ("bound %1, %0" : : "r" (11), "m" (tab[0]));
+#else
         asm volatile ("bound %0, %1" : : "r" (11), "m" (tab[0]));
+#endif
     }
 #endif
 
-- 
2.13.2



~Theodore
