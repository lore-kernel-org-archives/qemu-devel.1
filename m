Received: from eggs.gnu.org ([2001:4830:134:3::10]:56424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyM-0004fd-KX
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyL-0007Fy-My
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:02 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyL-0007Fg-Ge
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:01 -0500
Received: by mail-wm0-x231.google.com with SMTP id 64so11089325wme.3
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:16:01 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:36 +0100
Message-Id: <1513790098-9815-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/46] tests/boot-serial-test: Add support for
 the raspi2 machine
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

The raspi2 machine supports loading firmware images, so we can easily
load a small test sequence as raw binary blob here to test the UART.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1512031988-32490-8-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include   | 1 +
 tests/boot-serial-test.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 02ca4b2..c1a4a22 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -361,6 +361,7 @@ check-qtest-arm-y += tests/virtio-blk-test$(EXESUF)
 gcov-files-arm-y += arm-softmmu/hw/block/virtio-blk.c
 check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
 gcov-files-arm-y += hw/timer/arm_mptimer.c
+check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
 
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 1deddb8..663b78b 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -47,6 +47,14 @@ static const uint8_t bios_moxiesim[] = {
     0x1a, 0x00, 0x00, 0x00, 0x10, 0x00      /* jmpa  0x1000 */
 };
 
+static const uint8_t bios_raspi2[] = {
+    0x08, 0x30, 0x9f, 0xe5,                 /* ldr   r3,[pc,#8]    Get base */
+    0x54, 0x20, 0xa0, 0xe3,                 /* mov     r2,#'T' */
+    0x00, 0x20, 0xc3, 0xe5,                 /* strb    r2,[r3] */
+    0xfb, 0xff, 0xff, 0xea,                 /* b       loop */
+    0x00, 0x10, 0x20, 0x3f,                 /* 0x3f201000 = UART0 base addr */
+};
+
 typedef struct testdef {
     const char *arch;       /* Target architecture */
     const char *machine;    /* Name of the machine */
@@ -78,6 +86,7 @@ static testdef_t tests[] = {
     { "microblazeel", "petalogix-ml605", "", "TT",
       sizeof(kernel_plml605), kernel_plml605 },
     { "moxie", "moxiesim", "", "TT", sizeof(bios_moxiesim), 0, bios_moxiesim },
+    { "arm", "raspi2", "", "TT", sizeof(bios_raspi2), 0, bios_raspi2 },
 
     { NULL }
 };
-- 
1.8.3.1
