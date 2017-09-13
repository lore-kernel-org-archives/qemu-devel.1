Received: from eggs.gnu.org ([2001:4830:134:3::10]:57975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsB8h-0008UV-Ax
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsB8e-0005XX-Kx
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:07:51 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:45477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsB8e-0005WF-Eh
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:07:48 -0400
Received: by mail-pg0-x231.google.com with SMTP id 188so1515398pgb.2
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 10:07:48 -0700 (PDT)
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
	<150506059354.19604.5050182852156612042.stgit@frigg.lan>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0250ce97-bef3-1feb-d9a9-4e4a91084fa7@linaro.org>
Date: Wed, 13 Sep 2017 10:07:44 -0700
MIME-Version: 1.0
In-Reply-To: <150506059354.19604.5050182852156612042.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/7] trace: Add event
 "guest_inst_info_before"
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

On 09/10/2017 09:23 AM, Lluís Vilanova wrote:
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>  accel/tcg/translator.c |   18 ++++++++++++++++++
>  trace-events           |    9 +++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 287d27b4f7..6598931171 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -70,6 +70,8 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
>  
>      while (true) {
>          target_ulong pc_insn = db->pc_next;
> +        TCGv_i32 insn_size_tcg = 0;
> +        int insn_size_opcode_idx;

Initializing a TCGv_i32 is wrong.
And surely insn_size_opcode is surely uninitialized?

> +        if (TRACE_GUEST_INST_INFO_BEFORE_EXEC_ENABLED) {
> +            insn_size_tcg = tcg_temp_new_i32();
> +            insn_size_opcode_idx = tcg_op_buf_count();
> +            tcg_gen_movi_i32(insn_size_tcg, 0xdeadbeef);
> +
> +            trace_guest_inst_info_before_tcg(
> +                cpu, tcg_ctx.tcg_env, pc_insn, insn_size_tcg);
> +
> +            tcg_temp_free_i32(insn_size_tcg);

There's no reason you can't declare insn_size_tcg right here and avoid the
incorrect initialization above.

Is there a reason to have both "guest_insn" and "guest_insn_info"?


r~
