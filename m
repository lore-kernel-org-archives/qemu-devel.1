Received: from eggs.gnu.org ([2001:4830:134:3::10]:60351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dknOq-0008Ef-Qu
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dknOp-0006hV-Fw
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:22:00 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 24 Aug 2017 10:21:48 +0200
Message-Id: <1503562911-2776-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503562911-2776-1-git-send-email-imammedo@redhat.com>
References: <1503562911-2776-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 3/6] ppc: make cpu alias point only to
 real cpu models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

alias pointing to another alias forces lookup code to
do recurrsive translation till real cpu model is reached.

Drop this nonsence and make each alias point to cpu model
that has corresponding CPU type. It will allow to drop
recurrsion in cpu model translation code and actually
make ppc_cpu_aliases[] content use PowerPCCPUAlias
fields properly
(i.e. alias goes into .alias and model goes into .model)

While at it add TODO defines around aliases that point to
cpu models excluded by the same TODO defines.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
If it were up to me, I'd remove all TODO cpu models as dead
code and make whomever wants to add them back to do so
with actual implementation.
---
 target/ppc/cpu-models.h |  2 +-
 target/ppc/cpu-models.c | 56 ++++++++++++++++++++++++++-----------------------
 2 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index b563c45..d748c68 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -24,7 +24,7 @@
 /**
  * PowerPCCPUAlias:
  * @alias: The alias name.
- * @model: The CPU model @alias refers to.
+ * @model: The CPU model @alias refers to, that directly resolves into CPU type
  *
  * A mapping entry from CPU @alias to CPU @model.
  */
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 346b6b1..f917b9d 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -1235,6 +1235,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "X2VP50", "X2VP20" },
 
     { "440EP", "440EPB" },
+#if defined(TODO_USER_ONLY)
     { "440GP", "440GPC" },
     { "440GR", "440GRA" },
     { "440GX", "440GXF" },
@@ -1272,36 +1273,37 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "MPC875", "MPC8XX" },
     { "MPC880", "MPC8XX" },
     { "MPC885", "MPC8XX" },
+#endif
 
     /* PowerPC MPC603 microcontrollers */
     { "MPC8240", "603" },
 
-    { "MPC52XX", "MPC5200" },
+    { "MPC52XX", "MPC5200_V12" },
     { "MPC5200", "MPC5200_V12" },
     { "MPC5200B", "MPC5200B_V21" },
 
-    { "MPC82XX", "MPC8280" },
-    { "POWERQUICC-II", "MPC82XX" },
+    { "MPC82XX", "G2LEGP3" },
+    { "POWERQUICC-II", "G2LEGP3" },
     { "MPC8241", "G2HIP4" },
     { "MPC8245", "G2HIP4" },
     { "MPC8247", "G2LEGP3" },
     { "MPC8248", "G2LEGP3" },
-    { "MPC8250", "MPC8250_HIP4" },
+    { "MPC8250", "G2HIP4" },
     { "MPC8250_HIP3", "G2HIP3" },
     { "MPC8250_HIP4", "G2HIP4" },
-    { "MPC8255", "MPC8255_HIP4" },
+    { "MPC8255", "G2HIP4" },
     { "MPC8255_HIP3", "G2HIP3" },
     { "MPC8255_HIP4", "G2HIP4" },
-    { "MPC8260", "MPC8260_HIP4" },
+    { "MPC8260", "G2HIP4" },
     { "MPC8260_HIP3", "G2HIP3" },
     { "MPC8260_HIP4", "G2HIP4" },
-    { "MPC8264", "MPC8264_HIP4" },
+    { "MPC8264", "G2HIP4" },
     { "MPC8264_HIP3", "G2HIP3" },
     { "MPC8264_HIP4", "G2HIP4" },
-    { "MPC8265", "MPC8265_HIP4" },
+    { "MPC8265", "G2HIP4" },
     { "MPC8265_HIP3", "G2HIP3" },
     { "MPC8265_HIP4", "G2HIP4" },
-    { "MPC8266", "MPC8266_HIP4" },
+    { "MPC8266", "G2HIP4" },
     { "MPC8266_HIP3", "G2HIP3" },
     { "MPC8266_HIP4", "G2HIP4" },
     { "MPC8270", "G2LEGP3" },
@@ -1339,18 +1341,18 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "601V", "601_V2" },
     { "VANILLA", "603" },
     { "603E", "603E_V4.1" },
-    { "STRETCH", "603E" },
+    { "STRETCH", "603E_V4.1" },
     { "VAILLANT", "603E7V" },
     { "603R", "603E7T" },
-    { "GOLDENEYE", "603R" },
+    { "GOLDENEYE", "603E7T" },
     { "604E", "604E_V2.4" },
-    { "SIROCCO", "604E" },
+    { "SIROCCO", "604E_V2.4" },
     { "MACH5", "604R" },
     { "740", "740_V3.1" },
-    { "ARTHUR", "740" },
+    { "ARTHUR", "740_V3.1" },
     { "750", "750_V3.1" },
-    { "TYPHOON", "750" },
-    { "G3",      "750" },
+    { "TYPHOON", "750_V3.1" },
+    { "G3",      "750_V3.1" },
     { "CONAN/DOYLE", "750P" },
     { "750CL", "750CL_V2.0" },
     { "750CX", "750CX_V2.2" },
@@ -1358,32 +1360,34 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "750FX", "750FX_V2.3" },
     { "750GX", "750GX_V1.2" },
     { "750L", "750L_V3.2" },
-    { "LONESTAR", "750L" },
+    { "LONESTAR", "750L_V3.2" },
     { "745", "745_V2.8" },
     { "755", "755_V2.8" },
-    { "GOLDFINGER", "755" },
+    { "GOLDFINGER", "755_V2.8" },
     { "7400", "7400_V2.9" },
-    { "MAX", "7400" },
-    { "G4",  "7400" },
+    { "MAX", "7400_V2.9" },
+    { "G4",  "7400_V2.9" },
     { "7410", "7410_V1.4" },
-    { "NITRO", "7410" },
+    { "NITRO", "7410_V1.4" },
     { "7448", "7448_V2.1" },
     { "7450", "7450_V2.1" },
-    { "VGER", "7450" },
+    { "VGER", "7450_V2.1" },
     { "7441", "7441_V2.3" },
     { "7451", "7451_V2.3" },
     { "7445", "7445_V3.2" },
     { "7455", "7455_V3.2" },
-    { "APOLLO6", "7455" },
+    { "APOLLO6", "7455_V3.2" },
     { "7447", "7447_V1.1" },
     { "7457", "7457_V1.2" },
-    { "APOLLO7", "7457" },
+    { "APOLLO7", "7457_V1.2" },
     { "7447A", "7447A_V1.2" },
     { "7457A", "7457A_V1.2" },
     { "APOLLO7PM", "7457A_V1.0" },
 #if defined(TARGET_PPC64)
+#if defined(TODO)
     { "POWER3", "630" },
     { "POWER3+", "631" },
+#endif
     { "POWER5+", "POWER5+_V2.1" },
     { "POWER5GS", "POWER5+_V2.1" },
     { "POWER7", "POWER7_V2.3" },
@@ -1399,10 +1403,10 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
 
     /* Generic PowerPCs */
 #if defined(TARGET_PPC64)
-    { "PPC64", "970FX" },
+    { "PPC64", "970FX_V3.1" },
 #endif
     { "PPC32", "604" },
-    { "PPC", "PPC32" },
-    { "DEFAULT", "PPC" },
+    { "PPC", "604" },
+    { "DEFAULT", "604" },
     { NULL, NULL }
 };
-- 
2.7.4
