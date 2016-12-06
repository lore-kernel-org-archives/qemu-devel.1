Received: from eggs.gnu.org ([2001:4830:134:3::10]:52799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cEIWS-0001cq-PI
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:23:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cEIWP-0001Nm-LR
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:23:16 -0500
Received: from mail-wj0-f171.google.com ([209.85.210.171]:32776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cEIWP-0001Nf-Cx
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:23:13 -0500
Received: by mail-wj0-f171.google.com with SMTP id xy5so327760245wjc.0
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 08:23:13 -0800 (PST)
References: <1479906121-12211-1-git-send-email-rth@twiddle.net>
	<1479906121-12211-20-git-send-email-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1479906121-12211-20-git-send-email-rth@twiddle.net>
Date: Tue, 06 Dec 2016 16:22:10 +0000
Message-ID: <87h96hyqml.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 19/64] tcg/optimize: Fold movcond 0/1
 into setcond
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org


Richard Henderson <rth@twiddle.net> writes:

> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  tcg/optimize.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index f41ed2c..9e26bb7 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1105,6 +1105,21 @@ void tcg_optimize(TCGContext *s)
>                  tcg_opt_gen_mov(s, op, args, args[0], args[4-tmp]);
>                  break;
>              }
> +            if (temp_is_const(args[3]) && temp_is_const(args[4])) {
> +                tcg_target_ulong tv = temps[args[3]].val;
> +                tcg_target_ulong fv = temps[args[4]].val;
> +                TCGCond cond = args[5];
> +                if (fv == 1 && tv == 0) {
> +                    cond = tcg_invert_cond(cond);
> +                } else if (!(tv == 1 && fv == 0)) {
> +                    goto do_default;
> +                }

Why the weird exit early here on an inverted test. Couldn't it just be

                } else if (tv == 1 && fv == 0) {
                    args[3] = cond;
                    op->opc = opc = (opc == INDEX_op_movcond_i32
                                     ? INDEX_op_setcond_i32
                                     : INDEX_op_setcond_i64);
                    nb_iargs = 2;
                }

And fall through to the goto do_default as before?

>              goto do_default;
>
>          case INDEX_op_add2_i32:


--
Alex Bennée
