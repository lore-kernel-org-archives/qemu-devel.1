Received: from eggs.gnu.org ([2001:4830:134:3::10]:59105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsBzs-0006Bc-R9
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsBzr-0006NL-TG
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:02:48 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:48403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsBzr-0006My-Pc
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:02:47 -0400
Received: by mail-qt0-x22f.google.com with SMTP id q8so2409425qtb.5
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 11:02:47 -0700 (PDT)
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
	<150506131942.19604.1306593039321280342.stgit@frigg.lan>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <418914ee-c8bf-2576-3cea-4a3eb2a9d4f7@linaro.org>
Date: Wed, 13 Sep 2017 11:01:39 -0700
MIME-Version: 1.0
In-Reply-To: <150506131942.19604.1306593039321280342.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/7] trace: Add event "guest_inst_after"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 09/10/2017 09:35 AM, Lluís Vilanova wrote:
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>  accel/tcg/translator.c |   23 ++++++++++++++++++-----
>  trace-events           |    8 ++++++++
>  2 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index d66d601c89..c010aeee45 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -35,7 +35,8 @@ void translator_loop_temp_check(DisasContextBase *db)
>  void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
>                       CPUState *cpu, TranslationBlock *tb)
>  {
> -    target_ulong pc_bbl;
> +    target_ulong pc_bbl, pc_insn = 0;
> +    bool translated_insn = false;
>      int max_insns;
>  
>      /* Initialize DisasContext */
> @@ -75,10 +76,15 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
>      tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
>  
>      while (true) {
> -        target_ulong pc_insn = db->pc_next;
>          TCGv_i32 insn_size_tcg = 0;
>          int insn_size_opcode_idx;
>  
> +        /* Tracing after (previous instruction) */
> +        if (db->num_insns > 0) {
> +            trace_guest_inst_after_tcg(cpu, tcg_ctx.tcg_env, pc_insn);
> +        }

How does this differ from "guest_inst"?  Why would you need two trace points?

Why are you placing this at the beginning of the while loop rather than the end?

> @@ -164,6 +172,9 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
>  
>          gen_set_inline_region_begin(tcg_ctx.disas.inline_label);
>  
> +        if (TRACE_GUEST_INST_AFTER_ENABLED && translated_insn) {
> +            trace_guest_inst_after_tcg(cpu, tcg_ctx.tcg_env, pc_insn);
> +        }
>          if (TRACE_GUEST_BBL_AFTER_ENABLED) {
>              trace_guest_bbl_after_tcg(cpu, tcg_ctx.tcg_env, pc_bbl);
>          }

I think I'm finally beginning to understand what you're after with your
inlining.  But I still think this should be doable in the appropriate opcode
generating functions.


r~
