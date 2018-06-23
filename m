Received: from eggs.gnu.org ([2001:4830:134:3::10]:57004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWp03-0002gj-Pg
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 16:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWp00-0005JH-L1
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 16:19:11 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWp00-0005J7-Fg
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 16:19:08 -0400
Received: by mail-qt0-x243.google.com with SMTP id z6-v6so8908149qti.2
	for <qemu-devel@nongnu.org>; Sat, 23 Jun 2018 13:19:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180623085028.29553-1-mark.cave-ayland@ilande.co.uk>
	<20180623085028.29553-3-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f6e618ca-3b19-5d3b-5007-5aea3ff6c878@amsat.org>
Date: Sat, 23 Jun 2018 17:19:03 -0300
MIME-Version: 1.0
In-Reply-To: <20180623085028.29553-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, lersek@redhat.com, marcel@redhat.com, armbru@redhat.com, mst@redhat.com

On 06/23/2018 05:50 AM, Mark Cave-Ayland wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
> 
