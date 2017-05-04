Received: from eggs.gnu.org ([2001:4830:134:3::10]:50082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1d6Da3-0007Ds-MX
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1d6DZz-0004vp-RU
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:01:51 -0400
Date: Thu, 4 May 2017 12:01:35 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170504100135.hdqovueuwiiq2s5r@kamzik.brq.redhat.com>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-10-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493816238-33120-10-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 09/24] numa: add check that board
 supports cpu_index to node mapping
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

On Wed, May 03, 2017 at 02:57:03PM +0200, Igor Mammedov wrote:
> Default node mapping initialization already checks that board
> supports cpu_index to node mapping and refuses to start if
> it's not supported. Do the same for explicitly provided
> mapping "-numa node,cpus=..."
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  numa.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/numa.c b/numa.c
> index ab1661d..b517870 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -140,10 +140,12 @@ uint32_t numa_get_node(ram_addr_t addr, Error **errp)
>      return -1;
>  }
>  
> -static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
> +static void numa_node_parse(MachineState *ms, NumaNodeOptions *node,
> +                            QemuOpts *opts, Error **errp)
>  {
>      uint16_t nodenr;
>      uint16List *cpus = NULL;
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>  
>      if (node->has_nodeid) {
>          nodenr = node->nodeid;
> @@ -162,6 +164,10 @@ static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
>          return;
>      }
>  
> +    if (!mc->cpu_index_to_instance_props) {
> +        error_report("CPUs to NUMA node mapping isn't supported");
> +        exit(1);
> +    }
>      for (cpus = node->cpus; cpus; cpus = cpus->next) {
>          if (cpus->value >= max_cpus) {
>              error_setg(errp,
> @@ -215,6 +221,7 @@ static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
>  static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
>  {
>      NumaOptions *object = NULL;
> +    MachineState *ms = opaque;
>      Error *err = NULL;
>  
>      {
> @@ -229,7 +236,7 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
>  
>      switch (object->type) {
>      case NUMA_OPTIONS_TYPE_NODE:
> -        numa_node_parse(&object->u.node, opts, &err);
> +        numa_node_parse(ms, &object->u.node, opts, &err);
>          if (err) {
>              goto end;
>          }
> @@ -303,7 +310,7 @@ void parse_numa_opts(MachineState *ms)
>          numa_info[i].node_cpu = bitmap_new(max_cpus);
>      }
>  
> -    if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, NULL, NULL)) {
> +    if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, NULL)) {
>          exit(1);
>      }
>  
> -- 
> 2.7.4
>

With Eduardo's error message change

Reviewed-by: Andrew Jones <drjones@redhat.com>
