Received: from eggs.gnu.org ([209.51.188.92]:52505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h3JTE-0008R5-VC
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h3JSD-0004ox-Qn
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:50:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h3JSD-0004nW-K0
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:50:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id o9so4721132wrv.9
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 04:50:49 -0700 (PDT)
References: <20190311005618.19007-1-philmd@redhat.com>
	<20190311005618.19007-8-philmd@redhat.com>
	<7c16b3f7-32b7-14c8-5c5f-3826df7c02f3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cd6ea9c1-fd8a-4af7-69ca-e78e4f26a2e3@redhat.com>
Date: Mon, 11 Mar 2019 12:50:47 +0100
MIME-Version: 1.0
In-Reply-To: <7c16b3f7-32b7-14c8-5c5f-3826df7c02f3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 7/7] hw/mips: Express dependencies of
 the Fulong 2E machine with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: James Hogan <jhogan@kernel.org>, Yang Zhong <yang.zhong@intel.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 3/11/19 12:25 PM, Thomas Huth wrote:
> On 11/03/2019 01.56, Philippe Mathieu-Daudé wrote:
>> The Fulong 2E machine uses a Loongson 2E as CPU, a Bonito64 system
>> controller as North Bridge and a VT82C686 chipset as South Bridge.
>> The network card chipset is a RTL8139D.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> v3: Loongson 2E = CPU, Fulong 2E = machine (Aleksandar)
>> ---
>>  default-configs/mips64el-softmmu.mak |  3 ---
>>  hw/isa/Kconfig                       | 13 +++++++++----
>>  hw/mips/Kconfig                      |  5 +++++
>>  3 files changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips64el-softmmu.mak
>> index 88b66a91d7..d0814e76af 100644
>> --- a/default-configs/mips64el-softmmu.mak
>> +++ b/default-configs/mips64el-softmmu.mak
>> @@ -1,9 +1,6 @@
>>  # Default configuration for mips64el-softmmu
>>  
>>  include mips-softmmu-common.mak
>> -CONFIG_IDE_VIA=y
>>  CONFIG_FULONG=y
>> -CONFIG_PCI_BONITO=y
> 
> I think I'd rather squash the previous patch into this one here (and
> adjust the patch description here with some information about BONITO),
> so that you don't have to remove the switch again that you've just added
> one patch earlier.

I find it clearer this way... And easier for the PCI maintainers to review.

> 
>>  CONFIG_JAZZ=y
>> -CONFIG_VT82C686=y
>>  CONFIG_MIPS_BOSTON=y
>> diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
>> index 57e09a0cb8..30055aed82 100644
>> --- a/hw/isa/Kconfig
>> +++ b/hw/isa/Kconfig
>> @@ -32,10 +32,15 @@ config PIIX4
>>  
>>  config VT82C686
>>      bool
>> -    select ISA_BUS
>> -    select ACPI_SMBUS
>> -    select SERIAL_ISA
>> -    select FDC
>> +    select PCI
>> +    select I8259
>> +    select I8254
>> +    select I8257
>> +    select PARALLEL
>> +    select IDE_ISA
>> +    select IDE_VIA
>> +    select USB_UHCI
>> +    #select PCKBD
> 
> Why is this commented out? Please mention the reason either in the
> commit message or in an additional comment here.

Oops I missed this while rebasing.
I commented this because I was not sure how to express the "USB Legacy
Support", I couldn't find reference to this feature in the USB specs.
It looks something the southbridge manufacturers use to emulate an i8042
controller for USB keyboard/mouse.
Gerd any idea?

Thomas, what about adding in hw/usb/Kconfig:

  config USB_LEGACY_PS2_SUPPORT
      # Emulated i8042
      select I8042

>>  config SMC37C669
>>      bool
>> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
>> index bd6e3be2cd..b06d70bf01 100644
>> --- a/hw/mips/Kconfig
>> +++ b/hw/mips/Kconfig
>> @@ -43,6 +43,11 @@ config JAZZ
>>  
>>  config FULONG
>>      bool
>> +    select PCI_BONITO
>> +    select VT82C686
>> +    select SMBUS_EEPROM
>> +    select RTL8139_PCI
> 
> I'd suggest to use "imply RTL8139_PCI" here instead, since "-net none"
> should be possible for this machine, too.

This chipset is soldered onboard, so I'd rather keep it that way...

The -net option is confusing IMHO.

Thought?
