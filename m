Received: from eggs.gnu.org ([2001:4830:134:3::10]:37230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqFtK-0005z2-IO
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 05:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqFtG-0006mf-IT
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 05:20:18 -0500
Date: Mon, 26 Feb 2018 11:19:53 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180226111953.1e9bc50c.cohuck@redhat.com>
In-Reply-To: <20180223173657.29125-1-david@redhat.com>
References: <20180223173657.29125-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] numa: s390x has no NUMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Fri, 23 Feb 2018 18:36:57 +0100
David Hildenbrand <david@redhat.com> wrote:

> Right now it is possible to crash QEMU for s390x by providing e.g.
>     -numa node,nodeid=0,cpus=0-1
> 
> Problem is, that numa.c uses mc->cpu_index_to_instance_props as an
> indicator whether NUMA is supported by a machine type. We don't
> implement NUMA on s390x (and that concept also doesn't really exist).
> We need mc->cpu_index_to_instance_props for query-cpus.

Is existence of cpu_index_to_instance_probs the correct indicator for
numa, then?

OTOH, your patch is straightforward...

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
