Received: from eggs.gnu.org ([2001:4830:134:3::10]:40354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzuI-0005O3-GM
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzuH-00061p-A2
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:04:46 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  8 Mar 2018 19:04:17 +0100
Message-Id: <20180308180423.941-6-cohuck@redhat.com>
In-Reply-To: <20180308180423.941-1-cohuck@redhat.com>
References: <20180308180423.941-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 05/11] numa: we don't implement NUMA for s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Right now it is possible to crash QEMU for s390x by providing e.g.
    -numa node,nodeid=0,cpus=0-1

Problem is, that numa.c uses mc->cpu_index_to_instance_props as an
indicator whether NUMA is supported by a machine type. We don't
implement NUMA for s390x ("topology") yet. However we need
mc->cpu_index_to_instance_props for query-cpus.

So let's fix this case by also checking for mc->get_default_cpu_node_id,
which will be needed by machine_set_cpu_numa_node().

qemu-system-s390x: -numa node,nodeid=0,cpus=0-1: NUMA is not supported by
                   this machine-type

While at it, make s390_cpu_index_to_props() look like on other
architectures.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180227110255.20999-1-david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 8 +++++---
 numa.c                     | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 8726b4c281..f82270401b 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -390,12 +390,14 @@ static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
     }
 }
 
-static CpuInstanceProperties s390_cpu_index_to_props(MachineState *machine,
+static CpuInstanceProperties s390_cpu_index_to_props(MachineState *ms,
                                                      unsigned cpu_index)
 {
-    g_assert(machine->possible_cpus && cpu_index < machine->possible_cpus->len);
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
 
-    return machine->possible_cpus->cpus[cpu_index].props;
+    assert(cpu_index < possible_cpus->len);
+    return possible_cpus->cpus[cpu_index].props;
 }
 
 static const CPUArchIdList *s390_possible_cpu_arch_ids(MachineState *ms)
diff --git a/numa.c b/numa.c
index 5d7529c1d9..398e2c9a85 100644
--- a/numa.c
+++ b/numa.c
@@ -80,7 +80,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
         return;
     }
 
-    if (!mc->cpu_index_to_instance_props) {
+    if (!mc->cpu_index_to_instance_props || !mc->get_default_cpu_node_id) {
         error_report("NUMA is not supported by this machine-type");
         exit(1);
     }
-- 
2.13.6
