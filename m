Received: from eggs.gnu.org ([2001:4830:134:3::10]:40979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eqdfh-000128-Dr
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:43:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eqdfe-0003Dd-4U
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:43:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eqdfd-0003D4-Rl
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:43:46 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1RBe09N111694
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:43:43 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gd5t4jcx3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:43:42 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 27 Feb 2018 11:43:40 -0000
References: <20180227110255.20999-1-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 27 Feb 2018 12:43:35 +0100
MIME-Version: 1.0
In-Reply-To: <20180227110255.20999-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c676a19e-3800-27df-7731-c5406d4717ef@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] numa: we don't implement NUMA for s390x
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



On 02/27/2018 12:02 PM, David Hildenbrand wrote:
> Right now it is possible to crash QEMU for s390x by providing e.g.
>     -numa node,nodeid=0,cpus=0-1
> 
> Problem is, that numa.c uses mc->cpu_index_to_instance_props as an
> indicator whether NUMA is supported by a machine type. We don't
> implement NUMA for s390x ("topology") yet. However we need
> mc->cpu_index_to_instance_props for query-cpus.
> 
> So let's fix this case by also checking for mc->get_default_cpu_node_id,
> which will be needed by machine_set_cpu_numa_node().
> 
> qemu-system-s390x: -numa node,nodeid=0,cpus=0-1: NUMA is not supported by
>                    this machine-type
> 
> While at it, make s390_cpu_index_to_props() look like on other
> architectures.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>


> ---
>  hw/s390x/s390-virtio-ccw.c | 8 +++++---
>  numa.c                     | 2 +-
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 4abbe89847..1eff4a6274 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -388,12 +388,14 @@ static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
>      }
>  }
> 
> -static CpuInstanceProperties s390_cpu_index_to_props(MachineState *machine,
> +static CpuInstanceProperties s390_cpu_index_to_props(MachineState *ms,
>                                                       unsigned cpu_index)
>  {
> -    g_assert(machine->possible_cpus && cpu_index < machine->possible_cpus->len);
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
> 
> -    return machine->possible_cpus->cpus[cpu_index].props;
> +    assert(cpu_index < possible_cpus->len);
> +    return possible_cpus->cpus[cpu_index].props;
>  }
> 
>  static const CPUArchIdList *s390_possible_cpu_arch_ids(MachineState *ms)
> diff --git a/numa.c b/numa.c
> index 7e0e789b02..103b93f5cb 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -80,7 +80,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>          return;
>      }
> 
> -    if (!mc->cpu_index_to_instance_props) {
> +    if (!mc->cpu_index_to_instance_props || !mc->get_default_cpu_node_id) {
>          error_report("NUMA is not supported by this machine-type");
>          exit(1);
>      }
> 
