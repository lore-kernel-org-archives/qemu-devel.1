Received: from eggs.gnu.org ([2001:4830:134:3::10]:33561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cDuwa-0005qf-TI
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:12:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cDuwU-0003mR-E9
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:12:40 -0500
References: <1480434248-27138-1-git-send-email-clg@kaod.org>
	<1480434248-27138-23-git-send-email-clg@kaod.org>
	<f3a5657c-39db-75a9-3bfc-25e5d03b7e1e@gmail.com>
	<09b0e4b9-faae-34aa-4042-aa3704c3457b@kaod.org>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <49894fce-5057-c17b-d511-f9806cea0917@gmail.com>
Date: Mon, 5 Dec 2016 16:12:22 +0100
MIME-Version: 1.0
In-Reply-To: <09b0e4b9-faae-34aa-4042-aa3704c3457b@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 22/30] aspeed/smc: handle dummy
 bytes when doing fast reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrew Jeffery <andrew@aj.id.au>, Marcin Krzeminski <marcin.krzeminski@nokia.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org



W dniu 05.12.2016 o 15:14, Cédric Le Goater pisze:
> On 12/04/2016 05:46 PM, mar.krzeminski wrote:
>>
>> W dniu 29.11.2016 o 16:44, Cédric Le Goater pisze:
>>> When doing fast read, a certain amount of dummy bytes should be sent
>>> before the read. This number is configurable in the controler CE0
>>> Control Register and needs to be modeled using fake transfers the
>>> flash module.
>>>
>>> When the controller is configured for Command mode, the SPI command
>>> used to do the read is stored in the CE0 control register but, in User
>>> mode, we need to snoop into the flow of bytes to catch the command. It
>>> should be the first byte after CS select.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>>> ---
>>>   hw/ssi/aspeed_smc.c         | 58 ++++++++++++++++++++++++++++++++++++++-------
>>>   include/hw/ssi/aspeed_smc.h |  1 +
>>>   2 files changed, 51 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
>>> index 9596ea94a3bc..733fd8b09c06 100644
>>> --- a/hw/ssi/aspeed_smc.c
>>> +++ b/hw/ssi/aspeed_smc.c
>>> @@ -71,7 +71,9 @@
>>>   #define R_CTRL0           (0x10 / 4)
>>>   #define   CTRL_CMD_SHIFT           16
>>>   #define   CTRL_CMD_MASK            0xff
>>> +#define   CTRL_DUMMY_HIGH_SHIFT    14
>>>   #define   CTRL_AST2400_SPI_4BYTE   (1 << 13)
>>> +#define   CTRL_DUMMY_LOW_SHIFT     6 /* 2 bits [7:6] */
>>>   #define   CTRL_CE_STOP_ACTIVE      (1 << 2)
>>>   #define   CTRL_CMD_MODE_MASK       0x3
>>>   #define     CTRL_READMODE          0x0
>>> @@ -151,6 +153,7 @@
>>>   #define SPI_OP_WRDI       0x04    /* Write disable */
>>>   #define SPI_OP_RDSR       0x05    /* Read status register */
>>>   #define SPI_OP_WREN       0x06    /* Write enable */
>>> +#define SPI_OP_READ_FAST  0x0b    /* Read data bytes (high frequency) */
>>>   
>>>   /* Used for Macronix and Winbond flashes. */
>>>   #define SPI_OP_EN4B       0xb7    /* Enter 4-byte mode */
>>> @@ -510,6 +513,12 @@ static void aspeed_smc_flash_setup_read(AspeedSMCFlash *fl, uint32_t addr)
>>>       /* access can not exceed CS segment */
>>>       addr = aspeed_smc_check_segment_addr(fl, addr);
>>>   
>>> +    /*
>>> +     * Remember command as we might need to send dummy bytes before
>>> +     * reading data
>>> +     */
>>> +    fl->cmd = cmd;
>>> +
>>>       /* TODO: do we have to send 4BYTE each time ? */
>>>       if (aspeed_smc_flash_is_4byte(fl)) {
>>>           ssi_transfer(s->spi, SPI_OP_EN4B);
>>> @@ -525,27 +534,50 @@ static void aspeed_smc_flash_setup_read(AspeedSMCFlash *fl, uint32_t addr)
>>>       ssi_transfer(s->spi, (addr & 0xff));
>>>   }
>>>   
>>> +static int aspeed_smc_flash_dummies(const AspeedSMCFlash *fl)
>>> +{
>>> +    AspeedSMCState *s = fl->controller;
>>> +    uint32_t r_ctrl0 = s->regs[s->r_ctrl0 + fl->id];
>>> +    uint32_t dummy_high = (r_ctrl0 >> CTRL_DUMMY_HIGH_SHIFT) & 0x1;
>>> +    uint32_t dummy_low = (r_ctrl0 >> CTRL_DUMMY_LOW_SHIFT) & 0x3;
>>> +
>>> +    return ((dummy_high << 2) | dummy_low) * 8;
>>> +}
>>> +
>>> +static uint64_t aspeed_smc_flash_do_read(AspeedSMCFlash *fl, unsigned size)
>>> +{
>>> +    AspeedSMCState *s = fl->controller;
>>> +    uint64_t ret = 0;
>>> +    int i;
>>> +
>>> +    if (fl->cmd == SPI_OP_READ_FAST) {
>>> +        for (i = 0; i < aspeed_smc_flash_dummies(fl); i++) {
>>> +            ssi_transfer(s->spi, 0x0);
>>> +        }
>>> +    }
>> Generally this is wrong, controller should be not aware of any command in user mode.
>> Currently you are forced to do this by m25p80c dummy cycles implementation.
>> I had no time to improve this since it need to update in Xilinx models, but maybe it is good place to talk about the solution.
>> I was thinking to add to ssi function transferN, and use it in flash models.
>> Firs introduce new state for dummy cycles in m25p80 and then:
> This new state would depend on the command op ? fastread would put
> the object in a dummy_cycle state ?
Yes, only when needed (so it will be all fast reads in single/dual/quad 
modes).
>
>> a) in case caller use ssi_transfer(transfer8 in flsh models) dummy count will be incremented by 8.
>> This should solve the problem when flash is connected to controller that is not aware about dummy cycles,
>> like this mode or clear SPI controller.
>> b) when caller use ssi_trasferN length (in bits) will be the number of dummy cycles.
>>
>> What is your opinion?
> when you have some time, please send a quick rfc patch for the API :)
> so that I can experiment on the aspeed controller.
Will do, can not promise when, but target is 2.9 :)

