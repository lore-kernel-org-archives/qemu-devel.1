Received: from eggs.gnu.org ([2001:4830:134:3::10]:37802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tc8-0002Pv-8Y
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tc7-0007nY-8y
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8tc7-0007nH-35
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:03 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 11 May 2017 16:18:22 -0300
Message-Id: <20170511191843.13784-9-ehabkost@redhat.com>
In-Reply-To: <20170511191843.13784-1-ehabkost@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 08/29] hw/arm/virt: explicitly allocate
 cpu_index for cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Currently cpu_index is implicitly auto assigned during
cpu.realize() time cpu_exec_realizefn()->cpu_list_add().

It happens to match index in possible_cpus so take
control over it and make board initialize cpu_index
to possible_cpus index explicitly. It will at least
document that board is in control of it and when
'-device cpu' support comes it will keep cpu_index
stable regardless of order cpus are created so it won't
break migration.
Within this series it will be used for internal
conversion from storing cpu_index based NUMA node
bitmaps to property based mapping with possible_cpus,
And will allow map cpu_index to a CPU entry in
possible_cpus array.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-Id: <1493816238-33120-5-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/arm/virt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e2c5626c52..acc748ec40 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1349,6 +1349,7 @@ static void machvirt_init(MachineState *machine)
     possible_cpus = mc->possible_cpu_arch_ids(machine);
     for (n = 0; n < possible_cpus->len; n++) {
         Object *cpuobj;
+        CPUState *cs;
 
         if (n >= smp_cpus) {
             break;
@@ -1358,6 +1359,9 @@ static void machvirt_init(MachineState *machine)
         object_property_set_int(cpuobj, possible_cpus->cpus[n].arch_id,
                                 "mp-affinity", NULL);
 
+        cs = CPU(cpuobj);
+        cs->cpu_index = n;
+
         if (!vms->secure) {
             object_property_set_bool(cpuobj, false, "has_el3", NULL);
         }
-- 
2.11.0.259.g40922b1
