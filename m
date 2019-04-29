Received: from eggs.gnu.org ([209.51.188.92]:58737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL87n-00047A-C2
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL87m-0004tX-BX
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:23:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hL87m-0004t8-57
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:23:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so14610217wmf.5
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:23:22 -0700 (PDT)
References: <20190427165504.29846-1-philmd@redhat.com>
	<20190427165504.29846-2-philmd@redhat.com>
	<bca8bc52-50fc-575e-718f-8590b47fa1f8@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <03341f11-db3d-3066-5687-3702bae0860b@redhat.com>
Date: Mon, 29 Apr 2019 17:23:13 +0200
MIME-Version: 1.0
In-Reply-To: <bca8bc52-50fc-575e-718f-8590b47fa1f8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/acpi: Simplify the Makefile logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Samuel Ortiz <sameo@linux.intel.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Yang Zhong <yang.zhong@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Igor Mammedov <imammedo@redhat.com>

7On 4/29/19 5:21 PM, Thomas Huth wrote:
> On 27/04/2019 18.55, Philippe Mathieu-Daudé wrote:
>> Since we only require to link with acpi-stub.o when CONFIG_ACPI
>> is disabled, we can simplify the Makefile logic.
>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/acpi/Makefile.objs | 10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
>> index 2d46e3789ae..c86edfbed90 100644
>> --- a/hw/acpi/Makefile.objs
>> +++ b/hw/acpi/Makefile.objs
>> @@ -1,4 +1,3 @@
>> -ifeq ($(CONFIG_ACPI),y)
>>  common-obj-$(CONFIG_ACPI_X86) += core.o piix4.o pcihp.o
>>  common-obj-$(CONFIG_ACPI_X86_ICH) += ich9.o tco.o
>>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu_hotplug.o
>> @@ -6,16 +5,11 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
>>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
>>  common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
>>  common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
>> -common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
>> -
>>  common-obj-y += acpi_interface.o
>>  common-obj-y += bios-linker-loader.o
>>  common-obj-y += aml-build.o
> 
> What about these three object files? We don't want to build them if
> CONFIG_ACPI is disabled, do we?

Indeed. This was fixed in the v2:
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04721.html

> 
>  Thomas
> 
> 
>>  common-obj-$(CONFIG_TPM) += tpm.o
>> -
>>  common-obj-$(CONFIG_IPMI) += ipmi.o
>> +
>>  common-obj-$(call lnot,$(CONFIG_IPMI)) += ipmi-stub.o
>> -else
>> -common-obj-y += acpi-stub.o
>> -endif
>> -common-obj-$(CONFIG_ALL) += acpi-stub.o ipmi-stub.o
>> +common-obj-$(call lnot,$(CONFIG_ACPI)) += acpi-stub.o
>>
> 
