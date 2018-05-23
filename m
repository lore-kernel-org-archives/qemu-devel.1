Received: from eggs.gnu.org ([2001:4830:134:3::10]:42970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fLRFf-000449-Ms
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fLRFb-0007re-M3
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:44:15 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:42496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fLRFb-0007r5-Cf
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:44:11 -0400
Received: by mail-wr0-x241.google.com with SMTP id w10-v6so2778733wrk.9
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 03:44:11 -0700 (PDT)
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-20-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180521140402.23318-20-peter.maydell@linaro.org>
Date: Wed, 23 May 2018 11:44:08 +0100
Message-ID: <87zi0qtzwn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 19/27] hw/misc/tz-mpc.c: Implement registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> Implement the missing registers for the TZ MPC.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/misc/tz-mpc.h |  10 +++
>  hw/misc/tz-mpc.c         | 137 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 144 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/misc/tz-mpc.h b/include/hw/misc/tz-mpc.h
> index b5eaf1699e..1fff4d6029 100644
> --- a/include/hw/misc/tz-mpc.h
> +++ b/include/hw/misc/tz-mpc.h
> @@ -48,6 +48,16 @@ struct TZMPC {
>
>      /*< public >*/
>
> +    /* State */
> +    uint32_t ctrl;
> +    uint32_t blk_idx;
> +    uint32_t int_stat;
> +    uint32_t int_en;
> +    uint32_t int_info1;
> +    uint32_t int_info2;
> +
> +    uint32_t *blk_lut;
> +
>      qemu_irq irq;
>
>      /* Properties */
> diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
> index d4467ccc3b..93453cbef2 100644
> --- a/hw/misc/tz-mpc.c
> +++ b/hw/misc/tz-mpc.c
> @@ -28,16 +28,23 @@ enum {
>
>  /* Config registers */
>  REG32(CTRL, 0x00)
> +    FIELD(CTRL, SEC_RESP, 4, 1)
> +    FIELD(CTRL, AUTOINC, 8, 1)
> +    FIELD(CTRL, LOCKDOWN, 31, 1)
>  REG32(BLK_MAX, 0x10)
>  REG32(BLK_CFG, 0x14)
>  REG32(BLK_IDX, 0x18)
>  REG32(BLK_LUT, 0x1c)
>  REG32(INT_STAT, 0x20)
> +    FIELD(INT_STAT, IRQ, 0, 1)
>  REG32(INT_CLEAR, 0x24)
> +    FIELD(INT_CLEAR, IRQ, 0, 1)
>  REG32(INT_EN, 0x28)
> +    FIELD(INT_EN, IRQ, 0, 1)
>  REG32(INT_INFO1, 0x2c)
>  REG32(INT_INFO2, 0x30)
>  REG32(INT_SET, 0x34)
> +    FIELD(INT_SET, IRQ, 0, 1)
>  REG32(PIDR4, 0xfd0)
>  REG32(PIDR5, 0xfd4)
>  REG32(PIDR6, 0xfd8)
> @@ -57,14 +64,55 @@ static const uint8_t tz_mpc_idregs[] =3D {
>      0x0d, 0xf0, 0x05, 0xb1,
>  };
>
> +static void tz_mpc_irq_update(TZMPC *s)
> +{
> +    qemu_set_irq(s->irq, s->int_stat && s->int_en);
> +}
> +
>  static MemTxResult tz_mpc_reg_read(void *opaque, hwaddr addr,
>                                     uint64_t *pdata,
>                                     unsigned size, MemTxAttrs attrs)
>  {
> +    TZMPC *s =3D TZ_MPC(opaque);
>      uint64_t r;
>      uint32_t offset =3D addr & ~0x3;
>
>      switch (offset) {
> +    case A_CTRL:
> +        r =3D s->ctrl;
> +        break;
> +    case A_BLK_MAX:
> +        r =3D s->blk_max;
> +        break;
> +    case A_BLK_CFG:
> +        /* We are never in "init in progress state", so this just indica=
tes
> +         * the block size. s->blocksize =3D=3D (1 << BLK_CFG + 5), so
> +         * BLK_CFG =3D=3D ctz32(s->blocksize) - 5
> +         */
> +        r =3D ctz32(s->blocksize) - 5;
> +        break;
> +    case A_BLK_IDX:
> +        r =3D s->blk_idx;
> +        break;
> +    case A_BLK_LUT:
> +        r =3D s->blk_lut[s->blk_idx];
> +        if (size =3D=3D 4) {
> +            s->blk_idx++;
> +            s->blk_idx %=3D s->blk_max;
> +        }
> +        break;
> +    case A_INT_STAT:
> +        r =3D s->int_stat;
> +        break;
> +    case A_INT_EN:
> +        r =3D s->int_en;
> +        break;
> +    case A_INT_INFO1:
> +        r =3D s->int_info1;
> +        break;
> +    case A_INT_INFO2:
> +        r =3D s->int_info2;
> +        break;
>      case A_PIDR4:
>      case A_PIDR5:
>      case A_PIDR6:
> @@ -110,6 +158,7 @@ static MemTxResult tz_mpc_reg_write(void *opaque, hwa=
ddr addr,
>                                      uint64_t value,
>                                      unsigned size, MemTxAttrs attrs)
>  {
> +    TZMPC *s =3D TZ_MPC(opaque);
>      uint32_t offset =3D addr & ~0x3;
>
>      trace_tz_mpc_reg_write(addr, value, size);
> @@ -122,9 +171,15 @@ static MemTxResult tz_mpc_reg_write(void *opaque, hw=
addr addr,
>          uint32_t oldval;
>
>          switch (offset) {
> -            /* As we add support for registers which need expansions
> -             * other than zeroes we'll fill in cases here.
> -             */
> +        case A_CTRL:
> +            oldval =3D s->ctrl;
> +            break;
> +        case A_BLK_IDX:
> +            oldval =3D s->blk_idx;
> +            break;
> +        case A_BLK_LUT:
> +            oldval =3D s->blk_lut[s->blk_idx];
> +            break;
>          default:
>              oldval =3D 0;
>              break;
> @@ -132,7 +187,51 @@ static MemTxResult tz_mpc_reg_write(void *opaque, hw=
addr addr,
>          value =3D deposit32(oldval, (addr & 3) * 8, size * 8, value);
>      }
>
> +    if ((s->ctrl & R_CTRL_LOCKDOWN_MASK) &&
> +        (offset =3D=3D A_CTRL || offset =3D=3D A_BLK_LUT || offset =3D=
=3D A_INT_EN)) {
> +        /* Lockdown mode makes these three registers read-only, and
> +         * the only way out of it is to reset the device.
> +         */
> +        qemu_log_mask(LOG_GUEST_ERROR, "TZ MPC register write to offset =
0x%x "
> +                      "while MPC is in lockdown mode\n", offset);
> +        return MEMTX_OK;
> +    }
> +
>      switch (offset) {
> +    case A_CTRL:
> +        /* We don't implement the 'data gating' feature so all other bits
> +         * are reserved and we make them RAZ/WI.
> +         */
> +        s->ctrl =3D value & (R_CTRL_SEC_RESP_MASK |
> +                           R_CTRL_AUTOINC_MASK |
> +                           R_CTRL_LOCKDOWN_MASK);
> +        break;
> +    case A_BLK_IDX:
> +        s->blk_idx =3D value % s->blk_max;
> +        break;
> +    case A_BLK_LUT:
> +        s->blk_lut[s->blk_idx] =3D value;
> +        if (size =3D=3D 4) {
> +            s->blk_idx++;
> +            s->blk_idx %=3D s->blk_max;
> +        }
> +        break;
> +    case A_INT_CLEAR:
> +        if (value & R_INT_CLEAR_IRQ_MASK) {
> +            s->int_stat =3D 0;
> +            tz_mpc_irq_update(s);
> +        }
> +        break;
> +    case A_INT_EN:
> +        s->int_en =3D value & R_INT_EN_IRQ_MASK;
> +        tz_mpc_irq_update(s);
> +        break;
> +    case A_INT_SET:
> +        if (value & R_INT_SET_IRQ_MASK) {
> +            s->int_stat =3D R_INT_STAT_IRQ_MASK;
> +            tz_mpc_irq_update(s);
> +        }
> +        break;
>      case A_PIDR4:
>      case A_PIDR5:
>      case A_PIDR6:
> @@ -248,6 +347,16 @@ static int tz_mpc_num_indexes(IOMMUMemoryRegion *iom=
mu)
>
>  static void tz_mpc_reset(DeviceState *dev)
>  {
> +    TZMPC *s =3D TZ_MPC(dev);
> +
> +    s->ctrl =3D 0;

According to the spec the reset for CTRL is 0x100

> +    s->blk_idx =3D 0;
> +    s->int_stat =3D 0;
> +    s->int_en =3D 0;

the reset for INT_EN is 0x1

> +    s->int_info1 =3D 0;
> +    s->int_info2 =3D 0;
> +
> +    memset(s->blk_lut, 0, s->blk_max * sizeof(uint32_t));
>  }
>
>  static void tz_mpc_init(Object *obj)
> @@ -321,13 +430,35 @@ static void tz_mpc_realize(DeviceState *dev, Error =
**errp)
>                         "tz-mpc-downstream");
>      address_space_init(&s->blocked_io_as, &s->blocked_io,
>                         "tz-mpc-blocked-io");
> +
> +    s->blk_lut =3D g_new(uint32_t, s->blk_max);
> +}
> +
> +static int tz_mpc_post_load(void *opaque, int version_id)
> +{
> +    TZMPC *s =3D TZ_MPC(opaque);
> +
> +    /* Check the incoming data doesn't point blk_idx off the end of blk_=
lut. */
> +    if (s->blk_idx >=3D s->blk_max) {
> +        return -1;
> +    }
> +    return 0;
>  }
>
>  static const VMStateDescription tz_mpc_vmstate =3D {
>      .name =3D "tz-mpc",
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
> +    .post_load =3D tz_mpc_post_load,
>      .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(ctrl, TZMPC),
> +        VMSTATE_UINT32(blk_idx, TZMPC),
> +        VMSTATE_UINT32(int_stat, TZMPC),
> +        VMSTATE_UINT32(int_en, TZMPC),
> +        VMSTATE_UINT32(int_info1, TZMPC),
> +        VMSTATE_UINT32(int_info2, TZMPC),
> +        VMSTATE_VARRAY_UINT32(blk_lut, TZMPC, blk_max,
> +                              0, vmstate_info_uint32, uint32_t),
>          VMSTATE_END_OF_LIST()
>      }
>  };


--
Alex Benn=C3=A9e
