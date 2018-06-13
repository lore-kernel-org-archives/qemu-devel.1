Received: from eggs.gnu.org ([2001:4830:134:3::10]:40301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fT6Mx-0006WO-Qs
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fT6Mr-0008Eg-K0
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:03:27 -0400
Date: Wed, 13 Jun 2018 16:03:18 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180613100302.GJ30690@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1806131544190.90524@zero.eik.bme.hu>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<d13ea58b288f386a12a76c41a617c500c4454341.1528291908.git.balaton@eik.bme.hu>
	<20180613012236.GQ30690@umbus.fritz.box>
	<alpine.BSF.2.21.1806131051410.620@zero.eik.bme.hu>
	<20180613100302.GJ30690@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 3/8] ppc4xx_i2c: Implement directcntl
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

On Wed, 13 Jun 2018, David Gibson wrote:
> On Wed, Jun 13, 2018 at 10:54:22AM +0200, BALATON Zoltan wrote:
>> On Wed, 13 Jun 2018, David Gibson wrote:
>>> On Wed, Jun 06, 2018 at 03:31:48PM +0200, BALATON Zoltan wrote:
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>>  default-configs/ppc-softmmu.mak    |  1 +
>>>>  default-configs/ppcemb-softmmu.mak |  1 +
>>>>  hw/i2c/ppc4xx_i2c.c                | 14 +++++++++++++-
>>>>  3 files changed, 15 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
>>>> index 4d7be45..7d0dc2f 100644
>>>> --- a/default-configs/ppc-softmmu.mak
>>>> +++ b/default-configs/ppc-softmmu.mak
>>>> @@ -26,6 +26,7 @@ CONFIG_USB_EHCI_SYSBUS=y
>>>>  CONFIG_SM501=y
>>>>  CONFIG_IDE_SII3112=y
>>>>  CONFIG_I2C=y
>>>> +CONFIG_BITBANG_I2C=y
>>>>
>>>>  # For Macs
>>>>  CONFIG_MAC=y
>>>> diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-softmmu.mak
>>>> index 67d18b2..37af193 100644
>>>> --- a/default-configs/ppcemb-softmmu.mak
>>>> +++ b/default-configs/ppcemb-softmmu.mak
>>>> @@ -19,3 +19,4 @@ CONFIG_USB_EHCI_SYSBUS=y
>>>>  CONFIG_SM501=y
>>>>  CONFIG_IDE_SII3112=y
>>>>  CONFIG_I2C=y
>>>> +CONFIG_BITBANG_I2C=y
>>>> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
>>>> index a68b5f7..5806209 100644
>>>> --- a/hw/i2c/ppc4xx_i2c.c
>>>> +++ b/hw/i2c/ppc4xx_i2c.c
>>>> @@ -30,6 +30,7 @@
>>>>  #include "cpu.h"
>>>>  #include "hw/hw.h"
>>>>  #include "hw/i2c/ppc4xx_i2c.h"
>>>> +#include "bitbang_i2c.h"
>>>>
>>>>  #define PPC4xx_I2C_MEM_SIZE 18
>>>>
>>>> @@ -46,7 +47,13 @@
>>>>
>>>>  #define IIC_XTCNTLSS_SRST   (1 << 0)
>>>>
>>>> +#define IIC_DIRECTCNTL_SDAC (1 << 3)
>>>> +#define IIC_DIRECTCNTL_SCLC (1 << 2)
>>>> +#define IIC_DIRECTCNTL_MSDA (1 << 1)
>>>> +#define IIC_DIRECTCNTL_MSCL (1 << 0)
>>>> +
>>>>  typedef struct {
>>>> +    bitbang_i2c_interface *bitbang;
>>>>      uint8_t mdata;
>>>>      uint8_t lmadr;
>>>>      uint8_t hmadr;
>>>> @@ -308,7 +315,11 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
>>>>          i2c->xtcntlss = value;
>>>>          break;
>>>>      case 16:
>>>> -        i2c->directcntl = value & 0x7;
>>>> +        i2c->directcntl = value & (IIC_DIRECTCNTL_SDAC & IIC_DIRECTCNTL_SCLC);
>>>> +        i2c->directcntl |= (value & IIC_DIRECTCNTL_SCLC ? 1 : 0);
>>>> +        bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SCL, i2c->directcntl & 1);
>>>
>>> Shouldn't that use i2c->directcntl & IIC_DIRECTCNTL_MSCL ?
>>>
>>>> +        i2c->directcntl |= bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SDA,
>>>> +                               (value & IIC_DIRECTCNTL_SDAC) != 0) << 1;
>>>
>>> Last expression might be clearer as:
>>> 	value & IIC_DIRECTCNTL_SDAC ? IIC_DIRECTCNTL_MSDA : 0
>>
>> I guess this is a matter of taste but to me IIC_DIRECTCNTL_MSDA is a bit
>> position in the register so I use that when accessing that bit but when I
>> check for the values of a bit being 0 or 1 I don't use the define which is
>> for something else, just happens to have value 1 as well.
>
> Hmm.. but the bit is being store in i2c->directcntl, which means it
> can be read back from the register in that position, no?

Which of the above two do you mean?

In the first one I test for the 1/0 value set by the previous line before 
the bitbang_i2c_set call. This could be accessed as MSCL later but using 
that here would just make it longer and less obvious. If I want to be 
absolutely precise maybe it should be (value & IIC_DIRECTCNTL_SCL ? 1 : 0) 
in this line too but that was just stored in the register one line before 
so I can reuse that here as well. Otherwise I could add another variable 
just for this bit value and use that in both lines but why make it more 
complicated for a simple 1 or 0 value?

In the second case using MSDA is really not correct because the level to 
set is defined by SDAC bit. The SDAC, SCLC bits are what the program sets 
to tell which states the two i2c lines should be and the MSDA, MSCL are 
read only bits that show what states the lines really are.

IIC_DIRECTCNTL_MSDA has value of 1 but it means the second bit in the 
directcntl reg (which could have 0 or 1 value) not 1 value of a bit or i2c 
line.

Regards,
BALATON Zoltan
