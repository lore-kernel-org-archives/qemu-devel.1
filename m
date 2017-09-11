Received: from eggs.gnu.org ([2001:4830:134:3::10]:50456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1drODD-0005PD-87
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 08:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1drODC-0004qz-AU
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 08:53:15 -0400
Date: Mon, 11 Sep 2017 14:52:45 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170911125245.plvcrojgsvnxz6zb@hawk.localdomain>
References: <1499634139-20399-1-git-send-email-eric.auger@redhat.com>
	<1499634139-20399-4-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499634139-20399-4-git-send-email-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RESEND v3 3/3] hw/pci-host/gpex: Implement
 PCI INTx routing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, wei@redhat.com, agraf@suse.de, christoffer.dall@linaro.org, pranavkumar@linaro.org

On Sun, Jul 09, 2017 at 11:02:19PM +0200, Eric Auger wrote:
> From: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> 
> Now we are able to retrieve the gsi from the INTx pin, let's
> enable intx_to_irq routing. From that point on, irqfd becomes
> usable along with INTx when assigning a PCIe device.
> 
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/pci-host/gpex.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
> index 0d42ac2..94cc3c1 100644
> --- a/hw/pci-host/gpex.c
> +++ b/hw/pci-host/gpex.c
> @@ -53,6 +53,17 @@ int gpex_set_irq_num(GPEXHost *s, int index, uint32_t gsi)
>      return 0;
>  }
>  
> +static PCIINTxRoute gpex_route_intx_pin_to_irq(void *opaque, int pin)
> +{
> +    PCIINTxRoute route;
> +    GPEXHost *s = opaque;
> +
> +    route.mode = PCI_INTX_ENABLED;
> +    route.irq = (int)s->irq_num[pin];
> +
> +    return route;
> +}
> +
>  static void gpex_host_realize(DeviceState *dev, Error **errp)
>  {
>      PCIHostState *pci = PCI_HOST_BRIDGE(dev);
> @@ -77,6 +88,7 @@ static void gpex_host_realize(DeviceState *dev, Error **errp)
>                                  &s->io_ioport, 0, 4, TYPE_PCIE_BUS);
>  
>      qdev_set_parent_bus(DEVICE(&s->gpex_root), BUS(pci->bus));
> +    pci_bus_set_route_irq_fn(pci->bus, gpex_route_intx_pin_to_irq);
>      qdev_init_nofail(DEVICE(&s->gpex_root));
>  }
>  
> -- 
> 2.5.5
> 
>

Wouldn't need the cast if irq_num was an array of ints, but otherwise
 
Reviewed-by: Andrew Jones <drjones@redhat.com>
