Received: from eggs.gnu.org ([2001:4830:134:3::10]:52520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gQTU9-0002ZA-5d
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 03:40:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gQTSe-0000PA-1l
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 03:38:44 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Sun, 25 Nov 2018 01:00:15 +0800
Message-Id: <1543078821-16636-5-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543078821-16636-1-git-send-email-peng.hao2@zte.com.cn>
References: <1543078821-16636-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V8 04/10] hw/misc/pvpanic: moving structure
 definition to header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, drjones@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

Move structure definition to header file uniformly

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 hw/misc/pvpanic.c         | 16 ----------------
 include/hw/misc/pvpanic.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 2bcbfc5..aaa8b0c 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -27,9 +27,6 @@
 /* The pv event value */
 #define PVPANIC_PANICKED        (1 << PVPANIC_F_PANICKED)
 
-#define PVPANIC_ISA_DEVICE(obj)    \
-    OBJECT_CHECK(PVPanicISAState, (obj), TYPE_PVPANIC)
-
 static void handle_event(int event)
 {
     static bool logged;
@@ -45,19 +42,6 @@ static void handle_event(int event)
     }
 }
 
-#include "hw/isa/isa.h"
-
-/* PVPanicISAState for ISA device and
- * use ioport.
- */
-typedef struct PVPanicISAState {
-    ISADevice parent_obj;
-    /*< private>*/
-    uint16_t ioport;
-    /*<public>*/
-    MemoryRegion mr;
-} PVPanicISAState;
-
 /* return supported events on read */
 static uint64_t pvpanic_read(void *opaque, hwaddr addr, unsigned size)
 {
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 66dbdfe..066c707 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -13,12 +13,24 @@
  */
 #ifndef HW_MISC_PVPANIC_H
 #define HW_MISC_PVPANIC_H
+#include "hw/isa/isa.h"
 
 #define TYPE_PVPANIC "pvpanic"
 #define TYPE_PVPANIC_MMIO "pvpanic-mmio"
 
 #define PVPANIC_IOPORT_PROP "ioport"
 
+/* PVPanicISAState for ISA device and
+ * use ioport.
+ */
+typedef struct PVPanicISAState {
+    ISADevice parent_obj;
+    /*< private>*/
+    uint16_t ioport;
+    /*<public>*/
+    MemoryRegion mr;
+} PVPanicISAState;
+
 /* PVPanicMMIOState for sysbus device and
  * use mmio.
  */
@@ -30,6 +42,9 @@ typedef struct PVPanicMMIOState {
     MemoryRegion mr;
 } PVPanicMMIOState;
 
+#define PVPANIC_ISA_DEVICE(obj)    \
+    OBJECT_CHECK(PVPanicISAState, (obj), TYPE_PVPANIC)
+
 #define PVPANIC_MMIO_DEVICE(obj)    \
     OBJECT_CHECK(PVPanicMMIOState, (obj), TYPE_PVPANIC_MMIO)
 
-- 
1.8.3.1
