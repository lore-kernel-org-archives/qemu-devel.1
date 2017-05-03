Received: from eggs.gnu.org ([2001:4830:134:3::10]:39295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d5tqd-00082y-AG
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d5tqc-0000dX-JT
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:57:39 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed,  3 May 2017 14:56:58 +0200
Message-Id: <1493816238-33120-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/24] hw/arm/virt: explicitly allocate
 cpu_index for cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

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
---
 hw/arm/virt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e2c5626..acc748e 100644
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
2.7.4
