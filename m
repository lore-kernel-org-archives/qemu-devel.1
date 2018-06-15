Received: from eggs.gnu.org ([2001:4830:134:3::10]:49948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fTp1f-0001Oi-E6
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fTp1b-0007JX-8O
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:44:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53256 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fTp1b-0007JP-0r
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:44:23 -0400
Date: Fri, 15 Jun 2018 16:44:21 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180615164312-mutt-send-email-mst@kernel.org>
References: <20180615062547.4798-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615062547.4798-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] tcg: Reduce max TB opcode count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Jason@zx2c4.com, pmatouse@redhat.com, mdroth@linux.vnet.ibm.com, pjp@redhat.com, sstabellini@kernel.org, pbonzini@redhat.com, crosthwaite.peter@gmail.com, sw@weilnetz.de

On Thu, Jun 14, 2018 at 08:25:47PM -1000, Richard Henderson wrote:
> Also, assert that we don't overflow any of two different offsets into
> the TB. Both unwind and goto_tb both record a uint16_t for later use.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> This fixes an arm-softmmu test case forwarded to me by Michael Tsirkin.
> 
> There is a TB generated from that test case that runs to 7800 opcodes,
> and compiles to 96k on an x64 host.  This overflows the 16-bit offset
> in which we record the goto_tb reset offset.  Because of that overflow,
> we install a jump destination that goes to neverland.  Boom.
> 
> With this reduced op count, the same TB compiles to about 48k for
> both x64 and ppc64le hosts, and neither assertion fires.
> 
> 
> r~

I just forwarded it:

Reported-by: "Jason A. Donenfeld" <Jason@zx2c4.com>

