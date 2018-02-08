Received: from eggs.gnu.org ([2001:4830:134:3::10]:45476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejsWD-0002Wx-Id
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:10:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejsWC-0002Qu-Gg
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:10:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50442 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ejsWC-0002Qi-Bs
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:10:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06EF64026776
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 20:10:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  8 Feb 2018 21:09:42 +0100
Message-Id: <1518120582-26647-15-git-send-email-thuth@redhat.com>
In-Reply-To: <1518120582-26647-1-git-send-email-thuth@redhat.com>
References: <1518120582-26647-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 14/14] tests/boot-serial-test: Add support for
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

From: Wei Huang <wei@redhat.com>

This patch adds a small binary kernel to test aarch64 virt machine's
UART.

Signed-off-by: Wei Huang <wei@redhat.com>
[thuth: Fixed contextual conflict with the hppa patch]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include   | 1 +
 tests/boot-serial-test.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6609276..cc7e7dc 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -371,6 +371,7 @@ gcov-files-arm-y += hw/timer/arm_mptimer.c
 check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
+check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
 
 check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
 
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 72873ee..511bf31 100644
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
@@ -95,6 +102,8 @@ static testdef_t tests[] = {
     { "moxie", "moxiesim", "", "TT", sizeof(bios_moxiesim), 0, bios_moxiesim },
     { "arm", "raspi2", "", "TT", sizeof(bios_raspi2), 0, bios_raspi2 },
     { "hppa", "hppa", "", "SeaBIOS wants SYSTEM HALT" },
+    { "aarch64", "virt", "-cpu cortex-a57", "TT", sizeof(kernel_aarch64),
+      kernel_aarch64 },
 
     { NULL }
 };
-- 
1.8.3.1
