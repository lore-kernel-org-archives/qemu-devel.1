Received: from eggs.gnu.org ([2001:4830:134:3::10]:59233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drVgr-0006aU-1N
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drVgj-0005qV-Vu
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:52:21 -0400
Received: from 18.mo1.mail-out.ovh.net ([46.105.35.72]:38040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drVgj-0005nh-P8
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:52:13 -0400
Received: from player169.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id E9F2292E6F
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 22:52:10 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 11 Sep 2017 22:52:06 +0200
Message-ID: <150516312603.27897.5390701685108186266.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] spapr_cpu_core: fail gracefully with
 non-pseries machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Sam Bobroff <sam.bobroff@au1.ibm.com>

Since commit 7cca3e466eb0 ("ppc: spapr: Move VCPU ID calculation into
sPAPR"), QEMU aborts when started with a *-spapr-cpu-core device and
a non-pseries machine.

Let's rely on the already existing call to object_dynamic_cast() instead
of using the SPAPR_MACHINE() macro.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_cpu_core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index d04d1e0d8164..dc9df0d393d1 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -201,7 +201,7 @@ error:
 
 static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 {
-    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    sPAPRMachineState *spapr;
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
     sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
     CPUCore *cc = CPU_CORE(OBJECT(dev));
@@ -211,7 +211,8 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     void *obj;
     int i, j;
 
-    if (!object_dynamic_cast(qdev_get_machine(), TYPE_SPAPR_MACHINE)) {
+    spapr = (sPAPRMachineState *) qdev_get_machine();
+    if (!object_dynamic_cast((Object *) spapr, TYPE_SPAPR_MACHINE)) {
         error_setg(errp, "spapr-cpu-core needs a pseries machine");
         return;
     }
