Received: from eggs.gnu.org ([2001:4830:134:3::10]:52871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJN6W-0003Ro-77
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJN6V-0007Ig-6u
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:54:16 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJN6V-0007I5-0y
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:54:15 -0400
Received: by mail-wr0-x22c.google.com with SMTP id p18-v6so6583552wrm.1
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 10:54:14 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 May 2018 18:46:50 +0100
Message-Id: <20180517174718.10107-22-alex.bennee@linaro.org>
In-Reply-To: <20180517174718.10107-1-alex.bennee@linaro.org>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 21/49] tests/tcg/i386: add runner for
 test-i386-fprem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

The runner needs to compare against a reference run. We also only run
this test when SPEED=slow as it takes a while.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/i386/Makefile.target   | 11 +++++++++++
 tests/tcg/i386/test-i386-fprem.c | 12 +++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index 39a1627650..94fa50abbc 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -37,3 +37,14 @@ pi_10.com:
 run-runcom: runcom pi_10.com
 	$(call quiet-command, $(QEMU) ./runcom ./pi_10.com > runcom.out, "TEST", "$< on $(TARGET_NAME)")
 
+ifeq ($(SPEED), slow)
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
2.17.0
