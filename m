Received: from eggs.gnu.org ([2001:4830:134:3::10]:55458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1em3AW-00080i-8Q
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1em3AS-0004hv-9L
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:56:40 -0500
References: <1518542328-25741-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518542328-25741-4-git-send-email-mihajlov@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <47587888-f952-1f94-bd2b-98da282f32f1@redhat.com>
Date: Wed, 14 Feb 2018 13:56:17 -0600
MIME-Version: 1.0
In-Reply-To: <1518542328-25741-4-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 3/3] qmp: add architecture specific cpu
 data for query-cpus-fast
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
> The s390 CPU state can be retrieved without interrupting the
> VM execution. Extendend the CpuInfoFast union with architecture

s/Extendend/Extend/

> specific data and an implementation for s390.
> 
> Return data looks like this:
>   [
>     {"thread-id":64301,"props":{"core-id":0},
>      "arch":"s390","cpu-state":"operating",
>      "qom-path":"/machine/unattached/device[0]","cpu-index":0},
>     {"thread-id":64302,"props":{"core-id":1},
>      "arch":"s390","cpu-state":"operating",
>      "qom-path":"/machine/unattached/device[1]","cpu-index":1}
> ]
> 
> Currently there's a certain amount of duplication between
> the definitions of CpuInfo and CpuInfoFast, both in the
> base and variable areas, since there are data fields common
> to the slow and fast variants.

Even with the difference in spelling that I pointed out in 2/3?

> 
> A suggestion was made on the mailing list to enhance the QAPI
> code generation to support two layers of unions. This would
> allow to specify the common fields once and avoid the duplication
> in the leaf unions.
> 
> On the other hand, the slow query-cpus should be deprecated
> along with the slow CpuInfo type and eventually be removed.
> Assuming that new architectures will not be added at high
> rates, we could live with the duplication for the time being.

Yes, this part is true.

> 
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> ---
>   cpus.c           | 10 ++++++++++
>   hmp.c            | 10 ++++++++++
>   qapi-schema.json | 35 +++++++++++++++++++++++++++++------
>   3 files changed, 49 insertions(+), 6 deletions(-)
> 

> +++ b/qapi-schema.json
> @@ -537,15 +537,26 @@
>     'data': [ 'uninitialized', 'stopped', 'check-stop', 'operating', 'load' ] }
>   
>   ##
> -# @CpuInfoS390:
> +# @CpuInfoS390Fast:
>   #
> -# Additional information about a virtual S390 CPU
> +# Additional information about a virtual S390 CPU which can be
> +# obtained without a performance penalty for a running VM
>   #
>   # @cpu-state: the virtual CPU's state
>   #
>   # Since: 2.12
>   ##
> -{ 'struct': 'CpuInfoS390', 'data': { 'cpu-state': 'CpuS390State' } }
> +{ 'struct': 'CpuInfoS390Fast', 'data': { 'cpu-state': 'CpuS390State' } }
> +
> +##
> +# @CpuInfoS390:
> +#
> +# Additional information about a virtual S390 CPU, potentially expensive
> +# to obtain
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'CpuInfoS390', 'base': 'CpuInfoS390Fast', 'data': { } }

This part works - but since you aren't adding any further fields, what 
is the point in having two type names?  Why not just document that 
CpuInfoS390 is always fast, whether used in CpuInfoFast or in the slower 
CpuInfo?  It's not like we get any additional compile-time safety by 
inventing a new type.

>   
>   ##
>   # @query-cpus:
> @@ -604,12 +615,24 @@
>   # @props: properties describing to which node/socket/core/thread
>   #         virtual CPU belongs to, provided if supported by board
>   #
> +# @arch: architecture of the cpu, which determines which additional fields
> +#        will be listed

Doing this leaves a stale comment in query-cpus-fast that the arch name 
is not provided; you'll need to delete that comment if this patch goes in.

> +#
>   # Since: 2.12
>   #
>   ##
> -{ 'struct': 'CpuInfoFast',
> -  'data': {'cpu-index': 'int', 'qom-path': 'str',
> -           'thread-id': 'int', '*props': 'CpuInstanceProperties' } }
> +{ 'union': 'CpuInfoFast',
> +  'base': {'cpu-index': 'int', 'qom-path': 'str',
> +           'thread-id': 'int', '*props': 'CpuInstanceProperties',
> +           'arch': 'CpuInfoArch' },
> +  'discriminator': 'arch',
> +  'data': { 'x86': 'CpuInfoOther',
> +            'sparc': 'CpuInfoOther',
> +            'ppc': 'CpuInfoOther',
> +            'mips': 'CpuInfoOther',
> +            'tricore': 'CpuInfoOther',
> +            's390': 'CpuInfoS390Fast',
> +            'other': 'CpuInfoOther' } }

CpuInfoOther is an empty class, so it works as a placeholder for all 
other arches without having the dichotomy like the 
CpuInfoS390/CpuInfoS390Fast split.

At any rate, whether or not you merge the two CpuInfoS390 type into one, 
converting CpuInfoFast into a union (and NOT trying to inherit between 
the slow type with different field names and the new fast type) seems 
reasonable, if libvirt really wants to keep using cpu-info-fast to learn 
whether S390 vcpus are halted.

>   ##
>   # @query-cpus-fast:

So, if you fix the stale comment here, a v3 patch can have
Acked-by: Eric Blake <eblake@redhat.com>

I also think your v3 series should touch qemu-doc.texi to start the 
deprecation timeframe.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
