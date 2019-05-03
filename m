Received: from eggs.gnu.org ([209.51.188.92]:52199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMd9c-0007fy-6Y
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMd9b-00033E-Bp
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:43:28 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMd9b-000322-51
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:43:27 -0400
Received: by mail-pg1-x541.google.com with SMTP id i21so3105335pgi.12
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 11:43:26 -0700 (PDT)
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
	<20190502143409.59600-2-ysato@users.sourceforge.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3de96999-eba5-fa88-0c4d-a7b27d916081@linaro.org>
Date: Fri, 3 May 2019 11:43:23 -0700
MIME-Version: 1.0
In-Reply-To: <20190502143409.59600-2-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v8 01/12] target/rx: TCG translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 5/2/19 7:33 AM, Yoshinori Sato wrote:
> +/* conditional branch helper */
> +static void rx_bcnd_main(DisasContext *ctx, int cd, int dst)
> +{
> +    DisasCompare dc;
> +    TCGLabel *t, *done;
> +
> +    switch (cd) {
> +    case 0 ... 13:
> +        dc.temp = tcg_temp_new();
> +        psw_cond(&dc, cd);
> +        t = gen_new_label();
> +        done = gen_new_label();
> +        tcg_gen_brcondi_i32(dc.cond, dc.value, 0, t);
> +        gen_goto_tb(ctx, 0, ctx->base.pc_next);
> +        tcg_gen_br(done);
> +        gen_set_label(t);
> +        gen_goto_tb(ctx, 1, ctx->pc + dst);
> +        gen_set_label(done);
> +        tcg_temp_free(dc.temp);
> +        break;
> +    case 14:
> +        /* always true case */
> +        gen_goto_tb(ctx, 0, ctx->pc + dst);
> +        break;
> +    case 15:
> +        /* always false case */
> +        /* Nothing do */
> +        break;
> +    }
> +    ctx->base.is_jmp = DISAS_JUMP;
> +}

Do not set is_jmp to DISAS_JUMP here.  We have already set is_jmp to
DISAS_NORETURN in gen_goto_tb.  For case 15, we do not need to exit the TB in
order to treat the never-taken branch as a nop.

This assignment means that we will emit *another* exit from the TB in
rx_tr_tb_stop, which will be unreachable code.

This is the only bug I see in this revision.  Thanks for your patience!


r~
