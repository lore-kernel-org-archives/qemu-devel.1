Received: from eggs.gnu.org ([2001:4830:134:3::10]:40427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dsnkB-0004Ar-TD
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dsnk7-00024M-UG
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:21:07 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:57175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dsnk7-00023T-Nl
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:21:03 -0400
Received: by mail-wr0-x233.google.com with SMTP id r74so1421111wrb.13
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 03:21:03 -0700 (PDT)
References: <20170912162513.21694-1-richard.henderson@linaro.org>
	<20170912162513.21694-13-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170912162513.21694-13-richard.henderson@linaro.org>
Date: Fri, 15 Sep 2017 11:21:01 +0100
Message-ID: <87zi9w8dpu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 12/16] tcg: Remove tcg_regset_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

This breaks the mips cross build:

In file included from /tmp/qemu-test/src/tcg/tcg.c:254:0:
/tmp/qemu-test/src/tcg/mips/tcg-target.inc.c: In function 'target_parse_constraint':
/tmp/qemu-test/src/tcg/mips/tcg-target.inc.c:198:9: error: implicit
declaration of function 'tcg_regset_set' [-Werror=implicit-function-declaration]

         tcg_regset_set(ct->u.regs, 0xffffffff);                                                                                                                                      ^~~~~~~~~~~~~~                                                                                                                                                      /tmp/qemu-test/src/tcg/mips/tcg-target.inc.c:198:9: error: nested extern declaration of 'tcg_regset_set' [-Werror=nested-externs]

Via:

  make docker-test-build@debian-mips-cross V=1 J=9 TARGET_LIST=mips-softmmu,mipsel-linux-user

> ---
>  tcg/tcg.h | 1 -
>  tcg/tcg.c | 8 ++++----
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 7226727ee4..e168bd2c44 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -210,7 +210,6 @@ typedef enum TCGOpcode {
>      NB_OPS,
>  } TCGOpcode;
>
> -#define tcg_regset_set(d, s) (d) = (s)
>  #define tcg_regset_set32(d, reg, val32) (d) |= (val32) << (reg)
>  #define tcg_regset_set_reg(d, r) (d) |= 1L << (r)
>  #define tcg_regset_reset_reg(d, r) (d) &= ~(1L << (r))
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index f40cce3364..873915925f 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -2452,7 +2452,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOpDef *def,
>      TCGTemp *ts, *ots;
>      TCGType otype, itype;
>
> -    tcg_regset_set(allocated_regs, s->reserved_regs);
> +    allocated_regs = s->reserved_regs;
>      ots = &s->temps[args[0]];
>      ts = &s->temps[args[1]];
>
> @@ -2540,8 +2540,8 @@ static void tcg_reg_alloc_op(TCGContext *s,
>             args + nb_oargs + nb_iargs,
>             sizeof(TCGArg) * def->nb_cargs);
>
> -    tcg_regset_set(i_allocated_regs, s->reserved_regs);
> -    tcg_regset_set(o_allocated_regs, s->reserved_regs);
> +    i_allocated_regs = s->reserved_regs;
> +    o_allocated_regs = s->reserved_regs;
>
>      /* satisfy input constraints */
>      for(k = 0; k < nb_iargs; k++) {
> @@ -2741,7 +2741,7 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
>      }
>
>      /* assign input registers */
> -    tcg_regset_set(allocated_regs, s->reserved_regs);
> +    allocated_regs = s->reserved_regs;
>      for(i = 0; i < nb_regs; i++) {
>          arg = args[nb_oargs + i];
>          if (arg != TCG_CALL_DUMMY_ARG) {


--
Alex Bennée
