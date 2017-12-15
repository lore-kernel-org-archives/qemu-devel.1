Received: from eggs.gnu.org ([2001:4830:134:3::10]:53095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixJ-0003a9-OT
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixI-0004bh-Tr
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:45 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Dec 2017 16:54:14 +1100
Message-Id: <20171215055435.24204-4-david@gibson.dropbear.id.au>
In-Reply-To: <20171215055435.24204-1-david@gibson.dropbear.id.au>
References: <20171215055435.24204-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 03/24] spapr: Add pseries-2.12 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

While we're at it fix a couple of small errors in the 2.11 and 2.10 models
(they didn't have any real effect, but don't quite match the template).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c      | 26 +++++++++++++++++++++++---
 include/hw/compat.h |  2 ++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1ac7eb0f8c..8881f2f1e8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3713,28 +3713,48 @@ static const TypeInfo spapr_machine_info = {
     }                                                                \
     type_init(spapr_machine_register_##suffix)
 
+/*
+ * pseries-2.12
+ */
+static void spapr_machine_2_12_instance_options(MachineState *machine)
+{
+}
+
+static void spapr_machine_2_12_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
+
 /*
  * pseries-2.11
  */
+#define SPAPR_COMPAT_2_11                                              \
+    HW_COMPAT_2_11
+
 static void spapr_machine_2_11_instance_options(MachineState *machine)
 {
+    spapr_machine_2_12_instance_options(machine);
 }
 
 static void spapr_machine_2_11_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_2_12_class_options(mc);
+    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
 }
 
-DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
+DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
 
 /*
  * pseries-2.10
  */
 #define SPAPR_COMPAT_2_10                                              \
-    HW_COMPAT_2_10                                                     \
+    HW_COMPAT_2_10
 
 static void spapr_machine_2_10_instance_options(MachineState *machine)
 {
+    spapr_machine_2_11_instance_options(machine);
 }
 
 static void spapr_machine_2_10_class_options(MachineClass *mc)
diff --git a/include/hw/compat.h b/include/hw/compat.h
index cf389b4e85..0d2a6ac468 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,6 +1,8 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
 
+#define HW_COMPAT_2_11
+
 #define HW_COMPAT_2_10 \
     {\
         .driver   = "virtio-mouse-device",\
-- 
2.14.3
