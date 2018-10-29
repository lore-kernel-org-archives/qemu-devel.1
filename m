Received: from eggs.gnu.org ([2001:4830:134:3::10]:37897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHD3D-0001dD-BV
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHD39-0007pw-7s
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:18:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHD38-0007pX-T5
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:18:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id y15-v6so9955666wru.9
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 12:18:06 -0700 (PDT)
References: <20181029170159.3801-1-sameo@linux.intel.com>
	<20181029170159.3801-9-sameo@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d3976f9e-0ece-8f7a-5a5e-7d57f4136ab3@redhat.com>
Date: Mon, 29 Oct 2018 20:18:02 +0100
MIME-Version: 1.0
In-Reply-To: <20181029170159.3801-9-sameo@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 08/19] hw: i386: Refactor PCI host getter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi Yang, Samuel.

On 29/10/18 18:01, Samuel Ortiz wrote:
> From: Yang Zhong <yang.zhong@intel.com>
> 
> Make it more flexible by having it parsing a PCI host paths array
> instead of open coding those paths deep down into the code logic itself.
> This will be needed for PCI machine types that are neither emulatiing the
> ich9 nor the i440fx chipsets.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>   hw/i386/acpi-build.c | 29 +++++++++++++++++++----------
>   1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index fdfd6f4ba2..35f95baca7 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -114,6 +114,12 @@ typedef struct AcpiBuildPciBusHotplugState {
>       bool pcihp_bridge_en;
>   } AcpiBuildPciBusHotplugState;
>   
> +static const char *pci_hosts[] = {
> +   "/machine/i440fx",
> +   "/machine/q35",
> +   NULL,
> +};
> +
>   static void init_common_fadt_data(Object *o, AcpiFadtData *data)
>   {
>       uint32_t io = object_property_get_uint(o, ACPI_PM_PROP_PM_IO_BASE, NULL);
> @@ -238,27 +244,30 @@ static void acpi_get_misc_info(AcpiMiscInfo *info)
>    * Because of the PXB hosts we cannot simply query TYPE_PCI_HOST_BRIDGE.
>    * On i386 arch we only have two pci hosts, so we can look only for them.
>    */
> -static Object *acpi_get_i386_pci_host(void)
> +static Object *acpi_get_pci_host(void)

I'd rather have the machine array passed as argument:

    static Object *acpi_get_pci_host(const char *machine_paths)

So in your next patch you keep the hw/acpi/aml-build.c namespace 
generic. You would also add this argument to acpi_get_pci_holes().

With this change:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>   {
>       PCIHostState *host;
> +    int i = 0;
>   
> -    host = OBJECT_CHECK(PCIHostState,
> -                        object_resolve_path("/machine/i440fx", NULL),
> -                        TYPE_PCI_HOST_BRIDGE);
> -    if (!host) {
> +    while (pci_hosts[i]) {
>           host = OBJECT_CHECK(PCIHostState,
> -                            object_resolve_path("/machine/q35", NULL),
> +                            object_resolve_path(pci_hosts[i], NULL),
>                               TYPE_PCI_HOST_BRIDGE);
> +        if (host) {
> +            return OBJECT(host);
> +        }
> +
> +        i++;
>       }
>   
> -    return OBJECT(host);
> +    return NULL;
>   }
>   
>   static void acpi_get_pci_holes(Range *hole, Range *hole64)
>   {
>       Object *pci_host;
>   
> -    pci_host = acpi_get_i386_pci_host();
> +    pci_host = acpi_get_pci_host();
>       g_assert(pci_host);
>   
>       range_set_bounds1(hole,
> @@ -1636,7 +1645,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>           Object *pci_host;
>           PCIBus *bus = NULL;
>   
> -        pci_host = acpi_get_i386_pci_host();
> +        pci_host = acpi_get_pci_host();
>           if (pci_host) {
>               bus = PCI_HOST_BRIDGE(pci_host)->bus;
>           }
> @@ -2009,7 +2018,7 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>       Object *pci_host;
>       QObject *o;
>   
> -    pci_host = acpi_get_i386_pci_host();
> +    pci_host = acpi_get_pci_host();
>       g_assert(pci_host);
>   
>       o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_BASE, NULL);
> 
