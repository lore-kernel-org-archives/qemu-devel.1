Received: from eggs.gnu.org ([2001:4830:134:3::10]:44252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFrh-0007ga-6S
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFrg-0005D7-3t
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:55:49 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXFrf-0005Ct-V0
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:55:48 -0400
Received: by mail-qt0-x241.google.com with SMTP id h15so639932qte.2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 16:55:47 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-22-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <05b969cf-a6a0-eb3c-f9ec-0c536dbe9491@twiddle.net>
Date: Mon, 17 Jul 2017 13:55:42 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-22-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 21/45] tcg: check CF_PARALLEL instead of
 parallel_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/16/2017 10:04 AM, Emilio G. Cota wrote:
> Thereby decoupling the resulting translated code from the current state
> of the system.
> 
> The tb->cflags field is not passed to tcg generation functions. So
> we add a bit to TCGContext, storing there whether CF_PARALLEL is set
> before translating every TB.
> 
> Most architectures have <= 32 registers, which results in a 4-byte hole
> in TCGContext. Use this hole for the bit we need; use a uint8_t instead
> of a bool, since a bool might take more than one byte in some systems.

I would much rather use bool.

(1) I don't care about OSX and its broken ABI,
(2) Even then OSX still *works*.

Otherwise,


> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>   tcg/tcg.h                 |  1 +
>   accel/tcg/translate-all.c |  1 +
>   tcg/tcg-op.c              | 10 +++++-----
>   3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 96872f8..bd1fdfa 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -656,6 +656,7 @@ struct TCGContext {
>       uintptr_t *tb_jmp_target_addr; /* tb->jmp_target_addr if !USE_DIRECT_JUMP */
>   
>       TCGRegSet reserved_regs;
> +    uint8_t cf_parallel; /* whether CF_PARALLEL is set in tb->cflags */
>       intptr_t current_frame_offset;
>       intptr_t frame_start;
>       intptr_t frame_end;
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 483248f..80ac85a 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1275,6 +1275,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       tb->flags = flags;
>       tb->cflags = cflags;
>       tb->trace_vcpu_dstate = *cpu->trace_dstate;
> +    tcg_ctx.cf_parallel = !!(cflags & CF_PARALLEL);
>   
>   #ifdef CONFIG_PROFILER
>       tcg_ctx.tb_count1++; /* includes aborted translations because of
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 205d07f..ef420d4 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -150,7 +150,7 @@ void tcg_gen_op6(TCGContext *ctx, TCGOpcode opc, TCGArg a1, TCGArg a2,
>   
>   void tcg_gen_mb(TCGBar mb_type)
>   {
> -    if (parallel_cpus) {
> +    if (tcg_ctx.cf_parallel) {
>           tcg_gen_op1(&tcg_ctx, INDEX_op_mb, mb_type);
>       }
>   }
> @@ -2794,7 +2794,7 @@ void tcg_gen_atomic_cmpxchg_i32(TCGv_i32 retv, TCGv addr, TCGv_i32 cmpv,
>   {
>       memop = tcg_canonicalize_memop(memop, 0, 0);
>   
> -    if (!parallel_cpus) {
> +    if (!tcg_ctx.cf_parallel) {
>           TCGv_i32 t1 = tcg_temp_new_i32();
>           TCGv_i32 t2 = tcg_temp_new_i32();
>   
> @@ -2838,7 +2838,7 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
>   {
>       memop = tcg_canonicalize_memop(memop, 1, 0);
>   
> -    if (!parallel_cpus) {
> +    if (!tcg_ctx.cf_parallel) {
>           TCGv_i64 t1 = tcg_temp_new_i64();
>           TCGv_i64 t2 = tcg_temp_new_i64();
>   
> @@ -3015,7 +3015,7 @@ static void * const table_##NAME[16] = {                                \
>   void tcg_gen_atomic_##NAME##_i32                                        \
>       (TCGv_i32 ret, TCGv addr, TCGv_i32 val, TCGArg idx, TCGMemOp memop) \
>   {                                                                       \
> -    if (parallel_cpus) {                                                \
> +    if (tcg_ctx.cf_parallel) {                                          \
>           do_atomic_op_i32(ret, addr, val, idx, memop, table_##NAME);     \
>       } else {                                                            \
>           do_nonatomic_op_i32(ret, addr, val, idx, memop, NEW,            \
> @@ -3025,7 +3025,7 @@ void tcg_gen_atomic_##NAME##_i32                                        \
>   void tcg_gen_atomic_##NAME##_i64                                        \
>       (TCGv_i64 ret, TCGv addr, TCGv_i64 val, TCGArg idx, TCGMemOp memop) \
>   {                                                                       \
> -    if (parallel_cpus) {                                                \
> +    if (tcg_ctx.cf_parallel) {                                          \
>           do_atomic_op_i64(ret, addr, val, idx, memop, table_##NAME);     \
>       } else {                                                            \
>           do_nonatomic_op_i64(ret, addr, val, idx, memop, NEW,            \
> 
