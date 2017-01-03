Received: from eggs.gnu.org ([2001:4830:134:3::10]:33313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cOMfy-0001Ch-BH
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 05:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cOMft-0000BC-3J
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 05:50:42 -0500
Received: from 1.mo1.mail-out.ovh.net ([178.32.127.22]:53352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cOMfs-0000B4-N5
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 05:50:36 -0500
Received: from player691.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 5F0253504F
	for <qemu-devel@nongnu.org>; Tue,  3 Jan 2017 11:50:33 +0100 (CET)
References: <1480434248-27138-1-git-send-email-clg@kaod.org>
	<1480434248-27138-18-git-send-email-clg@kaod.org>
	<0fa6e0f2-2965-cbdc-3d22-5a4c74fc6772@gmail.com>
	<27bcad02-54fc-dbf9-f5f9-5b178ddb2ddd@kaod.org>
	<212a15c5-565c-434a-1387-250fa8f8f559@gmail.com>
	<9a5a321f-0d5e-d798-07c2-ad30c29d6a1d@kaod.org>
	<c6b1e60f-e0e9-f9a0-0e36-c82443191a6d@gmail.com>
	<d4b65172-e4f6-a379-11c7-0565479c2bdb@kaod.org>
	<57a42c1f-132b-f6c9-bb16-de161e4ec33a@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3a19ced5-7f26-af0a-0716-b7e28a70704c@kaod.org>
Date: Tue, 3 Jan 2017 11:50:24 +0100
MIME-Version: 1.0
In-Reply-To: <57a42c1f-132b-f6c9-bb16-de161e4ec33a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 17/30] aspeed/smc: handle SPI flash
 Command mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "mar.krzeminski" <mar.krzeminski@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 01/02/2017 07:21 PM, mar.krzeminski wrote:
>=20
>=20
> W dniu 02.01.2017 o 19:02, C=C3=A9dric Le Goater pisze:
>> On 01/02/2017 06:33 PM, mar.krzeminski wrote:
>>> Hello Cedric,
>>>
>>> W dniu 02.01.2017 o 16:56, C=C3=A9dric Le Goater pisze:
>>>> Hello Marcin,
>>>>
>>>> On 12/05/2016 04:33 PM, mar.krzeminski wrote:
>>>>> W dniu 05.12.2016 o 15:07, C=C3=A9dric Le Goater pisze:
>>>>>> On 12/04/2016 05:31 PM, mar.krzeminski wrote:
>>>>>>> Hi Cedric,
>>>>>>>
>>>>>>> Since there is no public datasheet user guide for SMC I would ask=
 some question
>>>>>>> regarding HW itself because I got impression that you are impleme=
nting in this
>>>>>>> model a part functionality that is done by Bootrom.
>>>>>>>
>>>>>>> W dniu 29.11.2016 o 16:43, C=C3=A9dric Le Goater pisze:
>>>>>>>> The Aspeed SMC controllers have a mode (Command mode) in which
>>>>>>>> accesses to the flash content are no different than doing MMIOs.=
 The
>>>>>>>> controller generates all the necessary commands to load (or stor=
e)
>>>>>>>> data in memory.
>>>>>>>>
>>>>>>>> However, accesses are restricted to the segment window assigned =
the
>>>>>>>> the flash module by the controller. This window is defined by th=
e
>>>>>>>> Segment Address Register.
>>>>>>>>
>>>>>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>>>>>> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>>>>>>>> ---
>>>>>>>>    hw/ssi/aspeed_smc.c | 174 +++++++++++++++++++++++++++++++++++=
+++++++++++++----
>>>>>>>>    1 file changed, 162 insertions(+), 12 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
>>>>>>>> index 72a44150b0a1..eec087199a22 100644
>>>>>>>> --- a/hw/ssi/aspeed_smc.c
>>>>>>>> +++ b/hw/ssi/aspeed_smc.c
>>>>>>>> @@ -69,6 +69,7 @@
>>>>>>>>    #define R_CTRL0           (0x10 / 4)
>>>>>>>>    #define   CTRL_CMD_SHIFT           16
>>>>>>>>    #define   CTRL_CMD_MASK            0xff
>>>>>>>> +#define   CTRL_AST2400_SPI_4BYTE   (1 << 13)
>>>>>>>>    #define   CTRL_CE_STOP_ACTIVE      (1 << 2)
>>>>>>>>    #define   CTRL_CMD_MODE_MASK       0x3
>>>>>>>>    #define     CTRL_READMODE          0x0
>>>>>>>> @@ -135,6 +136,16 @@
>>>>>>>>    #define ASPEED_SOC_SPI_FLASH_BASE   0x30000000
>>>>>>>>    #define ASPEED_SOC_SPI2_FLASH_BASE  0x38000000
>>>>>>>>    +/* Flash opcodes. */
>>>>>>>> +#define SPI_OP_READ       0x03    /* Read data bytes (low frequ=
ency) */
>>>>>>>> +#define SPI_OP_WRDI       0x04    /* Write disable */
>>>>>>>> +#define SPI_OP_RDSR       0x05    /* Read status register */
>>>>>>>> +#define SPI_OP_WREN       0x06    /* Write enable */
>>>>>>> Are you sure that the controller is aware af all above commands (=
especially WD/WE and RDS)?
>>>>>> HW is aware of SPI_OP_READ which is the default command for the
>>>>>> "normal" read mode. For other modes, fast and write, the command
>>>>>> op is configured in the CEx Control Register.
>>>>>>
>>>>>> These ops are used in the model :
>>>>>>
>>>>>>    * SPI_OP_READ_FAST, for dummies
>>>>>>    * SPI_OP_EN4B, might be useless if we expect software to send
>>>>>>      this command before using this mode.
>>>>>>    * SPI_OP_WREN, same comment.
>>>>>>
>>>>>> The rest I should remove as it is unused.
>>>>> I think only SPI_OP_READ should stay in the model, rest goes to gue=
st.
>>>> Well, we will need at least one 'EN4B' command to be sent for the qe=
mu
>>>> flash model to work. If the underlying m25p80 object does not know
>>>> about the address width, the expected number of bytes will be wrong =
and
>>>> the result bogus.
>>> Hmm, most of the flash I know by default use 3byte address mode.
>>> What flash are you connecting to model.
>> chips like n25q256a, mx25l25635e, w25q256. all are > 32MB.
>>
>>> Do you have same on HW?
>> No but it is difficult to know what the controller is doing
>> in that mode without spying on the bus.
>=20
> Maybe aspeed support can help?
> Or some clue in the doc.

