Received: from eggs.gnu.org ([2001:4830:134:3::10]:43595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elv7V-0006To-0p
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:21:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elv7U-0007Ep-1z
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:21:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34538 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1elv7T-0007Ed-Sk
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:20:59 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 14 Feb 2018 12:20:30 +0100
Message-Id: <1518607234-17739-15-git-send-email-thuth@redhat.com>
In-Reply-To: <1518607234-17739-1-git-send-email-thuth@redhat.com>
References: <1518607234-17739-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 14/18] tests/boot-serial-test: Add support for
 the aarch64 virt machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

From: Wei Huang <wei@redhat.com>

This patch adds a small binary kernel to test aarch64 virt machine's
UART.

Signed-off-by: Wei Huang <wei@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[thuth: Fixed contextual conflicts with the hppa and sdhci patches]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include   | 1 +
 tests/boot-serial-test.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8b304ea..566d30a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -374,6 +374,7 @@ check-qtest-arm-y += tests/sdhci-test$(EXESUF)
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
 check-qtest-aarch64-y += tests/sdhci-test$(EXESUF)
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
