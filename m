Received: from eggs.gnu.org ([2001:4830:134:3::10]:41281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eMBTg-0006xc-6z
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 06:33:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eMBTc-0007yh-7I
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 06:33:32 -0500
Received: from bran.ispras.ru ([83.149.199.196]:43708 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eMBTb-0007we-Vo
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 06:33:28 -0500
Date: Tue, 5 Dec 2017 14:33:25 +0300 (MSK)
From: Kirill Batuzov <batuzovk@ispras.ru>
In-Reply-To: <20171121212534.5177-22-richard.henderson@linaro.org>
Message-ID: <alpine.DEB.2.20.1712051427000.7159@bulbul.intra.ispras.ru>
References: <20171121212534.5177-1-richard.henderson@linaro.org>
	<20171121212534.5177-22-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v6 21/26] tcg: Add generic vector ops for
 multiplication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Tue, 21 Nov 2017, Richard Henderson wrote:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> +void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    TCGTemp *rt = tcgv_vec_temp(r);
> +    TCGTemp *at = tcgv_vec_temp(a);
> +    TCGTemp *bt = tcgv_vec_temp(b);
> +    TCGArg ri = temp_arg(rt);
> +    TCGArg ai = temp_arg(at);
> +    TCGArg bi = temp_arg(bt);
> +    TCGType type = rt->base_type;
> +    int can;
> +
> +    tcg_debug_assert(at->base_type == type);
> +    tcg_debug_assert(bt->base_type == type);
> +    can = tcg_can_emit_vec_op(INDEX_op_cmp_vec, type, vece);

Should be INDEX_op_mul_vec in the line above.

> +    if (can > 0) {
> +        vec_gen_3(INDEX_op_mul_vec, type, vece, ri, ai, bi);
> +    } else {
> +        tcg_debug_assert(can < 0);
> +        tcg_expand_vec_op(INDEX_op_mul_vec, type, vece, ri, ai, bi);
> +    }
> +}

-- 
Kirill
