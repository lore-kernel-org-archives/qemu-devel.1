Received: from eggs.gnu.org ([2001:4830:134:3::10]:45724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqiuu-00030E-0B
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqiuo-0005l6-Uk
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:52:07 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:50814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fqiuo-0005kh-Ng
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:52:02 -0400
Received: by mail-wm0-x244.google.com with SMTP id s12-v6so8333329wmc.0
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 10:52:02 -0700 (PDT)
References: <1533796513-23419-1-git-send-email-whois.zihan.yang@gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <74915968-f058-0a8b-1947-59b65e931e25@gmail.com>
Date: Fri, 17 Aug 2018 20:51:59 +0300
MIME-Version: 1.0
In-Reply-To: <1533796513-23419-1-git-send-email-whois.zihan.yang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC v4 5/6] pci_expander_bridge: Add ioport for
 pxb host bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>



On 08/09/2018 09:35 AM, Zihan Yang wrote:
> This enables seabios to read config file in pxb host bus other than sysbus
>
> Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
> ---
>   hw/pci-bridge/pci_expander_bridge.c         | 15 +++++++++++++++
>   include/hw/pci-bridge/pci_expander_bridge.h |  3 +++
>   2 files changed, 18 insertions(+)
>
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index c685c75..686b026 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -234,6 +234,20 @@ static void pxb_pcie_host_initfn(Object *obj)
>                            qdev_prop_allow_set_link_before_realize, 0, NULL);
>   }
>   
> +static void pxb_pcie_host_realize(DeviceState *dev, Error **errp)
> +{
> +    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    // FIX ME! Use specific port number for pxb-pcie host bridge, not scalable!
> +    /* port layout is | pxb1_cmd | pxb1_data | pxb2_cmd | pxb2_data | ... | */
> +    sysbus_add_io(sbd, PXB_PCIE_HOST_BRIDGE_CONFIG_ADDR_BASE, &pci->conf_mem);
> +    sysbus_init_ioports(sbd, PXB_PCIE_HOST_BRIDGE_CONFIG_ADDR_BASE + g_list_length(pxb_dev_list) * 8, 4);
> +
> +    sysbus_add_io(sbd, PXB_PCIE_HOST_BRIDGE_CONFIG_DATA_BASE, &pci->data_mem);
> +    sysbus_init_ioports(sbd, PXB_PCIE_HOST_BRIDGE_CONFIG_DATA_BASE + g_list_length(pxb_dev_list) * 8, 4);

Why do we need this functionality? Can't we access the pxb-pcie config 
space only with
MMCFG?

Thanks,
Marcel

> +}
> +
>   static Property pxb_pcie_host_props[] = {
>       DEFINE_PROP_UINT64(PCIE_HOST_MCFG_BASE, PXBPCIEHost, parent_obj.base_addr,
>                           PCIE_BASE_ADDR_UNMAPPED),
> @@ -262,6 +276,7 @@ static void pxb_pcie_host_class_init(ObjectClass *class, void *data)
>   
>       dc->fw_name = "pcie";
>       dc->props = pxb_pcie_host_props;
> +    dc->realize = pxb_pcie_host_realize;
>       /* Reason: Internal part of the pxb/pxb-pcie device, not usable by itself */
>       dc->user_creatable = false;
>       sbc->explicit_ofw_unit_address = pxb_host_ofw_unit_address;
> diff --git a/include/hw/pci-bridge/pci_expander_bridge.h b/include/hw/pci-bridge/pci_expander_bridge.h
> index 1119210..e6d3b67 100644
> --- a/include/hw/pci-bridge/pci_expander_bridge.h
> +++ b/include/hw/pci-bridge/pci_expander_bridge.h
> @@ -7,6 +7,9 @@
>   #define PROP_PXB_PCIE_DOMAIN_NR "domain_nr"
>   #define PROP_PXB_BUS_NR "bus_nr"
>   
> +#define PXB_PCIE_HOST_BRIDGE_CONFIG_ADDR_BASE 0x1000
> +#define PXB_PCIE_HOST_BRIDGE_CONFIG_DATA_BASE 0x1004
> +
>   uint64_t pxb_pcie_mcfg_hole(void);
>   
>   #endif
