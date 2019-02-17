Received: from eggs.gnu.org ([209.51.188.92]:52668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWiE-0008Ds-OM
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWi9-0005dd-Pu
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:08 -0500
Date: Mon, 18 Feb 2019 10:39:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190217233941.GG2765@umbus.fritz.box>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023081817.1011724.14078777320394028836.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/i8j2F0k9BYX4qLc"
Content-Disposition: inline
In-Reply-To: <155023081817.1011724.14078777320394028836.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 06/10] xics: Explicitely call KVM ICS
 methods from the common code
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


--/i8j2F0k9BYX4qLc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 12:40:18PM +0100, Greg Kurz wrote:
> The pre_save(), post_load() and synchronize_state() methods of the
> ICSStateClass type are really KVM only things. Make that obvious
> by dropping the indirections and directly calling the KVM functions
> instead.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/intc/xics.c        |   23 ++++++++++-------------
>  hw/intc/xics_kvm.c    |   12 ++++--------
>  include/hw/ppc/xics.h |    7 ++++---
>  3 files changed, 18 insertions(+), 24 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index acd63ab5e0b9..ae5d5ea135b8 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -58,7 +58,6 @@ void icp_pic_print_info(ICPState *icp, Monitor *mon)
> =20
>  void ics_pic_print_info(ICSState *ics, Monitor *mon)
>  {
> -    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(ics);
>      uint32_t i;
> =20
>      monitor_printf(mon, "ICS %4x..%4x %p\n",
> @@ -68,8 +67,8 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)
>          return;
>      }
> =20
> -    if (icsc->synchronize_state) {
> -        icsc->synchronize_state(ics);
> +    if (kvm_irqchip_in_kernel()) {
> +        ics_synchronize_state(ics);
>      }
> =20
>      for (i =3D 0; i < ics->nr_irqs; i++) {
> @@ -647,25 +646,23 @@ static void ics_base_instance_init(Object *obj)
>      ics->offset =3D XICS_IRQ_BASE;
>  }
> =20
> -static int ics_base_dispatch_pre_save(void *opaque)
> +static int ics_base_pre_save(void *opaque)
>  {
>      ICSState *ics =3D opaque;
> -    ICSStateClass *info =3D ICS_BASE_GET_CLASS(ics);
> =20
> -    if (info->pre_save) {
> -        info->pre_save(ics);
> +    if (kvm_irqchip_in_kernel()) {
> +        ics_get_kvm_state(ics);
>      }
> =20
>      return 0;
>  }
> =20
> -static int ics_base_dispatch_post_load(void *opaque, int version_id)
> +static int ics_base_post_load(void *opaque, int version_id)
>  {
>      ICSState *ics =3D opaque;
> -    ICSStateClass *info =3D ICS_BASE_GET_CLASS(ics);
> =20
> -    if (info->post_load) {
> -        return info->post_load(ics, version_id);
> +    if (kvm_irqchip_in_kernel()) {
> +        return ics_set_kvm_state(ics);
>      }
> =20
>      return 0;
> @@ -689,8 +686,8 @@ static const VMStateDescription vmstate_ics_base =3D {
>      .name =3D "ics",
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
> -    .pre_save =3D ics_base_dispatch_pre_save,
> -    .post_load =3D ics_base_dispatch_post_load,
> +    .pre_save =3D ics_base_pre_save,
> +    .post_load =3D ics_base_post_load,
>      .fields =3D (VMStateField[]) {
>          /* Sanity check */
>          VMSTATE_UINT32_EQUAL(nr_irqs, ICSState, NULL),
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index fae4ac431f2f..642351e5790f 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -155,7 +155,7 @@ void icp_kvm_realize(DeviceState *dev, Error **errp)
>  /*
>   * ICS-KVM
>   */
> -static void ics_get_kvm_state(ICSState *ics)
> +void ics_get_kvm_state(ICSState *ics)
>  {
>      uint64_t state;
>      int i;
> @@ -208,12 +208,12 @@ static void ics_get_kvm_state(ICSState *ics)
>      }
>  }
> =20
> -static void ics_synchronize_state(ICSState *ics)
> +void ics_synchronize_state(ICSState *ics)
>  {
>      ics_get_kvm_state(ics);
>  }
> =20
> -static int ics_set_kvm_state(ICSState *ics, int version_id)
> +int ics_set_kvm_state(ICSState *ics)
>  {
>      uint64_t state;
>      int i;
> @@ -286,7 +286,7 @@ static void ics_kvm_reset(DeviceState *dev)
> =20
>      icsc->parent_reset(dev);
> =20
> -    ics_set_kvm_state(ICS_KVM(dev), 1);
> +    ics_set_kvm_state(ICS_KVM(dev));
>  }
> =20
>  static void ics_kvm_reset_handler(void *dev)
> @@ -318,10 +318,6 @@ static void ics_kvm_class_init(ObjectClass *klass, v=
oid *data)
>                                      &icsc->parent_realize);
>      device_class_set_parent_reset(dc, ics_kvm_reset,
>                                    &icsc->parent_reset);
> -
> -    icsc->pre_save =3D ics_get_kvm_state;
> -    icsc->post_load =3D ics_set_kvm_state;
> -    icsc->synchronize_state =3D ics_synchronize_state;
>  }
> =20
>  static const TypeInfo ics_kvm_info =3D {
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index fae54e6f28ae..06e87128f88e 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -109,12 +109,9 @@ struct ICSStateClass {
>      DeviceRealize parent_realize;
>      DeviceReset parent_reset;
> =20
> -    void (*pre_save)(ICSState *s);
> -    int (*post_load)(ICSState *s, int version_id);
>      void (*reject)(ICSState *s, uint32_t irq);
>      void (*resend)(ICSState *s);
>      void (*eoi)(ICSState *s, uint32_t irq);
> -    void (*synchronize_state)(ICSState *s);
>  };
> =20
>  struct ICSState {
> @@ -201,4 +198,8 @@ int icp_set_kvm_state(ICPState *icp);
>  void icp_synchronize_state(ICPState *icp);
>  void icp_kvm_realize(DeviceState *dev, Error **errp);
> =20
> +void ics_get_kvm_state(ICSState *ics);
> +int ics_set_kvm_state(ICSState *ics);
> +void ics_synchronize_state(ICSState *ics);
> +
>  #endif /* XICS_H */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/i8j2F0k9BYX4qLc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxp8LwACgkQbDjKyiDZ
s5JZlRAAtRzouoO22pz2tJVRuUMgPYhSPqWdDlHCt33t4B+6sQ3doruyF71k9F71
Qg3ATbUzog5vcgEzMiyRlqsc3jbhoI0NHV64xFBqxOr/FTLNl6HO4RUOJal+Kg50
XAOxkuuANcMeV6GviX268w7hVJ+TTiVyg9HMmzdMoOgOqLaFzG42ufXTHzVjaAgn
fSMZmreyTlcEGXq5kR3J31UXAvjybHU6jErZDE0oXOmz057jO7mnSGDIly+xHYaG
s/crOPcxTp8QKjLlKQwPL30kAyrVoEb9+BrMEgsqtAZQruuDFzPJ/RQcp9aiacA9
LsbCsr3Tm9KaGoAoo5kFbg043X1PUNUcV9e7BE3wMfweyO73h1GQe5f15Q4OcfMJ
uIsVT6BQFpzSSmkCO1+TkCXlSPuTxLm2o25c6DgEAFQKtmBP8evk+lp7xBQLZBN2
xfopSgYLqxdGExf5Zh0BEtdS0gGuBjTJasQR/NmRFpA0IqGwUZ6xGFnoStDMIgTU
mcL3cXQ+DdxxtetWok1pasMyTaFbbH6MtVYUthPlOrV4+gzUYsn9RMD4Pv99KMf0
guGWd0ChpixHG9PhL9RHg/rOPr103geiRljNpxMJac4V5uMFY5aW8P3E7dZ1mgYL
nxJEs1zxYXwJKVUnTHoLA+cRQ6es64CafPejsA11xscLxjwysy8=
=8L6j
-----END PGP SIGNATURE-----

--/i8j2F0k9BYX4qLc--
