Received: from eggs.gnu.org ([2001:4830:134:3::10]:35502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXdlm-0000FE-1P
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 22:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXdlk-0004n4-Rg
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 22:31:50 -0400
Date: Tue, 26 Jun 2018 12:30:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180626023042.GB14434@umbus.fritz.box>
References: <20180625091718.18544-1-clg@kaod.org>
	<20180625091718.18544-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: <20180625091718.18544-5-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 4/5] ppc/xics: move the vmstate
 structures under the ics-base class
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


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2018 at 11:17:17AM +0200, C=E9dric Le Goater wrote:
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  hw/intc/xics.c | 112 ++++++++++++++++++++++++++++-----------------------=
------
>  1 file changed, 56 insertions(+), 56 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 8cfe2231531e..b9f1a3c97214 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -549,61 +549,6 @@ static void ics_simple_reset_handler(void *dev)
>      ics_simple_reset(dev);
>  }
> =20
> -static int ics_simple_dispatch_pre_save(void *opaque)
> -{
> -    ICSState *ics =3D opaque;
> -    ICSStateClass *info =3D ICS_BASE_GET_CLASS(ics);
> -
> -    if (info->pre_save) {
> -        info->pre_save(ics);
> -    }
> -
> -    return 0;
> -}
> -
> -static int ics_simple_dispatch_post_load(void *opaque, int version_id)
> -{
> -    ICSState *ics =3D opaque;
> -    ICSStateClass *info =3D ICS_BASE_GET_CLASS(ics);
> -
> -    if (info->post_load) {
> -        return info->post_load(ics, version_id);
> -    }
> -
> -    return 0;
> -}
> -
> -static const VMStateDescription vmstate_ics_simple_irq =3D {
> -    .name =3D "ics/irq",
> -    .version_id =3D 2,
> -    .minimum_version_id =3D 1,
> -    .fields =3D (VMStateField[]) {
> -        VMSTATE_UINT32(server, ICSIRQState),
> -        VMSTATE_UINT8(priority, ICSIRQState),
> -        VMSTATE_UINT8(saved_priority, ICSIRQState),
> -        VMSTATE_UINT8(status, ICSIRQState),
> -        VMSTATE_UINT8(flags, ICSIRQState),
> -        VMSTATE_END_OF_LIST()
> -    },
> -};
> -
> -static const VMStateDescription vmstate_ics_simple =3D {
> -    .name =3D "ics",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> -    .pre_save =3D ics_simple_dispatch_pre_save,
> -    .post_load =3D ics_simple_dispatch_post_load,
> -    .fields =3D (VMStateField[]) {
> -        /* Sanity check */
> -        VMSTATE_UINT32_EQUAL(nr_irqs, ICSState, NULL),
> -
> -        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(irqs, ICSState, nr_irqs,
> -                                             vmstate_ics_simple_irq,
> -                                             ICSIRQState),
> -        VMSTATE_END_OF_LIST()
> -    },
> -};
> -
>  static void ics_simple_realize(DeviceState *dev, Error **errp)
>  {
>      ICSState *ics =3D ICS_SIMPLE(dev);
> @@ -631,7 +576,6 @@ static void ics_simple_class_init(ObjectClass *klass,=
 void *data)
>      device_class_set_parent_reset(dc, ics_simple_reset,
>                                    &isc->parent_reset);
> =20
> -    dc->vmsd =3D &vmstate_ics_simple;
>      isc->reject =3D ics_simple_reject;
>      isc->resend =3D ics_simple_resend;
>      isc->eoi =3D ics_simple_eoi;
> @@ -692,6 +636,61 @@ static void ics_base_instance_init(Object *obj)
>      ics->offset =3D XICS_IRQ_BASE;
>  }
> =20
> +static int ics_base_dispatch_pre_save(void *opaque)
> +{
> +    ICSState *ics =3D opaque;
> +    ICSStateClass *info =3D ICS_BASE_GET_CLASS(ics);
> +
> +    if (info->pre_save) {
> +        info->pre_save(ics);
> +    }
> +
> +    return 0;
> +}
> +
> +static int ics_base_dispatch_post_load(void *opaque, int version_id)
> +{
> +    ICSState *ics =3D opaque;
> +    ICSStateClass *info =3D ICS_BASE_GET_CLASS(ics);
> +
> +    if (info->post_load) {
> +        return info->post_load(ics, version_id);
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_ics_base_irq =3D {
> +    .name =3D "ics/irq",
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(server, ICSIRQState),
> +        VMSTATE_UINT8(priority, ICSIRQState),
> +        VMSTATE_UINT8(saved_priority, ICSIRQState),
> +        VMSTATE_UINT8(status, ICSIRQState),
> +        VMSTATE_UINT8(flags, ICSIRQState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static const VMStateDescription vmstate_ics_base =3D {
> +    .name =3D "ics",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .pre_save =3D ics_base_dispatch_pre_save,
> +    .post_load =3D ics_base_dispatch_post_load,
> +    .fields =3D (VMStateField[]) {
> +        /* Sanity check */
> +        VMSTATE_UINT32_EQUAL(nr_irqs, ICSState, NULL),
> +
> +        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(irqs, ICSState, nr_irqs,
> +                                             vmstate_ics_base_irq,
> +                                             ICSIRQState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static Property ics_base_properties[] =3D {
>      DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
>      DEFINE_PROP_END_OF_LIST(),
> @@ -704,6 +703,7 @@ static void ics_base_class_init(ObjectClass *klass, v=
oid *data)
>      dc->realize =3D ics_base_realize;
>      dc->props =3D ics_base_properties;
>      dc->reset =3D ics_base_reset;
> +    dc->vmsd =3D &vmstate_ics_base;
>  }
> =20
>  static const TypeInfo ics_base_info =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsxpVIACgkQbDjKyiDZ
s5JvYg/+Kj5+h9+HIvD9frYUhw8/v7nAwJK5EBi64lYBrebt9WGV7bpX3/1Pp++T
/RalkqM4SQVtpS1VGcDTLgm3oV37R5o0kAyQJprf1wW800+gukViTZmdgocD8/Le
wPgSlHqaVjHQ6+QZNUuQBfAmG2d4+zaWdIhjL/BHgVbJelSN69IDzG6430XrcA+x
bObxsHGmW1QRqEwe9mxwOjUkrCbi8zwwDLL6On+uJioya7kW3y6bHxWH4uz4+PVk
k1jlIH6p2xt2fXnwpOXJszZJM9T/G8NeQzEsjmdwyDTf272YDwQoSXxiHfu70EA+
bNZNDs5FOTNcz7X+VoJsFg52MK1VIEgPPrM9i4jFqbweROVD5ruaQzdXougKje4v
5VkzAGr84mmNQVAXzF9EtcYdOLtd+cP6Uw1SEZSVdDr5o5q6Mc9nAGSlvZFq0hEc
ATClzmbId+f+Ln0uOIrKod7d9VSL0uh9Rr0TjcWF4YCIcAFMG1M79e6ITANYBG9I
ZzTlKZaYwXMOjLv6vc2EWqWNGmg5YQWn3a7tnBCiq4fAo/ACx1KwVQWi7nNEjKeS
fRckCBieHU+DM1xDaGZM9zU5RDn3MtuXm51b9z0RrMV0CORrcocOdtq7tlaWDv3N
qqt7/sUQCHTUD+1oACFkQdIg7Y10GqR8HIM8PFLsD7WYd9oOYNk=
=mFcu
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
