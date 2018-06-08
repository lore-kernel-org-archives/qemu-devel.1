Received: from eggs.gnu.org ([2001:4830:134:3::10]:46748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fRGa2-0001FD-KW
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fRGa1-0006Gi-Ii
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:33:22 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:46209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fRGa1-0006G0-B9
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:33:21 -0400
Received: by mail-wr0-x232.google.com with SMTP id v13-v6so13226285wrp.13
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 05:33:21 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  8 Jun 2018 13:32:35 +0100
Message-Id: <20180608123307.24773-18-alex.bennee@linaro.org>
In-Reply-To: <20180608123307.24773-1-alex.bennee@linaro.org>
References: <20180608123307.24773-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 17/49] tests/tcg/i386: add runner for
 test-i386-fprem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

The runner needs to compare against a reference run. We also only run
this test when SPEED=slow as it takes a while.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v5
  - include test-i386-fprem.ref
v5.1
  - remove the 69Mb test-i386-fprem.ref
  - generate test-i386-fprem.ref on developers machine
  - add TIMEOUT=60
---
 tests/tcg/i386/Makefile.target   | 16 ++++++++++++++++
 tests/tcg/i386/test-i386-fprem.c | 12 +++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index 8b46cc021e..64d241cfdf 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -33,5 +33,21 @@ test-i386: test-i386.c test-i386-code16.S test-i386-vm86.S test-i386.h test-i386
 run-runcom: runcom pi_10.com
 	$(call quiet-command, $(QEMU) ./runcom $(I386_SRC)/pi_10.com > runcom.out, "TEST", "$< on $(TARGET_NAME)")
 
+ifeq ($(SPEED), slow)
+
+test-i386-fprem.ref: test-i386-fprem
+	$(call quiet-command, ./$< > $@,"GENREF","generating $@")
+
+run-test-i386-fprem: TIMEOUT=60
+run-test-i386-fprem: test-i386-fprem
+	$(call quiet-command, \
+		$(QEMU) $< > $<.out && \
+		diff -u $(I386_SRC)/$<.ref $<.out, \
+		"TEST", "$< (default) on $(TARGET_NAME)")
+else
+run-test-i386-fprem: test-i386-fprem
+	$(call quiet-command, /bin/true, "SLOW TEST", "$< SKIPPED on $(TARGET_NAME)")
+endif
+
 # On i386 and x86_64 Linux only supports 4k pages (large pages are a different hack)
 EXTRA_RUNS+=run-test-mmap-4096
diff --git a/tests/tcg/i386/test-i386-fprem.c b/tests/tcg/i386/test-i386-fprem.c
index 1a71623204..66f5a9657d 100644
--- a/tests/tcg/i386/test-i386-fprem.c
+++ b/tests/tcg/i386/test-i386-fprem.c
@@ -23,7 +23,10 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "qemu/osdep.h"
+#include <stdio.h>
+#include <stdint.h>
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 /*
  * Inspired by <ieee754.h>'s union ieee854_long_double, but with single
@@ -39,7 +42,7 @@ union float80u {
         unsigned int exponent:15;
         unsigned int negative:1;
         unsigned int empty:16;
-    } QEMU_PACKED ieee;
+    } __attribute__((packed)) ieee;
 
     /* This is for NaNs in the IEEE 854 double-extended-precision format.  */
     struct {
@@ -49,7 +52,7 @@ union float80u {
         unsigned int exponent:15;
         unsigned int negative:1;
         unsigned int empty:16;
-    } QEMU_PACKED ieee_nan;
+    } __attribute__((packed)) ieee_nan;
 };
 
 #define IEEE854_LONG_DOUBLE_BIAS 0x3fff
@@ -229,6 +232,7 @@ static void test_fprem_cases(void)
     do_fprem_stack_underflow();
 
     printf("= invalid operation =\n");
+    do_fprem(q_nan.d, 1.0);
     do_fprem(s_nan.d, 1.0);
     do_fprem(1.0, 0.0);
     do_fprem(pos_inf.d, 1.0);
@@ -238,6 +242,8 @@ static void test_fprem_cases(void)
     do_fprem(pos_denorm.d, 1.0);
     do_fprem(1.0, pos_denorm.d);
 
+    do_fprem(smallest_positive_norm.d, smallest_positive_norm.d);
+
     /* printf("= underflow =\n"); */
     /* TODO: Is there a case where FPREM raises underflow? */
 }
-- 
2.17.1
