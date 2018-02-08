Received: from eggs.gnu.org ([2001:4830:134:3::10]:40677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1ejpIa-0003pl-HU
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1ejpIW-0007wO-Js
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:43:48 -0500
Date: Thu, 8 Feb 2018 11:22:16 -0500
From: Luiz Capitulino <lcapitulino@redhat.com>
Message-ID: <20180208112216.0c4b6f3c@redhat.com>
In-Reply-To: <2b9e79d9-9c13-3edc-38f4-80062824e0b6@linux.vnet.ibm.com>
References: <1518083288-20410-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180208090904.5a9c88df@redhat.com>
	<20180208162126.3426623b.cohuck@redhat.com>
	<20180208103024.35d962c9@redhat.com>
	<2b9e79d9-9c13-3edc-38f4-80062824e0b6@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Eric Blake <eblake@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu, 8 Feb 2018 16:52:28 +0100
Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:

> diff --git a/qapi-schema.json b/qapi-schema.json
> index 12c7dc8..0b36860 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -607,7 +607,27 @@
>  ##
>  { 'struct': 'CpuInfo2',
>    'data': {'cpu-index': 'int', '*halted': 'bool', 'qom-path': 'str',
> -           'thread-id': 'int', '*props': 'CpuInstanceProperties' } }
> +           'thread-id': 'int', '*props': 'CpuInstanceProperties',
> +           '*archdata': 'CpuInfoArchData' } }
> +
> +##
> +# @CpuInfoArchData:
> +#
> +# Architecure specific information about a virtual CPU
> +#
> +# Since: 2.12
> +#
> +##
> +{ 'union': 'CpuInfoArchData',
> +  'base': { 'arch': 'CpuInfoArch' },
> +  'discriminator': 'arch',
> +  'data': { 'x86': 'CpuInfoOther',
> +            'sparc': 'CpuInfoOther',
> +            'ppc': 'CpuInfoOther',
> +            'mips': 'CpuInfoOther',
> +            'tricore': 'CpuInfoOther',
> +            's390': 'CpuInfoS390',
> +            'other': 'CpuInfoOther' } }
>  
>  ##
>  # @query-cpus-fast:

I don't think you need CpuInfoArchData, you can have S390CpuState
instead and ignore the other archs. It's not like all archs data
can be returned at the same time, and also you start having to
replicate that arch string list everywhere. Lastly, the arch name
is returned by query-target, so no need to duplicate that one either.
