Received: from eggs.gnu.org ([2001:4830:134:3::10]:56607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fNoCS-0000Bn-OP
	for qemu-devel@nongnu.org; Tue, 29 May 2018 19:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fNoCR-00018J-Ai
	for qemu-devel@nongnu.org; Tue, 29 May 2018 19:38:44 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:44380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fNoCQ-00017h-VX
	for qemu-devel@nongnu.org; Tue, 29 May 2018 19:38:43 -0400
Received: by mail-lf0-x242.google.com with SMTP id g25-v6so1368296lfb.11
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 16:38:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-13-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-13-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 May 2018 16:38:11 -0700
Message-ID: <CAKmqyKN+K2iZcjJtEfVezemke55hGC80t7a6qchTAKD7keV-Zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 12/30] RISC-V: Mark mstatus.fs dirty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On Tue, May 22, 2018 at 5:14 PM, Michael Clark <mjc@sifive.com> wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
>
> Modifed from Richard Henderson's patch [1] to integrate
> with the new control and status register implementation.
>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg07034.html
>
> Note: the f* CSRs already mark mstatus.FS dirty using
> env->mstatus |= mstatus.FS so the bug in the first
> spin of this patch has been fixed in a prior commit.
>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Reviewed-by: Michael Clark <mjc@sifive.com>

It sounds like this should still have Richard's SOB line.

Once that is fixed:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
> Co-authored-by: Michael Clark <mjc@sifive.com>
> ---
>  target/riscv/csr.c       | 12 ------------
>  target/riscv/translate.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 39 insertions(+), 13 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 0e6c0c365154..b4452388ff02 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -325,18 +325,6 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
>
>      mstatus = (mstatus & ~mask) | (val & mask);
>
> -    /* Note: this is a workaround for an issue where mstatus.FS
> -       does not report dirty after floating point operations
> -       that modify floating point state. This workaround is
> -       technically compliant with the RISC-V Privileged
> -       specification as it is legal to return only off, or dirty.
> -       at the expense of extra floating point save/restore. */
> -
> -    /* FP is always dirty or off */
> -    if (mstatus & MSTATUS_FS) {
> -        mstatus |= MSTATUS_FS;
> -    }
> -
>      int dirty = ((mstatus & MSTATUS_FS) == MSTATUS_FS) |
>                  ((mstatus & MSTATUS_XS) == MSTATUS_XS);
>      mstatus = set_field(mstatus, MSTATUS_SD, dirty);
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 466b9551cbd9..a980611eb611 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -651,6 +651,31 @@ static void gen_store(DisasContext *ctx, uint32_t opc, int rs1, int rs2,
>      tcg_temp_free(dat);
>  }
>
> +#ifndef CONFIG_USER_ONLY
> +/* The states of mstatus_fs are:
> + * 0 = disabled, 1 = initial, 2 = clean, 3 = dirty
> + * We will have already diagnosed disabled state,
> + * and need to turn initial/clean into dirty.
> + */
> +static void mark_fs_dirty(DisasContext *ctx)
> +{
> +    TCGv tmp;
> +    if (ctx->mstatus_fs == MSTATUS_FS) {
> +        return;
> +    }
> +    /* Remember the state change for the rest of the TB.  */
> +    ctx->mstatus_fs = MSTATUS_FS;
> +
> +    tmp = tcg_temp_new();
> +    tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
> +    tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
> +    tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
> +    tcg_temp_free(tmp);
> +}
> +#else
> +static inline void mark_fs_dirty(DisasContext *ctx) { }
> +#endif
> +
>  static void gen_fp_load(DisasContext *ctx, uint32_t opc, int rd,
>          int rs1, target_long imm)
>  {
> @@ -679,6 +704,8 @@ static void gen_fp_load(DisasContext *ctx, uint32_t opc, int rd,
>          break;
>      }
>      tcg_temp_free(t0);
> +
> +    mark_fs_dirty(ctx);
>  }
>
>  static void gen_fp_store(DisasContext *ctx, uint32_t opc, int rs1,
> @@ -944,6 +971,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
>                           int rs1, int rs2, int rm)
>  {
>      TCGv t0 = NULL;
> +    bool fp_output = true;
>
>      if (ctx->mstatus_fs == 0) {
>          goto do_illegal;
> @@ -1006,6 +1034,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
>          }
>          gen_set_gpr(rd, t0);
>          tcg_temp_free(t0);
> +        fp_output = false;
>          break;
>
>      case OPC_RISC_FCVT_W_S:
> @@ -1035,6 +1064,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
>          }
>          gen_set_gpr(rd, t0);
>          tcg_temp_free(t0);
> +        fp_output = false;
>          break;
>
>      case OPC_RISC_FCVT_S_W:
> @@ -1085,6 +1115,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
>          }
>          gen_set_gpr(rd, t0);
>          tcg_temp_free(t0);
> +        fp_output = false;
>          break;
>
>      case OPC_RISC_FMV_S_X:
> @@ -1177,6 +1208,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
>          }
>          gen_set_gpr(rd, t0);
>          tcg_temp_free(t0);
> +        fp_output = false;
>          break;
>
>      case OPC_RISC_FCVT_W_D:
> @@ -1206,6 +1238,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
>          }
>          gen_set_gpr(rd, t0);
>          tcg_temp_free(t0);
> +        fp_output = false;
>          break;
>
>      case OPC_RISC_FCVT_D_W:
> @@ -1253,6 +1286,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
>          default:
>              goto do_illegal;
>          }
> +        fp_output = false;
>          break;
>
>      case OPC_RISC_FMV_D_X:
> @@ -1269,7 +1303,11 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
>              tcg_temp_free(t0);
>          }
>          gen_exception_illegal(ctx);
> -        break;
> +        return;
> +    }
> +
> +    if (fp_output) {
> +        mark_fs_dirty(ctx);
>      }
>  }
>
> --
> 2.7.0
>
>
