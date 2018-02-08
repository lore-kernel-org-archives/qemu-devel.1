Received: from eggs.gnu.org ([2001:4830:134:3::10]:42096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejsMU-000184-AV
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:00:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejsMQ-0002S0-5G
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:00:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ejsMP-0002RG-Rs
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:59:58 -0500
Date: Thu, 8 Feb 2018 17:59:39 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180208195939.GJ13301@localhost.localdomain>
References: <20180207175014.11157-1-lcapitulino@redhat.com>
	<20180207175014.11157-2-lcapitulino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207175014.11157-2-lcapitulino@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luiz Capitulino <lcapitulino@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com, berrange@redhat.com, mihajlov@linux.vnet.ibm.com

On Wed, Feb 07, 2018 at 12:50:13PM -0500, Luiz Capitulino wrote:
> The query-cpus command has an extremely serious side effect:
> it always interrupt all running vCPUs so that they can run
> ioctl calls. This can cause a huge performance degradation for
> some workloads. And most of the information retrieved by the
> ioctl calls are not even used by query-cpus.
> 
> This commit introduces a replacement for query-cpus called
> query-cpus-fast, which has the following features:
> 
>  o Never interrupt vCPUs threads. query-cpus-fast only returns
>    vCPU information maintained by QEMU itself, which should be
>    sufficient for most management software needs
> 
>  o Make "halted" field optional: we only return it if the
>    halted state is maintained by QEMU. But this also gives
>    the option of dropping the field in the future (see below)
> 
>  o Drop irrelevant fields such as "current", "pc" and "arch"
> 
>  o Rename some fields for better clarification & proper naming
>    standard
> 
> The "halted" field is somewhat controversial. On the one hand,
> it offers a convenient way to know if a guest CPU is idle or
> running. On the other hand, it's a field that can change many
> times a second. In fact, the halted state can change even
> before query-cpus-fast has returned. This makes one wonder if
> this field should be dropped all together. Having the "halted"
> field as optional gives a better option for dropping it in
> the future, since we can just stop returning it.
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
[...]
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 5c06745c79..82d6f12b53 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -558,6 +558,77 @@
>  ##
>  { 'command': 'query-cpus', 'returns': ['CpuInfo'] }
>  
> +##
> +# @CpuInfo2:
> +#
> +# Information about a virtual CPU
> +#
> +# @cpu-index: index of the virtual CPU
> +#
> +# @halted: true if the virtual CPU is in the halt state.  Halt usually refers
> +#          to a processor specific low power mode. This field is optional,
> +#          it is only present if the halted state can be retrieved without
> +#          a performance penalty
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

This will require duplicating struct fields every time we add a
new field to query-cpus-fast (e.g. how would VIktor's
CpuInfoS390State patch[1] look like if rebased on top of yours?).

One way to avoid that is to use CpuInfo for both, and make all
"slow"  fields optional.  Another option is to use QAPI
inheritance, but it could be a little complicated if unions are
involved?

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02032.html

-- 
Eduardo