Thanks,
Marcin
>
> Thanks,
>
> C.
>
>>> +    fl->cmd = 0;
>>> +
>>> +    for (i = 0; i < size; i++) {
>>> +        ret |= ssi_transfer(s->spi, 0x0) << (8 * i);
>>> +    }
>>> +    return ret;
>>> +}
>>> +
>>>   static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigned size)
>>>   {
>>>       AspeedSMCFlash *fl = opaque;
>>> -    const AspeedSMCState *s = fl->controller;
>>>       uint64_t ret = 0;
>>> -    int i;
>>>   
>>>       switch (aspeed_smc_flash_mode(fl)) {
>>>       case CTRL_USERMODE:
>>> -        for (i = 0; i < size; i++) {
>>> -            ret |= ssi_transfer(s->spi, 0x0) << (8 * i);
>>> -        }
>>> +        ret = aspeed_smc_flash_do_read(fl, size);
>>>           break;
>>>       case CTRL_READMODE:
>>>       case CTRL_FREADMODE:
>>>           aspeed_smc_flash_select(fl);
>>>           aspeed_smc_flash_setup_read(fl, addr);
>>>   
>>> -        for (i = 0; i < size; i++) {
>>> -            ret |= ssi_transfer(s->spi, 0x0) << (8 * i);
>>> -        }
>>> +        ret = aspeed_smc_flash_do_read(fl, size);
>>>   
>>>           aspeed_smc_flash_unselect(fl);
>>>           break;
>>> @@ -596,6 +628,15 @@ static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t data,
>>>   
>>>       switch (aspeed_smc_flash_mode(fl)) {
>>>       case CTRL_USERMODE:
>>> +        /*
>>> +         * First write after chip select is the chip command. Remember
>>> +         * it as we might need to send dummy bytes before reading
>>> +         * data. It will be reseted when the chip is unselected.
>>> +         */
>>> +        if (!fl->cmd) {
>>> +            fl->cmd = data & 0xff;
>>> +        }
>>> +
>>>           for (i = 0; i < size; i++) {
>>>               ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
>>>           }
>>> @@ -629,6 +670,7 @@ static const MemoryRegionOps aspeed_smc_flash_ops = {
>>>   static void aspeed_smc_flash_update_cs(AspeedSMCFlash *fl)
>>>   {
>>>       AspeedSMCState *s = fl->controller;
>>> +    fl->cmd = 0;
>>>       qemu_set_irq(s->cs_lines[fl->id], aspeed_smc_is_ce_stop_active(fl));
>>>   }
>>>   
>>> diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
>>> index 88a904849801..3ae0a369073d 100644
>>> --- a/include/hw/ssi/aspeed_smc.h
>>> +++ b/include/hw/ssi/aspeed_smc.h
>>> @@ -52,6 +52,7 @@ typedef struct AspeedSMCFlash {
>>>   
>>>       uint8_t id;
>>>       uint32_t size;
>>> +    uint8_t cmd;
>>>   
>>>       MemoryRegion mmio;
>>>       DeviceState *flash;
>
