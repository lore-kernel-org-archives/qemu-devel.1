Received: from eggs.gnu.org ([2001:4830:134:3::10]:51212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fp2ED-0004Mj-0N
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fp2E9-0002E3-Rc
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:05:04 -0400
Date: Mon, 13 Aug 2018 12:02:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180813020211.GJ4079@umbus>
References: <20180810080026.19398-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="enLffk0M6cffIOOh"
Content-Disposition: inline
In-Reply-To: <20180810080026.19398-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: factorize the use of
 SPAPR_MACHINE_GET_CLASS()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>


--enLffk0M6cffIOOh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2018 at 10:00:26AM +0200, C=E9dric Le Goater wrote:
> It should save us some CPU cycles as these routines perform a lot of
> checks.

I don't think any of these is particularly fastpath, but sure, applied
to ppc-for-3.1.

>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/spapr_pci.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 3791ced6c536..5cd676e4430d 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -267,6 +267,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
>                                  target_ulong args, uint32_t nret,
>                                  target_ulong rets)
>  {
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>      uint32_t config_addr =3D rtas_ld(args, 0);
>      uint64_t buid =3D rtas_ldq(args, 1);
>      unsigned int func =3D rtas_ld(args, 3);
> @@ -334,7 +335,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
>              return;
>          }
> =20
> -        if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> +        if (!smc->legacy_irq_allocation) {
>              spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
>          }
>          spapr_irq_free(spapr, msi->first_irq, msi->num);
> @@ -375,7 +376,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
>      }
> =20
>      /* Allocate MSIs */
> -    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> +    if (smc->legacy_irq_allocation) {
>          irq =3D spapr_irq_find(spapr, req_num, ret_intr_type =3D=3D RTAS=
_TYPE_MSI,
>                               &err);
>      } else {
> @@ -401,7 +402,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
> =20
>      /* Release previous MSIs */
>      if (msi) {
> -        if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> +        if (!smc->legacy_irq_allocation) {
>              spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
>          }
>          spapr_irq_free(spapr, msi->first_irq, msi->num);
> @@ -1558,6 +1559,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>      sPAPRMachineState *spapr =3D
>          (sPAPRMachineState *) object_dynamic_cast(qdev_get_machine(),
>                                                    TYPE_SPAPR_MACHINE);
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>      SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
>      sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(s);
>      PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
> @@ -1575,7 +1577,6 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>      }
> =20
>      if (sphb->index !=3D (uint32_t)-1) {
> -        sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>          Error *local_err =3D NULL;
> =20
>          smc->phb_placement(spapr, sphb->index,
> @@ -1720,7 +1721,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>          uint32_t irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS =
+ i;
>          Error *local_err =3D NULL;
> =20
> -        if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> +        if (smc->legacy_irq_allocation) {
>              irq =3D spapr_irq_findone(spapr, &local_err);
>              if (local_err) {
>                  error_propagate(errp, local_err);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--enLffk0M6cffIOOh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltw5qMACgkQbDjKyiDZ
s5LURA/+O23wcBWMskzD5QKF4sCpL48au3CmYMLA1+qVLU6BIei1FaT98D9BBLea
z00qMIIthIhUQBDrG30DOSKraqZAIdjNSE9fweC9KO0KM3ocQBcBd8uq3yJD7Rxu
MiwH2jzk2Xep07RyYVx9/7oPmNQpneEs5pJv5KS65jx5JuSWOT5EOafT5S5/FmmW
sUqUuSaVc/BOsVdNux3flrQaTj4+bDirbZ9WAgBV0e0EVFwUln87hUyOsvluhvGR
bKPDKSGADeOG7h4pZ4MYj7a4/0KoM0zeEn3ITE1UEvgGle2HyvjpasrL8XxIy/zM
x/84EXYdQ2AhViPZNFvVrJJNYFGog7943quN0g6tEoZlm1IXKmkcVUxfZf/jP4Pd
7zU4XJD1D8v908gTttl4h38xxzmDCE4H+xQC+r0Mb3vMbN5HMR6CuvIoGy4olJe0
KK6yt9hrGMM4CLmHCEExKzcK2QwvdIIYqOTE9MK3oigHSNAXufXmbAKWMFGPlaI7
SglsloMmbZm1EC36I08GhiE/cwBZEorsx4d89gCBYe6mRyjqmFNaUvJwgA66vuj6
mRMgtgN0PxZC55KeU/YwuBB7KNJ5my13ZKFPsj9hpqmTcylLvo4pfDXzhVNt7hQX
hUjLL7l6+zDUgpCJjFGuuhddPJ6SJErm0VgxRpZp4G66Sns71Tw=
=lYiF
-----END PGP SIGNATURE-----

--enLffk0M6cffIOOh--
