Received: from eggs.gnu.org ([2001:4830:134:3::10]:52695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e2gNT-0007aS-5H
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e2gNP-0002Cw-7o
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:30:31 -0400
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:36479)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e2gNP-0002CP-0n
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:30:27 -0400
Received: from player688.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id AB6B2863E8
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 18:30:25 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 12 Oct 2017 18:30:23 +0200
Message-ID: <150782582319.2204.272473445471969673.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <150782581468.2204.675461686446925339.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <150782581468.2204.675461686446925339.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 2/2] spapr_cpu_core: rewrite machine type
 sanity check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

This makes the code easier to understand and it is consistent with what
we already do for PHBs.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_cpu_core.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 195762d8d266..3a4c17401226 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -137,7 +137,12 @@ error:
 
 static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 {
-    sPAPRMachineState *spapr;
+    /* We don't use SPAPR_MACHINE() in order to exit gracefully if the user
+     * tries to add a sPAPR CPU core to a non-pseries machine.
+     */
+    sPAPRMachineState *spapr =
+        (sPAPRMachineState *) object_dynamic_cast(qdev_get_machine(),
+                                                  TYPE_SPAPR_MACHINE);
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
     sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
     CPUCore *cc = CPU_CORE(OBJECT(dev));
@@ -146,9 +151,8 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     void *obj;
     int i, j;
 
-    spapr = (sPAPRMachineState *) qdev_get_machine();
-    if (!object_dynamic_cast((Object *) spapr, TYPE_SPAPR_MACHINE)) {
-        error_setg(errp, "spapr-cpu-core needs a pseries machine");
+    if (!spapr) {
+        error_setg(errp, TYPE_SPAPR_CPU_CORE " needs a pseries machine");
         return;
     }
 
