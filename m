Received: from eggs.gnu.org ([2001:4830:134:3::10]:38057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVtqG-00081Q-R2
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 03:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVtqD-0006Tg-MT
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 03:17:16 -0400
Date: Thu, 21 Jun 2018 09:17:11 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180620052044.GA24636@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1806210900160.16898@zero.eik.bme.hu>
References: <cover.1529398335.git.balaton@eik.bme.hu>
	<ce619ddd11a875caae4c221c18ebf7c6a6f4bd4f.1529398335.git.balaton@eik.bme.hu>
	<20180620052044.GA24636@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v4 02/11] ppc4xx_i2c: Implement directcntl
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>

On Wed, 20 Jun 2018, David Gibson wrote:
> On Tue, Jun 19, 2018 at 10:52:15AM +0200, BALATON Zoltan wrote:
>> As well as being able to generate its own i2c transactions, the ppc4xx
>> i2c controller has a DIRECTCNTL register which allows explicit control
>> of the i2c lines.
>>
>> Using this register an OS can directly bitbang i2c operations. In
>> order to let emulated i2c devices respond to this, we need to wire up
>> the DIRECTCNTL register to qemu's bitbanged i2c handling code.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> v4: Updated commit message and use defined constant where
>> appropriate
>
> I'm still don't quite understand your approach to the symbolic
> constants here, but I don't care enough to hold this up any further.
> So, applied to ppc-for-3.0.

Thanks, just to try to clear this up, I consider symbolic constants to be 
the name of bits 0-3 in the directntl register so while MSCL equals 1 it's 
only appropriate to use the constant if I really mean (1 << 0) i.e. bit 0 
of directcntl reg.

>> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
>> index 4e0aaae..fca80d6 100644
>> --- a/hw/i2c/ppc4xx_i2c.c
>> +++ b/hw/i2c/ppc4xx_i2c.c
>> @@ -30,6 +30,7 @@
>>  #include "cpu.h"
>>  #include "hw/hw.h"
>>  #include "hw/i2c/ppc4xx_i2c.h"
>> +#include "bitbang_i2c.h"
>>
>>  #define PPC4xx_I2C_MEM_SIZE 18
>>
>> @@ -46,6 +47,11 @@
>>
>>  #define IIC_XTCNTLSS_SRST   (1 << 0)
>>
>> +#define IIC_DIRECTCNTL_SDAC (1 << 3)
>> +#define IIC_DIRECTCNTL_SCLC (1 << 2)
>> +#define IIC_DIRECTCNTL_MSDA (1 << 1)
>> +#define IIC_DIRECTCNTL_MSCL (1 << 0)
>> +
>>  static void ppc4xx_i2c_reset(DeviceState *s)
>>  {
>>      PPC4xxI2CState *i2c = PPC4xx_I2C(s);
>> @@ -289,7 +295,12 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
>>          i2c->xtcntlss = value;
>>          break;
>>      case 16:
>> -        i2c->directcntl = value & 0x7;
>> +        i2c->directcntl = value & (IIC_DIRECTCNTL_SDAC & IIC_DIRECTCNTL_SCLC);

This clears all bits but SDAC and SCLC so constants are OK here as they 
refer to bits in the register. (Guest can set the S* bits to say what 
state it wants the i2c lines to become.)

>> +        i2c->directcntl |= (value & IIC_DIRECTCNTL_SCLC ? 1 : 0);

This is directcntl[MSCL] = direcntl[SCLC] that is, set MSCL bit the same 
as SCLC, the 1 : 0 here are the value of the bit not the MSCL bit so 
constans are not appropriate here.

>> +        bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SCL,
>> +                        i2c->directcntl & IIC_DIRECTCNTL_MSCL);

This lets the bitbang_i2c emulation also know that MSCL is set to 1 or 0 
so constant here is OK, previously it was just 1 for brevity which may 
have confused you.

>> +        i2c->directcntl |= bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SDA,
>> +                               (value & IIC_DIRECTCNTL_SDAC) != 0) << 1;

This sets MSDA bit of directcntl to the value returned by bitbang_i2c 
emulation when sending it the bit in SDAC. So the
(value & IIC_DIRECTCNTL_SDAC) != 0)
tests what value the SDAC bit has so 0 means the value of the bit and 
constant refers to the bit in the register. (Because SDAC is not the LSB 
and we need 1 or 0 here hence the equality test to normalise the value, 
maybe the !! construct could also be used, I'm not sure.) The << 1 at the 
end makes sure we set the MSDA bit but that constant cannot be used here 
and using MSCL instead is not correct because we mean the MSDA bit.

In summary, guest sets SDAC and SCLC as it wants the i2c lines and MSDA 
and MSCL are set by the device to what state the lines are actually in. 
(The S in first two regs may stand for Set while M stands for Monitor.)

Regards,
BALATON Zoltan
