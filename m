Received: from eggs.gnu.org ([2001:4830:134:3::10]:58433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fkt06-0002iU-QY
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:25:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fkt02-00073n-Ox
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:25:22 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:35517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fkt02-00073c-IQ
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:25:18 -0400
Received: by mail-yb0-f175.google.com with SMTP id x15-v6so7684267ybm.2
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 08:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180801151417.23655-1-pbonzini@redhat.com>
In-Reply-To: <20180801151417.23655-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 1 Aug 2018 12:25:04 -0300
Message-ID: <CAAdtpL5Jp+KdspQCUyn=Lz5v3VnK7Pni1TEp4m5CS-bwuuuHRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fix "Missing break in switch" coverity
 reports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Le mer. 1 ao=C3=BBt 2018 12:15, Paolo Bonzini <pbonzini@redhat.com> a =C3=
=A9crit :

> Many of these are marked as "intentional/fix required" because they
> just need adding a fall through comment.  This is exactly what this
> patch does, except for target/mips/translate.c where it is easier to
> duplicate the code, and hw/audio/sb16.c where I consulted the DOSBox
> sources and decide to just remove the LOG_UNIMP before the fallthrough.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  disas/m68k.c            | 1 +
>  hw/arm/pxa2xx.c         | 2 +-
>  hw/audio/cs4231a.c      | 1 +
>  hw/audio/gusemu_hal.c   | 1 +
>  hw/audio/sb16.c         | 4 +---
>  hw/display/cg3.c        | 1 +
>  hw/display/cirrus_vga.c | 3 ++-
>  hw/timer/sh_timer.c     | 1 +
>  target/arm/helper.c     | 1 +
>  target/i386/translate.c | 2 ++
>  target/mips/translate.c | 2 ++
>  11 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/disas/m68k.c b/disas/m68k.c
> index a687df437c..0dc8aa1a3c 100644
> --- a/disas/m68k.c
> +++ b/disas/m68k.c
> @@ -1623,6 +1623,7 @@ print_insn_arg (const char *d,
>
>      case 'X':
>        place =3D '8';
> +      /* fall through */
>      case 'Y':
>      case 'Z':
>      case 'W':
> diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
> index b67b0cefb6..f598a1c053 100644
> --- a/hw/arm/pxa2xx.c
> +++ b/hw/arm/pxa2xx.c
> @@ -409,7 +409,7 @@ static uint64_t pxa2xx_mm_read(void *opaque, hwaddr
> addr,
>      case MDCNFG ... SA1110:
>          if ((addr & 3) =3D=3D 0)
>              return s->mm_regs[addr >> 2];
> -
> +        /* fall through */
>      default:
>          printf("%s: Bad register " REG_FMT "\n", __func__, addr);
>          break;
> diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
> index aaebec1839..9089dcb47e 100644
> --- a/hw/audio/cs4231a.c
> +++ b/hw/audio/cs4231a.c
> @@ -305,6 +305,7 @@ static void cs_reset_voices (CSState *s, uint32_t val=
)
>
>      case 6:
>          as.endianness =3D 1;
> +        /* fall through */
>      case 2:
>          as.fmt =3D AUD_FMT_S16;
>          s->shift =3D as.nchannels;
> diff --git a/hw/audio/gusemu_hal.c b/hw/audio/gusemu_hal.c
> index 1150fc4426..ae40ca341c 100644
> --- a/hw/audio/gusemu_hal.c
> +++ b/hw/audio/gusemu_hal.c
> @@ -261,6 +261,7 @@ void gus_write(GUSEmuState * state, int port, int
> size, unsigned int data)
>              GUSregb(IRQStatReg2x6) =3D 0x10;
>              GUS_irqrequest(state, state->gusirq, 1);
>          }
> +        /* fall through */
>      case 0x20D:                /* SB2xCd no IRQ */
>          GUSregb(SB2xCd) =3D (uint8_t) data;
>          break;
> diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
> index 5a4d32364e..665a7e75c5 100644
> --- a/hw/audio/sb16.c
> +++ b/hw/audio/sb16.c
> @@ -741,10 +741,8 @@ static void complete (SB16State *s)
>              ldebug ("set time const %d\n", s->time_const);
>              break;
>
> -        case 0x42:              /* FT2 sets output freq with this, go
> figure */
> -            qemu_log_mask(LOG_UNIMP, "cmd 0x42 might not do what it thin=
k
> it"
> -                          " should\n");
>          case 0x41:
> +        case 0x42:              /* FT2 sets output freq with this, go
> figure */
>              s->freq =3D dsp_get_hilo (s);
>              ldebug ("set freq %d\n", s->freq);
>              break;
> diff --git a/hw/display/cg3.c b/hw/display/cg3.c
> index 6fff4852c5..1c199ab369 100644
> --- a/hw/display/cg3.c
> +++ b/hw/display/cg3.c
> @@ -232,6 +232,7 @@ static void cg3_reg_write(void *opaque, hwaddr addr,
> uint64_t val,
>                  s->b[s->dac_index] =3D regval;
>                  /* Index autoincrement */
>                  s->dac_index =3D (s->dac_index + 1) & 0xff;
> +                /* fall through */
>              default:
>                  s->dac_state =3D 0;
>                  break;
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index 7583b18c29..04c87c8e8d 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -1426,7 +1426,8 @@ static void cirrus_vga_write_sr(CirrusVGAState * s,
> uint32_t val)
>          s->vga.hw_cursor_y =3D (val << 3) | (s->vga.sr_index >> 5);
>         break;
>      case 0x07:                 // Extended Sequencer Mode
> -    cirrus_update_memory_access(s);
> +        cirrus_update_memory_access(s);
> +        /* fall through */
>      case 0x08:                 // EEPROM Control
>      case 0x09:                 // Scratch Register 0
>      case 0x0a:                 // Scratch Register 1
> diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
> index 5f8736cf10..91b18ba312 100644
> --- a/hw/timer/sh_timer.c
> +++ b/hw/timer/sh_timer.c
> @@ -74,6 +74,7 @@ static uint32_t sh_timer_read(void *opaque, hwaddr
> offset)
>      case OFFSET_TCPR:
>          if (s->feat & TIMER_FEAT_CAPT)
>              return s->tcpr;
> +        /* fall through */
>      default:
>          hw_error("sh_timer_read: Bad offset %x\n", (int)offset);
>          return 0;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 66afb08ee0..12735ff089 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -12277,6 +12277,7 @@ int arm_rmode_to_sf(int rmode)
>          /* FIXME: add support for TIEAWAY and ODD */
>          qemu_log_mask(LOG_UNIMP, "arm: unimplemented rounding mode: %d\n=
",
>                        rmode);
> +        /* fall through for now */
>

This one looks weird, hidden bug?

For the rest:

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

     case FPROUNDING_TIEEVEN:
>      default:
>          rmode =3D float_round_nearest_even;
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 07d185e7b6..1f9d1d9b24 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -4689,6 +4689,7 @@ static target_ulong disas_insn(DisasContext *s,
> CPUState *cpu)
>      case 0x82:
>          if (CODE64(s))
>              goto illegal_op;
> +        /* fall through */
>      case 0x80: /* GRP1 */
>      case 0x81:
>      case 0x83:
> @@ -8292,6 +8293,7 @@ static target_ulong disas_insn(DisasContext *s,
> CPUState *cpu)
>      case 0x10e ... 0x10f:
>          /* 3DNow! instructions, ignore prefixes */
>          s->prefix &=3D ~(PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA);
> +        /* fall through */
>      case 0x110 ... 0x117:
>      case 0x128 ... 0x12f:
>      case 0x138 ... 0x13a:
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 20b43c0337..60408dcda3 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -19874,6 +19874,8 @@ static void decode_opc(CPUMIPSState *env,
> DisasContext *ctx)
>          case OPC_MTHC1:
>              check_cp1_enabled(ctx);
>              check_insn(ctx, ISA_MIPS32R2);
> +            gen_cp1(ctx, op1, rt, rd);
> +            break;
>          case OPC_MFC1:
>          case OPC_CFC1:
>          case OPC_MTC1:
> --
> 2.17.1
>
>
>
