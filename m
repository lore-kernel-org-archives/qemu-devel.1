Received: from eggs.gnu.org ([2001:4830:134:3::10]:47037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1d6FCb-0005RH-Dj
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1d6FCX-0005Pf-Dd
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:45:45 -0400
Date: Thu, 4 May 2017 13:45:28 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170504114528.hegmpv62s3iteq7y@kamzik.brq.redhat.com>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-12-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493816238-33120-12-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 11/24] numa: do default mapping based on
 possible_cpus instead of node_cpu bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Wed, May 03, 2017 at 02:57:05PM +0200, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  numa.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/numa.c b/numa.c
> index 5ff1212..c7e3e0a 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -309,6 +309,7 @@ static void validate_numa_cpus(void)
>  void parse_numa_opts(MachineState *ms)
>  {
>      int i;
> +    const CPUArchIdList *possible_cpus;
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
>  
>      for (i = 0; i < MAX_NODES; i++) {
> @@ -379,11 +380,6 @@ void parse_numa_opts(MachineState *ms)
>  
>          numa_set_mem_ranges();
>  
> -        for (i = 0; i < nb_numa_nodes; i++) {
> -            if (!bitmap_empty(numa_info[i].node_cpu, max_cpus)) {
> -                break;
> -            }
> -        }
>          /* Historically VCPUs were assigned in round-robin order to NUMA
>           * nodes. However it causes issues with guest not handling it nice
>           * in case where cores/threads from a multicore CPU appear on
> @@ -391,11 +387,20 @@ void parse_numa_opts(MachineState *ms)
>           * rule grouping VCPUs by socket so that VCPUs from the same socket
>           * would be on the same node.
>           */
> -        if (!mc->cpu_index_to_instance_props) {
> +        if (!mc->cpu_index_to_instance_props || !mc->possible_cpu_arch_ids) {
>              error_report("default CPUs to NUMA node mapping isn't supported");
>              exit(1);
>          }
> -        if (i == nb_numa_nodes) {
> +
> +        possible_cpus = mc->possible_cpu_arch_ids(ms);
> +        for (i = 0; i < possible_cpus->len; i++) {
> +            if (possible_cpus->cpus[i].props.has_node_id) {
> +                break;
> +            }
> +        }
> +
> +        /* no CPUs are assigned to NUMA nodes */
> +        if (i == possible_cpus->len) {
>              for (i = 0; i < max_cpus; i++) {
>                  CpuInstanceProperties props;
>                  /* fetch default mapping from board and enable it */
> -- 
> 2.7.4
>

Reviewed-by: Andrew Jones <drjones@redhat.com> 
