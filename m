Received: from eggs.gnu.org ([2001:4830:134:3::10]:43939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dAEUj-0001wj-T0
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dAEUg-0006r7-Nq
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:48:57 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:51585)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dAEUg-0006qk-HZ
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:48:54 -0400
Received: from player699.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 205281FC38
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 13:48:53 +0200 (CEST)
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484837602.20089.6188552126304330653.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0eae3812-85d6-8619-2594-4a06727d74e6@kaod.org>
Date: Mon, 15 May 2017 13:48:47 +0200
MIME-Version: 1.0
In-Reply-To: <149484837602.20089.6188552126304330653.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] spapr: fix error reporting in
 xics_system_init()
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
> The xics_system_init() function passes its errp argument to xics_kvm_in=
it().
> If the call fails and the user requested in-kernel irqchip, it then end=
s up
> passing a NULL Error * to error_reportf_err() and the error message is
> silently dropped.
>=20
> Passing an errp argument is generally wrong, unless you really just nee=
d
> to convey an error to the caller.
>=20
> This patch converts xics_system_init() to *only* pass a pointer to its =
own
> Error * and then to propagate it with error_propagate(), as recommended
> in error.h.
>=20
> The local_err name is used for consistency with the rest of the code.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Thanks for the fix.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

C.

> ---
>  hw/ppc/spapr.c |   17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f477d7b8a210..44f7dc7f40e9 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -121,29 +121,32 @@ static ICSState *spapr_ics_create(sPAPRMachineSta=
te *spapr,
>  static void xics_system_init(MachineState *machine, int nr_irqs, Error=
 **errp)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> +    Error *local_err =3D NULL;
> =20
>      if (kvm_enabled()) {
> -        Error *err =3D NULL;
> -
>          if (machine_kernel_irqchip_allowed(machine) &&
> -            !xics_kvm_init(spapr, errp)) {
> +            !xics_kvm_init(spapr, &local_err)) {
>              spapr->icp_type =3D TYPE_KVM_ICP;
> -            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_ir=
qs, &err);
> +            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_ir=
qs,
> +                                          &local_err);
>          }
>          if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
> -            error_reportf_err(err,
> +            error_reportf_err(local_err,
>                                "kernel_irqchip requested but unavailabl=
e: ");
>              exit(EXIT_FAILURE);
>          } else {
> -            error_free(err);
> +            error_free(local_err);
>          }
>      }
> =20
>      if (!spapr->ics) {
>          xics_spapr_init(spapr);
>          spapr->icp_type =3D TYPE_ICP;
> -        spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irq=
s, errp);
> +        spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irq=
s,
> +                                      &local_err);
>      }
> +
> +    error_propagate(errp, local_err);
>  }
> =20
>  static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *c=
pu,
>=20
