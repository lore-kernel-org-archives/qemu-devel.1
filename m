Received: from eggs.gnu.org ([2001:4830:134:3::10]:59213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eosGj-0002Fz-W6
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eosGj-0004bh-3B
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:54:46 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eosGi-0004ah-Sn
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:54:44 -0500
Received: by mail-oi0-x241.google.com with SMTP id a207so3867903oii.10
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 06:54:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217164037.15727-2-richard.henderson@linaro.org>
References: <20180217164037.15727-1-richard.henderson@linaro.org>
	<20180217164037.15727-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 14:54:23 +0000
Message-ID: <CAFEAcA9rLWsSH82XM4nvPZo_urJL3BZv_4g_CMCvxYsCT=hVyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] tcg: Fold unspecified opcode test into
 tcg_can_emit_vec_op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 February 2018 at 16:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This releases the callers from having to check themselves,
> which tidies up the code a bit.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/aarch64/tcg-target.inc.c |  4 ++++
>  tcg/i386/tcg-target.inc.c    |  4 ++++
>  tcg/tcg-op-gvec.c            | 28 ++++++++++++----------------
>  3 files changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index be3192078d..9b0a803d79 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -2217,6 +2217,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>  int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
>  {
>      switch (opc) {
> +    case 0:
> +        /* Unspecified opcode */
> +        return 1;
> +
>      case INDEX_op_add_vec:
>      case INDEX_op_sub_vec:
>      case INDEX_op_mul_vec:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
since there's clearly no behaviour change here.

But it isn't clear to me why tcg_can_emit_vec_op() should return 1
for unspecified opcodes -- shouldn't the default be "we can't vectorize
something we don't know about", not "no idea what this is so let's
assume it's vectorizable" ?

A comment about why unspecified opcodes are always OK might be helpful.

thanks
-- PMM
