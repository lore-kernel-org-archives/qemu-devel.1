Received: from eggs.gnu.org ([2001:4830:134:3::10]:54178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cGxEk-0008WR-O8
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 19:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cGxEg-0002dC-Gm
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 19:15:58 -0500
Date: Wed, 14 Dec 2016 11:14:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161214001451.GB32647@umbus>
References: <1481633076-24521-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <1481633076-24521-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr: Fix boot path of usb-host
 storage devices
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


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2016 at 01:44:36PM +0100, Thomas Huth wrote:
> When passing through a USB storage device to a pseries guest, it
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
> we've got to adjust the firmware boot-device path properly, so that
> SLOF can automatically boot from the device.
>=20
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1354177
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/ppc/spapr.c       |  9 +++++++++
>  hw/usb/host-libusb.c | 29 +++++++++++++++++++++++++++++
>  hw/usb/host-stub.c   |  5 +++++
>  include/hw/usb.h     |  1 +
>  4 files changed, 44 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 208ef7b..fe315b5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2185,6 +2185,15 @@ static char *spapr_get_fw_dev_path(FWPathProvider =
*p, BusState *bus,
>          }
>      }

I think a chunk of your commit message needs to go into a comment
here.  Anticipating the guest firmware behaviour is kind of a hack - I
think it's worth it in this case, but we do need to make it clear to
someone reading the code what the rationale is.

> +    if (strcmp("usb-host", qdev_fw_name(dev)) =3D=3D 0) {
> +        USBDevice *usbdev =3D CAST(USBDevice, dev, TYPE_USB_DEVICE);
> +
> +        /* SLOF scans USB storage and adds a "disk" node for the SCSI LU=
N */
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

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYUI73AAoJEGw4ysog2bOSWEwP/A8tV1VjQFE024hlcqm8q+ft
J+XA3DaA7wf6adQdee1PD3P8APEGhtrkQdtrLLXjayvWR3062qqXGRCWlAulwim/
gr8035uFXdGHSZP6fJqrHOeUwatzn8/1IJGZlQ6VYPO+FPXlm3cfbFC6r9atJKRG
LX5OBZtI4foejDsjCgVqbLDKgTIyKHkNd5IBTnOLzN1WD8U0Y/UzNr+HsDJQL/eF
jqsrXWgV5vXZ8ESXQdDDUL0tfaKCakAKcERPWTnlWcR1dzccYkTIWECTSS0XfCTe
DTwuB2dkYTlKCd98vD48pFzl82b7mIWeUGm6Ct/sncpjrMYo3VXUdZIb15/hqqTp
0ztaOYzNXqJEcUhwiCtJ9KenbSon+zZFU35WeLjhhOX+uBXlZUxu7BjTtwG/SxEF
63bW01jaOFt5y+4JDaWa5PX7XDH11LLHFvJccYwNYkjvWcWRgV54M5ugKknh2ul1
xnQvuIzY7voniQjLjWJguwbOgALIhXP0t/guw1WPLA5Ue5VyqJVCLKjpvuJIWbrv
57Duzd9Yaw4HVXlrjvgDIr5lGLshVlyuMk0dbtN190DVdfG4t6MFHHpRmvz6ing+
+FGjJKAfNDiN7ySyhfni2XsmzDkQPr8D9hYkNkO7RT6lI34RnKIBdfLwyYUA8eQr
zUMMkN0GH1vzj+A9p30i
=IBs5
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
