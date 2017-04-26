Received: from eggs.gnu.org ([2001:4830:134:3::10]:48674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3Qce-0006lH-7F
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3Qcd-0004H4-6X
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:21:00 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:36772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d3Qcc-0004Fz-L4
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:20:59 -0400
Received: by mail-wr0-x230.google.com with SMTP id l50so3900011wrc.3
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 10:20:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170425104338.31984-1-rth@twiddle.net>
References: <20170425104338.31984-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Apr 2017 18:20:36 +0100
Message-ID: <CAFEAcA-sj19NJ8S1LJKfQ4UkOKtCQfE0jYdf=BPv9B2WQ59-TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] tcg: Initialize return value after
 exit_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On 25 April 2017 at 11:43, Richard Henderson <rth@twiddle.net> wrote:
> Users of tcg_gen_atomic_cmpxchg and do_atomic_op rightfully utilize
> the output.  Even though this code is dead, it gets translated, and
> without the initialization we encounter a tcg_error.
>
> Reported-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  tcg/tcg-op.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 95a39b7..6b1f415 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -2861,6 +2861,9 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
>  #endif
>  #else
>          gen_helper_exit_atomic(tcg_ctx.tcg_env);
> +        /* Produce a result, so that we have a well-formed opcode stream
> +           with respect to uses of the result in the (dead) code following.  */
> +        tcg_gen_movi_i64(retv, 0);
>  #endif /* CONFIG_ATOMIC64 */
>      } else {
>          TCGv_i32 c32 = tcg_temp_new_i32();
> @@ -2966,6 +2969,9 @@ static void do_atomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,
>  #endif
>  #else
>          gen_helper_exit_atomic(tcg_ctx.tcg_env);
> +        /* Produce a result, so that we have a well-formed opcode stream
> +           with respect to uses of the result in the (dead) code following.  */
> +        tcg_gen_movi_i64(ret, 0);
>  #endif /* CONFIG_ATOMIC64 */
>      } else {
>          TCGv_i32 v32 = tcg_temp_new_i32();
> --

Tested-by: Peter Maydell <peter.maydell@linaro.org>

Without this patch an AArch64 QEMU crashes on startup if I build it
with clang and with optimization enabled. We should probably get this
into master sooner rather than later...

thanks
-- PMM
