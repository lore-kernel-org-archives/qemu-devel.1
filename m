Received: from eggs.gnu.org ([209.51.188.92]:45600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkXVC-0003hC-Qn
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkXVA-0007Bj-2e
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:18 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52995 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gkXV7-00077Y-GV
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:15 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 18 Jan 2019 17:59:41 +0100
Message-Id: <1547830785-7079-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1547830785-7079-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1547830785-7079-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 08/12] target/mips: Update ITU to handle bus
 errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Update ITU to handle bus errors.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 hw/misc/mips_itu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index ee1addc..1257d8f 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -375,6 +375,12 @@ static void view_pv_try_write(ITCStorageCell *c)
     view_pv_common_write(c);
 }
 
+static void raise_exception(int excp)
+{
+    current_cpu->exception_index = excp;
+    cpu_loop_exit(current_cpu);
+}
+
 static uint64_t itc_storage_read(void *opaque, hwaddr addr, unsigned size)
 {
     MIPSITUState *s = (MIPSITUState *)opaque;
@@ -382,6 +388,14 @@ static uint64_t itc_storage_read(void *opaque, hwaddr addr, unsigned size)
     ITCView view = get_itc_view(addr);
     uint64_t ret = -1;
 
+    switch (size) {
+    case 1:
+    case 2:
+        s->icr0 |= 1 << ITC_ICR0_ERR_AXI;
+        raise_exception(EXCP_DBE);
+        return 0;
+    }
+
     switch (view) {
     case ITCVIEW_BYPASS:
         ret = view_bypass_read(cell);
@@ -420,6 +434,14 @@ static void itc_storage_write(void *opaque, hwaddr addr, uint64_t data,
     ITCStorageCell *cell = get_cell(s, addr);
     ITCView view = get_itc_view(addr);
 
+    switch (size) {
+    case 1:
+    case 2:
+        s->icr0 |= 1 << ITC_ICR0_ERR_AXI;
+        raise_exception(EXCP_DBE);
+        return;
+    }
+
     switch (view) {
     case ITCVIEW_BYPASS:
         view_bypass_write(cell, data);
-- 
2.7.4
