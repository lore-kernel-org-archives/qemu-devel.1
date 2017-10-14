Received: from eggs.gnu.org ([2001:4830:134:3::10]:59012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e3RLd-0006B6-Lx
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e3RLc-0001mh-RH
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:39:45 -0400
Received: from chuckie.co.uk ([82.165.15.123]:36938
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e3RLc-0001mS-KH
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:39:44 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat, 14 Oct 2017 19:38:58 +0100
Message-Id: <1508006342-5304-10-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1508006342-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1508006342-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv3 09/13] lance: move TYPE_LANCE and
 SysBusPCNetState from lance.c to sun4m.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Jason Wang <jasowang@redhat.com>

This enables them to be used outside of lance.c.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Jason Wang <jasowang@redhat.com>
---
 hw/net/lance.c           |    9 ---------
 include/hw/sparc/sun4m.h |   13 +++++++++++++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/net/lance.c b/hw/net/lance.c
index 92b0c68..ef7747d 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -45,15 +45,6 @@
 #include "trace.h"
 #include "sysemu/sysemu.h"
 
-#define TYPE_LANCE "lance"
-#define SYSBUS_PCNET(obj) \
-    OBJECT_CHECK(SysBusPCNetState, (obj), TYPE_LANCE)
-
-typedef struct {
-    SysBusDevice parent_obj;
-
-    PCNetState state;
-} SysBusPCNetState;
 
 static void parent_lance_reset(void *opaque, int irq, int level)
 {
diff --git a/include/hw/sparc/sun4m.h b/include/hw/sparc/sun4m.h
index 1f1cf91..a4f5f09 100644
--- a/include/hw/sparc/sun4m.h
+++ b/include/hw/sparc/sun4m.h
@@ -5,6 +5,8 @@
 #include "exec/hwaddr.h"
 #include "qapi/qmp/types.h"
 #include "hw/sysbus.h"
+#include "net/net.h"
+#include "hw/net/pcnet.h"
 
 /* Devices used by sparc32 system.  */
 
@@ -40,6 +42,17 @@ static inline void sparc_iommu_memory_write(void *opaque,
     sparc_iommu_memory_rw(opaque, addr, buf, len, 1);
 }
 
+/* lance.c */
+#define TYPE_LANCE "lance"
+#define SYSBUS_PCNET(obj) \
+    OBJECT_CHECK(SysBusPCNetState, (obj), TYPE_LANCE)
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    PCNetState state;
+} SysBusPCNetState;
+
 /* sparc32_dma.c */
 #include "hw/sparc/sparc32_dma.h"
 
-- 
1.7.10.4
