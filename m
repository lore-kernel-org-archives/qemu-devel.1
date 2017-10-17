Received: from eggs.gnu.org ([2001:4830:134:3::10]:50408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOU-0008J8-Ba
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOT-0006wf-5y
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:18 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:24 +1100
Message-Id: <20171017042152.29443-7-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 06/34] target/ppc: Add POWER9 DD2.0 model
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: ehabkost@redhat.com, agraf@suse.de, imammedo@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

At the moment the only POWER9 model which is listed in qemu is v1.0 (aka
"DD1").  This is a very early (read, buggy) version which will never be
released to the public - it was included in qemu only for the convenience
of those doing bringup on the early silicon.  For bonus points, we actually
had its PVR incorrect in the table (0x004e0000 instead of 0x004e0100).  We
also never actually implemented the differences in behaviour (read, bugs)
that marked DD1 in qemu.

Now that we know the PVR for the substantially better v2.0 (DD2) chip,
include it and make it the default POWER9 in qemu.  For the time being we
leave the DD1 definition in place for the poor souls (read, me) who still
need to work with DD1 hardware.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 1 +
 target/ppc/cpu-models.c | 6 ++++--
 target/ppc/cpu-models.h | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 3e20b1d886..37beb56e8b 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -296,6 +296,7 @@ static const char *spapr_core_models[] = {
 
     /* POWER9 */
     "power9_v1.0",
+    "power9_v2.0",
 };
 
 static Property spapr_cpu_core_properties[] = {
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 9d45702843..6c9bfde2d2 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -756,8 +756,10 @@
     POWERPC_DEF("970_v2.2",      CPU_POWERPC_970_v22,                970,
                 "PowerPC 970 v2.2")
 
-    POWERPC_DEF("power9_v1.0",   CPU_POWERPC_POWER9_BASE,            POWER9,
+    POWERPC_DEF("power9_v1.0",   CPU_POWERPC_POWER9_DD1,             POWER9,
                 "POWER9 v1.0")
+    POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POWER9,
+                "POWER9 v2.0")
 
     POWERPC_DEF("970fx_v1.0",    CPU_POWERPC_970FX_v10,              970,
                 "PowerPC 970FX v1.0 (G5)")
@@ -945,7 +947,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "power8e", "power8e_v2.1" },
     { "power8", "power8_v2.0" },
     { "power8nvl", "power8nvl_v1.0" },
-    { "power9", "power9_v1.0" },
+    { "power9", "power9_v2.0" },
     { "970", "970_v2.2" },
     { "970fx", "970fx_v3.1" },
     { "970mp", "970mp_v1.1" },
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index 25ef372d4c..efdb2fa53c 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -372,6 +372,7 @@ enum {
     CPU_POWERPC_POWER8NVL_v10      = 0x004C0100,
     CPU_POWERPC_POWER9_BASE        = 0x004E0000,
     CPU_POWERPC_POWER9_DD1         = 0x004E0100,
+    CPU_POWERPC_POWER9_DD20        = 0x004E1200,
     CPU_POWERPC_970_v22            = 0x00390202,
     CPU_POWERPC_970FX_v10          = 0x00391100,
     CPU_POWERPC_970FX_v20          = 0x003C0200,
-- 
2.13.6
