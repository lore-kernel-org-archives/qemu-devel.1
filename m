Received: from eggs.gnu.org ([2001:4830:134:3::10]:49177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cSTUr-0008Hb-Hy
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 13:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cSTUo-0004PJ-DV
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 13:56:13 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mar.krzeminski@gmail.com>)
	id 1cSTUo-0004PD-1G
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 13:56:10 -0500
Received: by mail-lf0-x242.google.com with SMTP id v186so8760569lfa.2
	for <qemu-devel@nongnu.org>; Sat, 14 Jan 2017 10:56:09 -0800 (PST)
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
	<1483979087-32663-12-git-send-email-clg@kaod.org>
	<b5660d74-0c16-871b-bec0-31a5a6e19f04@gmail.com>
	<9b1c1700-04cc-9b1e-6fdc-5ac84e5cd42e@kaod.org>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <e6c78999-f851-eb32-6244-80e85e0b5190@gmail.com>
Date: Sat, 14 Jan 2017 19:56:05 +0100
MIME-Version: 1.0
In-Reply-To: <9b1c1700-04cc-9b1e-6fdc-5ac84e5cd42e@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 11/11] aspeed/smc: handle dummy bytes
 when doing fast reads in command mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org



W dniu 11.01.2017 o 19:55, Cédric Le Goater pisze:
> On 01/11/2017 07:20 PM, mar.krzeminski wrote:
>> W dniu 09.01.2017 o 17:24, Cédric Le Goater pisze:
>>> When doing fast read, a certain amount of dummy bytes should be sent
>>> before the read. This number is configurable in the controler CE0
>>> Control Register and needs to be modeled using fake transfers the
>>> flash module.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>>> ---
>>>   hw/ssi/aspeed_smc.c | 21 +++++++++++++++++++++
>>>   1 file changed, 21 insertions(+)
>>>
>>>   Changes since v1:
>>>
>>>   - splitted user mode from command mode support.
>>>
>>> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
>>> index 28d563a5800f..7a76d3344df2 100644
>>> --- a/hw/ssi/aspeed_smc.c
>>> +++ b/hw/ssi/aspeed_smc.c
>>> @@ -69,7 +69,9 @@
>>>   #define R_CTRL0           (0x10 / 4)
>>>   #define   CTRL_CMD_SHIFT           16
>>>   #define   CTRL_CMD_MASK            0xff
>>> +#define   CTRL_DUMMY_HIGH_SHIFT    14
>>>   #define   CTRL_AST2400_SPI_4BYTE   (1 << 13)
>>> +#define   CTRL_DUMMY_LOW_SHIFT     6 /* 2 bits [7:6] */
>>>   #define   CTRL_CE_STOP_ACTIVE      (1 << 2)
>>>   #define   CTRL_CMD_MODE_MASK       0x3
>>>   #define     CTRL_READMODE          0x0
>>> @@ -141,6 +143,7 @@
>>>   
>>>   /* Flash opcodes. */
>>>   #define SPI_OP_READ       0x03    /* Read data bytes (low frequency) */
>>> +#define SPI_OP_READ_FAST  0x0b    /* Read data bytes (high frequency) */
>>>   
>>>   /*
>>>    * Default segments mapping addresses and size for each slave per
>>> @@ -490,10 +493,21 @@ static uint32_t aspeed_smc_check_segment_addr(const AspeedSMCFlash *fl,
>>>       return addr;
>>>   }
>>>   
>>> +static int aspeed_smc_flash_dummies(const AspeedSMCFlash *fl)
>>> +{
>>> +    const AspeedSMCState *s = fl->controller;
>>> +    uint32_t r_ctrl0 = s->regs[s->r_ctrl0 + fl->id];
>>> +    uint32_t dummy_high = (r_ctrl0 >> CTRL_DUMMY_HIGH_SHIFT) & 0x1;
>>> +    uint32_t dummy_low = (r_ctrl0 >> CTRL_DUMMY_LOW_SHIFT) & 0x3;
>>> +
>>> +    return ((dummy_high << 2) | dummy_low) * 8;
>>> +}
>>> +
>>>   static void aspeed_smc_flash_send_addr(AspeedSMCFlash *fl, uint32_t addr)
>>>   {
>>>       const AspeedSMCState *s = fl->controller;
>>>       uint8_t cmd = aspeed_smc_flash_cmd(fl);
>>> +    int i;
>>>   
>>>       /* Flash access can not exceed CS segment */
>>>       addr = aspeed_smc_check_segment_addr(fl, addr);
>>> @@ -506,6 +520,13 @@ static void aspeed_smc_flash_send_addr(AspeedSMCFlash *fl, uint32_t addr)
>>>       ssi_transfer(s->spi, (addr >> 16) & 0xff);
>>>       ssi_transfer(s->spi, (addr >> 8) & 0xff);
>>>       ssi_transfer(s->spi, (addr & 0xff));
>>> +
>>> +    /* Handle dummies in case of fast read */
>>> +    if (cmd == SPI_OP_READ_FAST) {
>> I feel this is wrong. It indicates that the controller knows FAST_READ op code.
> you are right. I should not be testing the SPI OP command code
> but the controller mode :
>
> 	CTRL_FREADMODE
>
>> I believe controller always try to send dummy cycles, and do not do this when
>> their count is set to 0 (so you do not need above if).
> Indeed. I will check If I can just drop the test then.
I did not notice that this function is also called in writes, isn't it?
If yes, dummy cycles are used only during reads so probably CTRL_FREADMODE
needs to be tested.

Thanks,
Marcin
>
> Thanks,
>
> C.
>
>> Thanks,
>> Marcin
>>> +        for (i = 0; i < aspeed_smc_flash_dummies(fl); i++) {
>>> +            ssi_transfer(fl->controller->spi, 0xFF);
>>> +        }
>>> +    }
>>>   }
>>>   
>>>   static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigned size)
>
