Received: from eggs.gnu.org ([2001:4830:134:3::10]:48434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dlRBM-0003ls-QN
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 22:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dlRBL-0002CJ-Sn
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 22:50:44 -0400
References: <1503066227-18251-1-git-send-email-gengdongjiu@huawei.com>
	<1503066227-18251-3-git-send-email-gengdongjiu@huawei.com>
	<599ECE95.10205@huawei.com>
	<9a878b42-c480-2c7b-0f04-202193d8c56b@huawei.com>
	<59A0C9FE.5010204@huawei.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <27894653-ff09-7839-a46d-b41b9ee8ae48@huawei.com>
Date: Sat, 26 Aug 2017 10:49:44 +0800
MIME-Version: 1.0
In-Reply-To: <59A0C9FE.5010204@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 2/6] ACPI: Add APEI GHES Table
 Generation support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>, lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, edk2-devel@lists.01.org, christoffer.dall@linaro.org, marc.zyngier@arm.com, will.deacon@arm.com, james.morse@arm.com, tbaicar@codeaurora.org, ard.biesheuvel@linaro.org, mingo@kernel.org, bp@suse.de, shiju.jose@huawei.com, zjzhang@codeaurora.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, john.garry@huawei.com, jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com, huangdaode@hisilicon.com, wangzhou1@hisilicon.com
Cc: huangshaoyu@huawei.com, wuquanming@huawei.com, linuxarm@huawei.com, zhengqiang10@huawei.com

Hi Shannon,

On 2017/8/26 9:08, Shannon Zhao wrote:
> 
> 
> On 2017/8/25 19:20, gengdongjiu wrote:
>>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>>>>>> index 3d78ff6..def1ec1 100644
>>>>>> --- a/hw/arm/virt-acpi-build.c
>>>>>> +++ b/hw/arm/virt-acpi-build.c
>>>>>> @@ -45,6 +45,7 @@
>>>>>>  #include "hw/arm/virt.h"
>>>>>>  #include "sysemu/numa.h"
>>>>>>  #include "kvm_arm.h"
>>>>>> +#include "hw/acpi/hest_ghes.h"
>>>>>>  
>>>>>>  #define ARM_SPI_BASE 32
>>>>>>  #define ACPI_POWER_BUTTON_DEVICE "PWRB"
>>>>>> @@ -771,6 +772,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>>>>>>      acpi_add_table(table_offsets, tables_blob);
>>>>>>      build_spcr(tables_blob, tables->linker, vms);
>>>>>>  
>>>>>> +    acpi_add_table(table_offsets, tables_blob);
>>>>>> +    ghes_build_acpi(tables_blob, tables->hardware_errors, tables->linker);
>>>>>> +
>>>> So we add this table unconditionally. Is there any bad impact if QEMU
>>>> runs on old kvm? Does it need to check whether KVM supports RAS?
>> this table is added before guest OS boot. so can not use KVM to check it.
> No, we can check the RAS capability when we create vcpus like you done
> in another patch ans can use that in table generation.
understand your meaning.

ARM James ever have below comments about the table generation.
----------------------------------------------------------------------------------
But you can use APEI in a guest on CPUs without the RAS extensions: the host may
signal memory errors to Qemu for any number of reasons, user-space shouldn't
care how it knows. Examples are PCI-AER, any APEI event notified by polling or
one of the flavours of irq.

I would expect Qemu to generate a HEST based on its abilities, i.e. if it
supports any mechanism of notifying the guest about errors. Choosing the
mechanism then depends on the type of error.

Ideally the Qemu code for HEST/GHES/CPER generation code using some of the irqs
and polling could be shared with x86, as these should be possible using common
KVM APIs.
-----------------------------------------------------------------------------------

He means we can use APEI on CPUs without RAS and may be share this code with x86,
if Qemu can support any mechanism of notifying the guest about errors, it should be
generate the table.
Now we depend on the macro KVM_HAVE_MCE_INJECTION to decide whether Qemu can support
notifying the guest.

what do you think which we should be dependent on to generate the table?

> 
>> if the old kvm does not support RAS, it does not have bad impact. only waste table memory.
>> May be we can make it as device? if this device is enabled in the qemu
>> boot parameters, then we will add this table?
>>
> 
> And you need to add a option to virt machine for (migration)
> compatibility. On new virt machine it's on by default while off for old
> ones.
ok.

> 
> Thanks,
> 
