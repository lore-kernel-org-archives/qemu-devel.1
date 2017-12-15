Received: from eggs.gnu.org ([2001:4830:134:3::10]:35814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgk5-0003hY-6X
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:32:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgk4-0006tR-4W
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:32:57 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 00:30:12 -0300
Message-Id: <20171215033015.738-41-f4bug@amsat.org>
In-Reply-To: <20171215033015.738-1-f4bug@amsat.org>
References: <20171215033015.738-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 40/43] i386/pc: move vmport.c to hw/i386/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>

It's a x86-only device, so it does not make sense to keep it
in the shared misc folder.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/{misc => i386}/vmport.c | 17 +++++++++--------
 hw/i386/Makefile.objs      |  1 +
 hw/misc/Makefile.objs      |  2 --
 3 files changed, 10 insertions(+), 10 deletions(-)
 rename hw/{misc => i386}/vmport.c (95%)

diff --git a/hw/misc/vmport.c b/hw/i386/vmport.c
similarity index 95%
rename from hw/misc/vmport.c
rename to hw/i386/vmport.c
index 165500223f..eb880c6def 100644
--- a/hw/misc/vmport.c
+++ b/hw/i386/vmport.c
@@ -28,7 +28,7 @@
 #include "sysemu/hw_accel.h"
 #include "hw/qdev.h"
 
-//#define VMPORT_DEBUG
+/* #define VMPORT_DEBUG */
 
 #define VMPORT_CMD_GETVERSION 0x0a
 #define VMPORT_CMD_GETRAMSIZE 0x14
@@ -38,8 +38,7 @@
 
 #define VMPORT(obj) OBJECT_CHECK(VMPortState, (obj), TYPE_VMPORT)
 
-typedef struct VMPortState
-{
+typedef struct VMPortState {
     ISADevice parent_obj;
 
     MemoryRegion io;
@@ -51,8 +50,9 @@ static VMPortState *port_state;
 
 void vmport_register(unsigned char command, VMPortReadFunc *func, void *opaque)
 {
-    if (command >= VMPORT_ENTRIES)
+    if (command >= VMPORT_ENTRIES) {
         return;
+    }
 
     port_state->func[command] = func;
     port_state->opaque[command] = opaque;
@@ -71,14 +71,15 @@ static uint64_t vmport_ioport_read(void *opaque, hwaddr addr,
     cpu_synchronize_state(cs);
 
     eax = env->regs[R_EAX];
-    if (eax != VMPORT_MAGIC)
+    if (eax != VMPORT_MAGIC) {
         return eax;
+    }
 
     command = env->regs[R_ECX];
-    if (command >= VMPORT_ENTRIES)
+    if (command >= VMPORT_ENTRIES) {
         return eax;
-    if (!s->func[command])
-    {
+    }
+    if (!s->func[command]) {
 #ifdef VMPORT_DEBUG
         fprintf(stderr, "vmport: unknown command %x\n", command);
 #endif
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 2e5e1299ad..1548ad1ad0 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -5,6 +5,7 @@ obj-y += pc_sysfw.o
 obj-y += x86-iommu.o intel_iommu.o
 obj-y += amd_iommu.o
 obj-$(CONFIG_XEN) += ../xenpv/ xen/
+obj-$(CONFIG_VMPORT) += vmport.o
 
 obj-y += kvmvapic.o
 obj-y += acpi-build.o
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 10c88a84b4..d517f83e81 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -11,8 +11,6 @@ common-obj-$(CONFIG_EDU) += edu.o
 common-obj-y += unimp.o
 common-obj-$(CONFIG_FW_CFG_DMA) += vmcoreinfo.o
 
-obj-$(CONFIG_VMPORT) += vmport.o
-
 # ARM devices
 common-obj-$(CONFIG_PL310) += arm_l2x0.o
 common-obj-$(CONFIG_INTEGRATOR_DEBUG) += arm_integrator_debug.o
-- 
2.15.1
