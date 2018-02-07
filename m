Received: from eggs.gnu.org ([2001:4830:134:3::10]:40933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejUmw-0005YF-Ur
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejUms-0005Yv-VY
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:49:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40600 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ejUms-0005Yp-PZ
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:49:42 -0500
References: <20180207175014.11157-1-lcapitulino@redhat.com>
	<20180207175014.11157-2-lcapitulino@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ee002ca0-c634-7708-fbb9-800797cf9539@redhat.com>
Date: Wed, 7 Feb 2018 12:49:38 -0600
MIME-Version: 1.0
In-Reply-To: <20180207175014.11157-2-lcapitulino@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luiz Capitulino <lcapitulino@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, ehabkost@redhat.com, berrange@redhat.com, mihajlov@linux.vnet.ibm.com

On 02/07/2018 11:50 AM, Luiz Capitulino wrote:
> The query-cpus command has an extremely serious side effect:
> it always interrupt all running vCPUs so that they can run

s/interrupt/interrupts/

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
>   o Drop irrelevant fields such as "current", "pc" and "arch"
> 
>   o Rename some fields for better clarification & proper naming
>     standard
> 
> The "halted" field is somewhat controversial. On the one hand,
> it offers a convenient way to know if a guest CPU is idle or
> running. On the other hand, it's a field that can change many
> times a second. In fact, the halted state can change even
> before query-cpus-fast has returned. This makes one wonder if
> this field should be dropped all together. Having the "halted"
> field as optional gives a better option for dropping it in
> the future, since we can just stop returning it.

Makes sense to me.

> 
> Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> ---
>   cpus.c               | 44 ++++++++++++++++++++++++++++++++
>   hmp-commands-info.hx | 14 +++++++++++
>   hmp.c                | 24 ++++++++++++++++++
>   hmp.h                |  1 +
>   qapi-schema.json     | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 154 insertions(+)
> 

> +++ b/hmp-commands-info.hx
> @@ -157,6 +157,20 @@ STEXI
>   @item info cpus
>   @findex info cpus
>   Show infos for each CPU.

Pre-existing, but...

> +ETEXI
> +
> +    {
> +        .name       = "cpus_fast",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "show infos for each CPU without performance penalty",

...copied here.  s/infos/information/ in public-facing documentation, 
while we're touching it.


> +++ b/qapi-schema.json
> @@ -558,6 +558,77 @@
>   ##
>   { 'command': 'query-cpus', 'returns': ['CpuInfo'] }
>   
> +##
> +# @CpuInfo2:

Good thing that type names aren't part of our introspection ABI.  Would 
CpuInfoLite or CpuInfoFast make the code any more legible?

> +#
> +# Information about a virtual CPU
> +#
> +# @cpu-index: index of the virtual CPU
> +#
> +# @halted: true if the virtual CPU is in the halt state.  Halt usually refers
> +#          to a processor specific low power mode. This field is optional,
> +#          it is only present if the halted state can be retrieved without
> +#          a performance penalty

Disclaimer is good.

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
> +# Notes: @halted is a transient state that changes frequently.  By the time the
> +#        data is sent to the client, the guest may no longer be halted.
> +##
> +{ 'struct': 'CpuInfo2',
> +  'data': {'cpu-index': 'int', '*halted': 'bool', 'qom-path': 'str',
> +           'thread-id': 'int', '*props': 'CpuInstanceProperties' } }

Looks reasonable.

> +
> +##
> +# @query-cpus-fast:
> +#
> +# Returns information about all virtual CPUs. This command does not
> +# incur a performance penalty and should be used in production
> +# instead of query-cpus.
> +#
> +# Returns: list of @CpuInfo2
> +#
> +# Notes: The CPU architecture name is not returned by query-cpus-fast.
> +#        Use query-target to retreive that information.

s/retreive/retrieve/


> +##
> +{ 'command': 'query-cpus-fast', 'returns': [ 'CpuInfo2' ] }
> +

Also, please add some docs to 'query-cpus' pointing to 'query-cpus-fast'.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
