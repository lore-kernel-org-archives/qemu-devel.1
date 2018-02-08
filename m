Received: from eggs.gnu.org ([2001:4830:134:3::10]:49209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejnzO-0000rL-45
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:19:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejnzK-0004ro-1A
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:19:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37030 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ejnzJ-0004rc-SS
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:19:49 -0500
References: <1518083288-20410-1-git-send-email-mihajlov@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3e34d51f-e4d1-a69b-1fac-c4d1982834c2@redhat.com>
Date: Thu, 8 Feb 2018 09:19:41 -0600
MIME-Version: 1.0
In-Reply-To: <1518083288-20410-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] S390: Expose s390-specific CPU info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 02/08/2018 03:48 AM, Viktor Mihajlovski wrote:
> Presently s390x is the only architecture not exposing specific
> CPU information via QMP query-cpus. Upstream discussion has shown
> that it could make sense to report the architecture specific CPU
> state, e.g. to detect that a CPU has been stopped.
> 
> With this change the output of query-cpus will look like this on
> s390:
> 
>      [{"arch": "s390", "current": true,
>        "props": {"core-id": 0}, "cpu_state": "operating", "CPU": 0,
>        "qom_path": "/machine/unattached/device[0]",
>        "halted": false, "thread_id": 63115},
>       {"arch": "s390", "current": false,
>        "props": {"core-id": 1}, "cpu_state": "stopped", "CPU": 1,
>        "qom_path": "/machine/unattached/device[1]",
>        "halted": true, "thread_id": 63116}]
> 
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> ---

> +++ b/qapi-schema.json
> @@ -413,7 +413,7 @@
>   # Since: 2.6
>   ##
>   { 'enum': 'CpuInfoArch',
> -  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 'other' ] }
> +  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 's390', 'other' ] }

Missing a documentation line that mentions when the enum grew. Also, has 
a conflict with this other proposed addition, which demonstrates what 
the documentation should look like (should be easy to resolve, though):
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg01986.html


>   ##
> +# @CpuInfoS390State:
> +#
> +# An enumeration of cpu states that can be assumed by a virtual
> +# S390 CPU
> +#
> +# Since: 2.12
> +##
> +{ 'enum': 'CpuInfoS390State',
> +  'data': [ 'uninitialized', 'stopped', 'check_stop', 'operating', 'load' ] }
> +

Is there a consistency reason for naming this 'check_stop', or can we go 
with our preference for using dash 'check-stop'?

> +##
> +# @CpuInfoS390:
> +#
> +# Additional information about a virtual S390 CPU
> +#
> +# @cpu_state: the CPUs state
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'CpuInfoS390', 'data': { 'cpu_state': 'CpuInfoS390State' } }

Likewise for 'cpu-state'

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
