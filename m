Received: from eggs.gnu.org ([2001:4830:134:3::10]:35597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXdlo-0000GV-Vn
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 22:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXdlk-0004my-Qv
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 22:31:52 -0400
Date: Tue, 26 Jun 2018 12:25:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180626022546.GA14434@umbus.fritz.box>
References: <20180625091718.18544-1-clg@kaod.org>
	<20180625091718.18544-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20180625091718.18544-4-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] ppx/xics: introduce a parent_reset
 in ICSStateClass
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


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2018 at 11:17:16AM +0200, C=E9dric Le Goater wrote:
> Just like for the realize handlers, this makes possible to move the
> common ICSState code of the reset handlers in the ics-base class.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  include/hw/ppc/xics.h |  1 +
>  hw/intc/xics.c        | 45 ++++++++++++++++++++++++++++++---------------
>  hw/intc/xics_kvm.c    | 26 ++++++++++----------------
>  3 files changed, 41 insertions(+), 31 deletions(-)
>=20
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 44e96e640070..6ac8a9392da6 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -116,6 +116,7 @@ struct ICSStateClass {
>      DeviceClass parent_class;
> =20
>      DeviceRealize parent_realize;
> +    DeviceReset parent_reset;
> =20
>      void (*pre_save)(ICSState *s);
>      int (*post_load)(ICSState *s, int version_id);
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 83340770f7c0..8cfe2231531e 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -537,23 +537,16 @@ static void ics_simple_eoi(ICSState *ics, uint32_t =
nr)
>      }
>  }
> =20
> -static void ics_simple_reset(void *dev)
> +static void ics_simple_reset(DeviceState *dev)
>  {
> -    ICSState *ics =3D ICS_SIMPLE(dev);
> -    int i;
> -    uint8_t flags[ics->nr_irqs];
> +    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(dev);
> =20
> -    for (i =3D 0; i < ics->nr_irqs; i++) {
> -        flags[i] =3D ics->irqs[i].flags;
> -    }
> -
> -    memset(ics->irqs, 0, sizeof(ICSIRQState) * ics->nr_irqs);
> +    icsc->parent_reset(dev);
> +}
> =20
> -    for (i =3D 0; i < ics->nr_irqs; i++) {
> -        ics->irqs[i].priority =3D 0xff;
> -        ics->irqs[i].saved_priority =3D 0xff;
> -        ics->irqs[i].flags =3D flags[i];
> -    }
> +static void ics_simple_reset_handler(void *dev)
> +{
> +    ics_simple_reset(dev);
>  }
> =20
>  static int ics_simple_dispatch_pre_save(void *opaque)
> @@ -625,7 +618,7 @@ static void ics_simple_realize(DeviceState *dev, Erro=
r **errp)
> =20
>      ics->qirqs =3D qemu_allocate_irqs(ics_simple_set_irq, ics, ics->nr_i=
rqs);
> =20
> -    qemu_register_reset(ics_simple_reset, ics);
> +    qemu_register_reset(ics_simple_reset_handler, ics);
>  }
> =20
>  static void ics_simple_class_init(ObjectClass *klass, void *data)
> @@ -635,6 +628,8 @@ static void ics_simple_class_init(ObjectClass *klass,=
 void *data)
