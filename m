Received: from eggs.gnu.org ([2001:4830:134:3::10]:50763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuGt-0003La-P6
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:59:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuGq-0007cV-Ho
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:59:43 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:46214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuGq-0007bk-5W
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:59:40 -0500
Received: by mail-qk0-x244.google.com with SMTP id b184so11361646qkc.13
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 09:59:40 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171215170732.31125-1-richard.henderson@linaro.org>
	<20171215170732.31125-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0397263e-9d94-da2c-6e47-ea95c752338c@amsat.org>
Date: Fri, 15 Dec 2017 14:59:35 -0300
MIME-Version: 1.0
In-Reply-To: <20171215170732.31125-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/7] tcg: Generalize TCGOp parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 12/15/2017 02:07 PM, Richard Henderson wrote:
> We had two fields specific to INDEX_op_call.  Rename these and
> add some macros so that the fields may be reused for other opcodes.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tcg/tcg.h      | 10 ++++++----
>  tcg/optimize.c |  4 ++--
>  tcg/tcg.c      | 22 +++++++++++-----------
>  3 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index a577447846..f25efa9795 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -566,10 +566,9 @@ typedef uint16_t TCGLifeData;
>  typedef struct TCGOp {
>      TCGOpcode opc   : 8;        /*  8 */
>  
> -    /* The number of out and in parameter for a call.  */
> -    unsigned calli  : 4;        /* 12 */
> -    unsigned callo  : 2;        /* 14 */
> -    unsigned        : 2;        /* 16 */
> +    /* Parameters for this opcode.  See below.  */
> +    unsigned param1 : 4;        /* 12 */
> +    unsigned param2 : 4;        /* 16 */
>  
>      /* Lifetime data of the operands.  */
>      unsigned life   : 16;       /* 32 */
> @@ -581,6 +580,9 @@ typedef struct TCGOp {
>      TCGArg args[MAX_OPC_PARAM];
>  } TCGOp;
>  
> +#define TCGOP_CALLI(X)    (X)->param1
> +#define TCGOP_CALLO(X)    (X)->param2
> +
>  /* Make sure operands fit in the bitfields above.  */
>  QEMU_BUILD_BUG_ON(NB_OPS > (1 << 8));
>  
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index e495680e95..2cbbeefd53 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -627,8 +627,8 @@ void tcg_optimize(TCGContext *s)
>          /* Count the arguments, and initialize the temps that are
>             going to be used */
>          if (opc == INDEX_op_call) {
> -            nb_oargs = op->callo;
> -            nb_iargs = op->calli;
> +            nb_oargs = TCGOP_CALLO(op);
> +            nb_iargs = TCGOP_CALLI(op);
>              for (i = 0; i < nb_oargs + nb_iargs; i++) {
>                  TCGTemp *ts = arg_temp(op->args[i]);
>                  if (ts) {
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index f26949a900..93caa0be93 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1430,7 +1430,7 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
>      } else {
>          nb_rets = 0;
>      }
> -    op->callo = nb_rets;
> +    TCGOP_CALLO(op) = nb_rets;
>  
>      real_args = 0;
>      for (i = 0; i < nargs; i++) {
> @@ -1469,10 +1469,10 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
>      }
>      op->args[pi++] = (uintptr_t)func;
>      op->args[pi++] = flags;
> -    op->calli = real_args;
> +    TCGOP_CALLI(op) = real_args;
>  
>      /* Make sure the fields didn't overflow.  */
> -    tcg_debug_assert(op->calli == real_args);
> +    tcg_debug_assert(TCGOP_CALLI(op) == real_args);
>      tcg_debug_assert(pi <= ARRAY_SIZE(op->args));
>  
>  #if defined(__sparc__) && !defined(__arch64__) \
> @@ -1634,8 +1634,8 @@ void tcg_dump_ops(TCGContext *s)
>              }
>          } else if (c == INDEX_op_call) {
>              /* variable number of arguments */
> -            nb_oargs = op->callo;
> -            nb_iargs = op->calli;
> +            nb_oargs = TCGOP_CALLO(op);
> +            nb_iargs = TCGOP_CALLI(op);
>              nb_cargs = def->nb_cargs;
>  
>              /* function name, flags, out args */
> @@ -1996,8 +1996,8 @@ static void liveness_pass_1(TCGContext *s)
>              {
>                  int call_flags;
>  
> -                nb_oargs = op->callo;
> -                nb_iargs = op->calli;
> +                nb_oargs = TCGOP_CALLO(op);
> +                nb_iargs = TCGOP_CALLI(op);
>                  call_flags = op->args[nb_oargs + nb_iargs + 1];
>  
>                  /* pure functions can be removed if their result is unused */
> @@ -2233,8 +2233,8 @@ static bool liveness_pass_2(TCGContext *s)
>          TCGTemp *arg_ts, *dir_ts;
>  
>          if (opc == INDEX_op_call) {
> -            nb_oargs = op->callo;
> -            nb_iargs = op->calli;
> +            nb_oargs = TCGOP_CALLO(op);
> +            nb_iargs = TCGOP_CALLI(op);
>              call_flags = op->args[nb_oargs + nb_iargs + 1];
>          } else {
>              nb_iargs = def->nb_iargs;
> @@ -2915,8 +2915,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>  
>  static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
>  {
> -    const int nb_oargs = op->callo;
> -    const int nb_iargs = op->calli;
> +    const int nb_oargs = TCGOP_CALLO(op);
> +    const int nb_iargs = TCGOP_CALLI(op);
>      const TCGLifeData arg_life = op->life;
>      int flags, nb_regs, i;
>      TCGReg reg;
> 
