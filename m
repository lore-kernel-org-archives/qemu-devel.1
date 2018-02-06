Received: from eggs.gnu.org ([2001:4830:134:3::10]:44346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ix-0005YS-FM
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8iq-00086y-Em
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8iq-00086G-4G
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:04 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JFV1D117402
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:16:03 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fygkucwk2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:16:02 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:16:01 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:58 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-38-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 37/54] spapr: Add pseries-2.12 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, David Gibson <david@gibson.dropbear.id.au>

From: David Gibson <david@gibson.dropbear.id.au>

While we're at it fix a couple of small errors in the 2.11 and 2.10 models
(they didn't have any real effect, but don't quite match the template).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit 2b6154120cbd7f5514cefd3c6084d39922d26d88)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c      | 26 +++++++++++++++++++++++---
 include/hw/compat.h |  2 ++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 66d0ed5256..bedc39a2e5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3716,27 +3716,47 @@ static const TypeInfo spapr_machine_info = {
     type_init(spapr_machine_register_##suffix)
 
 /*
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
+/*
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
2.11.0
