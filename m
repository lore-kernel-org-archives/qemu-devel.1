Received: from eggs.gnu.org ([2001:4830:134:3::10]:36423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diRAK-0005Cs-Ek
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 16:13:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diRAF-0003Oq-In
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 16:13:16 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:34145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1diRAF-0003OJ-D2
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 16:13:11 -0400
Received: by mail-pg0-x22b.google.com with SMTP id u185so49517812pgb.1
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 13:13:11 -0700 (PDT)
References: <20170817180404.29334-1-alex.bennee@linaro.org>
	<20170817180404.29334-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <63b2dd72-90bf-d9f6-9f7c-c9919904e74e@linaro.org>
Date: Thu, 17 Aug 2017 13:13:07 -0700
MIME-Version: 1.0
In-Reply-To: <20170817180404.29334-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/9] tcg: generate ptrs to vector
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, rth@twiddle.net, cota@braap.org, batuzovk@ispras.ru
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 08/17/2017 11:03 AM, Alex Bennée wrote:
> As we operate directly on the vectors in memory we pass around the
> address for TCG_TYPE_VECTOR. Currently only helpers ever see these
> values but if we were to generate simd backend instructions they would
> load directly from the backing store.
> 
> We also need to ensure when copying from one temp register to the
> other the right size is used.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tcg/tcg.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 35598296c5..e16811d68d 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -2034,7 +2034,21 @@ static void temp_load(TCGContext *s, TCGTemp *ts, TCGRegSet desired_regs,
>          break;
>      case TEMP_VAL_MEM:
>          reg = tcg_reg_alloc(s, desired_regs, allocated_regs, ts->indirect_base);
> -        tcg_out_ld(s, ts->type, reg, ts->mem_base->reg, ts->mem_offset);
> +        if (ts->type == TCG_TYPE_VECTOR) {
> +            /* Vector registers are ptr's to the memory representation */
> +            TCGArg args[TCG_MAX_OP_ARGS];
> +            int const_args[TCG_MAX_OP_ARGS];
> +            args[0] = reg;
> +            args[1] = ts->mem_base->reg;
> +            args[2] = ts->mem_offset;
> +            const_args[0] = 0;
> +            const_args[1] = 0;
> +            const_args[2] = 1;
> +            /* FIXME: needs to by host_ptr centric */
> +            tcg_out_op(s, INDEX_op_add_i64, args, const_args);

This fails when the offset is out of range for the addition, and technically if
the backend does not support 3-operand addition.  You didn't see this because
the x86 backend does use lea, and has a 32-bit offset.

Once upon a time we had a tcg_out_addi; if we go this way with TCG_TYPE_VECTOR,
we should re-introduce that.


r~
