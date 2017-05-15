Received: from eggs.gnu.org ([2001:4830:134:3::10]:44624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAGB5-0008JU-6t
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAGB2-0005tm-28
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:36:47 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484835694.20089.2114938170632779266.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6e1c2116-e7b5-083b-6eeb-87356f8e1996@amsat.org>
Date: Mon, 15 May 2017 10:36:40 -0300
MIME-Version: 1.0
In-Reply-To: <149484835694.20089.2114938170632779266.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/6] ppc/xics: simplify prototype of
 xics_spapr_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Cedric Le Goater <clg@kaod.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>

On 05/15/2017 08:39 AM, Greg Kurz wrote:
> This function only does hypercall and RTAS-call registration, and thus
> never returns an error. This patch adapt the prototype to reflect that.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/intc/xics_spapr.c  |    3 +--
>  hw/ppc/spapr.c        |    2 +-
>  include/hw/ppc/xics.h |    2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index f05308b897f2..d98ea8b13068 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -229,7 +229,7 @@ static void rtas_int_on(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
>
> -int xics_spapr_init(sPAPRMachineState *spapr, Error **errp)
> +void xics_spapr_init(sPAPRMachineState *spapr)
>  {
>      /* Registration of global state belongs into realize */
>      spapr_rtas_register(RTAS_IBM_SET_XIVE, "ibm,set-xive", rtas_set_xive);
> @@ -243,7 +243,6 @@ int xics_spapr_init(sPAPRMachineState *spapr, Error **errp)
>      spapr_register_hypercall(H_XIRR_X, h_xirr_x);
>      spapr_register_hypercall(H_EOI, h_eoi);
>      spapr_register_hypercall(H_IPOLL, h_ipoll);
> -    return 0;
>  }
>
>  #define ICS_IRQ_FREE(ics, srcno)   \
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1b7cadab0cdf..abfb99b71b7d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -139,7 +139,7 @@ static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
>      }
>
>      if (!spapr->ics) {
> -        xics_spapr_init(spapr, errp);
> +        xics_spapr_init(spapr);
>          spapr->icp_type = TYPE_ICP;
>          spapr->ics = spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs, errp);
>      }
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 05e6acbb3533..d6cb51f3ad5d 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -206,6 +206,6 @@ void icp_resend(ICPState *ss);
>  typedef struct sPAPRMachineState sPAPRMachineState;
>
>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
> -int xics_spapr_init(sPAPRMachineState *spapr, Error **errp);
> +void xics_spapr_init(sPAPRMachineState *spapr);
>
>  #endif /* XICS_H */
>
>
