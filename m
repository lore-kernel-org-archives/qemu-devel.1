Received: from eggs.gnu.org ([2001:4830:134:3::10]:45499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ejPtg-0004jl-2X
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:36:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ejPtb-000575-2w
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:36:24 -0500
References: <20180207121027.32466-1-lersek@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <ca07e122-dedc-91cc-7469-8518618349ae@redhat.com>
Date: Wed, 7 Feb 2018 15:35:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180207121027.32466-1-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pci-bridge/i82801b11: clear bridge
 registers on platform reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org

Hi Laszlo,

On 07/02/2018 14:10, Laszlo Ersek wrote:
> The "i82801b11-bridge" device model is a descendant of "base-pci-bridge"
> (TYPE_PCI_BRIDGE). However, unlike other similar devices, such as
> 
> - pci-bridge,
> - pcie-pci-bridge,
> - PCIE Root Port,
> - xio3130 switch upstream and downstream ports,
> - dec-21154-p2p-bridge,
> - pbm-bridge,
> - xilinx-pcie-root,
> 
> "i82801b11-bridge" does not clear the bridge specific registers at
> platform reset.
> 
> This is a problem because devices on "i82801b11-bridge" continue to
> respond to config space cycles after platform reset, when addressed with
> the bus number that was previously programmed into the secondary bus
> number register of "i82801b11-bridge". This error breaks OVMF's search for
> extra (PXB) root buses, for example.
> 

Now I understand why we didn't catch the error until now. Nobody
tried to use the pxb device with the dmi-pci bridge.

> The device class reset method for "i82801b11-bridge" is currently NULL;

This is sad, the device was always broken.

> set it directly to pci_bridge_reset(), like the last three bridge models
> in the above listing do.
> 

Thanks for catching it!

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel

> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: qemu-stable@nongnu.org
> Ref: https://bugzilla.redhat.com/show_bug.cgi?id=1541839
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  hw/pci-bridge/i82801b11.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
> index cb522bf30c31..ebf7f5f0e81c 100644
> --- a/hw/pci-bridge/i82801b11.c
> +++ b/hw/pci-bridge/i82801b11.c
> @@ -98,6 +98,7 @@ static void i82801b11_bridge_class_init(ObjectClass *klass, void *data)
>      k->realize = i82801b11_bridge_realize;
>      k->config_write = pci_bridge_write_config;
>      dc->vmsd = &i82801b11_bridge_dev_vmstate;
> +    dc->reset = pci_bridge_reset;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
>  
> 
