Received: from eggs.gnu.org ([209.51.188.92]:56274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h1TsQ-0004ac-3P
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h1TsP-0002bW-61
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:34:18 -0500
Date: Wed, 6 Mar 2019 11:33:54 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190306113354.5a98654b@redhat.com>
In-Reply-To: <1551823429-1440-1-git-send-email-guoheyi@huawei.com>
References: <1551823429-1440-1-git-send-email-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] hw/arm/acpi: simplify AML bit
 and/or statement
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

On Wed, 6 Mar 2019 06:03:48 +0800
Heyi Guo <guoheyi@huawei.com> wrote:

> The last argument of AML bit and/or statement is the target variable,
> so we don't need to use a NULL target and then an additional store
> operation; a single bit and/or statement is enough.
> 
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> ---
>  hw/arm/virt-acpi-build.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 04b62c7..1c84e87 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -265,16 +265,16 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>          aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
>      aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
>      aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
> -    aml_append(ifctx, aml_store(aml_and(aml_name("CTRL"), aml_int(0x1D), NULL),
> +    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1D),
>                                  aml_name("CTRL")));
pls fix indent in all such cases. I'd align it like this:
   aml_append(ifctx,
              aml_and(aml_name("CTRL"), aml_int(0x1D), aml_name("CTRL")));

or
   aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1D),
                             aml_name("CTRL")));


PS:
When making multi-patch series use --cover-letter git option

>  
>      ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
> -    aml_append(ifctx1, aml_store(aml_or(aml_name("CDW1"), aml_int(0x08), NULL),
> +    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
>                                   aml_name("CDW1")));
>      aml_append(ifctx, ifctx1);
>  
>      ifctx1 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), aml_name("CTRL"))));
> -    aml_append(ifctx1, aml_store(aml_or(aml_name("CDW1"), aml_int(0x10), NULL),
> +    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x10),
>                                   aml_name("CDW1")));
>      aml_append(ifctx, ifctx1);
>  
> @@ -283,7 +283,7 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>      aml_append(method, ifctx);
>  
>      elsectx = aml_else();
> -    aml_append(elsectx, aml_store(aml_or(aml_name("CDW1"), aml_int(4), NULL),
> +    aml_append(elsectx, aml_or(aml_name("CDW1"), aml_int(4),
>                                    aml_name("CDW1")));
>      aml_append(elsectx, aml_return(aml_arg(3)));
>      aml_append(method, elsectx);
