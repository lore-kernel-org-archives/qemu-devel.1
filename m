Received: from eggs.gnu.org ([2001:4830:134:3::10]:47996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5xFo-00019d-BR
	for qemu-devel@nongnu.org; Wed, 03 May 2017 12:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5xFn-00008O-C6
	for qemu-devel@nongnu.org; Wed, 03 May 2017 12:35:52 -0400
Date: Wed, 3 May 2017 13:35:43 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170503163543.GR3482@thinpad.lan.raisama.net>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-24-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493816238-33120-24-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 23/24] numa: add '-numa cpu,
 ...' option for property based node mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On Wed, May 03, 2017 at 02:57:17PM +0200, Igor Mammedov wrote:
[...]
> diff --git a/numa.c b/numa.c
> index 40e9f44..61521f5 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -227,6 +227,7 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
>      NumaOptions *object = NULL;
>      MachineState *ms = opaque;
>      Error *err = NULL;
> +    CpuInstanceProperties cpu;
>  
>      {
>          Visitor *v = opts_visitor_new(opts);
> @@ -246,6 +247,30 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
>          }
>          nb_numa_nodes++;
>          break;
> +    case NUMA_OPTIONS_TYPE_CPU:
> +        if (!object->u.cpu.has_node_id) {
> +            error_setg(&err, "Missing mandatory node-id property");
> +            goto end;
> +        }
> +        if (!numa_info[object->u.cpu.node_id].present) {
> +            error_setg(&err, "Invalid node-id=%" PRId64 ", NUMA node must be "
> +                "defined with -numa node,nodeid=ID before it's used with "
> +                "-numa cpu,node-id=ID", object->u.cpu.node_id);
> +            goto end;
> +        }
> +
> +        memset(&cpu, 0, sizeof(cpu));
> +        cpu.has_node_id = object->u.cpu.has_node_id;
> +        cpu.node_id = object->u.cpu.node_id;
> +        cpu.has_socket_id = object->u.cpu.has_socket_id;
> +        cpu.socket_id = object->u.cpu.socket_id;
> +        cpu.has_core_id = object->u.cpu.has_core_id;
> +        cpu.core_id = object->u.cpu.core_id;
> +        cpu.has_thread_id = object->u.cpu.has_thread_id;
> +        cpu.thread_id = object->u.cpu.thread_id;

We don't have a way to avoid copying each field individually?
Some visitor trick, maybe?

Eric, Markus, Michael, do you have any suggestions?

> +
> +        machine_set_cpu_numa_node(ms, &cpu, &err);
> +        break;
>      default:
>          abort();
>      }
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 76d137d..5baf3a4 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -5680,10 +5680,12 @@
>  ##
>  # @NumaOptionsType:
>  #
> +# @cpu: property based CPU(s) to node mapping (Since: 2.10)
> +#
>  # Since: 2.1
>  ##
>  { 'enum': 'NumaOptionsType',
> -  'data': [ 'node' ] }
> +  'data': [ 'node', 'cpu' ] }
>  
>  ##
>  # @NumaOptions:
> @@ -5696,7 +5698,8 @@
>    'base': { 'type': 'NumaOptionsType' },
>    'discriminator': 'type',
>    'data': {
> -    'node': 'NumaNodeOptions' }}
> +    'node': 'NumaNodeOptions',
> +    'cpu': 'NumaCpuOptions' }}
>  
>  ##
>  # @NumaNodeOptions:
> @@ -5725,6 +5728,20 @@
>     '*memdev': 'str' }}
>  
>  ##
> +# @NumaCpuOptions:
> +#
> +# Option "-numa cpu" overrides default cpu to node mapping.
> +# It accepts the same set of cpu properties as returned by
> +# query-hotpluggable-cpus[].props, where node-id could be used to
> +# override default node mapping.
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'NumaCpuOptions',
> +   'base': 'CpuInstanceProperties',
> +   'data' : {} }
> +
> +##
>  # @HostMemPolicy:
>  #
>  # Host memory policy types
[...]

-- 
Eduardo
