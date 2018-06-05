Received: from eggs.gnu.org ([2001:4830:134:3::10]:50511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQ0TY-0002nS-JK
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 21:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQ0TX-0001wX-7Q
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 21:09:28 -0400
Date: Tue, 5 Jun 2018 11:02:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180605010253.GE5140@umbus.fritz.box>
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tMbDGjvJuJijemkf"
Content-Disposition: inline
In-Reply-To: <20180517081527.14410-4-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 03/14] qdev: let machine hotplug handler
 to override bus hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>


--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2018 at 10:15:16AM +0200, David Hildenbrand wrote:
> From: Igor Mammedov <imammedo@redhat.com>
>=20
> it will allow to return another hotplug handler than the default
> one for a specific bus based device type. Which is needed to handle
> non trivial plug/unplug sequences that need the access to resources
> configured outside of bus where device is attached.
>=20
> That will allow for returned hotplug handler to orchestrate wiring
> in arbitrary order, by chaining other hotplug handlers when
> it's needed.
>=20
> PS:
> It could be used for hybrid virtio-mem and virtio-pmem devices
> where it will return machine as hotplug handler which will do
> necessary wiring at machine level and then pass control down
> the chain to bus specific hotplug handler.
>=20
> Example of top level hotplug handler override and custom plug sequence:
>=20
>   some_machine_get_hotplug_handler(machine){
>       if (object_dynamic_cast(OBJECT(dev), TYPE_SOME_BUS_DEVICE)) {
>           return HOTPLUG_HANDLER(machine);
>       }
>       return NULL;
>   }
>=20
>   some_machine_device_plug(hotplug_dev, dev) {
>       if (object_dynamic_cast(OBJECT(dev), TYPE_SOME_BUS_DEVICE)) {
>           /* do machine specific initialization */
>           some_machine_init_special_device(dev)
>=20
>           /* pass control to bus specific handler */
>           hotplug_handler_plug(dev->parent_bus->hotplug_handler, dev)
>       }
>   }
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

I've been considering a similar change for a while; we'll also need
something like this in order to do hoplug for PCI devices under p2p
bridges on pseries (there's a PAPR specific hotplug model that we need
to use instead of SHP).

> ---
>  hw/core/qdev.c         |  6 ++----
>  include/hw/qdev-core.h | 11 +++++++++++
>  2 files changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index f6f92473b8..885286f579 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -261,12 +261,10 @@ HotplugHandler *qdev_get_machine_hotplug_handler(De=
viceState *dev)
> =20
>  HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
>  {
> -    HotplugHandler *hotplug_ctrl;
> +    HotplugHandler *hotplug_ctrl =3D qdev_get_machine_hotplug_handler(de=
v);
> =20
> -    if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
> +    if (hotplug_ctrl =3D=3D NULL && dev->parent_bus) {
>          hotplug_ctrl =3D dev->parent_bus->hotplug_handler;
> -    } else {
> -        hotplug_ctrl =3D qdev_get_machine_hotplug_handler(dev);
>      }
>      return hotplug_ctrl;
>  }
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 9453588160..e6a8eca558 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -286,6 +286,17 @@ void qdev_init_nofail(DeviceState *dev);
>  void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
>                                   int required_for_version);
>  HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
> +/**
> + * qdev_get_hotplug_handler: Get handler responsible for device wiring
> + *
> + * Find HOTPLUG_HANDLER for @dev that provides [pre|un]plug callbacks fo=
r it.
> + *
> + * Note: in case @dev has a parent bus, it will be returned as handler u=
nless
> + * machine handler overrides it.
> + *
> + * Returns: pointer to object that implements TYPE_HOTPLUG_HANDLER inter=
face
> + *          or NULL if there aren't any.
> + */
>  HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev);
>  void qdev_unplug(DeviceState *dev, Error **errp);
>  void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tMbDGjvJuJijemkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsV4TsACgkQbDjKyiDZ
s5JYEhAAgJHRnqL5caq786afDxov3pZTLu0SicBit2qoMuqRdqe9K/3fe4N/2Mz/
6gWvTwZiNEAEwYBykmfsLCMHUBy8qSuYekaS1n1i3DNkTFaiJgt7sNcBidQCg6p1
QtDhlDaUYZ87FrT6NAYSEZoV7rN3uryLD3nUEWNcNhfB8+syUOJjFV77YuvUoFYC
EjdfEI+GRlTljoMZetawpyt+dlYSk/kwgt2JPWNezM3vMYcPtgXFBiZlABPVfiox
DumN6LWt4SgxLEIx48Qz88H3YdonXNFvWTb0ItLW4WQgpui5NcTUZc32fSG3dknk
oVFFIlBYLL4QlOMA3q11TXDPsKlbMr93keoyAGcVw3C05bvowJEA1VoWK5PTT2bP
Aw890RkjNKP8rID5OwKJgxlds0wHNWxlhi77owVAxsVfG0uOao5UAniMGWFpqNQN
n8BO+pM3QJHn5zdyJmpXnlIo777OLpq7CtNiHVRDYh/XV4vyUKjbUwnTxO4QZjvm
7s51HHahDEtrUvP/tqXioWSl/kL1bBiSLXuNczfqeFNR+75PwW7bewv6KiTX1pwp
qWdRhY4j7im8pBvnYNAUlfr3iBnWXxhABJc8VnmHco+noPfUg0tzOLaEpf8eZFSP
QlrJZHuSvzz9KPR2PXfXC/wItu3EIFdTsd2eaj0/BJ1ENenwTR4=
=Klm0
-----END PGP SIGNATURE-----

--tMbDGjvJuJijemkf--
