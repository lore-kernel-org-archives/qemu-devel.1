Received: from eggs.gnu.org ([209.51.188.92]:59825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gziVx-0002uG-Mw
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:47:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gziVr-0002ig-Ar
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:47:49 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gziVq-0002ec-WA
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:47:43 -0500
Received: by mail-qt1-f196.google.com with SMTP id s1so27744882qte.5
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 05:47:40 -0800 (PST)
Date: Fri, 1 Mar 2019 08:47:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190301084619-mutt-send-email-mst@kernel.org>
References: <1551407310-32413-1-git-send-email-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551407310-32413-1-git-send-email-guoheyi@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] hw/arm/acpi: enable SHPC native hot plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Heyi Guo <guoheyi@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wanghaibin.wang@huawei.com, Shannon Zhao <shannon.zhaosl@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Heyi Guo <heyi.guo@linaro.org>

On Fri, Mar 01, 2019 at 10:28:30AM +0800, Heyi Guo wrote:
> After the introduction of generic PCIe root port and PCIe-PCI bridge,
> we will also have SHPC controller on ARM, so just enalbe SHPC native
> hot plug.
> 
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> Signed-off-by: Heyi Guo <heyi.guo@linaro.org>


So when OS enables SHPC, should we block ACPI hotplug events?


> ---
>  hw/arm/virt-acpi-build.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 04b62c7..7849ec5 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -265,7 +265,12 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>          aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
>      aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
>      aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
> -    aml_append(ifctx, aml_store(aml_and(aml_name("CTRL"), aml_int(0x1D), NULL),
> +
> +    /*
> +     * Allow OS control for all 5 features:
> +     * PCIeHotplug SHPCHotplug PME AER PCIeCapability.
> +     */
> +    aml_append(ifctx, aml_store(aml_and(aml_name("CTRL"), aml_int(0x1F), NULL),
>                                  aml_name("CTRL")));
>  
>      ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
> -- 
> 1.8.3.1
