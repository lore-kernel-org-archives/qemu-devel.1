Received: from eggs.gnu.org ([2001:4830:134:3::10]:48283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSOzN-00044O-IG
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSOzM-0004DU-AY
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:44:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180611011501.10235-1-f4bug@amsat.org>
	<20180611011501.10235-33-f4bug@amsat.org>
	<alpine.BSF.2.21.1806110959440.5957@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d04f4485-3b07-3b19-458d-0372ee131fca@amsat.org>
Date: Mon, 11 Jun 2018 12:44:02 -0300
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1806110959440.5957@zero.eik.bme.hu>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v4 32/40] hw/ppc: Use the IEC
 binary prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, "open list:sPAPR" <qemu-ppc@nongnu.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>

Hi Zoltan,

On 06/11/2018 05:09 AM, BALATON Zoltan wrote:
> On Sun, 10 Jun 2018, Philippe Mathieu-Daudé wrote:
>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>> index 2a98c10664..b35e3fff1c 100644
>> --- a/hw/ppc/sam460ex.c
>> +++ b/hw/ppc/sam460ex.c
>> @@ -12,8 +12,9 @@
>>  */
>>
>> #include "qemu/osdep.h"
>> +#include "qemu/units.h"
>> #include "qemu-common.h"
>> -#include "qemu/cutils.h"
>> +#include "qemu/units.h"
> 
> I think one of these includes of qemu/units.h is enough.

Oops :) Rebase mistake.

> 
>> #include "qemu/error-report.h"
>> #include "qapi/error.h"
>> #include "hw/hw.h"
>> @@ -46,7 +47,7 @@
>> /* from Sam460 U-Boot include/configs/Sam460ex.h */
>> #define FLASH_BASE             0xfff00000
>> #define FLASH_BASE_H           0x4
>> -#define FLASH_SIZE             (1 << 20)
>> +#define FLASH_SIZE             (1 * MiB)
>> #define UBOOT_LOAD_BASE        0xfff80000
>> #define UBOOT_SIZE             0x00080000
>> #define UBOOT_ENTRY            0xfffffffc
>> @@ -71,7 +72,8 @@
>>
>> /* FIXME: See u-boot.git 8ac41e, also fix in ppc440_uc.c */
>> static const unsigned int ppc460ex_sdram_bank_sizes[] = {
>> -    1024 << 20, 512 << 20, 256 << 20, 128 << 20, 64 << 20, 32 << 20, 0
>> +    1 * GiB, 512 * MiB, 256 * MiB, 128 * MiB,
>> +    64 * MiB, 32 * MiB, 0
>> };
> 
> You said elsewhere:
> 
> On Sun, 10 Jun 2018, Philippe Mathieu-Daudé wrote:
>> Each use this saves 3 char of the 80 columns limit!

This was versus the M_BYTE/G_BYTE definitions, now I noticed the ML ate
this patch...
(it supposed to be 31/41 here)
http://patchew.org/QEMU/20180415234307.28132-1-f4bug@amsat.org/

Where the diff was:

 static const unsigned int ppc460ex_sdram_bank_sizes[] = {
-    1024 << 20, 512 << 20, 256 << 20, 128 << 20, 64 << 20, 32 << 20, 0
+    1 * G_BYTE, 512 * M_BYTE, 256 * M_BYTE, 128 * M_BYTE,
+    64 * M_BYTE, 32 * M_BYTE, 0
 };

> Except when not but at least should not be longer than before and maybe
> more readable. But why are you splitting this line into two? I prefer
> one line for readability if it's not over the line limit.

Sure, as it fits.

> 
>> struct boot_info {
>> @@ -225,7 +227,7 @@ static int sam460ex_load_uboot(void)
>>     fl_sectors = (bios_size + 65535) >> 16;
>>
>>     if (!pflash_cfi01_register(base, NULL, "sam460ex.flash", bios_size,
>> -                               blk, (64 * 1024), fl_sectors,
>> +                               blk, 64 * KiB, fl_sectors,
>>                                1, 0x89, 0x18, 0x0000, 0x0, 1)) {
>>         error_report("qemu: Error registering flash memory.");
>>         /* XXX: return an error instead? */
>> @@ -359,14 +361,14 @@ static void main_cpu_reset(void *opaque)
>>
>>     /* either we have a kernel to boot or we jump to U-Boot */
>>     if (bi->entry != UBOOT_ENTRY) {
>> -        env->gpr[1] = (16 << 20) - 8;
>> +        env->gpr[1] = (16 * MiB) - 8;
>>         env->gpr[3] = FDT_ADDR;
>>         env->nip = bi->entry;
>>
>>         /* Create a mapping for the kernel.  */
>>         mmubooke_create_initial_mapping(env, 0, 0);
>>         env->gpr[6] = tswap32(EPAPR_MAGIC);
>> -        env->gpr[7] = (16 << 20) - 8; /*bi->ima_size;*/
>> +        env->gpr[7] = (16 * MiB) - 8; /* bi->ima_size; */
>>
>>     } else {
>>         env->nip = UBOOT_ENTRY;
>> @@ -479,8 +481,8 @@ static void sam460ex_init(MachineState *machine)
>>     /* 256K of L2 cache as memory */
>>     ppc4xx_l2sram_init(env);
>>     /* FIXME: remove this after fixing l2sram mapping in ppc440_uc.c? */
>> -    memory_region_init_ram(l2cache_ram, NULL, "ppc440.l2cache_ram",
>> 256 << 10,
>> -                           &error_abort);
>> +    memory_region_init_ram(l2cache_ram, NULL, "ppc440.l2cache_ram",
>> +                           256 * KiB, &error_abort);
> 
> Line is split differently here too for no apparent reason.

Same explanation:

+    memory_region_init_ram(l2cache_ram, NULL, "ppc440.l2cache_ram",
+                           256 * K_BYTE, &error_abort);

I'll update.

> 
> Regards,
> BALATON Zoltan
