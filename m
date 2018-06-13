Received: from eggs.gnu.org ([2001:4830:134:3::10]:57535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fT1Xv-0006oL-VM
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fT1Xs-0005ot-Pb
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:54:28 -0400
Date: Wed, 13 Jun 2018 10:54:22 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180613012236.GQ30690@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1806131051410.620@zero.eik.bme.hu>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<d13ea58b288f386a12a76c41a617c500c4454341.1528291908.git.balaton@eik.bme.hu>
	<20180613012236.GQ30690@umbus.fritz.box>
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
> On Wed, Jun 06, 2018 at 03:31:48PM +0200, BALATON Zoltan wrote:
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  default-configs/ppc-softmmu.mak    |  1 +
>>  default-configs/ppcemb-softmmu.mak |  1 +
>>  hw/i2c/ppc4xx_i2c.c                | 14 +++++++++++++-
>>  3 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
>> index 4d7be45..7d0dc2f 100644
>> --- a/default-configs/ppc-softmmu.mak
>> +++ b/default-configs/ppc-softmmu.mak
>> @@ -26,6 +26,7 @@ CONFIG_USB_EHCI_SYSBUS=y
>>  CONFIG_SM501=y
>>  CONFIG_IDE_SII3112=y
>>  CONFIG_I2C=y
>> +CONFIG_BITBANG_I2C=y
>>
>>  # For Macs
>>  CONFIG_MAC=y
>> diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-softmmu.mak
>> index 67d18b2..37af193 100644
>> --- a/default-configs/ppcemb-softmmu.mak
>> +++ b/default-configs/ppcemb-softmmu.mak
>> @@ -19,3 +19,4 @@ CONFIG_USB_EHCI_SYSBUS=y
>>  CONFIG_SM501=y
>>  CONFIG_IDE_SII3112=y
>>  CONFIG_I2C=y
>> +CONFIG_BITBANG_I2C=y
>> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
>> index a68b5f7..5806209 100644
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
>> @@ -46,7 +47,13 @@
>>
>>  #define IIC_XTCNTLSS_SRST   (1 << 0)
>>
>> +#define IIC_DIRECTCNTL_SDAC (1 << 3)
>> +#define IIC_DIRECTCNTL_SCLC (1 << 2)
>> +#define IIC_DIRECTCNTL_MSDA (1 << 1)
>> +#define IIC_DIRECTCNTL_MSCL (1 << 0)
>> +
>>  typedef struct {
>> +    bitbang_i2c_interface *bitbang;
>>      uint8_t mdata;
>>      uint8_t lmadr;
>>      uint8_t hmadr;
>> @@ -308,7 +315,11 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
>>          i2c->xtcntlss = value;
>>          break;
>>      case 16:
>> -        i2c->directcntl = value & 0x7;
>> +        i2c->directcntl = value & (IIC_DIRECTCNTL_SDAC & IIC_DIRECTCNTL_SCLC);
>> +        i2c->directcntl |= (value & IIC_DIRECTCNTL_SCLC ? 1 : 0);
>> +        bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SCL, i2c->directcntl & 1);
>
> Shouldn't that use i2c->directcntl & IIC_DIRECTCNTL_MSCL ?
>
>> +        i2c->directcntl |= bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SDA,
>> +                               (value & IIC_DIRECTCNTL_SDAC) != 0) << 1;
>
> Last expression might be clearer as:
> 	value & IIC_DIRECTCNTL_SDAC ? IIC_DIRECTCNTL_MSDA : 0

I guess this is a matter of taste but to me IIC_DIRECTCNTL_MSDA is a bit 
position in the register so I use that when accessing that bit but when I 
check for the values of a bit being 0 or 1 I don't use the define which is 
for something else, just happens to have value 1 as well.

If this does not explain your question and you think it's better to use 
defines here I can change that in next version, please let me know.

Regards,
BALATON Zoltan
