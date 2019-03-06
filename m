Received: from eggs.gnu.org ([209.51.188.92]:56435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h1TtB-0005B9-6c
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:35:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h1TtA-0005Ox-8Z
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:35:05 -0500
Date: Wed, 6 Mar 2019 11:34:52 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190306113452.688aae6d@redhat.com>
In-Reply-To: <1551823429-1440-2-git-send-email-guoheyi@huawei.com>
References: <1551823429-1440-1-git-send-email-guoheyi@huawei.com>
	<1551823429-1440-2-git-send-email-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] hw/arm/acpi: enable SHPC native hot
 plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Heyi Guo <guoheyi@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, wanghaibin.wang@huawei.com

On Wed, 6 Mar 2019 06:03:49 +0800
Heyi Guo <guoheyi@huawei.com> wrote:

> After the introduction of generic PCIe root port and PCIe-PCI bridge,
> we will also have SHPC controller on ARM, so just enalbe SHPC native
> hot plug.
> 
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> ---
>  hw/arm/virt-acpi-build.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 1c84e87..e8e00fe 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -265,7 +265,12 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>          aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
>      aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
>      aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
> -    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1D),
> +
> +    /*
> +     * Allow OS control for all 5 features:
> +     * PCIeHotplug SHPCHotplug PME AER PCIeCapability.
> +     */
> +    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1F),
>                                  aml_name("CTRL")));
ditto: fix indent

>  
>      ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
