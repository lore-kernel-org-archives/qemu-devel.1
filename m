Received: from eggs.gnu.org ([2001:4830:134:3::10]:34870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drlu6-0005kj-8k
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drlu2-0001sP-7p
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:11:06 -0400
References: <20170912140149.7692-1-lvivier@redhat.com>
	<20170912140149.7692-2-lvivier@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <01253a14-2254-dc47-c4ac-dbcb87bfd5ad@redhat.com>
Date: Tue, 12 Sep 2017 16:10:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170912140149.7692-2-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] hmp: fix "dump-quest-memory"
 segfault (ppc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>

On 12.09.2017 16:01, Laurent Vivier wrote:
> Running QEMU with
>     qemu-system-ppc64 -M none -nographic -m 256
> and executing
>     dump-guest-memory /dev/null 0 8192
> results in segfault
> 
> Fix by checking if we have CPU, and exit with
> error if there is no CPU:
> 
>     (qemu) dump-guest-memory /dev/null
>     this feature or command is not currently supported
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  target/ppc/arch_dump.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
> index 8e9397aa58..95b9ab6f29 100644
> --- a/target/ppc/arch_dump.c
> +++ b/target/ppc/arch_dump.c
> @@ -224,8 +224,15 @@ typedef struct NoteFuncDescStruct NoteFuncDesc;
>  int cpu_get_dump_info(ArchDumpInfo *info,
>                        const struct GuestPhysBlockList *guest_phys_blocks)
>  {
> -    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
> -    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
> +    PowerPCCPU *cpu;
> +    PowerPCCPUClass *pcc;
> +
> +    if (first_cpu == NULL) {
> +        return -1;
> +    }
> +
> +    cpu = POWERPC_CPU(first_cpu);
> +    pcc = POWERPC_CPU_GET_CLASS(cpu);
>  
>      info->d_machine = PPC_ELF_MACHINE;
>      info->d_class = ELFCLASS;
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
