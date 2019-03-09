Received: from eggs.gnu.org ([209.51.188.92]:42882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1h2RoJ-0001wf-G4
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 21:34:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1h2RoI-0006gg-P6
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 21:34:03 -0500
References: <1551879417-21031-1-git-send-email-guoheyi@huawei.com>
	<1551879417-21031-2-git-send-email-guoheyi@huawei.com>
	<20190306173420.3614a38b@Igors-MacBook-Pro.local>
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <266bac89-2be1-3ee7-55c3-74053918ae66@huawei.com>
Date: Sat, 9 Mar 2019 10:33:46 +0800
MIME-Version: 1.0
In-Reply-To: <20190306173420.3614a38b@Igors-MacBook-Pro.local>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/2] hw/arm/acpi: simplify AML bit
 and/or statement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon
	Zhao <shannon.zhaosl@gmail.com>, wanghaibin.wang@huawei.com



On 2019/3/7 0:34, Igor Mammedov wrote:
> On Wed, 6 Mar 2019 21:36:56 +0800
> Heyi Guo <guoheyi@huawei.com> wrote:
>
>> The last argument of AML bit and/or statement is the target variable,
>> so we don't need to use a NULL target and then an additional store
>> operation; a single bit and/or statement is enough.
> s: a single bit and/or : using just aml_and() or aml_and() "
>
> With commit message fixed up:
>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Thanks; have fixed it in v5.

Heyi

>
>> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
>> ---
>>   hw/arm/virt-acpi-build.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index d7e2e48..cebec4c 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -265,17 +265,17 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>>           aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
>>       aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
>>       aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
>> -    aml_append(ifctx, aml_store(aml_and(aml_name("CTRL"), aml_int(0x1D), NULL),
>> -                                aml_name("CTRL")));
>> +    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1D),
>> +                              aml_name("CTRL")));
>>   
>>       ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
>> -    aml_append(ifctx1, aml_store(aml_or(aml_name("CDW1"), aml_int(0x08), NULL),
>> -                                 aml_name("CDW1")));
>> +    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
>> +                              aml_name("CDW1")));
>>       aml_append(ifctx, ifctx1);
>>   
>>       ifctx1 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), aml_name("CTRL"))));
>> -    aml_append(ifctx1, aml_store(aml_or(aml_name("CDW1"), aml_int(0x10), NULL),
>> -                                 aml_name("CDW1")));
>> +    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x10),
>> +                              aml_name("CDW1")));
>>       aml_append(ifctx, ifctx1);
>>   
>>       aml_append(ifctx, aml_store(aml_name("CTRL"), aml_name("CDW3")));
>> @@ -283,8 +283,8 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>>       aml_append(method, ifctx);
>>   
>>       elsectx = aml_else();
>> -    aml_append(elsectx, aml_store(aml_or(aml_name("CDW1"), aml_int(4), NULL),
>> -                                  aml_name("CDW1")));
>> +    aml_append(elsectx, aml_or(aml_name("CDW1"), aml_int(4),
>> +                               aml_name("CDW1")));
>>       aml_append(elsectx, aml_return(aml_arg(3)));
>>       aml_append(method, elsectx);
>>       aml_append(dev, method);
>
> .
>
