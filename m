Received: from eggs.gnu.org ([2001:4830:134:3::10]:53854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eqExi-0005Xq-3C
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:20:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eqExe-000641-3L
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:20:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42656
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eqExd-00063N-TY
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:20:42 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1Q9KREj042062
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 04:20:40 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gcew3hk30-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 04:20:40 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 26 Feb 2018 09:20:38 -0000
References: <20180223173657.29125-1-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 26 Feb 2018 10:20:34 +0100
MIME-Version: 1.0
In-Reply-To: <20180223173657.29125-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <afa4789f-8377-f033-00c8-35821a872178@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1] numa: s390x has no NUMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>



On 02/23/2018 06:36 PM, David Hildenbrand wrote:
> Right now it is possible to crash QEMU for s390x by providing e.g.
>     -numa node,nodeid=0,cpus=0-1
> 
> Problem is, that numa.c uses mc->cpu_index_to_instance_props as an
> indicator whether NUMA is supported by a machine type. We don't
> implement NUMA on s390x (and that concept also doesn't really exist).
> We need mc->cpu_index_to_instance_props for query-cpus.

Looks like we assert because of 
machine->possible_cpus == 0.

Later during boot this is created in s390_possible_cpu_arch_ids. (via 
s390_init_cpus). What we (in the future) actually could provide is a 
cpu topology.

So something like this also fixes the bug

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index fd5bfcdaa5..d981335ca9 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "sysemu/numa.h"
 #include "hw/boards.h"
 #include "exec/address-spaces.h"
 #include "hw/s390x/s390-virtio-hcall.h"
@@ -393,11 +394,20 @@ static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
 static CpuInstanceProperties s390_cpu_index_to_props(MachineState *machine,
                                                      unsigned cpu_index)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+
+    /* make sure possible_cpu are intialized */
+    mc->possible_cpu_arch_ids(machine);
     g_assert(machine->possible_cpus && cpu_index < machine->possible_cpus->len);
 
     return machine->possible_cpus->cpus[cpu_index].props;
 }
 
+static int64_t s390_get_default_cpu_node_id(const MachineState *ms, int idx)
+{
+    return idx / smp_cpus % nb_numa_nodes;
+}
+
 static const CPUArchIdList *s390_possible_cpu_arch_ids(MachineState *ms)
 {
     int i;
@@ -473,6 +483,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     mc->get_hotplug_handler = s390_get_hotplug_handler;
     mc->cpu_index_to_instance_props = s390_cpu_index_to_props;
     mc->possible_cpu_arch_ids = s390_possible_cpu_arch_ids;
+    mc->get_default_cpu_node_id = s390_get_default_cpu_node_id;
     /* it is overridden with 'host' cpu *in kvm_arch_init* */
     mc->default_cpu_type = S390_CPU_TYPE_NAME("qemu");
     hc->plug = s390_machine_device_plug;


and it would allow us to extend things later on. On the other hand, my fix does not
implement anything so your fix is "more correct".

> 
> So let's fix this case.
> 
> qemu-system-s390x: -numa node,nodeid=0,cpus=0-1: NUMA is not supported by
>                    this machine-type
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  numa.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/numa.c b/numa.c
> index 7e0e789b02..3b9be613d9 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -80,10 +80,16 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>          return;
>      }
> 
> +#ifdef TARGET_S390X
> +    /* s390x provides cpu_index_to_instance_props but has no NUMA */
> +    error_report("NUMA is not supported by this machine-type");
> +    exit(1);
> +#else
>      if (!mc->cpu_index_to_instance_props) {
>          error_report("NUMA is not supported by this machine-type");
>          exit(1);
>      }
> +#endif
>      for (cpus = node->cpus; cpus; cpus = cpus->next) {
>          CpuInstanceProperties props;
>          if (cpus->value >= max_cpus) {
> 
