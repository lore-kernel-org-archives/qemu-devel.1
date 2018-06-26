Received: from eggs.gnu.org ([2001:4830:134:3::10]:35516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXdlm-0000FI-CX
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 22:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXdlk-0004nH-Te
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 22:31:50 -0400
Date: Tue, 26 Jun 2018 12:18:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180626021821.GH22971@umbus.fritz.box>
References: <20180625091718.18544-1-clg@kaod.org>
	<20180625091718.18544-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oyqLL/JqMvClXZi1"
Content-Disposition: inline
In-Reply-To: <20180625091718.18544-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/5] ppc/xics: introduce a
 parent_realize in ICSStateClass
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


--oyqLL/JqMvClXZi1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2018 at 11:17:14AM +0200, C=E9dric Le Goater wrote:
> This makes possible to move the common ICSState code of the realize
> handlers in the ics-base class.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-3.0, thanks.

> ---
>  include/hw/ppc/xics.h |  3 ++-
>  hw/intc/xics.c        | 37 ++++++++++++++++++++++---------------
>  hw/intc/xics_kvm.c    | 20 +++++++++++++++-----
>  3 files changed, 39 insertions(+), 21 deletions(-)
>=20
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 4b04b295a772..44e96e640070 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -115,7 +115,8 @@ struct PnvICPState {
>  struct ICSStateClass {
>      DeviceClass parent_class;
> =20
> -    void (*realize)(ICSState *s, Error **errp);
> +    DeviceRealize parent_realize;
> +
>      void (*pre_save)(ICSState *s);
>      int (*post_load)(ICSState *s, int version_id);
>      void (*reject)(ICSState *s, uint32_t irq);
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 063491f38712..d6066d561fdc 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -618,30 +618,31 @@ static void ics_simple_initfn(Object *obj)
>      ics->offset =3D XICS_IRQ_BASE;
>  }
> =20
> -static void ics_simple_realize(ICSState *ics, Error **errp)
> +static void ics_simple_realize(DeviceState *dev, Error **errp)
>  {
> -    if (!ics->nr_irqs) {
> -        error_setg(errp, "Number of interrupts needs to be greater 0");
> +    ICSState *ics =3D ICS_SIMPLE(dev);
> +    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(ics);
> +    Error *local_err =3D NULL;
> +
> +    icsc->parent_realize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
>          return;
>      }
> -    ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
> +
>      ics->qirqs =3D qemu_allocate_irqs(ics_simple_set_irq, ics, ics->nr_i=
rqs);
> =20
>      qemu_register_reset(ics_simple_reset, ics);
>  }
> =20
> -static Property ics_simple_properties[] =3D {
> -    DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
>  static void ics_simple_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      ICSStateClass *isc =3D ICS_BASE_CLASS(klass);
> =20
> -    isc->realize =3D ics_simple_realize;
> -    dc->props =3D ics_simple_properties;
> +    device_class_set_parent_realize(dc, ics_simple_realize,
> +                                    &isc->parent_realize);
> +
>      dc->vmsd =3D &vmstate_ics_simple;
>      isc->reject =3D ics_simple_reject;
>      isc->resend =3D ics_simple_resend;
> @@ -659,7 +660,6 @@ static const TypeInfo ics_simple_info =3D {
> =20
>  static void ics_base_realize(DeviceState *dev, Error **errp)
>  {
> -    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(dev);
>      ICSState *ics =3D ICS_BASE(dev);
>      Object *obj;
>      Error *err =3D NULL;
> @@ -672,17 +672,24 @@ static void ics_base_realize(DeviceState *dev, Erro=
r **errp)
>      }
>      ics->xics =3D XICS_FABRIC(obj);
> =20
> -
> -    if (icsc->realize) {
> -        icsc->realize(ics, errp);
> +    if (!ics->nr_irqs) {
> +        error_setg(errp, "Number of interrupts needs to be greater 0");
> +        return;
>      }
> +    ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
>  }
> =20
> +static Property ics_base_properties[] =3D {
> +    DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void ics_base_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
>      dc->realize =3D ics_base_realize;
> +    dc->props =3D ics_base_properties;
>  }
> =20
>  static const TypeInfo ics_base_info =3D {
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index f511e50a8020..1f27eb497981 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -345,13 +345,17 @@ static void ics_kvm_reset(void *dev)
>      ics_set_kvm_state(ics, 1);
>  }
> =20
> -static void ics_kvm_realize(ICSState *ics, Error **errp)
> +static void ics_kvm_realize(DeviceState *dev, Error **errp)
>  {
> -    if (!ics->nr_irqs) {
> -        error_setg(errp, "Number of interrupts needs to be greater 0");
> +    ICSState *ics =3D ICS_KVM(dev);
> +    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(ics);
> +    Error *local_err =3D NULL;
> +
> +    icsc->parent_realize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
>          return;
>      }
> -    ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
>      ics->qirqs =3D qemu_allocate_irqs(ics_kvm_set_irq, ics, ics->nr_irqs=
);
> =20
>      qemu_register_reset(ics_kvm_reset, ics);
> @@ -360,8 +364,14 @@ static void ics_kvm_realize(ICSState *ics, Error **e=
rrp)
>  static void ics_kvm_class_init(ObjectClass *klass, void *data)
>  {
>      ICSStateClass *icsc =3D ICS_BASE_CLASS(klass);
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    /*
> +     * Use device_class_set_parent_realize() when ics-kvm inherits
> +     * directly from ics-base and not from ics-simple anymore.
> +     */
> +    dc->realize =3D ics_kvm_realize;
> =20
> -    icsc->realize =3D ics_kvm_realize;
>      icsc->pre_save =3D ics_get_kvm_state;
>      icsc->post_load =3D ics_set_kvm_state;
>      icsc->synchronize_state =3D ics_synchronize_state;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oyqLL/JqMvClXZi1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsxomoACgkQbDjKyiDZ
s5KUXRAA5119AoAUHEjpw2OVIAFKTCFJo30CUCPjnZVhxHbx2GHw3zTG1FmVlEVj
PqfeCrP7ZhXqpFWGmXHHJT41hbNxHC1lVnWZQtcfqazIcWWABAUGYbaorrRCQSSp
7cidbLlt7fZWGzAlLVX23GdY3UAlEsOv0Dj9y7boE0dWcmrzOcDJynS3TADmBz9e
RGSryrWnaIqZst6IdaJ8UHsAORTvLD2GSSGkyIXGtDj3mzcoC4sqaSRt63w7kqqZ
Yth8ApTHksJrnGcGAUpg+I2kTtuFlPci8Zym3pAZe80bJZq8cbjyc6WasJgKfjVd
XQLqOL9NFBZxVlR0gVb0QqRWXREWVge/u+mAM6JJE4oCNBOe1GwktsEQqW8gboTf
wU1DQg34k37CXCPP/p9zbAXKx7mnf8aS7atEWN3oydvdpGYFojYOt+M4gvt07lXT
zY3qeQIybd2jaPOBQciQoNHVZLqPlTX61XFQL6RW/fiGjTLiMQ8ww5hGx6yvH01j
JaAI7Aoc6ni9QUS6QsGuV38/UmpFTkMG63QiwOH9n/QawuBBz+Sh0gRBYWSgGft3
b+PziOeG6ag1XQ/MnCqFogGx19k8qP6MWHW0Gj67hN//TjWnT5JzZWtrPxPQjVzf
7IHyiN0KXSdY7nqflCKL80Lzj2D85wfAeSu279wmP85Dh5Jc7q4=
=I+s6
-----END PGP SIGNATURE-----

--oyqLL/JqMvClXZi1--