> 
> ---
>  tcg/tcg.h                    |  2 +-
>  tcg/aarch64/tcg-target.inc.c |  2 +-
>  tcg/arm/tcg-target.inc.c     |  2 +-
>  tcg/i386/tcg-target.inc.c    |  2 +-
>  tcg/mips/tcg-target.inc.c    |  2 +-
>  tcg/ppc/tcg-target.inc.c     |  4 ++--
>  tcg/s390/tcg-target.inc.c    |  2 +-
>  tcg/sparc/tcg-target.inc.c   |  4 ++--
>  tcg/tcg.c                    | 13 ++++++++++++-
>  tcg/tci/tcg-target.inc.c     |  2 +-
>  10 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 532d2a0710..2902a51505 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -852,7 +852,7 @@ static inline bool tcg_op_buf_full(void)
>       * such that a RISC host can reasonably use a 16-bit signed
>       * branch within the TB.
>       */
> -    return tcg_ctx->nb_ops >= 8000;
> +    return tcg_ctx->nb_ops >= 4000;
>  }
>  
>  /* pool based memory allocation */
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index be3192078d..4562d36d1b 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -1733,7 +1733,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
>              tcg_out_insn(s, 3305, LDR, offset, TCG_REG_TMP);
>          }
>          tcg_out_insn(s, 3207, BR, TCG_REG_TMP);
> -        s->tb_jmp_reset_offset[a0] = tcg_current_code_size(s);
> +        set_jmp_reset_offset(s, a0);
>          break;
>  
>      case INDEX_op_goto_ptr:
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index 56a32a470f..e1fbf465cb 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -1822,7 +1822,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
>                  tcg_out_movi32(s, COND_AL, base, ptr - dil);
>              }
>              tcg_out_ld32_12(s, COND_AL, TCG_REG_PC, base, dil);
> -            s->tb_jmp_reset_offset[args[0]] = tcg_current_code_size(s);
> +            set_jmp_reset_offset(s, args[0]);
>          }
>          break;
>      case INDEX_op_goto_ptr:
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 0d0ff524b7..e87b0d445e 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -2245,7 +2245,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
>              tcg_out_modrm_offset(s, OPC_GRP5, EXT5_JMPN_Ev, -1,
>                                   (intptr_t)(s->tb_jmp_target_addr + a0));
>          }
> -        s->tb_jmp_reset_offset[a0] = tcg_current_code_size(s);
> +        set_jmp_reset_offset(s, a0);
>          break;
>      case INDEX_op_goto_ptr:
>          /* jmp to the given host address (could be epilogue) */
> diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
> index ca5f1d4894..cff525373b 100644
> --- a/tcg/mips/tcg-target.inc.c
> +++ b/tcg/mips/tcg-target.inc.c
> @@ -1744,7 +1744,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
>              tcg_out_opc_reg(s, OPC_JR, 0, TCG_TMP0, 0);
>          }
>          tcg_out_nop(s);
> -        s->tb_jmp_reset_offset[a0] = tcg_current_code_size(s);
> +        set_jmp_reset_offset(s, a0);
>          break;
>      case INDEX_op_goto_ptr:
>          /* jmp to the given host address (could be epilogue) */
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index 86f7de5f7e..c2f729ee8f 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -2025,10 +2025,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
>          }
>          tcg_out32(s, MTSPR | RS(TCG_REG_TB) | CTR);
>          tcg_out32(s, BCCTR | BO_ALWAYS);
> -        s->tb_jmp_reset_offset[args[0]] = c = tcg_current_code_size(s);
> +        set_jmp_reset_offset(s, args[0]);
>          if (USE_REG_TB) {
>              /* For the unlinked case, need to reset TCG_REG_TB.  */
> -            c = -c;
> +            c = -tcg_current_code_size(s);
>              assert(c == (int16_t)c);
>              tcg_out32(s, ADDI | TAI(TCG_REG_TB, TCG_REG_TB, c));
>          }
> diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
> index 9af6dcef05..17c435ade5 100644
> --- a/tcg/s390/tcg-target.inc.c
> +++ b/tcg/s390/tcg-target.inc.c
> @@ -1783,7 +1783,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
>              /* and go there */
>              tcg_out_insn(s, RR, BCR, S390_CC_ALWAYS, TCG_REG_TB);
>          }
> -        s->tb_jmp_reset_offset[a0] = tcg_current_code_size(s);
> +        set_jmp_reset_offset(s, a0);
>  
>          /* For the unlinked path of goto_tb, we need to reset
>             TCG_REG_TB to the beginning of this TB.  */
> diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
> index bc673bd8c6..04bdc3df5e 100644
> --- a/tcg/sparc/tcg-target.inc.c
> +++ b/tcg/sparc/tcg-target.inc.c
> @@ -1388,12 +1388,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
>              tcg_out_arithi(s, TCG_REG_G0, TCG_REG_TB, 0, JMPL);
>              tcg_out_nop(s);
>          }
> -        s->tb_jmp_reset_offset[a0] = c = tcg_current_code_size(s);
> +        set_jmp_reset_offset(s, a0);
>  
>          /* For the unlinked path of goto_tb, we need to reset
>             TCG_REG_TB to the beginning of this TB.  */
>          if (USE_REG_TB) {
> -            c = -c;
> +            c = -tcg_current_code_size(s);
>              if (check_fit_i32(c, 13)) {
>                  tcg_out_arithi(s, TCG_REG_TB, TCG_REG_TB, c, ARITH_ADD);
>              } else {
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 1d1dfd7f7c..f27b22bd3c 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -306,6 +306,14 @@ TCGLabel *gen_new_label(void)
>      return l;
>  }
>  
> +static void set_jmp_reset_offset(TCGContext *s, int which)
> +{
> +    size_t off = tcg_current_code_size(s);
> +    s->tb_jmp_reset_offset[which] = off;
> +    /* Make sure that we didn't overflow the stored offset.  */
> +    assert(s->tb_jmp_reset_offset[which] == off);
> +}
> +
>  #include "tcg-target.inc.c"
>  
>  /* compare a pointer @ptr and a tb_tc @s */
> @@ -3532,7 +3540,10 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
>              break;
>          case INDEX_op_insn_start:
>              if (num_insns >= 0) {
> -                s->gen_insn_end_off[num_insns] = tcg_current_code_size(s);
> +                size_t off = tcg_current_code_size(s);
> +                s->gen_insn_end_off[num_insns] = off;
> +                /* Assert that we do not overflow our stored offset.  */
> +                assert(s->gen_insn_end_off[num_insns] == off);
>              }
>              num_insns++;
>              for (i = 0; i < TARGET_INSN_START_WORDS; ++i) {
> diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
> index cc949bea85..62ed097254 100644
> --- a/tcg/tci/tcg-target.inc.c
> +++ b/tcg/tci/tcg-target.inc.c
> @@ -574,7 +574,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
>              /* Indirect jump method. */
>              TODO();
>          }
> -        s->tb_jmp_reset_offset[args[0]] = tcg_current_code_size(s);
> +        set_jmp_reset_offset(s, args[0]);
>          break;
>      case INDEX_op_br:
>          tci_out_label(s, arg_label(args[0]));
> -- 
> 2.17.1
