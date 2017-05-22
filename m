Received: from eggs.gnu.org ([2001:4830:134:3::10]:36721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dCgrt-0007HK-Bl
	for qemu-devel@nongnu.org; Mon, 22 May 2017 02:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dCgrq-0000fq-0l
	for qemu-devel@nongnu.org; Mon, 22 May 2017 02:31:01 -0400
Message-ID: <1495434650.2205.1.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Mon, 22 May 2017 16:30:50 +1000
In-Reply-To: <1495172439-1504-5-git-send-email-bharata@linux.vnet.ibm.com>
References: <1495172439-1504-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1495172439-1504-5-git-send-email-bharata@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH v2 4/4] spapr: Fix migration
 of Radix guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: rnsastry@linux.vnet.ibm.com, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, david@gibson.dropbear.id.au

On Fri, 2017-05-19 at 11:10 +0530, Bharata B Rao wrote:
> Fix migration of radix guests by ensuring that we issue
> KVM_PPC_CONFIGURE_V3_MMU for radix case post migration.
> 
> Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index daf335c..8f20f14 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1400,6 +1400,18 @@ static int spapr_post_load(void *opaque, int
> version_id)
>          err = spapr_rtc_import_offset(&spapr->rtc, spapr-
> >rtc_offset);
>      }

This will break migration for tcg radix guests.

Given that there is essentially nothing special we need to do on
incoming tcg migration, I suggest we make it:

if (spapr->patb_entry && kvm_enabled()) {
    [snip]
}

>  
> +    if (spapr->patb_entry) {
> +        PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
> +        if (kvmppc_has_cap_mmu_radix() && kvm_enabled()) {

Why not make this a bit more generic? Something like:

err = kvmppc_configure_v3_mmu(cpu, !!(spapr->patb_entry & PATBE1_GR),
!!(cpu->env.spr[SPR_LPCR] & LPCR_GTSE), spapr->patb_entry);
if (err) {
    error_report("Process table config unsupported by the host");
    return -EINVAL;
}

return err;

While I don't think it's possible currently, there is nothing
inherently incorrect about having a non-zero process table entry for a
hash guest. And this saves a future update.

> +            err = kvmppc_configure_v3_mmu(cpu,
> SPAPR_PROC_TABLE_RADIX,
> +                ((cpu->env.spr[SPR_LPCR] & LPCR_GTSE) ?
> SPAPR_PROC_TABLE_GTSE :
> +                0), spapr->patb_entry);
> +        } else {
> +            error_report("Radix guest is unsupported by the host");
> +            return -EINVAL;
> +        }
> +    }
> +
>      return err;
>  }
>  
