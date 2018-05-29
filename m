Received: from eggs.gnu.org ([2001:4830:134:3::10]:41932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fNmjO-0007MQ-Q1
	for qemu-devel@nongnu.org; Tue, 29 May 2018 18:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fNmjO-00086c-12
	for qemu-devel@nongnu.org; Tue, 29 May 2018 18:04:38 -0400
Received: from smtp18.mail.ru ([94.100.176.155]:51412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fNmjN-00084J-Q8
	for qemu-devel@nongnu.org; Tue, 29 May 2018 18:04:37 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Wed, 30 May 2018 01:03:38 +0300
Message-Id: <20180529220338.10879-4-jusual@mail.ru>
In-Reply-To: <20180529220338.10879-1-jusual@mail.ru>
References: <20180529220338.10879-1-jusual@mail.ru>
Subject: [Qemu-devel] [RFC 3/3] tests/boot-serial-test: Add support for the
 microbit board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

New mini-kernel test for nRF51 SoC UART.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 tests/boot-serial-test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 4d6815c3e0..e6dbc8a293 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -62,6 +62,16 @@ static const uint8_t kernel_aarch64[] = {
     0xfd, 0xff, 0xff, 0x17,                 /* b       -12 (loop) */
 };
 
+static const uint8_t kernel_nrf51[] = {
+    0x00, 0x00, 0x00, 0x00,                 /* Stack top address */
+    0x09, 0x00, 0x00, 0x00,                 /* Reset handler address */
+    0x01, 0x4b,                             /* ldr   r3,[pc,#4]    Get base */
+    0x54, 0x22,                             /* mov   r2,#'T' */
+    0x1a, 0x70,                             /* strb  r2,[r3] */
+    0x01, 0xe0,                             /* b     loop */
+    0x1c, 0x25, 0x00, 0x40,                 /* 0x40002000 = UART0 base addr */
+};
+
 typedef struct testdef {
     const char *arch;       /* Target architecture */
     const char *machine;    /* Name of the machine */
@@ -107,6 +117,7 @@ static testdef_t tests[] = {
     { "hppa", "hppa", "", "SeaBIOS wants SYSTEM HALT" },
     { "aarch64", "virt", "-cpu cortex-a57", "TT", sizeof(kernel_aarch64),
       kernel_aarch64 },
+    { "arm", "microbit", "", "T", sizeof(kernel_nrf51), kernel_nrf51 },
 
     { NULL }
 };
-- 
2.17.0
