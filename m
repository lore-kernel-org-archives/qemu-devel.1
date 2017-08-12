Received: from eggs.gnu.org ([2001:4830:134:3::10]:51710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dgRw1-00022i-F3
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 04:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dgRvy-0003Ue-89
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 04:38:17 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Sat, 12 Aug 2017 10:38:10 +0200
Message-Id: <1502527090-11473-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/ppc/spapr_cpu_core: Add a proper check for
 spapr machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>

QEMU currently crashes when the user tries to add a spapr-cpu-core
on a non-pseries machine:

$ qemu-system-ppc64 -S -machine ppce500,accel=tcg \
                    -device POWER5+_v2.1-spapr-cpu-core
hw/ppc/spapr_cpu_core.c:178:spapr_cpu_core_realize_child:
Object 0x55cee1f55160 is not an instance of type spapr-machine
Aborted (core dumped)

So let's add a proper check for the correct machine time with
a more friendly error message here.

Reported-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/spapr_cpu_core.c   | 9 ++++++++-
 scripts/device-crash-test | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index ea278ce..0f3d653 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -175,11 +175,18 @@ static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
 static void spapr_cpu_core_realize_child(Object *child, Error **errp)
 {
     Error *local_err = NULL;
-    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    sPAPRMachineState *spapr;
     CPUState *cs = CPU(child);
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     Object *obj;
 
+    spapr = (sPAPRMachineState *)object_dynamic_cast(qdev_get_machine(),
+                                                     TYPE_SPAPR_MACHINE);
+    if (!spapr) {
+        error_setg(errp, "spapr-cpu-core needs a pseries machine");
+        return;
+    }
+
     object_property_set_bool(child, true, "realized", &local_err);
     if (local_err) {
         goto error;
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index e77b693..8eb2d02 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -200,6 +200,7 @@ ERROR_WHITELIST = [
     {'log':r"Multiple VT220 operator consoles are not supported"},
     {'log':r"core 0 already populated"},
     {'log':r"could not find stage1 bootloader"},
+    {'log':r"spapr-cpu-core needs a pseries machine"},
 
     # other exitcode=1 failures not listed above will just generate INFO messages:
     {'exitcode':1, 'loglevel':logging.INFO},
-- 
1.8.3.1
