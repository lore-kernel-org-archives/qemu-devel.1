Received: from eggs.gnu.org ([2001:4830:134:3::10]:59761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjWnO-00088e-Mr
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjWnM-0002Xb-Tr
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:50 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:36200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cjWnM-0002XF-Nr
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:48 -0500
Received: by mail-wm0-x22d.google.com with SMTP id n11so96810wma.1
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 11:53:48 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  2 Mar 2017 19:53:37 +0000
Message-Id: <20170302195337.31558-12-alex.bennee@linaro.org>
In-Reply-To: <20170302195337.31558-1-alex.bennee@linaro.org>
References: <20170302195337.31558-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 11/11] hw/intc/arm_gic: modernise the DPRINTF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:ARM cores" <qemu-arm@nongnu.org>

While I was debugging the icount issues I realised a bunch of the
messages look quite similar. I've fixed this by including __func__ in
the debug print. At the same time I move the a modern if (GATE) style
printf which ensures the compiler can check for format string errors
even if the code gets optimised away in the non-DEBUG_GIC case.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/intc/arm_gic.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 8e5a9d8a3e..b305d9032a 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -26,15 +26,20 @@
 #include "qemu/log.h"
 #include "trace.h"
 
-//#define DEBUG_GIC
+/* #define DEBUG_GIC */
 
 #ifdef DEBUG_GIC
-#define DPRINTF(fmt, ...) \
-do { fprintf(stderr, "arm_gic: " fmt , ## __VA_ARGS__); } while (0)
+#define DEBUG_GIC_GATE 1
 #else
-#define DPRINTF(fmt, ...) do {} while(0)
+#define DEBUG_GIC_GATE 0
 #endif
 
+#define DPRINTF(fmt, ...) do {                                          \
+        if (DEBUG_GIC_GATE) {                                           \
+            fprintf(stderr, "%s: " fmt, __func__, ## __VA_ARGS__);      \
+        }                                                               \
+    } while (0)
+
 static const uint8_t gic_id_11mpcore[] = {
     0x00, 0x00, 0x00, 0x00, 0x90, 0x13, 0x04, 0x00, 0x0d, 0xf0, 0x05, 0xb1
 };
-- 
2.11.0
