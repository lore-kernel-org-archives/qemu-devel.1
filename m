Received: from eggs.gnu.org ([2001:4830:134:3::10]:41071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWw7f-0001dz-Jy
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 23:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWw7c-00077L-HC
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 23:55:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49936 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fWw7c-000776-5X
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 23:55:28 -0400
Date: Sun, 24 Jun 2018 06:55:24 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180624065424-mutt-send-email-mst@kernel.org>
References: <20180623085028.29553-1-mark.cave-ayland@ilande.co.uk>
	<20180623085028.29553-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180623085028.29553-3-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 2/2] pci: allow DeviceClass fw_name to
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

On Sat, Jun 23, 2018 at 09:50:28AM +0100, Mark Cave-Ayland wrote:
> The current implementation of pci_dev_fw_name() scans through a fixed
> set of PCI class descriptions to determine the firmware device name
> but in some cases this isn't always appropriate, for example with
> the macio device which uses a class code of 0xff (unassigned).
> 
> Rather than add a new entry for the macio device and risk a potential
> clash with another unassigned device later, add a check to
> pcibus_get_fw_dev_path() that will use DeviceClass fw_name if set in
> preference to pci_dev_fw_name().
> 
> This enables PCI devices such as macio to set dc->fw_name as required
> to match the name specified in the firmware.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Do we know no existing pci device sets this?

> ---
>  hw/pci/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 80bc45930d..126dd683dc 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2411,12 +2411,14 @@ static char *pci_dev_fw_name(DeviceState *dev, char *buf, int len)
>  
>  static char *pcibus_get_fw_dev_path(DeviceState *dev)
>  {
> +    DeviceClass *dc = DEVICE_GET_CLASS(dev);
>      PCIDevice *d = (PCIDevice *)dev;
>      char path[50], name[33];
>      int off;
>  
>      off = snprintf(path, sizeof(path), "%s@%x",
> -                   pci_dev_fw_name(dev, name, sizeof name),
> +                   dc->fw_name ? dc->fw_name :
> +                       pci_dev_fw_name(dev, name, sizeof name),
>                     PCI_SLOT(d->devfn));
>      if (PCI_FUNC(d->devfn))
>          snprintf(path + off, sizeof(path) + off, ",%x", PCI_FUNC(d->devfn));
> -- 
> 2.11.0
