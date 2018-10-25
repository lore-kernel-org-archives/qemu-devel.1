Received: from eggs.gnu.org ([2001:4830:134:3::10]:57519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gFTsC-0000dF-8N
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gFTs9-0001eA-1U
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:51:40 -0400
Received: from smtp36.i.mail.ru ([94.100.177.96]:58644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1gFTs2-0001R7-QW
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:51:32 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Thu, 25 Oct 2018 03:50:52 +0300
Message-Id: <20181025005052.27661-4-jusual@mail.ru>
In-Reply-To: <20181025005052.27661-1-jusual@mail.ru>
References: <20181025005052.27661-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v3 3/3] tests/boot-serial-test: Add microbit
 board testcase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Thomas Huth <thuth@redhat.com>, Julia Suvorova <jusual@mail.ru>

New mini-kernel test for nRF51 SoC UART.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/boot-serial-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index f865822e32..8ec6aed35d 100644
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
2.17.1
