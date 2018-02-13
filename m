Received: from eggs.gnu.org ([2001:4830:134:3::10]:47859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1elf5D-0003tn-Ul
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:13:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1elf5D-000584-0X
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:13:35 -0500
Date: Tue, 13 Feb 2018 20:13:27 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180213200450-mutt-send-email-mst@kernel.org>
References: <20180213170712.18239-1-andrew.smirnov@gmail.com>
	<20180213170712.18239-2-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213170712.18239-2-andrew.smirnov@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/3] pci: Add support for Designware IP
 block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel.apfelbaum@zoho.com>, qemu-devel@nongnu.org, yurovsky@gmail.com

On Tue, Feb 13, 2018 at 09:07:10AM -0800, Andrey Smirnov wrote:
> +static void designware_pcie_root_class_init(ObjectClass *klass, void *data)
> +{
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +
> +    k->vendor_id = PCI_VENDOR_ID_SYNOPSYS;
> +    k->device_id = 0xABCD;
> +    k->revision = 0;
> +    k->class_id = PCI_CLASS_BRIDGE_PCI;
> +    k->is_express = true;
> +    k->is_bridge = true;
> +    k->exit = pci_bridge_exitfn;
> +    k->realize = designware_pcie_root_realize;
> +    k->config_read = designware_pcie_root_config_read;
> +    k->config_write = designware_pcie_root_config_write;
> +
> +    dc->reset = pci_bridge_reset;
> +    /*
> +     * PCI-facing part of the host bridge, not usable without the
> +     * host-facing part, which can't be device_add'ed, yet.
> +     */
> +    dc->user_creatable = false;
> +    dc->vmsd = &vmstate_designware_pcie_root;
> +}
> +
> +static uint64_t designware_pcie_host_mmio_read(void *opaque, hwaddr addr,
> +                                               unsigned int size)
> +{
> +    PCIHostState *pci = PCI_HOST_BRIDGE(opaque);
> +    PCIDevice *device = pci_find_device(pci->bus, 0, 0);
> +
> +    return pci_host_config_read_common(device,
> +                                       addr,
> +                                       pci_config_size(device),
> +                                       size);
> +}
> +
> +static void designware_pcie_host_mmio_write(void *opaque, hwaddr addr,
> +                                            uint64_t val, unsigned int size)
> +{
> +    PCIHostState *pci = PCI_HOST_BRIDGE(opaque);
> +    PCIDevice *device = pci_find_device(pci->bus, 0, 0);
> +
> +    return pci_host_config_write_common(device,
> +                                        addr,
> +                                        pci_config_size(device),
> +                                        val, size);
> +}
> +
> +static const MemoryRegionOps designware_pci_mmio_ops = {
> +    .read       = designware_pcie_host_mmio_read,
> +    .write      = designware_pcie_host_mmio_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .impl = {
> +        /*
> +         * Our device would not work correctly if the guest was doing
> +         * unaligned access. This might not be a limitation on the real
> +         * device but in practice there is no reason for a guest to access
> +         * this device unaligned.
> +         */
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +};

Could you pls add some comments explaining why is DEVICE_NATIVE_ENDIAN
appropriate here?  Most of these cases are plain "we never bothered
about cross-endian setups". Some are "there's a mix of different
endian-ness values, need to handle in a special way".

I suspect you really need DEVICE_LITTLE_ENDIAN.

-- 
MST
