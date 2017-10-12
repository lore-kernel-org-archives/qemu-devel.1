Received: from eggs.gnu.org ([2001:4830:134:3::10]:37890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e2ffn-0000Ci-Ql
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e2ffj-0005Nn-OI
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:45:23 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 12 Oct 2017 17:45:14 +0200
Message-Id: <1507823114-270153-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH] fixup! ppc: spapr: use cpu type name directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, agraf@suse.de, david@gibson.dropbear.id.au, groug@kaod.org

follow up commit that registers host-spapr-cpu-core type unconditionally
 "ppc: spapr: register 'host' core type  along with the rest of core types"

makes 'non' machine crash
 ppc64-softmmu/qemu-system-ppc64 -M none -device host-spapr-cpu-core
 ERROR:qom/object.c:217:object_type_get_instance_size: assertion failed: (type != NULL)
 Aborted

before it qemu fails cleanly with
 ppc64-softmmu/qemu-system-ppc64 -M none -device host-spapr-cpu-core
 qemu-system-ppc64: -device host-spapr-cpu-core: 'host-spapr-cpu-core' is not a valid device model name

spapr_cpu_core_realize() already has explicit check for pseries machine,
so move access to host cpu type after it so 'none' machine would fail
cleanly as expected.

Reported-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/ppc/spapr_cpu_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index b5bbb6a..7dbf9c3 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -151,7 +151,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
     sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
     CPUCore *cc = CPU_CORE(OBJECT(dev));
-    size_t size = object_type_get_instance_size(scc->cpu_type);
+    size_t size;
     Error *local_err = NULL;
     void *obj;
     int i, j;
@@ -162,6 +162,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    size = object_type_get_instance_size(scc->cpu_type);
     sc->threads = g_malloc0(size * cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
         char id[32];
-- 
2.7.4
