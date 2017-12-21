Received: from eggs.gnu.org ([2001:4830:134:3::10]:60913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eS6eF-0006EO-QS
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:37:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eS6eB-0005g7-9a
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:36:55 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:52983)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eS6eA-0005ei-Tu
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:36:51 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 21 Dec 2017 20:36:40 +0100
Message-Id: <20171221193640.27418-6-laurent@vivier.eu>
In-Reply-To: <20171221193640.27418-1-laurent@vivier.eu>
References: <20171221193640.27418-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 5/5] tests/boot-serial-test: Add support for the
 mcf5208evb board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>

From: Thomas Huth <thuth@redhat.com>

We can output a character quite easily here with some few lines of
assembly that we provide as a mini-kernel for this board.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1512031988-32490-4-git-send-email-thuth@redhat.com>
[lv: add boot-serial-test in check-qtest-m68k]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/Makefile.include   |  2 ++
 tests/boot-serial-test.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f8e20d9f5d..77f8183117 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -297,6 +297,8 @@ gcov-files-x86_64-y = $(subst i386-softmmu/,x86_64-softmmu/,$(gcov-files-i386-y)
 
 check-qtest-alpha-y = tests/boot-serial-test$(EXESUF)
 
+check-qtest-m68k-y = tests/boot-serial-test$(EXESUF)
+
 check-qtest-mips-y = tests/endianness-test$(EXESUF)
 
 check-qtest-mips64-y = tests/endianness-test$(EXESUF)
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index d99726919e..dd3828c49b 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -16,6 +16,14 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 
+static const uint8_t kernel_mcf5208[] = {
+    0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
+    0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
+    0x11, 0x7c, 0x00, 0x04, 0x00, 0x08,     /* move.b #4,8(%a0)     Enable TX */
+    0x11, 0x40, 0x00, 0x0c,                 /* move.b %d0,12(%a0)   Print 'T' */
+    0x60, 0xfa                              /* bra.s  loop */
+};
+
 typedef struct testdef {
     const char *arch;       /* Target architecture */
     const char *machine;    /* Name of the machine */
@@ -41,6 +49,8 @@ static testdef_t tests[] = {
     { "x86_64", "q35", "-device sga", "SGABIOS" },
     { "s390x", "s390-ccw-virtio",
       "-nodefaults -device sclpconsole,chardev=serial0", "virtio device" },
+    { "m68k", "mcf5208evb", "", "TT", sizeof(kernel_mcf5208), kernel_mcf5208 },
+
     { NULL }
 };
 
-- 
2.14.3
