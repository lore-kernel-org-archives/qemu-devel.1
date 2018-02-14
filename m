Received: from eggs.gnu.org ([2001:4830:134:3::10]:53648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1em31Q-0000RU-IB
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:47:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1em31M-00075f-2N
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:47:16 -0500
References: <1518542328-25741-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518542328-25741-3-git-send-email-mihajlov@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5d3cae28-9b13-3570-0be4-44de64102647@redhat.com>
Date: Wed, 14 Feb 2018 13:46:54 -0600
MIME-Version: 1.0
In-Reply-To: <1518542328-25741-3-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 2/3] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, cohuck@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On 02/13/2018 11:18 AM, Viktor Mihajlovski wrote:
> From: Luiz Capitulino <lcapitulino@redhat.com>
> 
> The query-cpus command has an extremely serious side effect:
> it always interrupts all running vCPUs so that they can run
> ioctl calls. This can cause a huge performance degradation for
> some workloads. And most of the information retrieved by the
> ioctl calls are not even used by query-cpus.
> 
> This commit introduces a replacement for query-cpus called
> query-cpus-fast, which has the following features:
> 
>   o Never interrupt vCPUs threads. query-cpus-fast only returns
>     vCPU information maintained by QEMU itself, which should be
>     sufficient for most management software needs
> 
>   o Make "halted" field optional: we only return it if the
>     halted state is maintained by QEMU. But this also gives
>     the option of dropping the field in the future (see below)
> 
>   o Drop irrelevant fields such as "current", "pc", "arch"
>     and "halted"
> 

Others have pointed out the commit message inconsistencies; I'm focusing 
on the QMP.

> +++ b/qapi-schema.json
> @@ -552,6 +552,12 @@
>   #
>   # Returns a list of information about each virtual CPU.
>   #
> +# This command causes vCPU threads to exit to userspace, which causes
> +# an small interruption guest CPU execution. This will have a negative

s/an small interruption/a small interruption to/

> +# impact on realtime guests and other latency sensitive guest workloads.
> +# It is recommended to use @query-cpus-fast instead of this command to
> +# avoid the vCPU interruption.
> +#
>   # Returns: a list of @CpuInfo for each virtual CPU
>   #
>   # Since: 0.14.0
> @@ -585,6 +591,70 @@
>   { 'command': 'query-cpus', 'returns': ['CpuInfo'] }
>   
>   ##
> +# @CpuInfoFast:
> +#
> +# Information about a virtual CPU
> +#
> +# @cpu-index: index of the virtual CPU
> +#
> +# @qom-path: path to the CPU object in the QOM tree
> +#
> +# @thread-id: ID of the underlying host thread
> +#
> +# @props: properties describing to which node/socket/core/thread
> +#         virtual CPU belongs to, provided if supported by board
> +#
> +# Since: 2.12
> +#
> +##
> +{ 'struct': 'CpuInfoFast',
> +  'data': {'cpu-index': 'int', 'qom-path': 'str',
> +           'thread-id': 'int', '*props': 'CpuInstanceProperties' } }

Comparing against the existing CpuInfo: if I'm not mistaken, you've renamed:

CPU -> cpu-index
qom_path -> qom-path
thread_id -> thread-id

and kept props unchanged.

If we REALLY cared about reducing duplication, we can do:

{ 'struct': 'CpuInfoFast',
   'data': { 'CPU': 'int', 'qom_path': 'str', 'thread_id': 'int',
             '*props': 'CpuInstanceProperties' } }
{ 'struct': 'CpuInfoBase',
   'base': 'CpuInfoFast',
   'data': { 'current': 'bool', 'halted': 'bool',
             'arch': 'CpuInfoArch' } }
{ 'union': 'CpuInfo', 'base': 'CpuInfoBase', 'discriminator': 'arch',
   'data': { ... } }

but I'm not yet convinced whether we need that.  If we're going to 
deprecate the old command, having the new command use modern spelling is 
a nice change, even though it costs some duplication in the qapi file; 
where sharing code may save qapi costs in the short run, but will burden 
us with poor naming down the road even when we delete the slow command.

> +
> +##
> +# @query-cpus-fast:
> +#
> +# Returns information about all virtual CPUs. This command does not
> +# incur a performance penalty and should be used in production
> +# instead of query-cpus.
> +#
> +# Returns: list of @CpuInfoFast
> +#
> +# Notes: The CPU architecture name is not returned by query-cpus-fast.
> +#        Use query-target to retrieve that information.
> +#
> +# Since: 2.12

> +{ 'command': 'query-cpus-fast', 'returns': [ 'CpuInfoFast' ] }
> +
> +##
>   # @IOThreadInfo:
>   #
>   # Information about an iothread
> 

I didn't inspect the code, so similar to 1/3, once you fix the grammar 
nit and commit message,

Acked-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
