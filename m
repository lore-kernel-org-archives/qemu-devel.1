Received: from eggs.gnu.org ([2001:4830:134:3::10]:46497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5ir-0002Sk-Jg
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5in-0000IG-KM
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:17 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:24 -0500
Message-Id: <20180619014319.28272-59-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 058/113] hw/char/cmsdk-apb-uart.c: Correctly
 clear INTSTATUS bits on writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

The CMSDK APB UART INTSTATUS register bits are all write-one-to-clear.
We were getting this correct for the TXO and RXO bits (which need
special casing because their state lives in the STATE register),
but had forgotten to handle the normal bits for RX and TX which
we do store in our s->intstatus field.

Perform the W1C operation on the bits in s->intstatus too.

Fixes: https://bugs.launchpad.net/qemu/+bug/1760262
Cc: qemu-stable@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180410134203.17552-1-peter.maydell@linaro.org
(cherry picked from commit 6670b494fdb23f74ecd9be3d952c007f64e268f1)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/char/cmsdk-apb-uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index 1ad1e14295..9c0929d8a2 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -274,6 +274,7 @@ static void uart_write(void *opaque, hwaddr offset, uint64_t value,
          * is then reflected into the intstatus value by the update function).
          */
         s->state &= ~(value & (R_INTSTATUS_TXO_MASK | R_INTSTATUS_RXO_MASK));
+        s->intstatus &= ~value;
         cmsdk_apb_uart_update(s);
         break;
     case A_BAUDDIV:
-- 
2.11.0
