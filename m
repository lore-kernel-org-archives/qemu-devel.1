Received: from eggs.gnu.org ([2001:4830:134:3::10]:33540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1dlPbl-0002E8-A5
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 21:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1dlPbk-00024C-9q
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 21:09:53 -0400
Message-ID: <59A0C9FE.5010204@huawei.com>
Date: Sat, 26 Aug 2017 09:08:14 +0800
From: Shannon Zhao <zhaoshenglong@huawei.com>
MIME-Version: 1.0
References: <1503066227-18251-1-git-send-email-gengdongjiu@huawei.com>
	<1503066227-18251-3-git-send-email-gengdongjiu@huawei.com>
	<599ECE95.10205@huawei.com>
	<9a878b42-c480-2c7b-0f04-202193d8c56b@huawei.com>
In-Reply-To: <9a878b42-c480-2c7b-0f04-202193d8c56b@huawei.com>
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
To: gengdongjiu <gengdongjiu@huawei.com>, lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, edk2-devel@lists.01.org, christoffer.dall@linaro.org, marc.zyngier@arm.com, will.deacon@arm.com, james.morse@arm.com, tbaicar@codeaurora.org, ard.biesheuvel@linaro.org, mingo@kernel.org, bp@suse.de, shiju.jose@huawei.com, zjzhang@codeaurora.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, john.garry@huawei.com, jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com, huangdaode@hisilicon.com, wangzhou1@hisilicon.com
Cc: huangshaoyu@huawei.com, wuquanming@huawei.com, linuxarm@huawei.com, zhengqiang10@huawei.com



On 2017/8/25 19:20, gengdongjiu wrote:
>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>>> >> index 3d78ff6..def1ec1 100644
>>> >> --- a/hw/arm/virt-acpi-build.c
>>> >> +++ b/hw/arm/virt-acpi-build.c
>>> >> @@ -45,6 +45,7 @@
>>> >>  #include "hw/arm/virt.h"
>>> >>  #include "sysemu/numa.h"
>>> >>  #include "kvm_arm.h"
>>> >> +#include "hw/acpi/hest_ghes.h"
>>> >>  
>>> >>  #define ARM_SPI_BASE 32
>>> >>  #define ACPI_POWER_BUTTON_DEVICE "PWRB"
>>> >> @@ -771,6 +772,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>>> >>      acpi_add_table(table_offsets, tables_blob);
>>> >>      build_spcr(tables_blob, tables->linker, vms);
>>> >>  
>>> >> +    acpi_add_table(table_offsets, tables_blob);
>>> >> +    ghes_build_acpi(tables_blob, tables->hardware_errors, tables->linker);
>>> >> +
>> > So we add this table unconditionally. Is there any bad impact if QEMU
>> > runs on old kvm? Does it need to check whether KVM supports RAS?
> this table is added before guest OS boot. so can not use KVM to check it.
No, we can check the RAS capability when we create vcpus like you done
in another patch ans can use that in table generation.

> if the old kvm does not support RAS, it does not have bad impact. only waste table memory.
> May be we can make it as device? if this device is enabled in the qemu
> boot parameters, then we will add this table?
> 

And you need to add a option to virt machine for (migration)
compatibility. On new virt machine it's on by default while off for old
ones.

Thanks,
-- 
Shannon
