Received: from eggs.gnu.org ([2001:4830:134:3::10]:37510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eGq0h-0008HS-DA
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eGq0g-0006Iv-6L
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:37:31 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eGq0f-0006IH-V8
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:37:30 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eGq0e-0006OP-UC
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:37:28 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2017 17:37:24 +0000
Message-Id: <1511199444-17922-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1511199444-17922-1-git-send-email-peter.maydell@linaro.org>
References: <1511199444-17922-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 5/5] hw/arm: Silence xlnx-ep108 deprecation
 warning during tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

The new deprecation warning for the xlnx-ep108 machine also pops up
during "make check" which is kind of confusing. Silence it if testing
mode is enabled.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Acked-by: Wei Huang <wei@redhat.com>
Message-id: 1510846183-756-1-git-send-email-thuth@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-zcu102.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 9631a53..bbe7d04 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -24,6 +24,7 @@
 #include "qemu/error-report.h"
 #include "exec/address-spaces.h"
 #include "qemu/log.h"
+#include "sysemu/qtest.h"
 
 typedef struct XlnxZCU102 {
     MachineState parent_obj;
@@ -164,8 +165,10 @@ static void xlnx_ep108_init(MachineState *machine)
 {
     XlnxZCU102 *s = EP108_MACHINE(machine);
 
-    info_report("The Xilinx EP108 machine is deprecated, please use the "
-                "ZCU102 machine instead. It has the same features supported.");
+    if (!qtest_enabled()) {
+        info_report("The Xilinx EP108 machine is deprecated, please use the "
+                    "ZCU102 machine (which has the same features) instead.");
+    }
 
     xlnx_zynqmp_init(s, machine);
 }
-- 
2.7.4
