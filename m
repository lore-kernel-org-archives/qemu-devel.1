Received: from eggs.gnu.org ([209.51.188.92]:37599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLt7X-0002xI-4m
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLt7V-0001Pi-54
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:34:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLt7S-0001F9-1z
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:34:11 -0400
Received: by mail-wr1-x444.google.com with SMTP id e28so2303911wra.0
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 10:34:05 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id 5sm4440300wmi.32.2019.05.01.10.34.03
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 10:34:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 02AEE1FF87
	for <qemu-devel@nongnu.org>; Wed,  1 May 2019 18:34:03 +0100 (BST)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-8-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190501050536.15580-8-richard.henderson@linaro.org>
Date: Wed, 01 May 2019 18:34:02 +0100
Message-ID: <87muk65bat.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/29] tcg: Support cross-class moves
 without instruction support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> PowerPC Altivec does not support direct moves between vector registers
> and general registers.  So when tcg_out_mov fails, we can use the
> backing memory for the temporary to perform the move.

I couldn't see where tcg_out_mov fails in this way for ppc, it is still
abort or pass:

static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
{
    tcg_debug_assert(TCG_TARGET_REG_BITS =3D=3D 64 || type =3D=3D TCG_TYPE_=
I32);
    if (ret !=3D arg) {
        tcg_out32(s, OR | SAB(arg, ret, arg));
    }
    return true;
}

did a patch get missed somewhere?



>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 8ed7cb8654..68d86361e2 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3368,7 +3368,20 @@ static void tcg_reg_alloc_mov(TCGContext *s, const=
 TCGOp *op)
>                                           ots->indirect_base);
>              }
>              if (!tcg_out_mov(s, otype, ots->reg, ts->reg)) {
> -                abort();
> +                /*
> +                 * Cross register class move not supported.
> +                 * Store the source register into the destination slot
> +                 * and leave the destination temp as TEMP_VAL_MEM.
> +                 */
> +                assert(!ots->fixed_reg);
> +                if (!ts->mem_allocated) {
> +                    temp_allocate_frame(s, ots);
> +                }
> +                tcg_out_st(s, ts->type, ts->reg,
> +                           ots->mem_base->reg, ots->mem_offset);
> +                ots->mem_coherent =3D 1;
> +                temp_free_or_dead(s, ots, -1);
> +                return;
>              }
>          }
>          ots->val_type =3D TEMP_VAL_REG;
> @@ -3470,7 +3483,13 @@ static void tcg_reg_alloc_op(TCGContext *s, const =
TCGOp *op)
>              reg =3D tcg_reg_alloc(s, arg_ct->u.regs, i_allocated_regs,
>                                  o_preferred_regs, ts->indirect_base);
>              if (!tcg_out_mov(s, ts->type, reg, ts->reg)) {
> -                abort();
> +                /*
> +                 * Cross register class move not supported.  Sync the
> +                 * temp back to its slot and load from there.
> +                 */
> +                temp_sync(s, ts, i_allocated_regs, 0, 0);
> +                tcg_out_ld(s, ts->type, reg,
> +                           ts->mem_base->reg, ts->mem_offset);
>              }
>          }
>          new_args[i] =3D reg;
> @@ -3631,7 +3650,13 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGO=
p *op)
>                  if (ts->reg !=3D reg) {
>                      tcg_reg_free(s, reg, allocated_regs);
>                      if (!tcg_out_mov(s, ts->type, reg, ts->reg)) {
> -                        abort();
> +                        /*
> +                         * Cross register class move not supported.  Syn=
c the
> +                         * temp back to its slot and load from there.
> +                         */
> +                        temp_sync(s, ts, allocated_regs, 0, 0);
> +                        tcg_out_ld(s, ts->type, reg,
> +                                   ts->mem_base->reg, ts->mem_offset);
>                      }
>                  }
>              } else {


--
Alex Benn=C3=A9e
