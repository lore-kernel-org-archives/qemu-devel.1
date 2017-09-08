Received: from eggs.gnu.org ([2001:4830:134:3::10]:58775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe9-0002Cj-Eo
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe2-0003Hh-W2
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:25 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:46 +1000
Message-Id: <20170908103558.31632-29-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 28/40] hw/ppc/spapr_cpu_core: Add a proper check
 for spapr machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

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
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c   | 5 +++++
 scripts/device-crash-test | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index ea278ce2a7..dd9232620d 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -220,6 +220,11 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     void *obj;
     int i, j;
 
+    if (!object_dynamic_cast(qdev_get_machine(), TYPE_SPAPR_MACHINE)) {
+        error_setg(errp, "spapr-cpu-core needs a pseries machine");
+        return;
+    }
+
     sc->threads = g_malloc0(size * cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
         char id[32];
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 81d65b9617..043b24a4aa 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -160,6 +160,9 @@ ERROR_WHITELIST = [
     {'machine':'q35|pc.*', 'device':'kvm-ioapic', 'expected':True}, # Only 1 ioapics allowed
     {'machine':'q35|pc.*', 'device':'ioapic', 'expected':True},     # Only 1 ioapics allowed
 
+    # "spapr-cpu-core needs a pseries machine"
+    {'machine':'(?!pseries).*', 'device':'.*-spapr-cpu-core', 'expected':True},
+
     # KVM-specific devices shouldn't be tried without accel=kvm:
     {'accel':'(?!kvm).*', 'device':'kvmclock', 'expected':True},
     {'accel':'(?!kvm).*', 'device':'kvm-pci-assign', 'expected':True},
-- 
2.13.5
