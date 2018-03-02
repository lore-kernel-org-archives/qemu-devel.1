Received: from eggs.gnu.org ([2001:4830:134:3::10]:43334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWX-0002np-Tp
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWW-0004pz-VV
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:49 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWW-0004oB-NM
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:48 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWV-0001KX-G1
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:06:47 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:10 +0000
Message-Id: <20180302110640.28004-10-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 09/39] armv7m: Forward idau property to CPU
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Create an "idau" property on the armv7m container object which
we can forward to the CPU object. Annoyingly, we can't use
object_property_add_alias() because the CPU object we want to
forward to doesn't exist until the armv7m container is realized.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180220180325.29818-6-peter.maydell@linaro.org
---
 include/hw/arm/armv7m.h | 3 +++
 hw/arm/armv7m.c         | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index 35ab757264..5c3f406ccc 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -12,6 +12,7 @@
 
 #include "hw/sysbus.h"
 #include "hw/intc/armv7m_nvic.h"
+#include "target/arm/idau.h"
 
 #define TYPE_BITBAND "ARM,bitband-memory"
 #define BITBAND(obj) OBJECT_CHECK(BitBandState, (obj), TYPE_BITBAND)
@@ -40,6 +41,7 @@ typedef struct {
  * + Property "memory": MemoryRegion defining the physical address space
  *   that CPU accesses see. (The NVIC, bitbanding and other CPU-internal
  *   devices will be automatically layered on top of this view.)
+ * + Property "idau": IDAU interface (forwarded to CPU object)
  */
 typedef struct ARMv7MState {
     /*< private >*/
@@ -58,6 +60,7 @@ typedef struct ARMv7MState {
     char *cpu_type;
     /* MemoryRegion the board provides to us (with its devices, RAM, etc) */
     MemoryRegion *board_memory;
+    Object *idau;
 } ARMv7MState;
 
 #endif
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index facc536b07..9f38d3b254 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -19,6 +19,7 @@
 #include "sysemu/qtest.h"
 #include "qemu/error-report.h"
 #include "exec/address-spaces.h"
+#include "target/arm/idau.h"
 
 /* Bitbanded IO.  Each word corresponds to a single bit.  */
 
@@ -162,6 +163,13 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
 
     object_property_set_link(OBJECT(s->cpu), OBJECT(&s->container), "memory",
                              &error_abort);
+    if (object_property_find(OBJECT(s->cpu), "idau", NULL)) {
+        object_property_set_link(OBJECT(s->cpu), s->idau, "idau", &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
     object_property_set_bool(OBJECT(s->cpu), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
@@ -217,6 +225,7 @@ static Property armv7m_properties[] = {
     DEFINE_PROP_STRING("cpu-type", ARMv7MState, cpu_type),
     DEFINE_PROP_LINK("memory", ARMv7MState, board_memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
+    DEFINE_PROP_LINK("idau", ARMv7MState, idau, TYPE_IDAU_INTERFACE, Object *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.16.2
