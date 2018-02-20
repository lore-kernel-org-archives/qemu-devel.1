Received: from eggs.gnu.org ([2001:4830:134:3::10]:54061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eoCGd-0008Hf-7O
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:03:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eoCGc-0001m2-34
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:03:51 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Feb 2018 18:03:11 +0000
Message-Id: <20180220180325.29818-6-peter.maydell@linaro.org>
In-Reply-To: <20180220180325.29818-1-peter.maydell@linaro.org>
References: <20180220180325.29818-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 05/19] armv7m: Forward idau property to CPU
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Create an "idau" property on the armv7m container object which
we can forward to the CPU object. Annoyingly, we can't use
object_property_add_alias() because the CPU object we want to
forward to doesn't exist until the armv7m container is realized.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/armv7m.h | 3 +++
 hw/arm/armv7m.c         | 7 +++++++
 2 files changed, 10 insertions(+)

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
index facc536b07..189066812c 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -19,6 +19,7 @@
 #include "sysemu/qtest.h"
 #include "qemu/error-report.h"
 #include "exec/address-spaces.h"
+#include "target/arm/idau.h"
 
 /* Bitbanded IO.  Each word corresponds to a single bit.  */
 
@@ -162,6 +163,11 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
 
     object_property_set_link(OBJECT(s->cpu), OBJECT(&s->container), "memory",
                              &error_abort);
+    object_property_set_link(OBJECT(s->cpu), s->idau, "idau", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(s->cpu), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
@@ -217,6 +223,7 @@ static Property armv7m_properties[] = {
     DEFINE_PROP_STRING("cpu-type", ARMv7MState, cpu_type),
     DEFINE_PROP_LINK("memory", ARMv7MState, board_memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
+    DEFINE_PROP_LINK("idau", ARMv7MState, idau, TYPE_IDAU_INTERFACE, Object *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.16.1
