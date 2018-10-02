Received: from eggs.gnu.org ([2001:4830:134:3::10]:44857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SHb-0001y7-Ky
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SHX-0003Wo-Hf
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:32:43 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SHX-0003Wc-8L
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:32:39 -0400
Received: by mail-wm1-x344.google.com with SMTP id 193-v6so3579505wme.3
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 14:32:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-12-f4bug@amsat.org>
	<CACXAS8CcEu89HkP3HtT0snp_H8hc9HmEhX9-iK4e4W-035v-kQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c2ed96ae-0e94-c93a-5555-d661b59f9bb8@amsat.org>
Date: Tue, 2 Oct 2018 23:32:36 +0200
MIME-Version: 1.0
In-Reply-To: <CACXAS8CcEu89HkP3HtT0snp_H8hc9HmEhX9-iK4e4W-035v-kQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 11/15] hw/sparc/sun4m: Replace 'empty_slot'
 by 'unimplemented_device'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, clg@kaod.org, qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Hi Artyom,

On 10/2/18 10:14 AM, Artyom Tarasenko wrote:
> Hi Philippe,
> 
> On Tue, Oct 2, 2018 at 12:10 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> The TYPE_EMPTY_SLOT and TYPE_UNIMPLEMENTED_DEVICE are identical devices,
>> however the later use more recent APIs and is more widely used.
>>
>> Replace 'empty_slot' by 'unimplemented_device' to simplify devices code
>> maintenance.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  default-configs/sparc-softmmu.mak |  1 -
>>  hw/sparc/sun4m.c                  | 24 ++++++++++++++----------
>>  2 files changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/default-configs/sparc-softmmu.mak b/default-configs/sparc-softmmu.mak
>> index 12f97eeb20..7369b54467 100644
>> --- a/default-configs/sparc-softmmu.mak
>> +++ b/default-configs/sparc-softmmu.mak
>> @@ -8,7 +8,6 @@ CONFIG_ESCC=y
>>  CONFIG_M48T59=y
>>  CONFIG_PTIMER=y
>>  CONFIG_FDC=y
>> -CONFIG_EMPTY_SLOT=y
>>  CONFIG_PCNET_COMMON=y
>>  CONFIG_LANCE=y
>>  CONFIG_TCX=y
>> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
>> index 3c29b68e67..ca37acf7af 100644
>> --- a/hw/sparc/sun4m.c
>> +++ b/hw/sparc/sun4m.c
>> @@ -42,7 +42,7 @@
>>  #include "hw/nvram/chrp_nvram.h"
>>  #include "hw/nvram/fw_cfg.h"
>>  #include "hw/char/escc.h"
>> -#include "hw/empty_slot.h"
>> +#include "hw/misc/unimp.h"
>>  #include "hw/loader.h"
>>  #include "elf.h"
>>  #include "trace.h"
>> @@ -863,7 +863,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>>      ram_init(0, machine->ram_size, hwdef->max_mem);
>>      /* models without ECC don't trap when missing ram is accessed */
>>      if (!hwdef->ecc_base) {
>> -        empty_slot_init(machine->ram_size, hwdef->max_mem - machine->ram_size);
>> +        create_unimplemented_device("ecc", machine->ram_size,
>> +                                    hwdef->max_mem - machine->ram_size);
> 
> In this particular case of find the name UNIMPLEMENTED_DEVICE a bit
> misleading: there is nothing to implement for non-installed memory
> SIMMs. It's rather an unconnected device. And the name "ecc" is
> misleading too. These machines are not supposed to have any ECC.
> Maybe "unconnected-ram", "empty-ram-slot" or "empty-slot"?

OK. I'll rework on this patch later and resend in another series.

Thanks for your review!

Phil.

> Regards,
> Artyom
> 
>>      }
>>
>>      prom_init(hwdef->slavio_base, bios_name);
>> @@ -892,9 +893,10 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>>      if (hwdef->iommu_pad_base) {
>>          /* On the real hardware (SS-5, LX) the MMU is not padded, but aliased.
>>             Software shouldn't use aliased addresses, neither should it crash
>> -           when does. Using empty_slot instead of aliasing can help with
>> -           debugging such accesses */
>> -        empty_slot_init(hwdef->iommu_pad_base,hwdef->iommu_pad_len);
>> +           when does. Using the 'unimplemented device' instead of aliasing can
>> +           help with debugging such accesses */
>> +        create_unimplemented_device("iommu.alias", hwdef->iommu_pad_base,
>> +                                    hwdef->iommu_pad_len);
>>      }
>>
>>      sparc32_dma_init(hwdef->dma_base,
>> @@ -944,12 +946,13 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>>      for (i = num_vsimms; i < MAX_VSIMMS; i++) {
>>          /* vsimm registers probed by OBP */
>>          if (hwdef->vsimm[i].reg_base) {
>> -            empty_slot_init(hwdef->vsimm[i].reg_base, 0x2000);
>> +            create_unimplemented_device("vsimm", hwdef->vsimm[i].reg_base,
>> +                                        0x2000);
>>          }
>>      }
>>
>>      if (hwdef->sx_base) {
>> -        empty_slot_init(hwdef->sx_base, 0x2000);
>> +        create_unimplemented_device("sx", hwdef->sx_base, 0x2000);
>>      }
>>
>>      nvram = m48t59_init(slavio_irq[0], hwdef->nvram_base, 0, 0x2000, 1968, 8);
>> @@ -1012,14 +1015,15 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>>      if (hwdef->dbri_base) {
>>          /* ISDN chip with attached CS4215 audio codec */
>>          /* prom space */
>> -        empty_slot_init(hwdef->dbri_base+0x1000, 0x30);
>> +        create_unimplemented_device("dbri.prom", hwdef->dbri_base + 0x1000,
>> +                                    0x30);
>>          /* reg space */
>> -        empty_slot_init(hwdef->dbri_base+0x10000, 0x100);
>> +        create_unimplemented_device("dbri", hwdef->dbri_base + 0x10000, 0x100);
>>      }
>>
>>      if (hwdef->bpp_base) {
>>          /* parallel port */
>> -        empty_slot_init(hwdef->bpp_base, 0x20);
>> +        create_unimplemented_device("bpp", hwdef->bpp_base, 0x20);
>>      }
>>
>>      kernel_size = sun4m_load_kernel(machine->kernel_filename,
>> --
>> 2.19.0
>>
> 
> 
