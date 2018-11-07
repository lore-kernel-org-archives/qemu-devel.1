Received: from eggs.gnu.org ([2001:4830:134:3::10]:51151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKCBB-0004tl-I1
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 19:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKCB4-0006vc-Pp
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 19:58:40 -0500
Date: Wed, 7 Nov 2018 11:55:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181107005527.GA1754@umbus.fritz.box>
References: <20181105102044.20547-1-david@redhat.com>
	<20181105102044.20547-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20181105102044.20547-9-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 08/10] pci/pcie: perform unplug via the
 hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 11:20:42AM +0100, David Hildenbrand wrote:
> Introduce and use the "unplug" callback.
>=20
> This is a preparation for multi-stage hotplug handlers, whereby the bus
> hotplug handler is overwritten by the machine hotplug handler. This handl=
er
> will then pass control to the bus hotplug handler. So to get this running
> cleanly, we also have to make sure to go via the hotplug handler chain wh=
en
> actually unplugging a device after an unplug request. Lookup the hotplug
> handler and call "unplug".
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/pci/pcie.c         | 10 +++++++++-
>  hw/pci/pcie_port.c    |  1 +
>  include/hw/pci/pcie.h |  2 ++
>  3 files changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index ccba29269e..ba3ea925e9 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -364,11 +364,19 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_=
dev, DeviceState *dev,
>      }
>  }
> =20
> -static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, void *opaque)
> +void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *d=
ev,
> +                             Error **errp)
>  {
>      object_unparent(OBJECT(dev));
>  }
> =20
> +static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, void *opaque)
> +{
> +    HotplugHandler *hotplug_ctrl =3D qdev_get_hotplug_handler(DEVICE(dev=
));
> +
> +    hotplug_handler_unplug(hotplug_ctrl, DEVICE(dev), &error_abort);
> +}
> +
>  void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                       DeviceState *dev, Error **errp)
>  {
> diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
> index 7982a87880..a30291ef54 100644
> --- a/hw/pci/pcie_port.c
> +++ b/hw/pci/pcie_port.c
> @@ -156,6 +156,7 @@ static void pcie_slot_class_init(ObjectClass *oc, voi=
d *data)
>      dc->props =3D pcie_slot_props;
>      hc->pre_plug =3D pcie_cap_slot_pre_plug_cb;
>      hc->plug =3D pcie_cap_slot_plug_cb;
> +    hc->unplug =3D pcie_cap_slot_unplug_cb;
>      hc->unplug_request =3D pcie_cap_slot_unplug_request_cb;
>  }
> =20
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index d9fbcf4a4a..9ae6482658 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -135,6 +135,8 @@ void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplu=
g_dev, DeviceState *dev,
>                                 Error **errp);
>  void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>                             Error **errp);
> +void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *d=
ev,
> +                             Error **errp);
>  void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                       DeviceState *dev, Error **errp);
>  #endif /* QEMU_PCIE_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlviN/8ACgkQbDjKyiDZ
s5Lx+hAAkK16gLvTJzVaYv0F2X30P6Z+i1jjfiiD6eV3kdOY7B7xMf96gvmCjX3D
o6N7vmHb7wsJ5RcZO7wrjQhzeMbwtjSmDWcdsJr2uoK5FBxaga6ylzRzPqEBxJsk
jH1i7P6H8f5tWsb68TkOfppQOqAQzUJYQ7YkQQ78fLXf0B0HTKMfWzhaF2zhH8So
wmVXiK1Ie6Kg6ukUpybIvDA68IJpSzenAhYRv8kea2uGaEtxZKBTSOfy4ZdyYPZO
TjBJ+bohohZy1TeSR90ogHKsy8YD25oFDcMjbSSBHoOJCHUXH5Wwun0FiZ842BZV
0jjHQJ7Hi3VZ6VUzvsuGaQ0cU7FphoiGjFU86XkWA72I6/dpVDWF82FucBFBdKdx
9waX+5rY8cVkNUTkl+7IoOQ3P9T+MVR//DedOQy7iyKqarWIbeoy47gENfenKdMP
2cTss5t/MrjOE2/t/f/VDQMeYSVqH7rr/+qGicrm3phgrJAe/k+YBcFm4c9sUyD9
+2q13fB9ZeKyglWRzJq6N1pA9Jr+f3O+Htq6Rcm2C/clmtpbnaMwvuqojNHZpDYd
jS0a3y0lWhR55afObvM9aaqY1vE0//u1HoeGWBKfjmbAZylvUKloZL62ZIS4BQgB
TCWdy22Og0UJdc6lq1pTOyEocOBUtsFH5zDl4uJew5E98YGEdDU=
=3EDk
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
