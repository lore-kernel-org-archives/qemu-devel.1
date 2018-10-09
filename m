Received: from eggs.gnu.org ([2001:4830:134:3::10]:58177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9tUK-0007Qr-Mt
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:00:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9tU2-0006OG-85
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:59:54 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:35799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9tU1-0006Mq-Ql
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:59:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id e187-v6so2374382wmf.0
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 07:59:37 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  9 Oct 2018 15:59:32 +0100
Message-Id: <20181009145933.18925-3-alex.bennee@linaro.org>
In-Reply-To: <20181009145933.18925-1-alex.bennee@linaro.org>
References: <20181009145933.18925-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/3] tests/tcg: make test-i386 test program
 compile on clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, f4bug@amsat.org, Theodore Dubois <tblodt@icloud.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Theodore Dubois <tblodt@icloud.com>

Clang's assembler is slightly incompatible with GCC's assembler, which
caused the program to not compile on Clang for these reasons:

  - The "q" constraint was specified for an argument to the set
    instruction, which didn't work because Clang chose the esi register,
    which has no 8-bit form on i386.
  - Clang doesn't support size suffixes on the loop instructions.
    https://bugs.llvm.org/show_bug.cgi?id=33741
  - Clang requires a size suffix on the fist instruction.
  - Clang doesn't support specifying segment prefixes before the
    instruction, and requires specifying them on the address.
  - The arguments to the bound instruction are in the wrong order on
    Clang. https://bugs.llvm.org/show_bug.cgi?id=27653

Signed-off-by: Theodore Dubois <tblodt@icloud.com>
[AJB: tweaked title, add bugref]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/i386/test-i386.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/i386/test-i386.c b/tests/tcg/i386/test-i386.c
index a29b41e764..c5f67000e4 100644
--- a/tests/tcg/i386/test-i386.c
+++ b/tests/tcg/i386/test-i386.c
@@ -368,7 +368,7 @@ void test_lea(void)
     asm("movl $0, %0\n\t"\
         "cmpl %2, %1\n\t"\
         "set" JCC " %b0\n\t"\
-        : "=r" (res)\
+        : "=q" (res)\
         : "r" (v1), "r" (v2));\
     printf("%-10s %d\n", "set" JCC, res);\
  if (TEST_CMOV) {\
@@ -490,15 +490,23 @@ void test_loop(void)
 
 #if !defined(__x86_64__)
     TEST_LOOP("jcxz");
+#if !defined(__clang__)
     TEST_LOOP("loopw");
     TEST_LOOP("loopzw");
     TEST_LOOP("loopnzw");
+#endif
 #endif
 
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
@@ -866,7 +874,7 @@ void test_fcvt(double a)
         uint16_t val16;
         val16 = (fpuc & ~0x0c00) | (i << 10);
         asm volatile ("fldcw %0" : : "m" (val16));
-        asm volatile ("fist %0" : "=m" (wa) : "t" (a));
+        asm volatile ("fists %0" : "=m" (wa) : "t" (a));
         asm volatile ("fistl %0" : "=m" (ia) : "t" (a));
         asm volatile ("fistpll %0" : "=m" (lla) : "t" (a) : "st");
         asm volatile ("frndint ; fstl %0" : "=m" (ra) : "t" (a));
@@ -1317,12 +1325,12 @@ void test_segs(void)
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
@@ -1763,7 +1771,11 @@ void test_exceptions(void)
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
2.17.1
