Received: from eggs.gnu.org ([2001:4830:134:3::10]:40213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKBm6-0005KF-DX
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 19:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKBdP-00069T-PC
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 19:23:56 -0500
Date: Wed, 7 Nov 2018 10:10:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181106231041.GC24589@umbus.fritz.box>
References: <20181105102044.20547-1-david@redhat.com>
	<20181105102044.20547-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
In-Reply-To: <20181105102044.20547-5-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/10] pci/pcie: stop plug/unplug if the
 slot is locked
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


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 11:20:38AM +0100, David Hildenbrand wrote:
> We better stop right away. While at it, properly move the check
> to the pre_plug handler.
>=20
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Although I'm not sure the commit message gives a terribly clear
picture of what's going on here.

> ---
>  hw/pci/pcie.c         | 25 +++++++++++++++++--------
>  hw/pci/pcie_port.c    |  1 +
>  include/hw/pci/pcie.h |  2 ++
>  3 files changed, 20 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 44737cc1cd..ccba29269e 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -316,10 +316,10 @@ static void pcie_cap_slot_event(PCIDevice *dev, PCI=
ExpressHotPlugEvent event)
>  }
> =20
>  static void pcie_cap_slot_plug_common(PCIDevice *hotplug_dev, DeviceStat=
e *dev,
> -                                      uint8_t **exp_cap, Error **errp)
> +                                      Error **errp)
>  {
> -    *exp_cap =3D hotplug_dev->config + hotplug_dev->exp.exp_cap;
> -    uint16_t sltsta =3D pci_get_word(*exp_cap + PCI_EXP_SLTSTA);
> +    uint8_t *exp_cap =3D hotplug_dev->config + hotplug_dev->exp.exp_cap;
> +    uint16_t sltsta =3D pci_get_word(exp_cap + PCI_EXP_SLTSTA);
> =20
>      PCIE_DEV_PRINTF(PCI_DEVICE(dev), "hotplug state: 0x%x\n", sltsta);
>      if (sltsta & PCI_EXP_SLTSTA_EIS) {
> @@ -330,14 +330,19 @@ static void pcie_cap_slot_plug_common(PCIDevice *ho=
tplug_dev, DeviceState *dev,
>      }
>  }
> =20
> +void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState =
*dev,
> +                               Error **errp)
> +{
> +    pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, errp);
> +}
> +
>  void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>                             Error **errp)
>  {
> -    uint8_t *exp_cap;
> +    PCIDevice *hotplug_pdev =3D PCI_DEVICE(hotplug_dev);
> +    uint8_t *exp_cap =3D hotplug_pdev->config + hotplug_pdev->exp.exp_ca=
p;
>      PCIDevice *pci_dev =3D PCI_DEVICE(dev);
> =20
> -    pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, &exp_cap, er=
rp);
> -
>      /* Don't send event when device is enabled during qemu machine creat=
ion:
>       * it is present on boot, no hotplug event is necessary. We do send =
an
>       * event when the device is disabled later. */
> @@ -367,11 +372,15 @@ static void pcie_unplug_device(PCIBus *bus, PCIDevi=
ce *dev, void *opaque)
>  void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                       DeviceState *dev, Error **errp)
>  {
> -    uint8_t *exp_cap;
> +    Error *local_err =3D NULL;
>      PCIDevice *pci_dev =3D PCI_DEVICE(dev);
>      PCIBus *bus =3D pci_get_bus(pci_dev);
> =20
> -    pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, &exp_cap, er=
rp);
> +    pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> =20
>      /* In case user cancel the operation of multi-function hot-add,
>       * remove the function that is unexposed to guest individually,
> diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
> index 73e81e5847..7982a87880 100644
> --- a/hw/pci/pcie_port.c
> +++ b/hw/pci/pcie_port.c
> @@ -154,6 +154,7 @@ static void pcie_slot_class_init(ObjectClass *oc, voi=
d *data)
>      HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
> =20
>      dc->props =3D pcie_slot_props;
> +    hc->pre_plug =3D pcie_cap_slot_pre_plug_cb;
>      hc->plug =3D pcie_cap_slot_plug_cb;
>      hc->unplug_request =3D pcie_cap_slot_unplug_request_cb;
>  }
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index 735f8e8154..d9fbcf4a4a 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -131,6 +131,8 @@ void pcie_ari_init(PCIDevice *dev, uint16_t offset, u=
int16_t nextfn);
>  void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser=
_num);
>  void pcie_ats_init(PCIDevice *dev, uint16_t offset);
> =20
> +void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState =
*dev,
> +                               Error **errp);
>  void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>                             Error **errp);
>  void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlviH24ACgkQbDjKyiDZ
s5Jp4hAAputxiQ4dWSTm7D/US1J9yeFO2H9qeppjeMVZckiApMxPC5NNKGzhvvcV
Hbp03+7zQ/xvtsmpHYOsPP9FdzmH/yp6FGpETI6H4EFXw3S9OVV8+DylxmsuZWup
kga8moA+g8FszK26nbK3x8OI+Qc3w4EgwSu/ZfU6Vy4eEn/YLAtqY0EeS/5hvP+c
ONAeU2ux8yGdyNwVCcF8ICt+CaFfCaEItoIKAkCTZ6zxoMAEUbrkYyvTsbSlEyON
n8emP0T26IGASuUQFhai2+z4F/iwxMrXq7UUvs2e/5LR+l+jX+y+BWPKH8Le80Fa
PLmFPn8yMjIebpdbqbTg9wQ/Zz/jI7aUSwLECyx4s8VI2q+Ms235nb/6tFeDI7rK
6V4L+05Ax9N2NIZEg0PQNmqtK1rpBUs0qDhZosNmhXYvWms0VqshUth2HubMUAj2
cY1jwL/KK6eLYbK7lieijuk8Up/MDjEzsFOKa4qzkCW7+LxM/UpJvy09s0j9JAk1
caYMIDHKRCROjDrNxLcCxvfHYri8m+9RiZ/GUzwOVLZHQ7CBnLp8TBNpZH99Qr7K
J7/wp6g/6j+DS2m5LlrXQD/ulLAuABrefxN2/TvZOwuqB2kRe7TsAeQ7588oZZey
95YOdfYG2jznIvVqqGbdCxLpFejnjW0IZw6WTT/37Evwa9sh30o=
=1sTa
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
