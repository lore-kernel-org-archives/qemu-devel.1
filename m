Received: from eggs.gnu.org ([2001:4830:134:3::10]:60763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drqIf-0007El-Eu
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drqIb-0008T9-SR
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:52:45 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drqIb-0008Sw-Nq
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:52:41 -0400
Received: by mail-qk0-x244.google.com with SMTP id o77so7705781qke.2
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 11:52:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
	<20170912162513.21694-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6f1f0e95-ca3e-d988-d5b9-05f29fd55053@amsat.org>
Date: Tue, 12 Sep 2017 15:52:38 -0300
MIME-Version: 1.0
In-Reply-To: <20170912162513.21694-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

On 09/12/2017 01:25 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tcg/tcg.h | 1 -
>   tcg/tcg.c | 8 ++++----
>   2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 7226727ee4..e168bd2c44 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -210,7 +210,6 @@ typedef enum TCGOpcode {
>       NB_OPS,
>   } TCGOpcode;
>   
> -#define tcg_regset_set(d, s) (d) = (s)
>   #define tcg_regset_set32(d, reg, val32) (d) |= (val32) << (reg)
>   #define tcg_regset_set_reg(d, r) (d) |= 1L << (r)
>   #define tcg_regset_reset_reg(d, r) (d) &= ~(1L << (r))
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index f40cce3364..873915925f 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -2452,7 +2452,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOpDef *def,
>       TCGTemp *ts, *ots;
>       TCGType otype, itype;
>   
> -    tcg_regset_set(allocated_regs, s->reserved_regs);
> +    allocated_regs = s->reserved_regs;
>       ots = &s->temps[args[0]];
>       ts = &s->temps[args[1]];
>   
> @@ -2540,8 +2540,8 @@ static void tcg_reg_alloc_op(TCGContext *s,
>              args + nb_oargs + nb_iargs,
>              sizeof(TCGArg) * def->nb_cargs);
>   
> -    tcg_regset_set(i_allocated_regs, s->reserved_regs);
> -    tcg_regset_set(o_allocated_regs, s->reserved_regs);
> +    i_allocated_regs = s->reserved_regs;
> +    o_allocated_regs = s->reserved_regs;
>   
>       /* satisfy input constraints */
>       for(k = 0; k < nb_iargs; k++) {
> @@ -2741,7 +2741,7 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
>       }
>       
>       /* assign input registers */
> -    tcg_regset_set(allocated_regs, s->reserved_regs);
> +    allocated_regs = s->reserved_regs;
>       for(i = 0; i < nb_regs; i++) {
>           arg = args[nb_oargs + i];
>           if (arg != TCG_CALL_DUMMY_ARG) {
> 
