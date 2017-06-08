Received: from eggs.gnu.org ([2001:4830:134:3::10]:45287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJ0dT-0008BN-TQ
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJ0dR-0000Vd-AT
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:50:15 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:32879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dJ0dR-0000VQ-6B
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:50:13 -0400
Received: by mail-qt0-x244.google.com with SMTP id w1so9402589qtg.0
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 09:50:13 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170607225212.23714-1-bobby.prani@gmail.com>
	<20170607225212.23714-2-bobby.prani@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <dc8ff867-6d7b-136f-dae9-a5fe11ac98c2@twiddle.net>
Date: Thu, 8 Jun 2017 09:50:09 -0700
MIME-Version: 1.0
In-Reply-To: <20170607225212.23714-2-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] tcg/aarch64: Introduce and use
 jump to register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org

On 06/07/2017 03:52 PM, Pranith Kumar wrote:
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>   tcg/aarch64/tcg-target.inc.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index 1fa3bccc89..ab0a8caa03 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -819,6 +819,12 @@ static inline void tcg_out_goto(TCGContext *s, tcg_insn_unit *target)
>       tcg_out_insn(s, 3206, B, offset);
>   }
>   
> +static inline void tcg_out_goto_register(TCGContext *s, intptr_t target)
> +{
> +    tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP, target);
> +    tcg_out_insn(s, 3207, BR, TCG_REG_TMP);
> +}
> +
>   static inline void tcg_out_goto_noaddr(TCGContext *s)
>   {
>       /* We pay attention here to not modify the branch target by reading from
> @@ -1364,10 +1370,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
>       case INDEX_op_exit_tb:
>           /* Reuse the zeroing that exists for goto_ptr.  */
>           if (a0 == 0) {
> -            tcg_out_goto(s, s->code_gen_epilogue);
> +            tcg_out_goto_register(s, (intptr_t)(s->code_gen_epilogue));

This pessimises the first 128MB of the buffer by not using a direct branch when 
it fits.  I think you should call the new function tcg_out_goto_long, and 
structure the function like tcg_out_call.


r~
