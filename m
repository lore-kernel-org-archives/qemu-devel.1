Received: from eggs.gnu.org ([2001:4830:134:3::10]:43360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWZ-0002p1-3x
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWY-0004rp-6u
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:51 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWY-0004qW-0C
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:50 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWX-0001L2-2a
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:06:49 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:12 +0000
Message-Id: <20180302110640.28004-12-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 11/39] armv7m: Forward init-svtor property to
 CPU object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Create an "init-svtor" property on the armv7m container
object which we can forward to the CPU object.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180220180325.29818-8-peter.maydell@linaro.org
---
 include/hw/arm/armv7m.h | 2 ++
 hw/arm/armv7m.c         | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index 5c3f406ccc..78308d1484 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -42,6 +42,7 @@ typedef struct {
  *   that CPU accesses see. (The NVIC, bitbanding and other CPU-internal
  *   devices will be automatically layered on top of this view.)
  * + Property "idau": IDAU interface (forwarded to CPU object)
+ * + Property "init-svtor": secure VTOR reset value (forwarded to CPU object)
  */
 typedef struct ARMv7MState {
     /*< private >*/
@@ -61,6 +62,7 @@ typedef struct ARMv7MState {
     /* MemoryRegion the board provides to us (with its devices, RAM, etc) */
     MemoryRegion *board_memory;
     Object *idau;
+    uint32_t init_svtor;
 } ARMv7MState;
 
 #endif
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 9f38d3b254..f123cc7d3d 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -170,6 +170,14 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
+    if (object_property_find(OBJECT(s->cpu), "init-svtor", NULL)) {
+        object_property_set_uint(OBJECT(s->cpu), s->init_svtor,
+                                 "init-svtor", &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
     object_property_set_bool(OBJECT(s->cpu), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
@@ -226,6 +234,7 @@ static Property armv7m_properties[] = {
     DEFINE_PROP_LINK("memory", ARMv7MState, board_memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_LINK("idau", ARMv7MState, idau, TYPE_IDAU_INTERFACE, Object *),
+    DEFINE_PROP_UINT32("init-svtor", ARMv7MState, init_svtor, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.16.2
