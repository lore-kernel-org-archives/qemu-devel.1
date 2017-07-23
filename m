Received: from eggs.gnu.org ([2001:4830:134:3::10]:50111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dZFtx-0002kk-Fu
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 08:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dZFto-0007bt-QO
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 08:22:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dZFto-0007bQ-Jp
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 08:22:16 -0400
Date: Sun, 23 Jul 2017 15:22:08 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170723055006-mutt-send-email-mst@kernel.org>
References: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
	<1500761743-1669-6-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500761743-1669-6-git-send-email-zuban32s@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 5/6] hw/pci: add bus_reserve
 property to pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, marcel@redhat.com, kraxel@redhat.com, seabios@seabios.org

On Sun, Jul 23, 2017 at 01:15:42AM +0300, Aleksandr Bezzubikov wrote:
> To enable hotplugging of a newly created pcie-pci-bridge,
> we need to tell firmware (SeaBIOS in this case)

Presumably, EFI would need to support this too?

> to reserve
> additional buses for pcie-root-port, that allows us to 
> hotplug pcie-pci-bridge into this root port.
> The number of buses to reserve is provided to the device via a corresponding
> property, and to the firmware via new PCI capability (next patch).
> The property's default value is 1 as we want to hotplug at least 1 bridge.

If so you should just teach firmware to allocate one bus #
unconditionally.

But why would that be so? What's wrong with a device
directly in the root port?


> 
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> ---
>  hw/pci-bridge/pcie_root_port.c | 1 +
>  include/hw/pci/pcie_port.h     | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
> index 4d588cb..b0e49e1 100644
> --- a/hw/pci-bridge/pcie_root_port.c
> +++ b/hw/pci-bridge/pcie_root_port.c
> @@ -137,6 +137,7 @@ static void rp_exit(PCIDevice *d)
>  static Property rp_props[] = {
>      DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
>                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
> +    DEFINE_PROP_UINT8("bus_reserve", PCIEPort, bus_reserve, 1),
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
> index 1333266..1b2dd1f 100644
> --- a/include/hw/pci/pcie_port.h
> +++ b/include/hw/pci/pcie_port.h
> @@ -34,6 +34,9 @@ struct PCIEPort {
>  
>      /* pci express switch port */
>      uint8_t     port;
> +
> +    /* additional buses to reserve on firmware init */
> +    uint8_t     bus_reserve;
>  };
>  
>  void pcie_port_init_reg(PCIDevice *d);

So here is a property and it does not do anything.
It makes it easier to work on series maybe, but review
is harder since we do not see what it does at all.
Please do not split up patches like this - you can maintain
it split up in your branch if you like and merge before sending.

> -- 
> 2.7.4
