Received: from eggs.gnu.org ([2001:4830:134:3::10]:52054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkjCB-0005jx-Jm
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 23:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkjC8-0001Ny-EK
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 23:52:39 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 24 Aug 2017 05:52:32 +0200
Message-Id: <1503546752-24569-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.11] hw/ppc/spapr_cpu_core: Add a
 proper check for spapr machine
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
 v2:
 - Add the check to spapr_cpu_core_realize() instead of adding it to
   spapr_cpu_core_realize_child()
 - Use device/machine whitelist for the device-crash-test instead of
   adding a log entry there

 hw/ppc/spapr_cpu_core.c   | 5 +++++
 scripts/device-crash-test | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index ea278ce..dd92326 100644
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
index 81d65b9..043b24a 100755
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
1.8.3.1
