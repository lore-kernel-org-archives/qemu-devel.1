Received: from eggs.gnu.org ([2001:4830:134:3::10]:46794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z7C-0000Kw-6j
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z7B-0006RV-3K
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:38 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:56055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f5z7A-0006Qi-T7
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:37 -0400
Received: by mail-wm0-x244.google.com with SMTP id b127so28590110wmf.5
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 12:39:36 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 10 Apr 2018 20:39:09 +0100
Message-Id: <20180410193919.28026-15-alex.bennee@linaro.org>
In-Reply-To: <20180410193919.28026-1-alex.bennee@linaro.org>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 14/24] tests/tcg/i386: fix test-i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, famz@redhat.com, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The test-i386 test case is a little special as it includes assembler
files. Add the additional compile magic to assemble these bits and
link them to the final binary.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/i386/Makefile.target | 19 +++++++++++++++++++
 tests/tcg/i386/test-i386.c     |  1 -
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index 7dbb7992e7..1df69e0dab 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -8,3 +8,22 @@ ifdef CROSS_CC_GUEST_CFLAGS
 CFLAGS+=$(CROSS_CC_GUEST_CFLAGS)
 endif
 endif
+
+#
+# test-386 includes a couple of additional objects that need to be linked together
+#
+
+TEST_I386_DEPS=test-i386-code16.o test-i386-vm86.o
+
+# override the default compile and link in one go rule
+test-i386.o: test-i386.c
+	$(CC) $(CFLAGS) -c $< -o $@
+
+# and provide a rule to compile .S files
+%.o: %.S
+	$(CC) $(CFLAGS) -c $< -o $@
+
+test-i386: LDFLAGS+=-lm -lc
+test-i386: test-i386.o $(TEST_I386_DEPS)
+	$(LD) -melf_i386 $(LDFLAGS) $< $(TEST_I386_DEPS) -o $@
+
diff --git a/tests/tcg/i386/test-i386.c b/tests/tcg/i386/test-i386.c
index 9599204895..cae6a7773a 100644
--- a/tests/tcg/i386/test-i386.c
+++ b/tests/tcg/i386/test-i386.c
@@ -17,7 +17,6 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #define _GNU_SOURCE
-#include "qemu/compiler.h"
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
-- 
2.16.2
