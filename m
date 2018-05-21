Received: from eggs.gnu.org ([2001:4830:134:3::10]:32956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fKidU-0005dX-Nx
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fKidQ-00064g-PZ
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:05:52 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:45531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fKidQ-00064E-GH
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:05:48 -0400
Received: by mail-wr0-x22b.google.com with SMTP id w3-v6so7866894wrl.12
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 04:05:48 -0700 (PDT)
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-3-git-send-email-whois.zihan.yang@gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <5f5a0e11-7048-ff5a-ec0c-8d05d50c2887@gmail.com>
Date: Mon, 21 May 2018 14:05:45 +0300
MIME-Version: 1.0
In-Reply-To: <1526801333-30613-3-git-send-email-whois.zihan.yang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC 2/3] pci: Link pci_host_bridges with QTAILQ
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



On 05/20/2018 10:28 AM, Zihan Yang wrote:
> QLIST will place the original q35 host bridge at the end of list because it is
> added first. Replace it with QTAILQ to make q35 at the first of queue, which
> makes it convinient and compatible when there are pxb hosts other than q35 hosts

I have no objection here, we'll see later how the modification helps.

Thanks,
Marcek

> Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
> ---
>   hw/pci/pci.c              | 9 +++++----
>   include/hw/pci/pci_host.h | 2 +-
>   2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 80bc459..ddc27ba 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -196,7 +196,8 @@ static void pci_del_option_rom(PCIDevice *pdev);
>   static uint16_t pci_default_sub_vendor_id = PCI_SUBVENDOR_ID_REDHAT_QUMRANET;
>   static uint16_t pci_default_sub_device_id = PCI_SUBDEVICE_ID_QEMU;
>   
> -static QLIST_HEAD(, PCIHostState) pci_host_bridges;
> +static QTAILQ_HEAD(, PCIHostState) pci_host_bridges =
> +    QTAILQ_HEAD_INITIALIZER(pci_host_bridges);
>   
>   int pci_bar(PCIDevice *d, int reg)
>   {
> @@ -330,7 +331,7 @@ static void pci_host_bus_register(DeviceState *host)
>   {
>       PCIHostState *host_bridge = PCI_HOST_BRIDGE(host);
>   
> -    QLIST_INSERT_HEAD(&pci_host_bridges, host_bridge, next);
> +    QTAILQ_INSERT_TAIL(&pci_host_bridges, host_bridge, next);
>   }
>   
>   PCIBus *pci_device_root_bus(const PCIDevice *d)
> @@ -1798,7 +1799,7 @@ PciInfoList *qmp_query_pci(Error **errp)
>       PciInfoList *info, *head = NULL, *cur_item = NULL;
>       PCIHostState *host_bridge;
>   
> -    QLIST_FOREACH(host_bridge, &pci_host_bridges, next) {
> +    QTAILQ_FOREACH(host_bridge, &pci_host_bridges, next) {
>           info = g_malloc0(sizeof(*info));
>           info->value = qmp_query_pci_bus(host_bridge->bus,
>                                           pci_bus_num(host_bridge->bus));
> @@ -2493,7 +2494,7 @@ int pci_qdev_find_device(const char *id, PCIDevice **pdev)
>       PCIHostState *host_bridge;
>       int rc = -ENODEV;
>   
> -    QLIST_FOREACH(host_bridge, &pci_host_bridges, next) {
> +    QTAILQ_FOREACH(host_bridge, &pci_host_bridges, next) {
>           int tmp = pci_qdev_find_recursive(host_bridge->bus, id, pdev);
>           if (!tmp) {
>               rc = 0;
> diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
> index ba31595..a5617cf 100644
> --- a/include/hw/pci/pci_host.h
> +++ b/include/hw/pci/pci_host.h
> @@ -47,7 +47,7 @@ struct PCIHostState {
>       uint32_t config_reg;
>       PCIBus *bus;
>   
> -    QLIST_ENTRY(PCIHostState) next;
> +    QTAILQ_ENTRY(PCIHostState) next;
>   };
>   
>   typedef struct PCIHostBridgeClass {
