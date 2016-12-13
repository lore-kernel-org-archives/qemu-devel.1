Received: from eggs.gnu.org ([2001:4830:134:3::10]:45715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cGnVv-0006j2-P9
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:53:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cGnVs-0004RU-Oy
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:53:03 -0500
Message-ID: <1481637176.27088.132.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 13 Dec 2016 14:52:56 +0100
In-Reply-To: <1481633076-24521-1-git-send-email-thuth@redhat.com>
References: <1481633076-24521-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On Di, 2016-12-13 at 13:44 +0100, Thomas Huth wrote:
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

> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 208ef7b..fe315b5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2185,6 +2185,15 @@ static char *spapr_get_fw_dev_path(FWPathProvider =
*p, BusState *bus,
>          }
>      }
> =20
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

Any reason why this is hidden in ppc/spapr?

usb-host could implement the ->fw_name callback instead to create a name
depending on the device type ...

cheers,
  Gerd