I will try to ping the aspeed engineers to have some hints on how=20
this is implemented.

> More generally have you tested this feature in real HW?

yes. we use it to read the flash contents. This is the pflash tool
in the open-power firmware. It is under github.

>> Anyhow, after some experiments, I think you are right and
>> I should  get rid of these command OP in the next version.
> MHO it is possible that controller send WREN command,
> but I would be really surprised if it send EN4B.

yes. we should be fine.

>>
>> What about the dummy cycles ? the linux driver now has
>> support for it and it would be nice to get some support
>> in qemu also.
> Target is still 2.9, but I am quite loaded now. From the other hand,
> in current Qemu you can have it working with easy update in the
> feature. Just send byte every dummy clock.

yes. I was just asking. No hurries on our side.

Thanks,

C.=20


> Thanks,
> Marcin
>>
>> Thanks,
>>
>> C.
>>
>>>> Same remark for the WREN, if the m25p80 object is not write enabled,
>>>> modifying the flash content won't work.
>>> Same as above.
>>>
>>> Thanks,
>>> Marcin
>>>> Thanks,
>>>>
>>>> C.
>>>>
>>>>>>>> +
>>>>>>>> +/* Used for Macronix and Winbond flashes. */
>>>>>>>> +#define SPI_OP_EN4B       0xb7    /* Enter 4-byte mode */
>>>>>>>> +#define SPI_OP_EX4B       0xe9    /* Exit 4-byte mode */
>>>>>>>> +
>>>>>>> Same as above but I think 4byte address mode bit changes onlu nym=
ber of bytes
>>>>>>> that is sent after instruction.
>>>>>>>
>>>>>>>>    /*
>>>>>>>>     * Default segments mapping addresses and size for each slave=
 per
>>>>>>>>     * controller. These can be changed when board is initialized=
 with the
>>>>>>>> @@ -357,6 +368,98 @@ static inline bool aspeed_smc_is_writable(c=
onst AspeedSMCFlash *fl)
>>>>>>>>        return s->regs[s->r_conf] & (1 << (s->conf_enable_w0 + fl=
->id));
>>>>>>>>    }
>>>>>>>>    +static inline int aspeed_smc_flash_cmd(const AspeedSMCFlash =
*fl)
>>>>>>>> +{
>>>>>>>> +    AspeedSMCState *s =3D fl->controller;
>>>>>>>> +    int cmd =3D (s->regs[s->r_ctrl0 + fl->id] >> CTRL_CMD_SHIFT=
) & CTRL_CMD_MASK;
>>>>>>>> +
>>>>>>>> +    /* This is the default value for read mode. In other modes,=
 the
>>>>>>>> +     * command should be defined */
>>>>>>>> +    if (aspeed_smc_flash_mode(fl) =3D=3D CTRL_READMODE) {
>>>>>>>> +        cmd =3D SPI_OP_READ;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    if (!cmd) {
>>>>>>> cmd =3D=3D 0 =3D> NOP command for some flash (eg. mx66l1g45g).
>>>>>> So I should use another default value, OxFF ?
>>>>> I believe this check is not needed at all because m25p80c will tell=
 if it has
>>>>> unsupported instruction and HW should accept all register values, i=
sn't it?
>>>>>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: no command defined =
for mode %d\n",
>>>>>>>> +                      __func__, aspeed_smc_flash_mode(fl));
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    return cmd;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static inline int aspeed_smc_flash_is_4byte(const AspeedSMCFlas=
h *fl)
>>>>>>>> +{
>>>>>>>> +    AspeedSMCState *s =3D fl->controller;
>>>>>>>> +
>>>>>>>> +    if (s->ctrl->segments =3D=3D aspeed_segments_spi) {
>>>>>>>> +        return s->regs[s->r_ctrl0] & CTRL_AST2400_SPI_4BYTE;
>>>>>>>> +    } else {
>>>>>>>> +        return s->regs[s->r_ce_ctrl] & (1 << (CTRL_EXTENDED0 + =
fl->id));
>>>>>>>> +    }
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void aspeed_smc_flash_select(const AspeedSMCFlash *fl)
>>>>>>>> +{
>>>>>>>> +    AspeedSMCState *s =3D fl->controller;
>>>>>>>> +
>>>>>>>> +    s->regs[s->r_ctrl0 + fl->id] &=3D ~CTRL_CE_STOP_ACTIVE;
>>>>>>>> +    qemu_set_irq(s->cs_lines[fl->id], aspeed_smc_is_ce_stop_act=
ive(fl));
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void aspeed_smc_flash_unselect(const AspeedSMCFlash *fl)
>>>>>>>> +{
>>>>>>>> +    AspeedSMCState *s =3D fl->controller;
>>>>>>>> +
>>>>>>>> +    s->regs[s->r_ctrl0 + fl->id] |=3D CTRL_CE_STOP_ACTIVE;
>>>>>>>> +    qemu_set_irq(s->cs_lines[fl->id], aspeed_smc_is_ce_stop_act=
ive(fl));
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static uint32_t aspeed_smc_check_segment_addr(AspeedSMCFlash *f=
l, uint32_t addr)
>>>>>>>> +{
>>>>>>>> +    AspeedSMCState *s =3D fl->controller;
>>>>>>>> +    AspeedSegments seg;
>>>>>>>> +
>>>>>>>> +    aspeed_smc_reg_to_segment(s->regs[R_SEG_ADDR0 + fl->id], &s=
eg);
>>>>>>>> +    if ((addr & (seg.size - 1)) !=3D addr) {
>>>>>>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>>>>>>> +                      "%s: invalid address 0x%08x for CS%d segm=
ent : "
>>>>>>>> +                      "[ 0x%"HWADDR_PRIx" - 0x%"HWADDR_PRIx" ]\=
n",
>>>>>>>> +                      s->ctrl->name, addr, fl->id, seg.addr,
>>>>>>>> +                      seg.addr + seg.size);
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    addr &=3D seg.size - 1;
>>>>>>>> +    return addr;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void aspeed_smc_flash_setup_read(AspeedSMCFlash *fl, uin=
t32_t addr)
>>>>>>>> +{
>>>>>>>> +    AspeedSMCState *s =3D fl->controller;
>>>>>>>> +    uint8_t cmd =3D aspeed_smc_flash_cmd(fl);
>>>>>>>> +
>>>>>>>> +    /*
>>>>>>>> +     * To be checked: I am not sure the Aspeed SPI controller n=
eeds to
>>>>>>>> +     * enable writes when running in READ/FREAD command mode
>>>>>>>> +     */
>>>>>>>> +
>>>>>>>> +    /* access can not exceed CS segment */
>>>>>>>> +    addr =3D aspeed_smc_check_segment_addr(fl, addr);
>>>>>>>> +
>>>>>>>> +    /* TODO: do we have to send 4BYTE each time ? */
>>>>>>> I am not aware of any flash that needs that, this  command should=
 be send only once.
>>>>>> yes. That is what I think also.
>>>>>>
>>>>>> it also means that a preliminary 4BYTE command should be
>>>>>> sent before using that mode.
>>>>> Generally there are two ways to access more than 16MiB in flash:
>>>>> - 4byte address mode: all commands change to accept 4byte address, =
not supported by all flash devices.
>>>>> - 4byte opcodes: different opcode is used to signal 4-byte long add=
ress (eg. 0x3 three bytes, 0x13 four).
>>>>> Also not all flash support that. If the HW does not use any of thos=
e, ones should be removed from this model.
>>>>>
>>>>>>> I also think that HW does not send this command (see above commen=
t).
>>>>>>>
>>>>>>>> +    if (aspeed_smc_flash_is_4byte(fl)) {
>>>>>>>> +        ssi_transfer(s->spi, SPI_OP_EN4B);
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    ssi_transfer(s->spi, cmd);
>>>>>>>> +
>>>>>>>> +    if (aspeed_smc_flash_is_4byte(fl)) {
>>>>>>>> +        ssi_transfer(s->spi, (addr >> 24) & 0xff);
>>>>>>>> +    }
>>>>>>>> +    ssi_transfer(s->spi, (addr >> 16) & 0xff);
>>>>>>>> +    ssi_transfer(s->spi, (addr >> 8) & 0xff);
>>>>>>>> +    ssi_transfer(s->spi, (addr & 0xff));
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>    static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr ad=
dr, unsigned size)
>>>>>>>>    {
>>>>>>>>        AspeedSMCFlash *fl =3D opaque;
>>>>>>>> @@ -364,19 +467,55 @@ static uint64_t aspeed_smc_flash_read(void=
 *opaque, hwaddr addr, unsigned size)
>>>>>>>>        uint64_t ret =3D 0;
>>>>>>>>        int i;
>>>>>>>>    -    if (aspeed_smc_is_usermode(fl)) {
>>>>>>>> +    switch (aspeed_smc_flash_mode(fl)) {
>>>>>>>> +    case CTRL_USERMODE:
>>>>>>>>            for (i =3D 0; i < size; i++) {
>>>>>>>>                ret |=3D ssi_transfer(s->spi, 0x0) << (8 * i);
>>>>>>>>            }
>>>>>>>> -    } else {
>>>>>>>> -        qemu_log_mask(LOG_UNIMP, "%s: usermode not implemented\=
n",
>>>>>>>> -                      __func__);
>>>>>>>> -        ret =3D -1;
>>>>>>>> +        break;
>>>>>>>> +    case CTRL_READMODE:
>>>>>>>> +    case CTRL_FREADMODE:
>>>>>>> CTRL_FREADMODE should not sent dummy bytes?
>>>>>> yes it should. this is in a following patch.
>>>>> Yes, I noticed that after sending this email :)
>>>>>
>>>>> Thanks,
>>>>> Marcin
>>>>>> Thanks,
>>>>>>
>>>>>> C.
>>>>>>
>>>>>>> Thanks,
>>>>>>> Marcin
>>>>>>>> +        aspeed_smc_flash_select(fl);
>>>>>>>> +        aspeed_smc_flash_setup_read(fl, addr);
>>>>>>>> +
>>>>>>>> +        for (i =3D 0; i < size; i++) {
>>>>>>>> +            ret |=3D ssi_transfer(s->spi, 0x0) << (8 * i);
>>>>>>>> +        }
>>>>>>>> +
>>>>>>>> +        aspeed_smc_flash_unselect(fl);
>>>>>>>> +        break;
>>>>>>>> +    default:
>>>>>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid flash mode =
%d\n",
>>>>>>>> +                      __func__, aspeed_smc_flash_mode(fl));
>>>>>>>>        }
>>>>>>>>          return ret;
>>>>>>>>    }
>>>>>>>>    +static void aspeed_smc_flash_setup_write(AspeedSMCFlash *fl,=
 uint32_t addr)
>>>>>>>> +{
>>>>>>>> +    AspeedSMCState *s =3D fl->controller;
>>>>>>>> +    uint8_t cmd =3D aspeed_smc_flash_cmd(fl);
>>>>>>>> +
>>>>>>>> +    /* Flash access can not exceed CS segment */
>>>>>>>> +    addr =3D aspeed_smc_check_segment_addr(fl, addr);
>>>>>>>> +
>>>>>>>> +    /* TODO: do we have to send 4BYTE each time ? */
>>>>>>>> +    if (aspeed_smc_flash_is_4byte(fl)) {
>>>>>>>> +        ssi_transfer(s->spi, SPI_OP_EN4B);
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    ssi_transfer(s->spi, SPI_OP_WREN);
>>>>>>>> +    ssi_transfer(s->spi, cmd);
>>>>>>>> +
>>>>>>>> +    if (aspeed_smc_flash_is_4byte(fl)) {
>>>>>>>> +        ssi_transfer(s->spi, (addr >> 24) & 0xff);
>>>>>>>> +    }
>>>>>>>> +    ssi_transfer(s->spi, (addr >> 16) & 0xff);
>>>>>>>> +    ssi_transfer(s->spi, (addr >> 8) & 0xff);
>>>>>>>> +    ssi_transfer(s->spi, (addr & 0xff));
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>    static void aspeed_smc_flash_write(void *opaque, hwaddr addr,=
 uint64_t data,
>>>>>>>>                               unsigned size)
>>>>>>>>    {
>>>>>>>> @@ -390,14 +529,25 @@ static void aspeed_smc_flash_write(void *o=
paque, hwaddr addr, uint64_t data,
>>>>>>>>            return;
>>>>>>>>        }
>>>>>>>>    -    if (!aspeed_smc_is_usermode(fl)) {
>>>>>>>> -        qemu_log_mask(LOG_UNIMP, "%s: usermode not implemented\=
n",
>>>>>>>> -                      __func__);
>>>>>>>> -        return;
>>>>>>>> -    }
>>>>>>>> +    switch (aspeed_smc_flash_mode(fl)) {
>>>>>>>> +    case CTRL_USERMODE:
>>>>>>>> +        for (i =3D 0; i < size; i++) {
>>>>>>>> +            ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
>>>>>>>> +        }
>>>>>>>> +        break;
>>>>>>>> +    case CTRL_WRITEMODE:
>>>>>>>> +        aspeed_smc_flash_select(fl);
>>>>>>>> +        aspeed_smc_flash_setup_write(fl, addr);
>>>>>>>> +
>>>>>>>> +        for (i =3D 0; i < size; i++) {
>>>>>>>> +            ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
>>>>>>>> +        }
>>>>>>>>    -    for (i =3D 0; i < size; i++) {
>>>>>>>> -        ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
>>>>>>>> +        aspeed_smc_flash_unselect(fl);
>>>>>>>> +        break;
>>>>>>>> +    default:
>>>>>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid flash mode =
%d\n",
>>>>>>>> +                      __func__, aspeed_smc_flash_mode(fl));
>>>>>>>>        }
>>>>>>>>    }
>>>>>>>>   =20
>>
>=20
