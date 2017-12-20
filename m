Received: from eggs.gnu.org ([2001:4830:134:3::10]:57766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRVzB-00015E-SU
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 23:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRVz8-0005DM-M2
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 23:28:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eRVz8-0005Ce-GR
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 23:28:02 -0500
Date: Wed, 20 Dec 2017 06:27:57 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171220062738-mutt-send-email-mst@kernel.org>
References: <20171213082644.83113-1-ben@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171213082644.83113-1-ben@skyportsystems.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-pci: Add subsystem-vendor-id
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com
Cc: qemu-devel@nongnu.org, yan@daynix.com, lprosek@redhat.com, eswierk@skyportsystems.com

On Wed, Dec 13, 2017 at 12:26:44AM -0800, ben@skyportsystems.com wrote:
> From: Ben Warren <ben@skyportsystems.com>
> 
> Now that virtio-win guest drivers provided by non-Redhat vendors need to
> use a different Subsystem Vendor ID value, a way is needed to set this
> parameter on the host.  This works with all of the PCI-based devices,
> such as NetKVM, viostor, vioscsi, vioserial and balloon.
> 
> Signed-off-by: Ben Warren <ben@skyportsystems.com>

I applied a related patch by Ladi, pls take a look.

> ---
>  hw/virtio/virtio-pci.c | 5 +++++
>  hw/virtio/virtio-pci.h | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index e92837c..b5c86e3 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1757,6 +1757,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>      if (proxy->disable_legacy == ON_OFF_AUTO_AUTO) {
>          proxy->disable_legacy = pcie_port ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>      }
> +    /* Set the PCI Subsystem Vendor ID */
> +    k->parent_class.subsystem_vendor_id = proxy->subsystem_vendor_id;
> +    pci_set_word(pci_dev->config + PCI_SUBSYSTEM_VENDOR_ID, proxy->subsystem_vendor_id);
>  
>      if (!virtio_pci_modern(proxy) && !virtio_pci_legacy(proxy)) {
>          error_setg(errp, "device cannot work as neither modern nor legacy mode"
> @@ -1876,6 +1879,8 @@ static Property virtio_pci_properties[] = {
>                      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
>      DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
> +    DEFINE_PROP_UINT16("subsystem-vendor-id", VirtIOPCIProxy,
> +                       subsystem_vendor_id, PCI_VENDOR_ID_REDHAT_QUMRANET),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index 12d3a90..8a897ea 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -186,6 +186,7 @@ struct VirtIOPCIProxy {
>      VirtIOIRQFD *vector_irqfd;
>      int nvqs_with_notifiers;
>      VirtioBusState bus;
> +    uint16_t subsystem_vendor_id;
>  };
>  
>  static inline bool virtio_pci_modern(VirtIOPCIProxy *proxy)
> -- 
> 2.7.4
