Received: from eggs.gnu.org ([2001:4830:134:3::10]:39593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dAvFV-0005II-Ur
	for qemu-devel@nongnu.org; Wed, 17 May 2017 05:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dAvFS-0001F5-LM
	for qemu-devel@nongnu.org; Wed, 17 May 2017 05:28:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dAvFS-0001Ex-Fe
	for qemu-devel@nongnu.org; Wed, 17 May 2017 05:28:02 -0400
Date: Wed, 17 May 2017 11:27:56 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170517112756.74cf6e47@nial.brq.redhat.com>
In-Reply-To: <1494972923-31756-1-git-send-email-anthony.xu@intel.com>
References: <1494972923-31756-1-git-send-email-anthony.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Memory: use memory address space for
 cpu-memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Xu <anthony.xu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Tue, 16 May 2017 15:15:23 -0700
Anthony Xu <anthony.xu@intel.com> wrote:

> If cpu-memory address space is same as memory address space,
> use memory address space for cpu-memory address space.
> 
> any memory region change causeaddress space to rebuild PhysPageMap,
> rebuilding PhysPageMap is very expensive.
> 
> removing cpu-memory address space reduces the guest boot time and
> memory usage.
> 
> Signed-off-by: Anthony Xu <anthony.xu@intel.com>
> ---
>  cpus.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/cpus.c b/cpus.c
> index 740b8dc..15c7a6a 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1748,8 +1748,13 @@ void qemu_init_vcpu(CPUState *cpu)
>          /* If the target cpu hasn't set up any address spaces itself,
>           * give it the default one.
>           */
> -        AddressSpace *as = address_space_init_shareable(cpu->memory,
> -                                                        "cpu-memory");
> +        AddressSpace *as;
> +        if (cpu->memory == address_space_memory.root) {
> +            address_space_memory.ref_count++;
probably this would cause reference leak when vcpu is destroyed

> +            as = &address_space_memory;
> +        } else {
> +            as = address_space_init_shareable(cpu->memory, "cpu-memory");
> +        }
>          cpu->num_ases = 1;
>          cpu_address_space_init(cpu, as, 0);
>      }
