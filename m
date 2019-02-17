Received: from eggs.gnu.org ([209.51.188.92]:52601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWiA-0008Bj-K6
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWi9-0005d2-Dk
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:06 -0500
Date: Mon, 18 Feb 2019 10:43:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190217234355.GI2765@umbus.fritz.box>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023082996.1011724.16237920586343905010.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r4QXMf6/kyF/FvJJ"
Content-Disposition: inline
In-Reply-To: <155023082996.1011724.16237920586343905010.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 08/10] xics: Handle KVM interrupt
 presentation from "simple" ICS code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--r4QXMf6/kyF/FvJJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 12:40:30PM +0100, Greg Kurz wrote:
> We want to use the "simple" ICS type in both KVM and non-KVM setups.
> Teach the "simple" ICS how to present interrupts to KVM and adapt
> sPAPR accordingly.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

As C=E9dric points out, not strictly required to accomplish the series'
goals, but I think it's a nice cleanup, so applied.

> ---
>  hw/intc/xics.c        |    5 +++++
>  hw/intc/xics_kvm.c    |    3 +--
>  hw/ppc/spapr_irq.c    |    7 +------
>  include/hw/ppc/xics.h |    2 +-
>  4 files changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 49401745c410..3009fa747277 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -466,6 +466,11 @@ void ics_simple_set_irq(void *opaque, int srcno, int=
 val)
>  {
>      ICSState *ics =3D (ICSState *)opaque;
> =20
> +    if (kvm_irqchip_in_kernel()) {
> +        ics_kvm_set_irq(ics, srcno, val);
> +        return;
> +    }
> +
>      if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
>          ics_simple_set_irq_lsi(ics, srcno, val);
>      } else {
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index e7b8d4c29ce6..f34eacda03e7 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -259,9 +259,8 @@ int ics_set_kvm_state(ICSState *ics)
>      return 0;
>  }
> =20
> -void ics_kvm_set_irq(void *opaque, int srcno, int val)
> +void ics_kvm_set_irq(ICSState *ics, int srcno, int val)
>  {
> -    ICSState *ics =3D opaque;
>      struct kvm_irq_level args;
>      int rc;
> =20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index e6893df61e76..9f43b7b3bf16 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -222,13 +222,8 @@ static int spapr_irq_post_load_xics(sPAPRMachineStat=
e *spapr, int version_id)
>  static void spapr_irq_set_irq_xics(void *opaque, int srcno, int val)
>  {
>      sPAPRMachineState *spapr =3D opaque;
> -    MachineState *machine =3D MACHINE(opaque);
> =20
> -    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
> -        ics_kvm_set_irq(spapr->ics, srcno, val);
> -    } else {
> -        ics_simple_set_irq(spapr->ics, srcno, val);
> -    }
> +    ics_simple_set_irq(spapr->ics, srcno, val);
>  }
> =20
>  static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **errp)
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 06e87128f88e..61bd0fb9784f 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -180,7 +180,6 @@ void icp_eoi(ICPState *icp, uint32_t xirr);
>  void ics_simple_write_xive(ICSState *ics, int nr, int server,
>                             uint8_t priority, uint8_t saved_priority);
>  void ics_simple_set_irq(void *opaque, int srcno, int val);
> -void ics_kvm_set_irq(void *opaque, int srcno, int val);
> =20
>  void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
>  void icp_pic_print_info(ICPState *icp, Monitor *mon);
> @@ -201,5 +200,6 @@ void icp_kvm_realize(DeviceState *dev, Error **errp);
>  void ics_get_kvm_state(ICSState *ics);
>  int ics_set_kvm_state(ICSState *ics);
>  void ics_synchronize_state(ICSState *ics);
> +void ics_kvm_set_irq(ICSState *ics, int srcno, int val);
> =20
>  #endif /* XICS_H */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--r4QXMf6/kyF/FvJJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxp8bsACgkQbDjKyiDZ
s5Jy4g//Qnn5mUWgoX0DFMtjtIfUyTAz8TWSucaA9jOQls0BkeTY3l/XfDmoOEhE
7uKcbhUy1LsfBIdUU+dVSaDSjaNLjjaa4uDSuRy6yjD4Ng2ZYpijZk9vxEasA9pT
Y6K00uMn0u0L1oCFB0alGOnn1pXFQbD258b0/n3tx5HCUWGrXQsi+8p7aFV2U/6B
EWbQg12rBLtSIuDHt/+iXOE7KghMXHBg2BxJnNO/D5manD/DItQCeF+SjawewJ8k
g9f1vkE9GkCdMWJceJYmPurqujQJB5eW7smIXlvLuB49UUs7Pf/X0LM83GQTrSX5
aV4eQe2zRhswCfHSLulS396wwbJXS25ch1mAUYmO7RRnH0LvNdbjR01GnEj6yuk3
0XD+zhGrY2lio41VuxBCawJedwpf9lBQEsCHeMi2Hw+Xr2leWiTuwT6OZgxUnRbJ
WofUiNV/5BkcQd2FeOIxNL5O844UN8RTzpfDrVXetg4XB/tTa9+Wsh4lh7TtznZB
wEKvAd+sOUngECXkZd7d4aXgcKFJyCW22SlbcRsrQwRhU1cemkU+5r7jnWK3SEYz
q0dbgB5nkbgHwRvh7E+J3DTNjzPvy4zPp1QsmOXRLnBk/+ZH4C52314qYSnBwXM5
zzWquqI/M+QIVlWbC73POVrS4cZc03C5DUTg2gSex9OOO8A9BT0=
=JRQ2
-----END PGP SIGNATURE-----

--r4QXMf6/kyF/FvJJ--
