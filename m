Received: from eggs.gnu.org ([209.51.188.92]:36342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1h15uS-0002LG-Ae
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 03:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1h15uQ-0007fU-Bm
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 03:58:48 -0500
References: <1551705934-28745-1-git-send-email-guoheyi@huawei.com>
	<20190304162711.105e09f2@redhat.com>
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <8f872106-a268-5adb-8c54-f09c1f90f491@huawei.com>
Date: Tue, 5 Mar 2019 16:58:19 +0800
MIME-Version: 1.0
In-Reply-To: <20190304162711.105e09f2@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/arm/acpi: enable SHPC native hot plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wanghaibin.wang@huawei.com, Shannon Zhao <shannon.zhaosl@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>



On 2019/3/4 23:27, Igor Mammedov wrote:
> On Mon, 4 Mar 2019 21:25:34 +0800
> Heyi Guo <guoheyi@huawei.com> wrote:
>
>> After the introduction of generic PCIe root port and PCIe-PCI bridge,
>> we will also have SHPC controller on ARM, so just enalbe SHPC native
>> hot plug.
>>
>> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
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
> aml_store here is excessive, you can use shorter variant that x86 uses
>
>   aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
>
> the last argument of aml_and() is the target var where to store computation result

Indeed. I'm going to generate a separate patch to fix this first and then apply SHPC patch.

Thanks,
Heyi

>
>>   
>>       ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
>
> .
>
