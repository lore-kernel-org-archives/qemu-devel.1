Received: from eggs.gnu.org ([209.51.188.92]:39707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gyT4F-0003qe-Rq
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gyT4F-0007hs-3g
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:06:03 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Tue, 26 Feb 2019 14:05:31 +1100
Message-Id: <20190226030531.9932-4-sjitindarsingh@gmail.com>
In-Reply-To: <20190226030531.9932-1-sjitindarsingh@gmail.com>
References: <20190226030531.9932-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 4/4] target/ppc/spapr: Enable the
 large decrementer by default on POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, clg@kaod.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Enable the large decrementer by default on POWER9 cpu models. The
default value applied is that provided in the cpu class.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_caps.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index e07568fb94..f48aa367e3 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -566,11 +566,18 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
 static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
                                                const char *cputype)
 {
+    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(object_class_by_name(cputype));
     sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     sPAPRCapabilities caps;
 
     caps = smc->default_caps;
 
+    caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = pcc->hdecr_bits;
+    if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_3_00,
+                               0, spapr->max_compat_pvr)) {
+        caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = 0;
+    }
+
     if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_2_07,
                                0, spapr->max_compat_pvr)) {
         caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
-- 
2.13.6
