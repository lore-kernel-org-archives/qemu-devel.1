Received: from eggs.gnu.org ([2001:4830:134:3::10]:33227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dSLaI-0000mN-Pb
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dSLaH-0004Kr-W3
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:01:34 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue,  4 Jul 2017 13:01:25 +0200
Message-Id: <20170704110126.26806-2-lvivier@redhat.com>
In-Reply-To: <20170704110126.26806-1-lvivier@redhat.com>
References: <20170704110126.26806-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/2] target/ppc/cpu-models: set POWER9_v1.0
 as POWER9 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Suraj Singh <sursingh@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Sam Bobroff <sbobroff@redhat.com>, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>

CPU_POWERPC_POWER9_DD1 is 0x004E0100, so this is the POWER9 v1.0.

When we run qemu on a POWER9 DD1 host, we must use either
"-cpu host" or "-cpu POWER9", but in the latter case it fails with

    Unable to find sPAPR CPU Core definition

because POWER9 DD1 doesn't appear in the list of known CPUs.

This patch fixes this by defining POWER9_v1.0 with POWER9 DD1
PVR instead of CPU_POWERPC_POWER9_BASE. It also add POWER_v2.0
with POWER9 DD2 PVR to avoid to trigger kernel POWER9 DD1 workaround
in TCG mode.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_cpu_core.c | 1 +
 target/ppc/cpu-models.c | 6 ++++--
 target/ppc/cpu-models.h | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index ea278ce..b5ecc7c 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -293,6 +293,7 @@ static const char *spapr_core_models[] = {
 
     /* POWER9 */
     "POWER9_v1.0",
+    "POWER9_v2.0",
 };
 
 static Property spapr_cpu_core_properties[] = {
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 4d3e635..ac7e299 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -1144,8 +1144,10 @@
     POWERPC_DEF("970_v2.2",      CPU_POWERPC_970_v22,                970,
                 "PowerPC 970 v2.2")
 
-    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_BASE,            POWER9,
+    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_DD1,             POWER9,
                 "POWER9 v1.0")
+    POWERPC_DEF("POWER9_v2.0",   CPU_POWERPC_POWER9_DD2,             POWER9,
+                "POWER9 v2.0")
 
     POWERPC_DEF("970fx_v1.0",    CPU_POWERPC_970FX_v10,              970,
                 "PowerPC 970FX v1.0 (G5)")
@@ -1391,7 +1393,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "POWER8E", "POWER8E_v2.1" },
     { "POWER8", "POWER8_v2.0" },
     { "POWER8NVL", "POWER8NVL_v1.0" },
-    { "POWER9", "POWER9_v1.0" },
+    { "POWER9", "POWER9_v2.0" },
     { "970", "970_v2.2" },
     { "970fx", "970fx_v3.1" },
     { "970mp", "970mp_v1.1" },
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index b563c45..c10745e 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -562,6 +562,7 @@ enum {
     CPU_POWERPC_POWER8NVL_v10      = 0x004C0100,
     CPU_POWERPC_POWER9_BASE        = 0x004E0000,
     CPU_POWERPC_POWER9_DD1         = 0x004E0100,
+    CPU_POWERPC_POWER9_DD2         = 0x004E1200, /* Scale out 24 cores */
     CPU_POWERPC_970_v22            = 0x00390202,
     CPU_POWERPC_970FX_v10          = 0x00391100,
     CPU_POWERPC_970FX_v20          = 0x003C0200,
-- 
2.9.4
