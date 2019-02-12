Received: from eggs.gnu.org ([209.51.188.92]:55510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gtYsJ-0002eY-Qh
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:17:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gtYsI-0002d4-Sd
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:17:27 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gtYsI-0002aW-Gp
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:17:26 -0500
Received: by mail-wm1-x343.google.com with SMTP id y185so1477564wmd.1
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 06:17:25 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20181207170951.7307-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2393c9b2-3141-4296-7cbe-a7091f969bcb@redhat.com>
Date: Tue, 12 Feb 2019 15:17:23 +0100
MIME-Version: 1.0
In-Reply-To: <20181207170951.7307-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/i386: Generate #UD when applying
 LOCK to a register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 07/12/18 18:09, Richard Henderson wrote:
> This covers inc, dec, and the bit test instructions.
> 
> I believe we've finally covered all of the cases for
> which we have an atomic path that would use the cpu_A0
> temp, which is only initialized for address sources.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1803160/comments/4
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/i386/translate.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 0dd5fbe45c..eb52322a47 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -1398,6 +1398,11 @@ static void gen_op(DisasContext *s1, int op, TCGMemOp ot, int d)
>  static void gen_inc(DisasContext *s1, TCGMemOp ot, int d, int c)
>  {
>      if (s1->prefix & PREFIX_LOCK) {
> +        if (d != OR_TMP0) {
> +            /* Lock prefix when destination is not memory.  */
> +            gen_illegal_opcode(s1);
> +            return;
> +        }
>          tcg_gen_movi_tl(s1->T0, c > 0 ? 1 : -1);
>          tcg_gen_atomic_add_fetch_tl(s1->T0, s1->A0, s1->T0,
>                                      s1->mem_index, ot | MO_LE);
> @@ -6764,6 +6769,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
>                  gen_op_ld_v(s, ot, s->T0, s->A0);
>              }
>          } else {
> +            if (s->prefix & PREFIX_LOCK) {
> +                goto illegal_op;
> +            }
>              gen_op_mov_v_reg(s, ot, s->T0, rm);
>          }
>          /* load shift */
> @@ -6803,6 +6811,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
>                  gen_op_ld_v(s, ot, s->T0, s->A0);
>              }
>          } else {
> +            if (s->prefix & PREFIX_LOCK) {
> +                goto illegal_op;
> +            }
>              gen_op_mov_v_reg(s, ot, s->T0, rm);
>          }
>      bt_op:
> 

Queued, thanks.

Paolo
