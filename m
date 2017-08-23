Received: from eggs.gnu.org ([2001:4830:134:3::10]:38320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dkSi8-0005WM-8k
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 06:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dkSi3-0004bc-9z
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 06:16:32 -0400
Date: Wed, 23 Aug 2017 12:16:24 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20170823023945.GM5379@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1708231108430.76247@zero.eik.bme.hu>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<ac6a19d43a6d36ae6f7cab99a1ac25d2515339ad.1503249785.git.balaton@eik.bme.hu>
	<20170823023945.GM5379@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH 13/15] ppc4xx: Add more PLB registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>

On Wed, 23 Aug 2017, David Gibson wrote:
> On Sun, Aug 20, 2017 at 07:23:05PM +0200, BALATON Zoltan wrote:
>> These registers are present in 440 SoCs (and maybe in others too) and
>> U-Boot accesses them when printing register info. We don't emulate
>> these but add them to avoid crashing when they are read or written.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> I'm ok with stub implementation, but I'm a bit uncomfortable with
> registering these DCRs unconditionally rather than just on the chips
> that actually implement them.

Problem is that I don't know which chips have these. I can only try to 
find out from the U-Boot sources where a comment says these are common 
registers for all SoCs (in u-boot/arch/powerpc/include/asm/ppc4xx.h:

http://git.denx.de/?p=u-boot.git;a=blob;f=arch/powerpc/include/asm/ppc4xx.h;h=45ff5dbacd9243e83bb2f6551e2dd64a7e544bf5;hb=e2351d5cf1e97408b4c52bafeaa85e0ca85c920c

while looking for this I've just noticed that u-boot has removed ppc440 
support just before 2017.07-rc3 so this is the last version that still has 
these files). So if that's true it should be OK for 405 too.

>> ---
>>  hw/ppc/ppc405_uc.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
>> index e621d0a..8e58065 100644
>> --- a/hw/ppc/ppc405_uc.c
>> +++ b/hw/ppc/ppc405_uc.c
>> @@ -105,9 +105,12 @@ ram_addr_t ppc405_set_bootinfo (CPUPPCState *env, ppc4xx_bd_info_t *bd,
>>  /*****************************************************************************/
>>  /* Peripheral local bus arbitrer */
>>  enum {
>> -    PLB0_BESR = 0x084,
>> -    PLB0_BEAR = 0x086,
>> -    PLB0_ACR  = 0x087,
>> +    PLB3A0_ACR = 0x077,
>> +    PLB4A0_ACR = 0x081,
>> +    PLB0_BESR  = 0x084,
>> +    PLB0_BEAR  = 0x086,
>> +    PLB0_ACR   = 0x087,
>> +    PLB4A1_ACR = 0x089,
>>  };
>>
>>  typedef struct ppc4xx_plb_t ppc4xx_plb_t;
>> @@ -179,9 +182,12 @@ void ppc4xx_plb_init(CPUPPCState *env)
>>      ppc4xx_plb_t *plb;
>>
>>      plb = g_malloc0(sizeof(ppc4xx_plb_t));
>> +    ppc_dcr_register(env, PLB3A0_ACR, plb, &dcr_read_plb, &dcr_write_plb);
>> +    ppc_dcr_register(env, PLB4A0_ACR, plb, &dcr_read_plb, &dcr_write_plb);
>>      ppc_dcr_register(env, PLB0_ACR, plb, &dcr_read_plb, &dcr_write_plb);
>>      ppc_dcr_register(env, PLB0_BEAR, plb, &dcr_read_plb, &dcr_write_plb);
>>      ppc_dcr_register(env, PLB0_BESR, plb, &dcr_read_plb, &dcr_write_plb);
>> +    ppc_dcr_register(env, PLB4A1_ACR, plb, &dcr_read_plb, &dcr_write_plb);
>>      qemu_register_reset(ppc4xx_plb_reset, plb);
>>  }
>>
>
>
