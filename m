Received: from eggs.gnu.org ([209.51.188.92]:42857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hIqno-0002SG-LK
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hIqnn-0008Ll-KD
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:29:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hIqnn-0008LS-BU
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:29:19 -0400
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-5-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b4633799-eb78-6c7f-54e5-8b11bca37370@redhat.com>
Date: Tue, 23 Apr 2019 10:29:17 +0200
MIME-Version: 1.0
In-Reply-To: <20190420073442.7488-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/38] tcg: Support cross-class moves
 without instruction support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 20.04.19 09:34, Richard Henderson wrote:
> PowerPC Altivec does not support direct moves between vector registers
> and general registers.  So when tcg_out_mov fails, we can use the
> backing memory for the temporary to perform the move.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index b083faacd2..d3dcfe3dca 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3373,7 +3373,18 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
>                                           ots->indirect_base);
>              }
>              if (!tcg_out_mov(s, otype, ots->reg, ts->reg)) {
> -                abort();
> +                /* Cross register class move not supported.
> +                   Store the source register into the destination slot
> +                   and leave the destination temp as TEMP_VAL_MEM.  */
> +                assert(!ots->fixed_reg);
> +                if (!ts->mem_allocated) {
> +                    temp_allocate_frame(s, ots);
> +                }
> +                tcg_out_st(s, ts->type, ts->reg,
> +                           ots->mem_base->reg, ots->mem_offset);
> +                ots->mem_coherent = 1;
> +                temp_free_or_dead(s, ots, -1);
> +                return;
>              }
>          }
>          ots->val_type = TEMP_VAL_REG;
> @@ -3475,7 +3486,11 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>              reg = tcg_reg_alloc(s, arg_ct->u.regs, i_allocated_regs,
>                                  o_preferred_regs, ts->indirect_base);
>              if (!tcg_out_mov(s, ts->type, reg, ts->reg)) {
> -                abort();
> +                /* Cross register class move not supported.  Sync the
> +                   temp back to its slot and load from there.  */
> +                temp_sync(s, ts, i_allocated_regs, 0, 0);
> +                tcg_out_ld(s, ts->type, reg,
> +                           ts->mem_base->reg, ts->mem_offset);
>              }
>          }
>          new_args[i] = reg;
> @@ -3634,7 +3649,11 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
>                  if (ts->reg != reg) {
>                      tcg_reg_free(s, reg, allocated_regs);
>                      if (!tcg_out_mov(s, ts->type, reg, ts->reg)) {
> -                        abort();
> +                        /* Cross register class move not supported.  Sync the
> +                           temp back to its slot and load from there.  */
> +                        temp_sync(s, ts, allocated_regs, 0, 0);
> +                        tcg_out_ld(s, ts->type, reg,
> +                                   ts->mem_base->reg, ts->mem_offset);
>                      }
>                  }
>              } else {
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
