Received: from eggs.gnu.org ([209.51.188.92]:58060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMEa3-00005Z-Eo
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMEZv-00044h-7Z
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:29:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMEZu-00043r-W2
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:28:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id b188so3864843wmb.0
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 09:28:58 -0700 (PDT)
References: <20190428064731.29913-1-philmd@redhat.com>
	<20190428064731.29913-2-philmd@redhat.com>
	<20190502132437.GI6623@minyard.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9657d158-b952-b30e-f8ab-64b32e42a41c@redhat.com>
Date: Thu, 2 May 2019 18:28:56 +0200
MIME-Version: 1.0
In-Reply-To: <20190502132437.GI6623@minyard.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/6] hw/acpi: Move the IPMI stub to the
 stubs/ directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org
Cc: qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Hi Corey,

On 5/2/19 3:24 PM, Corey Minyard wrote:
> On Sun, Apr 28, 2019 at 08:47:26AM +0200, Philippe Mathieu-Daudé wrote:
>> Move the IPMI stub file to the stubs/ directory to simplify the
>> hw/acpi Makefile.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> I'm not sure of the overall view of this, but this is ok from an
> IPMI point of view in my view.

IIRC I had linking failure when building with Kconfig +ACPI -IPMI on
MIPS/PPC (series will come on top of this one).

I'll verify, I only looked at MIPS but it seems UEFI firmwares also use
it on PPC and ARM (currently the ACPI table is only built on X86).

Also I'll might rename stubs/ipmi.c -> stubs/acpi-ipmi.c.

> 
> Acked-by: Corey Minyard <cminyard@mvista.com>

Thanks for the review!

> 
>> ---
>>  MAINTAINERS                         | 1 +
>>  hw/acpi/Makefile.objs               | 3 +--
>>  stubs/Makefile.objs                 | 1 +
>>  hw/acpi/ipmi-stub.c => stubs/ipmi.c | 0
>>  4 files changed, 3 insertions(+), 2 deletions(-)
>>  rename hw/acpi/ipmi-stub.c => stubs/ipmi.c (100%)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 23db6f8408a..e1681eca5cb 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1309,6 +1309,7 @@ S: Maintained
>>  F: include/hw/ipmi/*
>>  F: hw/ipmi/*
>>  F: hw/smbios/smbios_type_38.c
>> +F: stubs/ipmi.c
>>  F: tests/ipmi*
>>  T: git https://github.com/cminyard/qemu.git master-ipmi-rebase
>>  
>> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
>> index 2d46e3789ae..4e302feb885 100644
>> --- a/hw/acpi/Makefile.objs
>> +++ b/hw/acpi/Makefile.objs
>> @@ -14,8 +14,7 @@ common-obj-y += aml-build.o
>>  common-obj-$(CONFIG_TPM) += tpm.o
>>  
>>  common-obj-$(CONFIG_IPMI) += ipmi.o
>> -common-obj-$(call lnot,$(CONFIG_IPMI)) += ipmi-stub.o
>>  else
>>  common-obj-y += acpi-stub.o
>>  endif
>> -common-obj-$(CONFIG_ALL) += acpi-stub.o ipmi-stub.o
>> +common-obj-$(CONFIG_ALL) += acpi-stub.o
>> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
>> index 269dfa58326..36bb9ff0b1d 100644
>> --- a/stubs/Makefile.objs
>> +++ b/stubs/Makefile.objs
>> @@ -9,6 +9,7 @@ stub-obj-y += error-printf.o
>>  stub-obj-y += fdset.o
>>  stub-obj-y += gdbstub.o
>>  stub-obj-y += get-vm-name.o
>> +stub-obj-y += ipmi.o
>>  stub-obj-y += iothread.o
>>  stub-obj-y += iothread-lock.o
>>  stub-obj-y += is-daemonized.o
>> diff --git a/hw/acpi/ipmi-stub.c b/stubs/ipmi.c
>> similarity index 100%
>> rename from hw/acpi/ipmi-stub.c
>> rename to stubs/ipmi.c
>> -- 
>> 2.20.1
>>
