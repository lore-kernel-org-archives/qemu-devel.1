Received: from eggs.gnu.org ([2001:4830:134:3::10]:41976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYw2k-000105-Qk
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:42:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYw2g-0001dN-Ed
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:42:26 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:38474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYw2g-0001cq-9C
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:42:22 -0500
Received: by mail-oi0-x242.google.com with SMTP id r65so10779963oie.5
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 07:42:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171228155832.05a9966b@igors-macbook-pro.local>
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-9-git-send-email-gengdongjiu@huawei.com>
	<20171228155832.05a9966b@igors-macbook-pro.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 15:42:00 +0000
Message-ID: <CAFEAcA8Zg6wikw+td9vkGG7S4YGJMr-2O7rkCx3Wp0RrSn2PdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v14 8/9] hw/arm/virt: Add RAS platform
 version for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, James Morse <james.morse@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, kvm-devel <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Huangshaoyu <huangshaoyu@huawei.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>, Xu Wei <xuwei5@hisilicon.com>

On 28 December 2017 at 14:58, Igor Mammedov <imammedo@redhat.com> wrote:
> On Thu, 28 Dec 2017 13:54:17 +0800
> Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>
>> Support this feature since version 2.10, disable it by
>> default in the old version.
> patch should go before acpi tables are actually added,
> otherwise it might break bisectability.
>
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>> Address Shannon's comments to add platform version in [1].
>>
>> [1]: https://lkml.org/lkml/2017/8/25/821
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>>  hw/arm/virt-acpi-build.c | 14 +++++++++-----
>>  hw/arm/virt.c            |  4 ++++
>>  include/hw/arm/virt.h    |  1 +
>>  3 files changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 06c14b3..b6974ef 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -801,10 +801,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>>      acpi_add_table(table_offsets, tables_blob);
>>      build_spcr(tables_blob, tables->linker, vms);
>>
>> -    acpi_add_table(table_offsets, tables_blob);
>> -    build_hardware_error_table(tables->hardware_errors, tables->linker);
>> -    build_apei_ghes(tables_blob, tables->hardware_errors, tables->linker);
>> -
>> +    if (!vmc->no_ras) {
>
> it's better to avoid no_foo, use something like
>
> vmc->has_ras

Fields in VirtMachineClass for this kind of thing tend to
end up having to be no_foo, because the default (false) must
be the setting for the most up to date version of the
virt board, because of the way the virt_machine_X_XX_options()
functions chain together. So no_ras matches the sense used
for all the existing bools in VirtMachineClass.

(In contrast, bools in the VirtMachineState struct are the
conventional sense, so there we have highmem/its/virt/etc.)

thanks
-- PMM
