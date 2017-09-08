Received: from eggs.gnu.org ([2001:4830:134:3::10]:58980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGeI-0002KM-5R
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe8-0003PU-Et
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:34 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:53 +1000
Message-Id: <20170908103558.31632-36-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 35/40] ppc: make cpu alias point only to real
 cpu models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Igor Mammedov <imammedo@redhat.com>

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
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu-models.c | 56 ++++++++++++++++++++++++++-----------------------
 target/ppc/cpu-models.h |  2 +-
 2 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 07a48ca548..64629fc39f 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -1237,6 +1237,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "x2vp50", "x2vp20" },
 
     { "440ep", "440epb" },
+#if defined(TODO_USER_ONLY)
     { "440gp", "440gpc" },
     { "440gr", "440gra" },
     { "440gx", "440gxf" },
@@ -1274,36 +1275,37 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "mpc875", "mpc8xx" },
     { "mpc880", "mpc8xx" },
     { "mpc885", "mpc8xx" },
+#endif
 
     /* PowerPC MPC603 microcontrollers */
     { "mpc8240", "603" },
 
-    { "mpc52xx", "mpc5200" },
+    { "mpc52xx", "mpc5200_v12" },
     { "mpc5200", "mpc5200_v12" },
     { "mpc5200b", "mpc5200b_v21" },
 
-    { "mpc82xx", "mpc8280" },
-    { "powerquicc-ii", "mpc82xx" },
+    { "mpc82xx", "g2legp3" },
+    { "powerquicc-ii", "g2legp3" },
     { "mpc8241", "g2hip4" },
     { "mpc8245", "g2hip4" },
     { "mpc8247", "g2legp3" },
     { "mpc8248", "g2legp3" },
-    { "mpc8250", "mpc8250_hip4" },
+    { "mpc8250", "g2hip4" },
     { "mpc8250_hip3", "g2hip3" },
     { "mpc8250_hip4", "g2hip4" },
-    { "mpc8255", "mpc8255_hip4" },
+    { "mpc8255", "g2hip4" },
     { "mpc8255_hip3", "g2hip3" },
     { "mpc8255_hip4", "g2hip4" },
-    { "mpc8260", "mpc8260_hip4" },
+    { "mpc8260", "g2hip4" },
     { "mpc8260_hip3", "g2hip3" },
     { "mpc8260_hip4", "g2hip4" },
-    { "mpc8264", "mpc8264_hip4" },
+    { "mpc8264", "g2hip4" },
     { "mpc8264_hip3", "g2hip3" },
     { "mpc8264_hip4", "g2hip4" },
-    { "mpc8265", "mpc8265_hip4" },
+    { "mpc8265", "g2hip4" },
     { "mpc8265_hip3", "g2hip3" },
     { "mpc8265_hip4", "g2hip4" },
-    { "mpc8266", "mpc8266_hip4" },
+    { "mpc8266", "g2hip4" },
     { "mpc8266_hip3", "g2hip3" },
     { "mpc8266_hip4", "g2hip4" },
     { "mpc8270", "g2legp3" },
@@ -1341,18 +1343,18 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "601v", "601_v2" },
     { "vanilla", "603" },
     { "603e", "603e_v4.1" },
-    { "stretch", "603e" },
+    { "stretch", "603e_v4.1" },
     { "vaillant", "603e7v" },
     { "603r", "603e7t" },
-    { "goldeneye", "603r" },
+    { "goldeneye", "603e7t" },
     { "604e", "604e_v2.4" },
-    { "sirocco", "604e" },
+    { "sirocco", "604e_v2.4" },
     { "mach5", "604r" },
     { "740", "740_v3.1" },
-    { "arthur", "740" },
+    { "arthur", "740_v3.1" },
     { "750", "750_v3.1" },
-    { "typhoon", "750" },
-    { "g3",      "750" },
+    { "typhoon", "750_v3.1" },
+    { "g3",      "750_v3.1" },
     { "conan/doyle", "750p" },
     { "750cl", "750cl_v2.0" },
     { "750cx", "750cx_v2.2" },
@@ -1360,32 +1362,34 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "750fx", "750fx_v2.3" },
     { "750gx", "750gx_v1.2" },
     { "750l", "750l_v3.2" },
-    { "lonestar", "750l" },
+    { "lonestar", "750l_v3.2" },
     { "745", "745_v2.8" },
     { "755", "755_v2.8" },
-    { "goldfinger", "755" },
+    { "goldfinger", "755_v2.8" },
     { "7400", "7400_v2.9" },
-    { "max", "7400" },
-    { "g4",  "7400" },
+    { "max", "7400_v2.9" },
+    { "g4",  "7400_v2.9" },
     { "7410", "7410_v1.4" },
-    { "nitro", "7410" },
+    { "nitro", "7410_v1.4" },
     { "7448", "7448_v2.1" },
     { "7450", "7450_v2.1" },
-    { "vger", "7450" },
+    { "vger", "7450_v2.1" },
     { "7441", "7441_v2.3" },
     { "7451", "7451_v2.3" },
     { "7445", "7445_v3.2" },
     { "7455", "7455_v3.2" },
-    { "apollo6", "7455" },
+    { "apollo6", "7455_v3.2" },
     { "7447", "7447_v1.1" },
     { "7457", "7457_v1.2" },
-    { "apollo7", "7457" },
+    { "apollo7", "7457_v1.2" },
     { "7447a", "7447a_v1.2" },
     { "7457a", "7457a_v1.2" },
     { "apollo7pm", "7457a_v1.0" },
 #if defined(TARGET_PPC64)
+#if defined(TODO)
     { "power3", "630" },
     { "power3+", "631" },
+#endif
     { "power5+", "power5+_v2.1" },
     { "power5gs", "power5+_v2.1" },
     { "power7", "power7_v2.3" },
@@ -1401,10 +1405,10 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
 
     /* Generic PowerPCs */
 #if defined(TARGET_PPC64)
-    { "ppc64", "970fx" },
+    { "ppc64", "970fx_v3.1" },
 #endif
     { "ppc32", "604" },
-    { "ppc", "ppc32" },
-    { "default", "ppc" },
+    { "ppc", "604" },
+    { "default", "604" },
     { NULL, NULL }
 };
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index eaa6849a42..629f112337 100644
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
-- 
2.13.5
