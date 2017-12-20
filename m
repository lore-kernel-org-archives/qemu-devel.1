Received: from eggs.gnu.org ([2001:4830:134:3::10]:56369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyI-0004b4-BM
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyH-0007DI-D9
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:58 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:44482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyH-0007Cy-5p
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:57 -0500
Received: by mail-wm0-x242.google.com with SMTP id t8so11241931wmc.3
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:15:57 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:32 +0100
Message-Id: <1513790098-9815-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 20/46] tests/boot-serial-test: Add support for
 the mcf5208evb board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

We can output a character quite easily here with some few lines of
assembly that we provide as a mini-kernel for this board.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1512031988-32490-4-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/boot-serial-test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index d997269..dd3828c 100644
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
1.8.3.1
