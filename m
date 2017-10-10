Received: from eggs.gnu.org ([2001:4830:134:3::10]:39730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1e1v4s-0007zu-9w
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:00:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1e1v4i-0001tt-O9
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:00:10 -0400
References: <20171010132159.15787-1-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <0639ec04-a340-4d8b-995f-249b6dd93cf6@redhat.com>
Date: Tue, 10 Oct 2017 15:59:51 +0200
MIME-Version: 1.0
In-Reply-To: <20171010132159.15787-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: Correct RAM size calculation for
 HPT resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org, clg@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 10/10/2017 15:21, David Gibson wrote:
> In order to prevent the guest from forcing the allocation of large amounts
> of qemu memory (or host kernel memory, in the case of KVM HV), we limit
> the size of Hashed Page Table (HPT) it is allowed to allocated, based on
> its RAM size.
> 
> However, the current calculation is not correct: it only adds up the size
> of plugged memory, ignoring the base memory size.  This patch corrects it.
> 
> While we're there, use get_plugged_memory_size() instead of directly
> calling pc_existing_dimms_capacity().  The only difference is that it
> will abort on failure, which is right: a failure here indicates something
> wrong within qemu.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_hcall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 8d72bb7c1c..06af1b15c0 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -494,7 +494,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
>          return H_PARAMETER;
>      }
>  
> -    current_ram_size = pc_existing_dimms_capacity(&error_fatal);
> +    current_ram_size = ram_size + get_plugged_memory_size();
>  
>      /* We only allow the guest to allocate an HPT one order above what
>       * we'd normally give them (to stop a small guest claiming a huge
> 

According to the content of qmp_query_memory_size_summary(), it's the
good way to compute the memory size...

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
