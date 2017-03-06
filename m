Received: from eggs.gnu.org ([2001:4830:134:3::10]:59597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cki5G-0005g2-TK
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 21:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cki5D-0006xI-Ii
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 21:09:10 -0500
Date: Mon, 6 Mar 2017 12:51:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170306015134.GD12030@umbus.fritz.box>
References: <1488545463-19776-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
In-Reply-To: <1488545463-19776-1-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] ppc/xics: register reset handlers for the
 ICP and ICS objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2017 at 01:51:03PM +0100, C=E9dric Le Goater wrote:
1;4601;0c> The recent changes on the XICS layer removed the XICSState objec=
t to
> let the sPAPR machine handle the ICP and ICS directly. The reset of
> these objects was previously handled by XICSState, which was a SysBus
> device, and to keep the same behavior, the ICP and ICS were assigned
> to SysbBus.
>=20
> But that broke the 'info qtree' command in the monitor. 'qtree'
> performs a loop on the children of a bus to print their properties and
> SysBus devices are expected to be found under SysBus, which is not the
> case anymore.
>=20
> The fix for this problem is to register reset handlers for the ICP and
> ICS objects and stop using SysBus for such devices.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-2.9, thanks.

> ---
>  hw/intc/xics.c     | 10 ++++++----
>  hw/intc/xics_kvm.c | 15 ++++++++++-----
>  hw/ppc/spapr.c     |  2 --
>  3 files changed, 16 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index ffc0747c7fa2..e740989a1162 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -333,7 +333,7 @@ static const VMStateDescription vmstate_icp_server =
=3D {
>      },
>  };
> =20
> -static void icp_reset(DeviceState *dev)
> +static void icp_reset(void *dev)
>  {
>      ICPState *icp =3D ICP(dev);
> =20
> @@ -359,6 +359,8 @@ static void icp_realize(DeviceState *dev, Error **err=
p)
>      }
> =20
>      icp->xics =3D XICS_FABRIC(obj);
> +
> +    qemu_register_reset(icp_reset, dev);
>  }
> =20
> =20
> @@ -366,7 +368,6 @@ static void icp_class_init(ObjectClass *klass, void *=
data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    dc->reset =3D icp_reset;
>      dc->vmsd =3D &vmstate_icp_server;
>      dc->realize =3D icp_realize;
>  }
> @@ -522,7 +523,7 @@ static void ics_simple_eoi(ICSState *ics, uint32_t nr)
>      }
>  }
> =20
> -static void ics_simple_reset(DeviceState *dev)
> +static void ics_simple_reset(void *dev)
>  {
>      ICSState *ics =3D ICS_SIMPLE(dev);
>      int i;
> @@ -611,6 +612,8 @@ static void ics_simple_realize(DeviceState *dev, Erro=
r **errp)
>      }
>      ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
>      ics->qirqs =3D qemu_allocate_irqs(ics_simple_set_irq, ics, ics->nr_i=
rqs);
> +
> +    qemu_register_reset(ics_simple_reset, dev);
>  }
> =20
>  static Property ics_simple_properties[] =3D {
> @@ -626,7 +629,6 @@ static void ics_simple_class_init(ObjectClass *klass,=
 void *data)
>      isc->realize =3D ics_simple_realize;
>      dc->props =3D ics_simple_properties;
>      dc->vmsd =3D &vmstate_ics_simple;
> -    dc->reset =3D ics_simple_reset;
>      isc->reject =3D ics_simple_reject;
>      isc->resend =3D ics_simple_resend;
>      isc->eoi =3D ics_simple_eoi;
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 0a3daca3bb5a..42e0e0ef8484 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -102,7 +102,7 @@ static int icp_set_kvm_state(ICPState *icp, int versi=
on_id)
>      return 0;
>  }
> =20
> -static void icp_kvm_reset(DeviceState *dev)
> +static void icp_kvm_reset(void *dev)
>  {
>      ICPState *icp =3D ICP(dev);
> =20
> @@ -146,12 +146,17 @@ static void icp_kvm_cpu_setup(ICPState *icp, PowerP=
CCPU *cpu)
>      icp->cap_irq_xics_enabled =3D true;
>  }
> =20
> +static void icp_kvm_realize(DeviceState *dev, Error **errp)
> +{
> +    qemu_register_reset(icp_kvm_reset, dev);
> +}
> +
>  static void icp_kvm_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      ICPStateClass *icpc =3D ICP_CLASS(klass);
> =20
> -    dc->reset =3D icp_kvm_reset;
> +    dc->realize =3D icp_kvm_realize;
>      icpc->pre_save =3D icp_get_kvm_state;
>      icpc->post_load =3D icp_set_kvm_state;
>      icpc->cpu_setup =3D icp_kvm_cpu_setup;
> @@ -293,7 +298,7 @@ static void ics_kvm_set_irq(void *opaque, int srcno, =
int val)
>      }
>  }
> =20
> -static void ics_kvm_reset(DeviceState *dev)
> +static void ics_kvm_reset(void *dev)
>  {
>      ICSState *ics =3D ICS_SIMPLE(dev);
>      int i;
> @@ -324,15 +329,15 @@ static void ics_kvm_realize(DeviceState *dev, Error=
 **errp)
>      }
>      ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
>      ics->qirqs =3D qemu_allocate_irqs(ics_kvm_set_irq, ics, ics->nr_irqs=
);
> +
> +    qemu_register_reset(ics_kvm_reset, dev);
>  }
> =20
>  static void ics_kvm_class_init(ObjectClass *klass, void *data)
>  {
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
>      ICSStateClass *icsc =3D ICS_BASE_CLASS(klass);
> =20
>      icsc->realize =3D ics_kvm_realize;
> -    dc->reset =3D ics_kvm_reset;
>      icsc->pre_save =3D ics_get_kvm_state;
>      icsc->post_load =3D ics_set_kvm_state;
>  }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 14192accf486..c3bb99160545 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -106,7 +106,6 @@ static int try_create_xics(sPAPRMachineState *spapr, =
const char *type_ics,
>      int i;
> =20
>      ics =3D ICS_SIMPLE(object_new(type_ics));
> -    qdev_set_parent_bus(DEVICE(ics), sysbus_get_default());
>      object_property_add_child(OBJECT(spapr), "ics", OBJECT(ics), NULL);
>      object_property_set_int(OBJECT(ics), nr_irqs, "nr-irqs", &err);
>      object_property_add_const_link(OBJECT(ics), "xics", OBJECT(xi), NULL=
);
> @@ -123,7 +122,6 @@ static int try_create_xics(sPAPRMachineState *spapr, =
const char *type_ics,
>          ICPState *icp =3D &spapr->icps[i];
> =20
>          object_initialize(icp, sizeof(*icp), type_icp);
> -        qdev_set_parent_bus(DEVICE(icp), sysbus_get_default());
>          object_property_add_child(OBJECT(spapr), "icp[*]", OBJECT(icp), =
NULL);
>          object_property_add_const_link(OBJECT(icp), "xics", OBJECT(xi), =
NULL);
>          object_property_set_bool(OBJECT(icp), true, "realized", &err);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYvMCjAAoJEGw4ysog2bOSLwsQANSCpu89bRYYrPh9HXOCsDzf
/zwmqU5s73nkBjcYcynfDrJd5JNj4Emwjx6w2uoPeOnP17/yrdKaWefS3ULC+yGt
a35AgYEk0MCn0PTNuDKCYR19deYzicQ3npJePlqqlgCUU8XHYYImjhFX/GtJo8Fm
B2xtEEnWthQaugP45fL2VSqOjjKxNj77RXDttZ4vKyadPCLB7nCUxhGR4cIuFpl3
ENOe1LtsxzKC44T9JwJHSRDhTHQJp5aJWVGgJWV1n6NzqUKuY9q03n0C9srkFzzV
C/A+owlnW15Z72tdTvxELSFJ7jFsqMHRh9zy9PWJnoTBtjLNWfAFkSPystNsL/C6
k5ga/Gbf5oVH0I+HmUjEDU2C74GmGQjjy6pOM8RtRW1alva53GOPBN9NAJ5G11Hq
OsKyzggOV4cqZqzWQj6uL7t7v0wNcUdRG3hZxeuLntTrCEmQ0tSdTRN3BhGlIlWu
XZahAXdJOBq4Ng5BKz1TtHiJiUpLhafzqSCwD5CYmEvN2ugKd6stlNMtY0mpRqNS
7ZlSdFKRvf+V67Gz3vfQK5o5XbuS+DprhMumxB0QPxJsCdGilhNFJVZlP6dNgRmy
pD/GzWs4WDRNOuKBDBPGmbyQRV/4qP0Bc7ym4H6uJZFB7hd+50s1M6lViM7YMZz4
TK60enIHzlnQ49y9WE7y
=Nl8+
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
