Received: from eggs.gnu.org ([2001:4830:134:3::10]:52412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fb4fh-0007Z7-JI
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fb4fg-0002Un-Mr
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:51:45 -0400
From: Guenter Roeck <linux@roeck-us.net>
Date: Thu,  5 Jul 2018 06:51:24 -0700
Message-Id: <1530798684-23009-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] sam460ex: Add comment explaining ignored
 errors from fdt operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>, BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?q?Pilippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>

Failing to set serial port clock frequencies is not fatal. Add a comment
into the code explaining this, and typecast the function to void to
silence static analyzers.

Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Pilippe Mathieu-Daudé <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/ppc/sam460ex.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 7eed2ec..b004cda 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -324,7 +324,10 @@ static int sam460ex_load_device_tree(hwaddr addr,
     /* set serial port clocks */
     offset = fdt_node_offset_by_compatible(fdt, -1, "ns16550");
     while (offset >= 0) {
-        fdt_setprop_cell(fdt, offset, "clock-frequency", UART_FREQ);
+        /* Failure to set serial port clocks is not fatal, so just ignore
+         * errors when trying to do so.
+         */
+        (void)fdt_setprop_cell(fdt, offset, "clock-frequency", UART_FREQ);
         offset = fdt_node_offset_by_compatible(fdt, offset, "ns16550");
     }
 
-- 
2.7.4
