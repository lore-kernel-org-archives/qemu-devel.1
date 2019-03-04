Received: from eggs.gnu.org ([209.51.188.92]:57729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1h0blB-0004ha-Ic
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 19:47:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1h0blA-0002zu-Qk
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 19:47:13 -0500
References: <1551407310-32413-1-git-send-email-guoheyi@huawei.com>
	<20190303183805-mutt-send-email-mst@kernel.org>
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <ca7be001-fc06-3852-cd0f-bf20eedc550d@huawei.com>
Date: Mon, 4 Mar 2019 08:46:43 +0800
MIME-Version: 1.0
In-Reply-To: <20190303183805-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/acpi: enable SHPC native hot plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wanghaibin.wang@huawei.com, Shannon Zhao <shannon.zhaosl@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Heyi Guo <heyi.guo@linaro.org>



On 2019/3/4 7:38, Michael S. Tsirkin wrote:
> On Fri, Mar 01, 2019 at 10:28:30AM +0800, Heyi Guo wrote:
>> After the introduction of generic PCIe root port and PCIe-PCI bridge,
>> we will also have SHPC controller on ARM, so just enalbe SHPC native
>> hot plug.
>>
>> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
>> Signed-off-by: Heyi Guo <heyi.guo@linaro.org>
> I don't think you need two Signed-off-by lines.
> Besides that:
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>
> Pls feel free to merge through the ARM tree.
Thanks, I'll change that and add your R-b, and send a v2 for some dear maintainer to commit it :)

Heyi

>
>> ---
>>   hw/arm/virt-acpi-build.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 04b62c7..7849ec5 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -265,7 +265,12 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>>           aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
>>       aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
>>       aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
>> -    aml_append(ifctx, aml_store(aml_and(aml_name("CTRL"), aml_int(0x1D), NULL),
>> +
>> +    /*
>> +     * Allow OS control for all 5 features:
>> +     * PCIeHotplug SHPCHotplug PME AER PCIeCapability.
>> +     */
>> +    aml_append(ifctx, aml_store(aml_and(aml_name("CTRL"), aml_int(0x1F), NULL),
>>                                   aml_name("CTRL")));
>>   
>>       ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
>> -- 
>> 1.8.3.1
> .
>
