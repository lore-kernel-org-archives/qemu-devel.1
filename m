Received: from eggs.gnu.org ([2001:4830:134:3::10]:43937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cO4yv-0007SR-N1
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:57:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cO4ys-0005Dd-JC
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:57:05 -0500
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:60770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cO4ys-0005Cw-8e
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:57:02 -0500
Received: from player760.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 93ADE5D5BB
	for <qemu-devel@nongnu.org>; Mon,  2 Jan 2017 16:56:58 +0100 (CET)
References: <1480434248-27138-1-git-send-email-clg@kaod.org>
	<1480434248-27138-18-git-send-email-clg@kaod.org>
	<0fa6e0f2-2965-cbdc-3d22-5a4c74fc6772@gmail.com>
	<27bcad02-54fc-dbf9-f5f9-5b178ddb2ddd@kaod.org>
	<212a15c5-565c-434a-1387-250fa8f8f559@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9a5a321f-0d5e-d798-07c2-ad30c29d6a1d@kaod.org>
Date: Mon, 2 Jan 2017 16:56:51 +0100
MIME-Version: 1.0
In-Reply-To: <212a15c5-565c-434a-1387-250fa8f8f559@gmail.com>
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
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrew Jeffery <andrew@aj.id.au>, Marcin Krzeminski <marcin.krzeminski@nokia.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Hello Marcin,

On 12/05/2016 04:33 PM, mar.krzeminski wrote:
>=20
>=20
> W dniu 05.12.2016 o 15:07, C=C3=A9dric Le Goater pisze:
>> On 12/04/2016 05:31 PM, mar.krzeminski wrote:
>>> Hi Cedric,
>>>
>>> Since there is no public datasheet user guide for SMC I would ask som=
e question
>>> regarding HW itself because I got impression that you are implementin=
g in this
>>> model a part functionality that is done by Bootrom.
>>>
>>> W dniu 29.11.2016 o 16:43, C=C3=A9dric Le Goater pisze:
>>>> The Aspeed SMC controllers have a mode (Command mode) in which
>>>> accesses to the flash content are no different than doing MMIOs. The
>>>> controller generates all the necessary commands to load (or store)
>>>> data in memory.
>>>>
>>>> However, accesses are restricted to the segment window assigned the
>>>> the flash module by the controller. This window is defined by the
>>>> Segment Address Register.
>>>>
>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>>>> ---
>>>>  hw/ssi/aspeed_smc.c | 174 +++++++++++++++++++++++++++++++++++++++++=
+++++++----
>>>>  1 file changed, 162 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
>>>> index 72a44150b0a1..eec087199a22 100644
>>>> --- a/hw/ssi/aspeed_smc.c
>>>> +++ b/hw/ssi/aspeed_smc.c
>>>> @@ -69,6 +69,7 @@
>>>>  #define R_CTRL0           (0x10 / 4)
>>>>  #define   CTRL_CMD_SHIFT           16
>>>>  #define   CTRL_CMD_MASK            0xff
>>>> +#define   CTRL_AST2400_SPI_4BYTE   (1 << 13)
>>>>  #define   CTRL_CE_STOP_ACTIVE      (1 << 2)
>>>>  #define   CTRL_CMD_MODE_MASK       0x3
>>>>  #define     CTRL_READMODE          0x0
>>>> @@ -135,6 +136,16 @@
>>>>  #define ASPEED_SOC_SPI_FLASH_BASE   0x30000000
>>>>  #define ASPEED_SOC_SPI2_FLASH_BASE  0x38000000
>>>> =20
>>>> +/* Flash opcodes. */
>>>> +#define SPI_OP_READ       0x03    /* Read data bytes (low frequency=
) */
>>>> +#define SPI_OP_WRDI       0x04    /* Write disable */
>>>> +#define SPI_OP_RDSR       0x05    /* Read status register */
>>>> +#define SPI_OP_WREN       0x06    /* Write enable */
>>> Are you sure that the controller is aware af all above commands (espe=
cially WD/WE and RDS)?
>> HW is aware of SPI_OP_READ which is the default command for the=20
>> "normal" read mode. For other modes, fast and write, the command=20
>> op is configured in the CEx Control Register.=20
>>
>> These ops are used in the model :
>>
>>  * SPI_OP_READ_FAST, for dummies
>>  * SPI_OP_EN4B, might be useless if we expect software to send
>>    this command before using this mode.
>>  * SPI_OP_WREN, same comment.
>>
>> The rest I should remove as it is unused.
> I think only SPI_OP_READ should stay in the model, rest goes to guest.

