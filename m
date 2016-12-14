Received: from eggs.gnu.org ([2001:4830:134:3::10]:38663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cHJqA-0003QO-Va
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:24:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cHJq6-0001PT-I8
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:24:06 -0500
Date: Thu, 15 Dec 2016 09:50:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161214225001.GK32647@umbus>
References: <1481751857-464-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lZZ4ablUVnt2XgAh"
Content-Disposition: inline
In-Reply-To: <1481751857-464-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] hw/ppc/spapr: Fix boot path of
 usb-host storage devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--lZZ4ablUVnt2XgAh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2016 at 10:44:17PM +0100, Thomas Huth wrote:
> When passing through an USB storage device to a pseries guest, it
> is currently not possible to automatically boot from the device
> if the "bootindex" property has been specified, too (e.g. when using
> "-device nec-usb-xhci -device usb-host,hostbus=3D1,hostaddr=3D2,bootindex=
=3D0"
> at the command line). The problem is that QEMU builds a device tree path
> like "/pci@800000020000000/usb@0/usb-host@1" and passes it to SLOF
> in the /chosen/qemu,boot-list property. SLOF, however, probes the
> USB device, recognizes that it is a storage device and thus changes
> its name to "storage", and additionally adds a child node for the
> SCSI LUN, so the correct boot path in SLOF is something like
> "/pci@800000020000000/usb@0/storage@1/disk@101000000000000" instead.
> So when we detect an USB mass storage device with SCSI interface,
> we've got to adjust the firmware boot-device path properly that
> SLOF can automatically boot from the device.
>=20
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1354177
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Improved the comment in spapr.c as requested by David

Applied to ppc-for-2.9. thanks.

>=20
>  hw/ppc/spapr.c       | 13 +++++++++++++
>  hw/usb/host-libusb.c | 29 +++++++++++++++++++++++++++++
>  hw/usb/host-stub.c   |  5 +++++
>  include/hw/usb.h     |  1 +
>  4 files changed, 48 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 208ef7b..cd83b2c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2185,6 +2185,19 @@ static char *spapr_get_fw_dev_path(FWPathProvider =
*p, BusState *bus,
>          }
>      }
> =20
> +    /*
> +     * SLOF probes the USB devices, and if it recognizes that the device=
 is a
> +     * storage device, it changes its name to "storage" instead of "usb-=
host",
> +     * and additionally adds a child node for the SCSI LUN, so the corre=
ct
> +     * boot path in SLOF is something like .../storage@1/disk@xxx" inste=
ad.
> +     */
> +    if (strcmp("usb-host", qdev_fw_name(dev)) =3D=3D 0) {
> +        USBDevice *usbdev =3D CAST(USBDevice, dev, TYPE_USB_DEVICE);
> +        if (usb_host_dev_is_scsi_storage(usbdev)) {
> +            return g_strdup_printf("storage@%s/disk", usbdev->port->path=
);
> +        }
> +    }
> +
>      if (phb) {
>          /* Replace "pci" with "pci@800000020000000" */
>          return g_strdup_printf("pci@%"PRIX64, phb->buid);
> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index bd81d71..7791c6d 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -1707,6 +1707,35 @@ static void usb_host_auto_check(void *unused)
>      timer_mod(usb_auto_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 2=
000);
>  }
> =20
> +/**
> + * Check whether USB host device has a USB mass storage SCSI interface
> + */
> +bool usb_host_dev_is_scsi_storage(USBDevice *ud)
> +{
> +    USBHostDevice *uhd =3D USB_HOST_DEVICE(ud);
> +    struct libusb_config_descriptor *conf;
> +    const struct libusb_interface_descriptor *intf;
> +    bool is_scsi_storage =3D false;
> +    int i;
> +
> +    if (!uhd || libusb_get_active_config_descriptor(uhd->dev, &conf) !=
=3D 0) {
> +        return false;
> +    }
> +
> +    for (i =3D 0; i < conf->bNumInterfaces; i++) {
> +        intf =3D &conf->interface[i].altsetting[ud->altsetting[i]];
> +        if (intf->bInterfaceClass =3D=3D LIBUSB_CLASS_MASS_STORAGE &&
> +            intf->bInterfaceSubClass =3D=3D 6) {                 /* 6 me=
ans SCSI */
> +            is_scsi_storage =3D true;
> +            break;
> +        }
> +    }
> +
> +    libusb_free_config_descriptor(conf);
> +
> +    return is_scsi_storage;
> +}
> +
>  void hmp_info_usbhost(Monitor *mon, const QDict *qdict)
>  {
>      libusb_device **devs =3D NULL;
> diff --git a/hw/usb/host-stub.c b/hw/usb/host-stub.c
> index 6ba65a1..d0268ba 100644
> --- a/hw/usb/host-stub.c
> +++ b/hw/usb/host-stub.c
> @@ -46,3 +46,8 @@ USBDevice *usb_host_device_open(USBBus *bus, const char=
 *devname)
>  {
>      return NULL;
>  }
> +
> +bool usb_host_dev_is_scsi_storage(USBDevice *ud)
> +{
> +    return false;
> +}
> diff --git a/include/hw/usb.h b/include/hw/usb.h
> index 847c9de..43838c9 100644
> --- a/include/hw/usb.h
> +++ b/include/hw/usb.h
> @@ -471,6 +471,7 @@ void usb_generic_async_ctrl_complete(USBDevice *s, US=
BPacket *p);
>  /* usb-linux.c */
>  USBDevice *usb_host_device_open(USBBus *bus, const char *devname);
>  void hmp_info_usbhost(Monitor *mon, const QDict *qdict);
> +bool usb_host_dev_is_scsi_storage(USBDevice *usbdev);
> =20
>  /* usb ports of the VM */
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lZZ4ablUVnt2XgAh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYUcyXAAoJEGw4ysog2bOSXrMQAIfA3LrW3YkR5fssHoKhl15N
Qtrm+/bDzzxGUg5xBtYfyUGKr28jYwMfkbiOKqShxNgy3J96o82qHTIjsnZK1cfg
Bs4hzhWe+EmawmIuWkxDrRzROBogskB7swDxsu93DWVGmlGuCzvuXUq5eEdESgoW
Fo5M5Csa4ZtPxL3xmjzKNnHWnL7CUdg0EUEpdnvhEMdj/x5hhD/OkBiENlGvoOvT
Ou3bX9tKRurggCUbE8OdntvdqQc0o5zyVSB1fcj2bcfoWyfQfjD3Oxrj9uOpPPzX
VgF3Q4gYjWu+0chef7D24OqqVpapooflxZ83AlT1VHzBMZyVawXHHV/DUbdTv0vH
2eKr5Q20z6crEGRVh8yVwfVq784nu+9zzvtHa4vS/a84asnSMddjcsEP8MlgBN2i
62zK92xCo25GiR5A/IJfht9G9/c8V72pMv113RQkQ58quoTTb6lPeg26xL3b1OhA
lBdEeEbi3AOSGH1ApT72CDl4+Abv+B1rKO1Bui7fWUJZMI89vZ4RMI+fylwjhCw9
hJo7UAt8aej84UfMMRsR07/xx+jv8InY+nabmSWu4x1yCyjKXNbapAo0C0iyefQK
4/eoOeI8MIAxJaNRZHj8+WaR1kcCBkGVhOf0OlUyHe1NJpwo3ChPf3deusOt1b5s
CLI3bW8JCImqT1meAHOj
=0waw
-----END PGP SIGNATURE-----

--lZZ4ablUVnt2XgAh--
