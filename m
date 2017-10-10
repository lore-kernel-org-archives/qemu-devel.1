Received: from eggs.gnu.org ([2001:4830:134:3::10]:56129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e1vm1-0006yM-5C
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e1vlx-0003Xn-UU
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:44:45 -0400
Received: from 17.mo4.mail-out.ovh.net ([46.105.41.16]:38805)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e1vlx-0003XN-Nv
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:44:41 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 1CFACDB4D6
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:44:39 +0200 (CEST)
Date: Tue, 10 Oct 2017 16:44:31 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171010164431.168777e9@bahia.lan>
In-Reply-To: <20171010132159.15787-1-david@gibson.dropbear.id.au>
References: <20171010132159.15787-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Wed, 11 Oct 2017 00:21:59 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

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

current_ram_size is initialized earlier in this function:

    uint64_t current_ram_size = MACHINE(spapr)->ram_size;

which is is initialized to ram_size in vl.c. Why not doing:

    current_ram_size += get_plugged_memory_size();

?

>  
>      /* We only allow the guest to allocate an HPT one order above what
>       * we'd normally give them (to stop a small guest claiming a huge