Well, we will need at least one 'EN4B' command to be sent for the qemu=20
flash model to work. If the underlying m25p80 object does not know=20
about the address width, the expected number of bytes will be wrong and
the result bogus.=20

Same remark for the WREN, if the m25p80 object is not write enabled,=20
modifying the flash content won't work.

Thanks,

C.=20

>>
>>>> +
>>>> +/* Used for Macronix and Winbond flashes. */
>>>> +#define SPI_OP_EN4B       0xb7    /* Enter 4-byte mode */
>>>> +#define SPI_OP_EX4B       0xe9    /* Exit 4-byte mode */
>>>> +
>>> Same as above but I think 4byte address mode bit changes onlu nymber =
of bytes
>>> that is sent after instruction.
>>>
>>>>  /*
>>>>   * Default segments mapping addresses and size for each slave per
>>>>   * controller. These can be changed when board is initialized with =
the
>>>> @@ -357,6 +368,98 @@ static inline bool aspeed_smc_is_writable(const=
 AspeedSMCFlash *fl)
>>>>      return s->regs[s->r_conf] & (1 << (s->conf_enable_w0 + fl->id))=
;
>>>>  }
>>>> =20
>>>> +static inline int aspeed_smc_flash_cmd(const AspeedSMCFlash *fl)
>>>> +{
>>>> +    AspeedSMCState *s =3D fl->controller;
>>>> +    int cmd =3D (s->regs[s->r_ctrl0 + fl->id] >> CTRL_CMD_SHIFT) & =
CTRL_CMD_MASK;
>>>> +
>>>> +    /* This is the default value for read mode. In other modes, the
>>>> +     * command should be defined */
>>>> +    if (aspeed_smc_flash_mode(fl) =3D=3D CTRL_READMODE) {
>>>> +        cmd =3D SPI_OP_READ;
>>>> +    }
>>>> +
>>>> +    if (!cmd) {
>>> cmd =3D=3D 0 =3D> NOP command for some flash (eg. mx66l1g45g).
>> So I should use another default value, OxFF ?=20
> I believe this check is not needed at all because m25p80c will tell if =
it has
> unsupported instruction and HW should accept all register values, isn't=
 it?
>>
>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: no command defined for =
mode %d\n",
>>>> +                      __func__, aspeed_smc_flash_mode(fl));
>>>> +    }
>>>> +
>>>> +    return cmd;
>>>> +}
>>>> +
>>>> +static inline int aspeed_smc_flash_is_4byte(const AspeedSMCFlash *f=
l)
>>>> +{
>>>> +    AspeedSMCState *s =3D fl->controller;
>>>> +
>>>> +    if (s->ctrl->segments =3D=3D aspeed_segments_spi) {
>>>> +        return s->regs[s->r_ctrl0] & CTRL_AST2400_SPI_4BYTE;
>>>> +    } else {
>>>> +        return s->regs[s->r_ce_ctrl] & (1 << (CTRL_EXTENDED0 + fl->=
id));
>>>> +    }
>>>> +}
>>>> +
>>>> +static void aspeed_smc_flash_select(const AspeedSMCFlash *fl)
>>>> +{
>>>> +    AspeedSMCState *s =3D fl->controller;
>>>> +
>>>> +    s->regs[s->r_ctrl0 + fl->id] &=3D ~CTRL_CE_STOP_ACTIVE;
>>>> +    qemu_set_irq(s->cs_lines[fl->id], aspeed_smc_is_ce_stop_active(=
fl));
>>>> +}
>>>> +
>>>> +static void aspeed_smc_flash_unselect(const AspeedSMCFlash *fl)
>>>> +{
>>>> +    AspeedSMCState *s =3D fl->controller;
>>>> +
>>>> +    s->regs[s->r_ctrl0 + fl->id] |=3D CTRL_CE_STOP_ACTIVE;
>>>> +    qemu_set_irq(s->cs_lines[fl->id], aspeed_smc_is_ce_stop_active(=
fl));
>>>> +}
>>>> +
>>>> +static uint32_t aspeed_smc_check_segment_addr(AspeedSMCFlash *fl, u=
int32_t addr)
>>>> +{
>>>> +    AspeedSMCState *s =3D fl->controller;
>>>> +    AspeedSegments seg;
>>>> +
>>>> +    aspeed_smc_reg_to_segment(s->regs[R_SEG_ADDR0 + fl->id], &seg);
>>>> +    if ((addr & (seg.size - 1)) !=3D addr) {
>>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>>> +                      "%s: invalid address 0x%08x for CS%d segment =
: "
>>>> +                      "[ 0x%"HWADDR_PRIx" - 0x%"HWADDR_PRIx" ]\n",
>>>> +                      s->ctrl->name, addr, fl->id, seg.addr,
>>>> +                      seg.addr + seg.size);
>>>> +    }
>>>> +
>>>> +    addr &=3D seg.size - 1;
>>>> +    return addr;
>>>> +}
>>>> +
>>>> +static void aspeed_smc_flash_setup_read(AspeedSMCFlash *fl, uint32_=
t addr)
>>>> +{
>>>> +    AspeedSMCState *s =3D fl->controller;
>>>> +    uint8_t cmd =3D aspeed_smc_flash_cmd(fl);
>>>> +
>>>> +    /*
>>>> +     * To be checked: I am not sure the Aspeed SPI controller needs=
 to
>>>> +     * enable writes when running in READ/FREAD command mode
>>>> +     */
>>>> +
>>>> +    /* access can not exceed CS segment */
>>>> +    addr =3D aspeed_smc_check_segment_addr(fl, addr);
>>>> +
>>>> +    /* TODO: do we have to send 4BYTE each time ? */
>>> I am not aware of any flash that needs that, this  command should be =
send only once.
>> yes. That is what I think also. =20
>>
>> it also means that a preliminary 4BYTE command should be=20
>> sent before using that mode.
> Generally there are two ways to access more than 16MiB in flash:
> - 4byte address mode: all commands change to accept 4byte address, not =
supported by all flash devices.
> - 4byte opcodes: different opcode is used to signal 4-byte long address=
 (eg. 0x3 three bytes, 0x13 four).
> Also not all flash support that. If the HW does not use any of those, o=
nes should be removed from this model.
>=20
>>
>>> I also think that HW does not send this command (see above comment).
>>>
>>>> +    if (aspeed_smc_flash_is_4byte(fl)) {
>>>> +        ssi_transfer(s->spi, SPI_OP_EN4B);
>>>> +    }
>>>> +
>>>> +    ssi_transfer(s->spi, cmd);
>>>> +
>>>> +    if (aspeed_smc_flash_is_4byte(fl)) {
>>>> +        ssi_transfer(s->spi, (addr >> 24) & 0xff);
>>>> +    }
>>>> +    ssi_transfer(s->spi, (addr >> 16) & 0xff);
>>>> +    ssi_transfer(s->spi, (addr >> 8) & 0xff);
>>>> +    ssi_transfer(s->spi, (addr & 0xff));
>>>> +}
>>>> +
>>>>  static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, un=
signed size)
>>>>  {
>>>>      AspeedSMCFlash *fl =3D opaque;
>>>> @@ -364,19 +467,55 @@ static uint64_t aspeed_smc_flash_read(void *op=
aque, hwaddr addr, unsigned size)
>>>>      uint64_t ret =3D 0;
>>>>      int i;
>>>> =20
>>>> -    if (aspeed_smc_is_usermode(fl)) {
>>>> +    switch (aspeed_smc_flash_mode(fl)) {
>>>> +    case CTRL_USERMODE:
>>>>          for (i =3D 0; i < size; i++) {
>>>>              ret |=3D ssi_transfer(s->spi, 0x0) << (8 * i);
>>>>          }
>>>> -    } else {
>>>> -        qemu_log_mask(LOG_UNIMP, "%s: usermode not implemented\n",
>>>> -                      __func__);
>>>> -        ret =3D -1;
>>>> +        break;
>>>> +    case CTRL_READMODE:
>>>> +    case CTRL_FREADMODE:
>>> CTRL_FREADMODE should not sent dummy bytes?
>> yes it should. this is in a following patch.
> Yes, I noticed that after sending this email :)
>=20
> Thanks,
> Marcin
>>
>> Thanks,
>>
>> C.=20
>>
>>> Thanks,
>>> Marcin
>>>> +        aspeed_smc_flash_select(fl);
>>>> +        aspeed_smc_flash_setup_read(fl, addr);
>>>> +
>>>> +        for (i =3D 0; i < size; i++) {
>>>> +            ret |=3D ssi_transfer(s->spi, 0x0) << (8 * i);
>>>> +        }
>>>> +
>>>> +        aspeed_smc_flash_unselect(fl);
>>>> +        break;
>>>> +    default:
>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid flash mode %d\n=
",
>>>> +                      __func__, aspeed_smc_flash_mode(fl));
>>>>      }
>>>> =20
>>>>      return ret;
>>>>  }
>>>> =20
>>>> +static void aspeed_smc_flash_setup_write(AspeedSMCFlash *fl, uint32=
_t addr)
>>>> +{
>>>> +    AspeedSMCState *s =3D fl->controller;
>>>> +    uint8_t cmd =3D aspeed_smc_flash_cmd(fl);
>>>> +
>>>> +    /* Flash access can not exceed CS segment */
>>>> +    addr =3D aspeed_smc_check_segment_addr(fl, addr);
>>>> +
>>>> +    /* TODO: do we have to send 4BYTE each time ? */
>>>> +    if (aspeed_smc_flash_is_4byte(fl)) {
>>>> +        ssi_transfer(s->spi, SPI_OP_EN4B);
>>>> +    }
>>>> +
>>>> +    ssi_transfer(s->spi, SPI_OP_WREN);
>>>> +    ssi_transfer(s->spi, cmd);
>>>> +
>>>> +    if (aspeed_smc_flash_is_4byte(fl)) {
>>>> +        ssi_transfer(s->spi, (addr >> 24) & 0xff);
>>>> +    }
>>>> +    ssi_transfer(s->spi, (addr >> 16) & 0xff);
>>>> +    ssi_transfer(s->spi, (addr >> 8) & 0xff);
>>>> +    ssi_transfer(s->spi, (addr & 0xff));
>>>> +}
>>>> +
>>>>  static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint6=
4_t data,
>>>>                             unsigned size)
>>>>  {
>>>> @@ -390,14 +529,25 @@ static void aspeed_smc_flash_write(void *opaqu=
e, hwaddr addr, uint64_t data,
>>>>          return;
>>>>      }
>>>> =20
>>>> -    if (!aspeed_smc_is_usermode(fl)) {
>>>> -        qemu_log_mask(LOG_UNIMP, "%s: usermode not implemented\n",
>>>> -                      __func__);
>>>> -        return;
>>>> -    }
>>>> +    switch (aspeed_smc_flash_mode(fl)) {
>>>> +    case CTRL_USERMODE:
>>>> +        for (i =3D 0; i < size; i++) {
>>>> +            ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
>>>> +        }
>>>> +        break;
>>>> +    case CTRL_WRITEMODE:
>>>> +        aspeed_smc_flash_select(fl);
>>>> +        aspeed_smc_flash_setup_write(fl, addr);
>>>> +
>>>> +        for (i =3D 0; i < size; i++) {
>>>> +            ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
>>>> +        }
>>>> =20
>>>> -    for (i =3D 0; i < size; i++) {
>>>> -        ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
>>>> +        aspeed_smc_flash_unselect(fl);
>>>> +        break;
>>>> +    default:
>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid flash mode %d\n=
",
>>>> +                      __func__, aspeed_smc_flash_mode(fl));
>>>>      }
>>>>  }
>>>> =20
>>
>=20
