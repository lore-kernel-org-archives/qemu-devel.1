Received: from eggs.gnu.org ([2001:4830:134:3::10]:51228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5vy7-0004w4-Fu
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5vy6-0002uz-Ih
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:13:31 -0400
Date: Wed, 3 May 2017 12:13:21 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170503151321.GP3482@thinpad.lan.raisama.net>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-6-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493816238-33120-6-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 05/24] numa: move source of default CPUs
 to NUMA node mapping into boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Wed, May 03, 2017 at 02:56:59PM +0200, Igor Mammedov wrote:
[...]
> diff --git a/numa.c b/numa.c
> index 6fc2393..ab1661d 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -294,9 +294,10 @@ static void validate_numa_cpus(void)
>      g_free(seen_cpus);
>  }
>  
> -void parse_numa_opts(MachineClass *mc)
> +void parse_numa_opts(MachineState *ms)
>  {
>      int i;
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>  
>      for (i = 0; i < MAX_NODES; i++) {
>          numa_info[i].node_cpu = bitmap_new(max_cpus);
> @@ -378,14 +379,16 @@ void parse_numa_opts(MachineClass *mc)


Expanding diff context:

>          /* Historically VCPUs were assigned in round-robin order to NUMA
>           * nodes. However it causes issues with guest not handling it nice
>           * in case where cores/threads from a multicore CPU appear on
>           * different nodes. So allow boards to override default distribution
>           * rule grouping VCPUs by socket so that VCPUs from the same socket
>           * would be on the same node.
>           */

The above comment looks obsolete, as we are removing the code inside
parse_numa_opts() that deals with grouping VCPUs by socket.

(Can be fixed by a follow-up patch, if necessary.)

> +        if (!mc->cpu_index_to_instance_props) {
> +            error_report("default CPUs to NUMA node mapping isn't supported");
> +            exit(1);
> +        }
>          if (i == nb_numa_nodes) {
>              for (i = 0; i < max_cpus; i++) {
> -                unsigned node_id = i % nb_numa_nodes;
> -                if (mc->cpu_index_to_socket_id) {
> -                    node_id = mc->cpu_index_to_socket_id(i) % nb_numa_nodes;
> -                }
> +                CpuInstanceProperties props;
> +                props = mc->cpu_index_to_instance_props(ms, i);
>  
> -                set_bit(i, numa_info[node_id].node_cpu);
> +                set_bit(i, numa_info[props.node_id].node_cpu);
>              }
>          }
>  
[...]

-- 
Eduardo
