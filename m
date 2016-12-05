Received: from eggs.gnu.org ([2001:4830:134:3::10]:50803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cDy8c-0006EL-T8
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:37:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cDy8a-0007kV-BH
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:37:18 -0500
Received: from mail-by2nam01on0083.outbound.protection.outlook.com
	([104.47.34.83]:20512
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1cDy8Z-0007k7-Ty
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:37:16 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 5 Dec 2016 10:35:26 -0800
Message-ID: <cb06a932a7c6b29bc6eb0d35f31766bfb0bba47f.1480962799.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for 2.8 v3 1/1] cadence_uart: Check baud rate
 generator and divider values on migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, pjp@fedoraproject.org, psirt@huawei.com

The Cadence UART device emulator calculates speed by dividing the
baud rate by a 'baud rate generator' & 'baud rate divider' value.
The device specification defines these register values to be
non-zero and within certain limits. Checks were recently added when
writing to these registers but not when restoring from migration.

This patch adds checks when restoring from migration to avoid divide by
zero errors.

Reported-by: Huawei PSIRT <psirt@huawei.com>
Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---
It would be nice to squeeze this into 2.8 if possible.

V3:
 - Fix broken migration logic
 - Manually double checked and it passes migration.
V2:
 - Abort the migration if the data is invalid

 hw/char/cadence_uart.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 0215d65..ce9063b 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -502,6 +502,13 @@ static int cadence_uart_post_load(void *opaque, int version_id)
 {
     CadenceUARTState *s = opaque;
 
+    /* Ensure these two aren't invalid numbers */
+    if (s->r[R_BRGR] <= 1 || s->r[R_BRGR] & ~0xFFFF ||
+        s->r[R_BDIV] <= 3 || s->r[R_BDIV] & ~0xFF) {
+        /* Value is invalid, abort */
+        return 1;
+    }
+
     uart_parameters_setup(s);
     uart_update_status(s);
     return 0;
-- 
2.7.4
