Received: from eggs.gnu.org ([2001:4830:134:3::10]:41552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmMZ-0005i9-O9
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmMV-0005I3-LY
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWmMV-0005AU-Bg
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:27 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 16:01:20 -0200
Message-Id: <20181211180129.7661-16-ehabkost@redhat.com>
In-Reply-To: <20181211180129.7661-1-ehabkost@redhat.com>
References: <20181211180129.7661-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 15/24] spapr: Use default_machine_opts to set
 use_hotplug_event_source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

Instead of setting use_hotplug_event_source at instance_init
time, set default_machine_opts on spapr_machine_2_7_class_options()
to implement equivalent behavior.

This will let us eliminate the need for separate instance_init
functions for each spapr machine-type.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20181205205827.19387-3-ehabkost@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/ppc/spapr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index def3e502d8..a3f4c86a44 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4240,10 +4240,7 @@ static void phb_placement_2_7(sPAPRMachineState *spapr, uint32_t index,
 
 static void spapr_machine_2_7_instance_options(MachineState *machine)
 {
-    sPAPRMachineState *spapr = SPAPR_MACHINE(machine);
-
     spapr_machine_2_8_instance_options(machine);
-    spapr->use_hotplug_event_source = false;
 }
 
 static void spapr_machine_2_7_class_options(MachineClass *mc)
@@ -4252,6 +4249,7 @@ static void spapr_machine_2_7_class_options(MachineClass *mc)
 
     spapr_machine_2_8_class_options(mc);
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power7_v2.3");
+    mc->default_machine_opts = "modern-hotplug-events=off";
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_7);
     smc->phb_placement = phb_placement_2_7;
 }
-- 
2.18.0.rc1.1.g3f1ff2140
