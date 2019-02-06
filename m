Received: from eggs.gnu.org ([209.51.188.92]:55946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grFyw-00087I-Mz
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:42:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grFyv-0004KG-TI
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:42:46 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grFyu-0004HB-BV
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:42:45 -0500
Received: by mail-wm1-x344.google.com with SMTP id d15so1151441wmb.3
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 21:42:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20181207170951.7307-1-richard.henderson@linaro.org>
Message-ID: <83ce7768-bff3-fcf2-12b8-3ff0c7778dfc@linaro.org>
Date: Wed, 6 Feb 2019 05:42:34 +0000
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
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Eduardo Habkost <ehabkost@redhat.com>

Ping.

On 12/7/18 5:09 PM, Richard Henderson wrote:
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
