Received: from eggs.gnu.org ([2001:4830:134:3::10]:38858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fYwpN-0006a6-M3
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fYwpM-0006fV-Ec
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:04:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53330 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fYwpM-0006f3-8V
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:04:56 -0400
Date: Fri, 29 Jun 2018 20:04:55 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180629200121-mutt-send-email-mst@kernel.org>
References: <20180629135616.16570-1-mark.cave-ayland@ilande.co.uk>
	<20180629135616.16570-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180629135616.16570-3-mark.cave-ayland@ilande.co.uk>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] pci: allow DeviceClass fw_name to
 override pci_dev_fw_name() if set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, marcel@redhat.com, armbru@redhat.com

On Fri, Jun 29, 2018 at 02:56:16PM +0100, Mark Cave-Ayland wrote:
> The current implementation of pci_dev_fw_name() scans through a fixed
> set of PCI class descriptions to determine the firmware device name
> but in some cases this isn't always appropriate, for example with
> the macio device which uses a class code of 0xff (unassigned).
>=20
> Rather than add a new entry for the macio device and risk a potential
> clash with another unassigned device later, add a check to
> pcibus_get_fw_dev_path() that will use DeviceClass fw_name if set in
> preference to pci_dev_fw_name().
>=20
> This enables PCI devices such as macio to set dc->fw_name as required
> to match the name specified in the firmware.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  hw/pci/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 80bc45930d..126dd683dc 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2411,12 +2411,14 @@ static char *pci_dev_fw_name(DeviceState *dev, =
char *buf, int len)
> =20
>  static char *pcibus_get_fw_dev_path(DeviceState *dev)
>  {
> +    DeviceClass *dc =3D DEVICE_GET_CLASS(dev);
>      PCIDevice *d =3D (PCIDevice *)dev;
>      char path[50], name[33];
>      int off;
> =20
>      off =3D snprintf(path, sizeof(path), "%s@%x",
> -                   pci_dev_fw_name(dev, name, sizeof name),
> +                   dc->fw_name ? dc->fw_name :
> +                       pci_dev_fw_name(dev, name, sizeof name),
>                     PCI_SLOT(d->devfn));

So why not put the logic into pci_dev_fw_name then?



>      if (PCI_FUNC(d->devfn))
>          snprintf(path + off, sizeof(path) + off, ",%x", PCI_FUNC(d->de=
vfn));
> --=20
> 2.11.0
