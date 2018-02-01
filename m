Received: from eggs.gnu.org ([2001:4830:134:3::10]:38643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1ehIgA-0003az-Ce
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:29:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1ehIg9-0005ks-7z
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:29:42 -0500
From: Wei Huang <wei@redhat.com>
Date: Thu,  1 Feb 2018 12:28:09 -0500
Message-Id: <1517506091-10396-2-git-send-email-wei@redhat.com>
In-Reply-To: <1517506091-10396-1-git-send-email-wei@redhat.com>
References: <1517506091-10396-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] tests/boot-serial-test: Add support for
 the aarch64 virt machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, wei@redhat.com, drjones@redhat.com

This patch adds a small binary kernel to test aarch64 virt machine's
UART.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 tests/Makefile.include   | 1 +
 tests/boot-serial-test.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ca82e0c..ebdb151 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -367,6 +367,7 @@ gcov-files-arm-y += hw/timer/arm_mptimer.c
 check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
+check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
 
 check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
 
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 418c5b9..66f7a84 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -55,6 +55,13 @@ static const uint8_t bios_raspi2[] = {
     0x00, 0x10, 0x20, 0x3f,                 /* 0x3f201000 = UART0 base addr */
 };
 
+static const uint8_t kernel_aarch64[] = {
+    0x81, 0x0a, 0x80, 0x52,                 /* mov     w1, #0x54 */
+    0x02, 0x20, 0xa1, 0xd2,                 /* mov     x2, #0x9000000 */
+    0x41, 0x00, 0x00, 0x39,                 /* strb    w1, [x2] */
+    0xfd, 0xff, 0xff, 0x17,                 /* b       -12 (loop) */
+};
+
 typedef struct testdef {
     const char *arch;       /* Target architecture */
     const char *machine;    /* Name of the machine */
@@ -87,6 +94,8 @@ static testdef_t tests[] = {
       sizeof(kernel_plml605), kernel_plml605 },
     { "moxie", "moxiesim", "", "TT", sizeof(bios_moxiesim), 0, bios_moxiesim },
     { "arm", "raspi2", "", "TT", sizeof(bios_raspi2), 0, bios_raspi2 },
+    { "aarch64", "virt", "-cpu cortex-a57", "TT", sizeof(kernel_aarch64),
+      kernel_aarch64 },
 
     { NULL }
 };
-- 
1.8.3.1
