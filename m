Received: from eggs.gnu.org ([2001:4830:134:3::10]:54579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g05qV-0003w4-Qm
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 10:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g05qP-0000Ob-OL
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 10:10:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41232 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g05qP-0000NF-G7
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 10:10:13 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Sep 2018 16:10:09 +0200
Message-Id: <20180912141009.19477-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] serial: fix DLL writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: linux@roeck-us.net

Commit 0147883450fe84bb8de2d4a58381881f4262ce9b tries to handle
word-sized writes to DLL/DLH, but due to a typo,
this patch is causing tracebacks in all Linux kernels running the PXA
serial driver, due to an unexpected DLL register value. Here is the
surrounding code from drivers/tty/serial/pxa.c:

	serial_out(up, UART_DLL, quot & 0xff);		/* LS of divisor */

	/*
	 * work around Errata #75 according to Intel(R) PXA27x
	 * Processor Family Specification Update (Nov 2005)
	 */
	dll = serial_in(up, UART_DLL);
	WARN_ON(dll != (quot & 0xff));	// <-- warning

Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 0147883450fe84bb8de2d4a58381881f4262ce9b
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 251f40fdac..02463e3388 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -345,9 +345,9 @@ static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
     default:
     case 0:
         if (s->lcr & UART_LCR_DLAB) {
-            if (size == 2) {
+            if (size == 1) {
                 s->divider = (s->divider & 0xff00) | val;
-            } else if (size == 4) {
+            } else {
                 s->divider = val;
             }
             serial_update_parameters(s);
-- 
2.17.1
