Received: from eggs.gnu.org ([2001:4830:134:3::10]:39131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gH9ZO-00058j-RI
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gH9ZO-00048N-4i
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:35:10 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gH9ZN-0003rj-SO
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:35:10 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gH9Yw-00005m-Rs
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:34:42 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 15:34:32 +0000
Message-Id: <20181029153432.23273-7-peter.maydell@linaro.org>
In-Reply-To: <20181029153432.23273-1-peter.maydell@linaro.org>
References: <20181029153432.23273-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 6/6] tests/boot-serial-test: Add microbit board
 testcase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>

New mini-kernel test for nRF51 SoC UART.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/boot-serial-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index f865822e32f..8ec6aed35d2 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -62,6 +62,24 @@ static const uint8_t kernel_aarch64[] = {
     0xfd, 0xff, 0xff, 0x17,                 /* b       -12 (loop) */
 };
 
+static const uint8_t kernel_nrf51[] = {
+    0x00, 0x00, 0x00, 0x00,                 /* Stack top address */
+    0x09, 0x00, 0x00, 0x00,                 /* Reset handler address */
+    0x04, 0x4a,                             /* ldr  r2, [pc, #16] Get ENABLE */
+    0x04, 0x21,                             /* movs r1, #4 */
+    0x11, 0x60,                             /* str  r1, [r2] */
+    0x04, 0x4a,                             /* ldr  r2, [pc, #16] Get STARTTX */
+    0x01, 0x21,                             /* movs r1, #1 */
+    0x11, 0x60,                             /* str  r1, [r2] */
+    0x03, 0x4a,                             /* ldr  r2, [pc, #12] Get TXD */
+    0x54, 0x21,                             /* movs r1, 'T' */
+    0x11, 0x60,                             /* str  r1, [r2] */
+    0xfe, 0xe7,                             /* b    . */
+    0x00, 0x25, 0x00, 0x40,                 /* 0x40002500 = UART ENABLE */
+    0x08, 0x20, 0x00, 0x40,                 /* 0x40002008 = UART STARTTX */
+    0x1c, 0x25, 0x00, 0x40                  /* 0x4000251c = UART TXD */
+};
+
 typedef struct testdef {
     const char *arch;       /* Target architecture */
     const char *machine;    /* Name of the machine */
@@ -105,6 +123,7 @@ static testdef_t tests[] = {
     { "hppa", "hppa", "", "SeaBIOS wants SYSTEM HALT" },
     { "aarch64", "virt", "-cpu cortex-a57", "TT", sizeof(kernel_aarch64),
       kernel_aarch64 },
+    { "arm", "microbit", "", "T", sizeof(kernel_nrf51), kernel_nrf51 },
 
     { NULL }
 };
-- 
2.19.1
