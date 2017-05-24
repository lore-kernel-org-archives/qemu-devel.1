Received: from eggs.gnu.org ([2001:4830:134:3::10]:37794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dDPbQ-0006JZ-1U
	for qemu-devel@nongnu.org; Wed, 24 May 2017 02:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dDPbM-0007A8-TJ
	for qemu-devel@nongnu.org; Wed, 24 May 2017 02:17:00 -0400
Message-ID: <1495606610.2305.0.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 24 May 2017 16:16:50 +1000
In-Reply-To: <1495601614-18586-4-git-send-email-bharata@linux.vnet.ibm.com>
References: <1495601614-18586-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1495601614-18586-4-git-send-email-bharata@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] spapr: Fix migration of Radix guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com

On Wed, 2017-05-24 at 10:23 +0530, Bharata B Rao wrote:
> Fix migration of radix guests by ensuring that we issue
> KVM_PPC_CONFIGURE_V3_MMU for radix case post migration.
> 
> Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

> ---
>  hw/ppc/spapr.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index daf335c..ea14bed 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1400,6 +1400,18 @@ static int spapr_post_load(void *opaque, int
> version_id)
>          err = spapr_rtc_import_offset(&spapr->rtc, spapr-
> >rtc_offset);
>      }
>  
> +    if (spapr->patb_entry) {
> +        PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
> +        bool radix = !!(spapr->patb_entry & PATBE1_GR);
> +        bool gtse = !!(cpu->env.spr[SPR_LPCR] & LPCR_GTSE);
> +
> +        err = kvmppc_configure_v3_mmu(cpu, radix, gtse, spapr-
> >patb_entry);
> +        if (err) {
> +            error_report("Process table config unsupported by the
> host");
> +            return -EINVAL;
> +        }
> +    }
> +
>      return err;
>  }
>  
