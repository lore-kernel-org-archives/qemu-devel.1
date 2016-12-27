Received: from eggs.gnu.org ([2001:4830:134:3::10]:35204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZF-0001aL-Sp
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZF-00018U-0w
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:21:33 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLtZE-00017i-RM
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:21:32 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZE-0003q1-1B
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:21:32 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:20:53 +0000
Message-Id: <1482852077-19397-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 01/25] cadence_uart: Check baud rate generator
 and divider values on migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alistair Francis <alistair.francis@xilinx.com>

The Cadence UART device emulator calculates speed by dividing the
baud rate by a 'baud rate generator' & 'baud rate divider' value.
The device specification defines these register values to be
non-zero and within certain limits. Checks were recently added when
writing to these registers but not when restoring from migration.

This patch adds checks when restoring from migration to avoid divide by
zero errors.

Reported-by: Huawei PSIRT <psirt@huawei.com>
Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 04ae30ed8ee1758cd2d2af880da4d28f74c67738.1481132150.git.alistair.francis@xilinx.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/cadence_uart.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 0215d65..dba1c53 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -502,6 +502,13 @@ static int cadence_uart_post_load(void *opaque, int version_id)
 {
     CadenceUARTState *s = opaque;
 
+    /* Ensure these two aren't invalid numbers */
+    if (s->r[R_BRGR] < 1 || s->r[R_BRGR] & ~0xFFFF ||
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
