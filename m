Received: from eggs.gnu.org ([2001:4830:134:3::10]:49410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKFMq-0006Fm-3K
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 23:23:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKFMk-0000Nc-1E
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 23:22:59 -0500
Date: Wed, 7 Nov 2018 15:22:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181107042212.GA5575@umbus.fritz.box>
References: <20181105102044.20547-1-david@redhat.com>
	<20181105102044.20547-11-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20181105102044.20547-11-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 10/10] spapr_pci: perform unplug via the
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


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 11:20:44AM +0100, David Hildenbrand wrote:
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

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr_pci.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 58afa46204..64b8591023 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1370,18 +1370,9 @@ static int spapr_create_pci_child_dt(sPAPRPHBState=
 *phb, PCIDevice *dev,
>  /* Callback to be called during DRC release. */
>  void spapr_phb_remove_pci_device_cb(DeviceState *dev)
>  {
> -    /* some version guests do not wait for completion of a device
> -     * cleanup (generally done asynchronously by the kernel) before
> -     * signaling to QEMU that the device is safe, but instead sleep
> -     * for some 'safe' period of time. unfortunately on a busy host
> -     * this sleep isn't guaranteed to be long enough, resulting in
> -     * bad things like IRQ lines being left asserted during final
> -     * device removal. to deal with this we call reset just prior
> -     * to finalizing the device, which will put the device back into
> -     * an 'idle' state, as the device cleanup code expects.
> -     */
> -    pci_device_reset(PCI_DEVICE(dev));
> -    object_unparent(OBJECT(dev));
> +    HotplugHandler *hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
> +
> +    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
>  }
> =20
>  static sPAPRDRConnector *spapr_phb_get_pci_func_drc(sPAPRPHBState *phb,
> @@ -1490,6 +1481,23 @@ out:
>      }
>  }
> =20
> +static void spapr_pci_unplug(HotplugHandler *plug_handler,
> +                             DeviceState *plugged_dev, Error **errp)
> +{
> +    /* some version guests do not wait for completion of a device
> +     * cleanup (generally done asynchronously by the kernel) before
> +     * signaling to QEMU that the device is safe, but instead sleep
> +     * for some 'safe' period of time. unfortunately on a busy host
> +     * this sleep isn't guaranteed to be long enough, resulting in
> +     * bad things like IRQ lines being left asserted during final
> +     * device removal. to deal with this we call reset just prior
> +     * to finalizing the device, which will put the device back into
> +     * an 'idle' state, as the device cleanup code expects.
> +     */
> +    pci_device_reset(PCI_DEVICE(plugged_dev));
> +    object_unparent(OBJECT(plugged_dev));
> +}
> +
>  static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
>                                       DeviceState *plugged_dev, Error **e=
rrp)
>  {
> @@ -1965,6 +1973,7 @@ static void spapr_phb_class_init(ObjectClass *klass=
, void *data)
>      dc->user_creatable =3D true;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      hp->plug =3D spapr_pci_plug;
> +    hp->unplug =3D spapr_pci_unplug;
>      hp->unplug_request =3D spapr_pci_unplug_request;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlviaHEACgkQbDjKyiDZ
s5KkBRAAtHKyzjWBP40KGVbJBfK11JuRsVmcRNZr73tJ+JbmvOMay8z4hQdI6ssC
0dbm3A4WZTf/Rh/3LafYN2pXEqKlZkhEanuMeAOkYfrX27KkGfMtNU6oPqKJA3Wq
YoCkzB2ZTLa++hfo51E8qMCv9EBF/pOPNWvZtqvSJBVJQgyXQB+lfH8BqBREXsSb
sVLPFy1zns6O/ezANIWzkv0IJdXwkcudk+vvIfXhTgJhJigcBT0a9iWhFcJXuqEu
IN2bxg2cFcfN75ogaFC79TqjKMvdHGZAK78ebkpkRyQJMpzoU3WUCK6uphpeA2j0
1yHJPK9WsS7ijR4ZTyN+FVfHsBIKlrY/UDxQSSBla25RfFfkiOxL8IWAVKAk77YT
hkPXdN0czJ0Ofd2kDpRPnkjSqFb0dkifUcw35L+QxUVEv95fECBPrCuIlZP4k1Dq
se2RGfAQOf5pIVgOougjKWSYuIXoVIdsfYqx372wseYoAmfaNT/mtrWfYwg3QfFB
7E2pU14LgPyG4SK0p7infCGufKdt+hHox6zgm4Bch+kcuoc+KVVcZJ4t+trr0Vor
xnki1RbadEvtoTs9UpoNHzsCTnBcGeutEjkPQpauH6ds2vlRfbIEp9qE71OiPq0X
266otG7YKCJT9itRxpK/+mapFhMlbNWER38vFrdNHIdtwDIDr60=
=yrDC
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
