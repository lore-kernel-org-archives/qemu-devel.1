Received: from eggs.gnu.org ([2001:4830:134:3::10]:49789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dAEon-0003BO-HI
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dAEok-0007fZ-Bd
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:09:41 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:58517)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dAEok-0007f2-5D
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:09:38 -0400
Received: from player699.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id C21831FC3B
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 14:09:36 +0200 (CEST)
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484835694.20089.2114938170632779266.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <50d58e97-3b23-80fa-8c53-047198ee5cc2@kaod.org>
Date: Mon, 15 May 2017 14:09:31 +0200
MIME-Version: 1.0
In-Reply-To: <149484835694.20089.2114938170632779266.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

On 05/15/2017 01:39 PM, Greg Kurz wrote:
> This function only does hypercall and RTAS-call registration, and thus
> never returns an error. This patch adapt the prototype to reflect that.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/intc/xics_spapr.c  |    3 +--
>  hw/ppc/spapr.c        |    2 +-
>  include/hw/ppc/xics.h |    2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index f05308b897f2..d98ea8b13068 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -229,7 +229,7 @@ static void rtas_int_on(PowerPCCPU *cpu, sPAPRMachi=
neState *spapr,
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> =20
> -int xics_spapr_init(sPAPRMachineState *spapr, Error **errp)
> +void xics_spapr_init(sPAPRMachineState *spapr)
>  {
>      /* Registration of global state belongs into realize */
>      spapr_rtas_register(RTAS_IBM_SET_XIVE, "ibm,set-xive", rtas_set_xi=
ve);
> @@ -243,7 +243,6 @@ int xics_spapr_init(sPAPRMachineState *spapr, Error=
 **errp)
>      spapr_register_hypercall(H_XIRR_X, h_xirr_x);
>      spapr_register_hypercall(H_EOI, h_eoi);
>      spapr_register_hypercall(H_IPOLL, h_ipoll);
> -    return 0;
>  }
> =20
>  #define ICS_IRQ_FREE(ics, srcno)   \
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1b7cadab0cdf..abfb99b71b7d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -139,7 +139,7 @@ static void xics_system_init(MachineState *machine,=
 int nr_irqs, Error **errp)
>      }
> =20
>      if (!spapr->ics) {
> -        xics_spapr_init(spapr, errp);
> +        xics_spapr_init(spapr);
>          spapr->icp_type =3D TYPE_ICP;
>          spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irq=
s, errp);
>      }
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 05e6acbb3533..d6cb51f3ad5d 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -206,6 +206,6 @@ void icp_resend(ICPState *ss);
>  typedef struct sPAPRMachineState sPAPRMachineState;
> =20
>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
> -int xics_spapr_init(sPAPRMachineState *spapr, Error **errp);
> +void xics_spapr_init(sPAPRMachineState *spapr);
> =20
>  #endif /* XICS_H */
>=20
