Received: from eggs.gnu.org ([2001:4830:134:3::10]:51954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e1FCz-0004TI-JY
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 13:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e1FCv-0004mv-Nj
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 13:17:45 -0400
Received: from 2.mo4.mail-out.ovh.net ([46.105.72.36]:60147)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e1FCv-0004jd-Hh
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 13:17:41 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 309C8D69DD
	for <qemu-devel@nongnu.org>; Sun,  8 Oct 2017 19:17:33 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Sun, 08 Oct 2017 19:17:23 +0200
Message-ID: <150748304313.11627.11685667181516412731.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 1/2] spapr: introduce
 SPAPR_MACHINE_NOASSERT()
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

A spapr-cpu-core device can only be plugged into a pseries machine. This
is checked in spapr_cpu_core_realize() with object_dynamic_cast() instead
of the usual SPAPR_MACHINE() macro because we don't want QEMU to abort.

This patch moves the gory details to a SPAPR_MACHINE_NOASSERT() macro
that acts like the SPAPR_MACHINE() one, except it returns NULL instead
of aborting if its argument doesn't point to a pseries machine type.

This is done for two reasons:
- it makes the code nicer
- it may be used by other pseries-specific devices like PHBs for example

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_cpu_core.c |    7 +++----
 include/hw/ppc/spapr.h  |    3 +++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 37beb56e8b18..5fde07614218 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -199,7 +199,7 @@ error:
 
 static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 {
-    sPAPRMachineState *spapr;
+    sPAPRMachineState *spapr = SPAPR_MACHINE_NOASSERT(qdev_get_machine());
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
     sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
     CPUCore *cc = CPU_CORE(OBJECT(dev));
@@ -209,9 +209,8 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     void *obj;
     int i, j;
 
-    spapr = (sPAPRMachineState *) qdev_get_machine();
-    if (!object_dynamic_cast((Object *) spapr, TYPE_SPAPR_MACHINE)) {
-        error_setg(errp, "spapr-cpu-core needs a pseries machine");
+    if (!spapr) {
+        error_setg(errp, TYPE_SPAPR_CPU_CORE " needs a pseries machine");
         return;
     }
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index c1b365f56431..4933da8083df 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -43,6 +43,9 @@ typedef struct sPAPRMachineClass sPAPRMachineClass;
 #define SPAPR_MACHINE_CLASS(klass) \
     OBJECT_CLASS_CHECK(sPAPRMachineClass, klass, TYPE_SPAPR_MACHINE)
 
+#define SPAPR_MACHINE_NOASSERT(obj) \
+    ((sPAPRMachineState *) object_dynamic_cast(obj, TYPE_SPAPR_MACHINE))
+
 typedef enum {
     SPAPR_RESIZE_HPT_DEFAULT = 0,
     SPAPR_RESIZE_HPT_DISABLED,