> =20
>      device_class_set_parent_realize(dc, ics_simple_realize,
>                                      &isc->parent_realize);
> +    device_class_set_parent_reset(dc, ics_simple_reset,
> +                                  &isc->parent_reset);
> =20
>      dc->vmsd =3D &vmstate_ics_simple;
>      isc->reject =3D ics_simple_reject;
> @@ -650,6 +645,25 @@ static const TypeInfo ics_simple_info =3D {
>      .class_size =3D sizeof(ICSStateClass),
>  };
> =20
> +static void ics_base_reset(DeviceState *dev)
> +{
> +    ICSState *ics =3D ICS_BASE(dev);
> +    int i;
> +    uint8_t flags[ics->nr_irqs];
> +
> +    for (i =3D 0; i < ics->nr_irqs; i++) {
> +        flags[i] =3D ics->irqs[i].flags;
> +    }
> +
> +    memset(ics->irqs, 0, sizeof(ICSIRQState) * ics->nr_irqs);
> +
> +    for (i =3D 0; i < ics->nr_irqs; i++) {
> +        ics->irqs[i].priority =3D 0xff;
> +        ics->irqs[i].saved_priority =3D 0xff;
> +        ics->irqs[i].flags =3D flags[i];
> +    }
> +}
> +
>  static void ics_base_realize(DeviceState *dev, Error **errp)
>  {
>      ICSState *ics =3D ICS_BASE(dev);
> @@ -689,6 +703,7 @@ static void ics_base_class_init(ObjectClass *klass, v=
oid *data)
> =20
>      dc->realize =3D ics_base_realize;
>      dc->props =3D ics_base_properties;
> +    dc->reset =3D ics_base_reset;
>  }
> =20
>  static const TypeInfo ics_base_info =3D {
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 1f27eb497981..b314eb7d1607 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -324,25 +324,18 @@ static void ics_kvm_set_irq(void *opaque, int srcno=
, int val)
>      }
>  }
> =20
> -static void ics_kvm_reset(void *dev)
> +static void ics_kvm_reset(DeviceState *dev)
>  {
> -    ICSState *ics =3D ICS_SIMPLE(dev);
> -    int i;
> -    uint8_t flags[ics->nr_irqs];
> -
> -    for (i =3D 0; i < ics->nr_irqs; i++) {
> -        flags[i] =3D ics->irqs[i].flags;
> -    }
> +    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(dev);
> =20
> -    memset(ics->irqs, 0, sizeof(ICSIRQState) * ics->nr_irqs);
> +    icsc->parent_reset(dev);
> =20
> -    for (i =3D 0; i < ics->nr_irqs; i++) {
> -        ics->irqs[i].priority =3D 0xff;
> -        ics->irqs[i].saved_priority =3D 0xff;
> -        ics->irqs[i].flags =3D flags[i];
> -    }
> +    ics_set_kvm_state(ICS_KVM(dev), 1);
> +}
> =20
> -    ics_set_kvm_state(ics, 1);
> +static void ics_kvm_reset_handler(void *dev)
> +{
> +    ics_kvm_reset(dev);
>  }
> =20
>  static void ics_kvm_realize(DeviceState *dev, Error **errp)
> @@ -358,7 +351,7 @@ static void ics_kvm_realize(DeviceState *dev, Error *=
*errp)
>      }
>      ics->qirqs =3D qemu_allocate_irqs(ics_kvm_set_irq, ics, ics->nr_irqs=
);
> =20
> -    qemu_register_reset(ics_kvm_reset, ics);
> +    qemu_register_reset(ics_kvm_reset_handler, ics);
>  }
> =20
>  static void ics_kvm_class_init(ObjectClass *klass, void *data)
> @@ -371,6 +364,7 @@ static void ics_kvm_class_init(ObjectClass *klass, vo=
id *data)
>       * directly from ics-base and not from ics-simple anymore.
>       */
>      dc->realize =3D ics_kvm_realize;
> +    dc->reset =3D ics_kvm_reset;
> =20
>      icsc->pre_save =3D ics_get_kvm_state;
>      icsc->post_load =3D ics_set_kvm_state;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsxpCoACgkQbDjKyiDZ
s5I6mA//QpI0L9kxLgUxIrMo01YdYHp5DBv9dMdxj840Z2Pg845OrxQvQcAwI/7Q
unVjj7FbZuSu+JaOS8ED5CcHnILk5R2CufW7kwHjWDO70iZtqdUfK8nI3gdqkMY1
BTLRSYrJHAZxb88Jr1X2QL+B2bCLioqADHJpQmEr+QUhpG2/7C8Ciy+doIYj1NZt
6sSZzpHj8XpWyAYNEpMORz84pFjG9I0H/oDSH2awNny8/HUVyOyvPeJxYDPkVXZD
hduvYZIGruzWhbYYWDvcst9deoeeC/37oPMXs/xMUvIL48QmB1qzxYUv/LgIQD9W
epNo8NzpScA+R7hyNW9mpZTp1VDd8D6Lp+h3aKFmFclzvYbi9pBlSMJM/85L5gg2
9Ohp+ZQEWfsP+0qkb0a411DiX6I81VYd4Y8UaGWAsm4N5KR2pN6xxzQZiPiqSp9O
ox1cN23T2v9JhIokttAy1nzZeHxH8N9kvAe16y4pKF3lJxp43x9ToEve3YSuxEPI
7gk4YD4x9iQqkJPLfCVvrISV0Yss4oa+gsxi2t1Fir41OgEpfNV02ScKHH9+lGh/
L4dX8CdghJ5GdPTy8azEn6wGsj/BlrjRK3DbvlrLAYe/mzyCYgzMDXq9QzpvuiXd
sLNu5nizLh2HhrQpN3aTSJrBhAiHVy1pSXtz5S4YcTRsRILtQPg=
=6IEL
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
