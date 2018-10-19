Received: from eggs.gnu.org ([2001:4830:134:3::10]:39114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDXkT-00067v-IT
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDXkQ-0001D7-9A
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:35:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDXkP-00019I-SK
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:35:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id n1-v6so38073857wrt.10
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 09:35:37 -0700 (PDT)
References: <1539954845-26716-1-git-send-email-thuth@redhat.com>
	<1539954845-26716-6-git-send-email-thuth@redhat.com>
	<CAFEAcA_NkdZtbM9n4633_hSr38eb9FJsi92=+Eeuky+U=eDtZA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6ea8c64f-272f-6645-8a2f-b94117a24027@redhat.com>
Date: Fri, 19 Oct 2018 18:35:30 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_NkdZtbM9n4633_hSr38eb9FJsi92=+Eeuky+U=eDtZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/5] configs: Add a CONFIG_SMC37C669 switch
 for the "smc37c669-superio" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 19/10/2018 16:46, Peter Maydell wrote:
> On 19 October 2018 at 14:14, Thomas Huth <thuth@redhat.com> wrote:
>> This device is not user-creatable and currently only used for the
>> "alpha" target. So if the user does not want to compile alpha-softmmu,
>> we should also not compile this device. Add a proper config switch to
>> be able to compile this more flexibly.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  default-configs/alpha-softmmu.mak | 1 +
>>  hw/isa/Makefile.objs              | 3 ++-
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
>> index bbe361f..eb58b40 100644
>> --- a/default-configs/alpha-softmmu.mak
>> +++ b/default-configs/alpha-softmmu.mak
>> @@ -19,3 +19,4 @@ CONFIG_IDE_CMD646=y
>>  CONFIG_I8259=y
>>  CONFIG_MC146818RTC=y
>>  CONFIG_ISA_TESTDEV=y
>> +CONFIG_SMC37C669=y
>> diff --git a/hw/isa/Makefile.objs b/hw/isa/Makefile.objs
>> index 83e06f6..9e106df 100644
>> --- a/hw/isa/Makefile.objs
>> +++ b/hw/isa/Makefile.objs
>> @@ -1,9 +1,10 @@
>>  common-obj-$(CONFIG_ISA_BUS) += isa-bus.o
>> -common-obj-$(CONFIG_ISA_BUS) += isa-superio.o smc37c669-superio.o
>> +common-obj-$(CONFIG_ISA_BUS) += isa-superio.o
>>  common-obj-$(CONFIG_APM) += apm.o
>>  common-obj-$(CONFIG_I82378) += i82378.o
>>  common-obj-$(CONFIG_PC87312) += pc87312.o
>>  common-obj-$(CONFIG_PIIX4) += piix4.o
>>  common-obj-$(CONFIG_VT82C686) += vt82c686.o
>> +common-obj-$(CONFIG_SMC37C669) += smc37c669-superio.o
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> Should isa-superio.o also go in its own config flag?

It could be, but pc87312/smc37c669/vt82c686 inherit of TYPE_ISA_SUPERIO
so would require something like:

common-obj-$(call land,$(CONFIG_ISA_SUPERIO),$(CONFIG_PC87312)) \
            += pc87312.o
common-obj-$(call land,$(CONFIG_ISA_SUPERIO),$(CONFIG_VT82C686)) \
            += vt82c686.o
common-obj-$(call land,$(CONFIG_ISA_SUPERIO),$(CONFIG_SMC37C669)) \
            += smc37c669-superio.o

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> thanks
> -- PMM
> 
