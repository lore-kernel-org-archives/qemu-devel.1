Received: from eggs.gnu.org ([2001:4830:134:3::10]:42931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFoi-0005Md-A4
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFof-0003BH-6I
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:52:44 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXFoe-0003B5-W4
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:52:41 -0400
Received: by mail-qt0-x244.google.com with SMTP id j25so654781qtf.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 16:52:40 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-19-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <032f07a7-e498-982b-ad12-0327bd5d604d@twiddle.net>
Date: Mon, 17 Jul 2017 13:52:34 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-19-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 18/45] target/m68k: check CF_PARALLEL
 instead of parallel_cpus
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
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>   target/m68k/helper.h    |  2 ++
>   target/m68k/op_helper.c | 32 ++++++++++++++++++++++++++++----
>   target/m68k/translate.c | 12 ++++++++++--
>   3 files changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/target/m68k/helper.h b/target/m68k/helper.h
> index 475a1f2..137ef48 100644
> --- a/target/m68k/helper.h
> +++ b/target/m68k/helper.h
> @@ -10,7 +10,9 @@ DEF_HELPER_4(divsll, void, env, int, int, s32)
>   DEF_HELPER_2(set_sr, void, env, i32)
>   DEF_HELPER_3(movec, void, env, i32, i32)
>   DEF_HELPER_4(cas2w, void, env, i32, i32, i32)
> +DEF_HELPER_4(cas2w_parallel, void, env, i32, i32, i32)
>   DEF_HELPER_4(cas2l, void, env, i32, i32, i32)
> +DEF_HELPER_4(cas2l_parallel, void, env, i32, i32, i32)
>   
>   #define dh_alias_fp ptr
>   #define dh_ctype_fp FPReg *
> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> index 7b5126c..061d468 100644
> --- a/target/m68k/op_helper.c
> +++ b/target/m68k/op_helper.c
> @@ -361,7 +361,8 @@ void HELPER(divsll)(CPUM68KState *env, int numr, int regr, int32_t den)
>       env->dregs[numr] = quot;
>   }
>   
> -void HELPER(cas2w)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
> +static void do_cas2w(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2,
> +                     bool parallel)
>   {
>       uint32_t Dc1 = extract32(regs, 9, 3);
>       uint32_t Dc2 = extract32(regs, 6, 3);
> @@ -374,7 +375,7 @@ void HELPER(cas2w)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
>       int16_t l1, l2;
>       uintptr_t ra = GETPC();
>   
> -    if (parallel_cpus) {
> +    if (parallel) {
>           /* Tell the main loop we need to serialize this insn.  */
>           cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
>       } else {
> @@ -399,7 +400,19 @@ void HELPER(cas2w)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
>       env->dregs[Dc2] = deposit32(env->dregs[Dc2], 0, 16, l2);
>   }
>   
> -void HELPER(cas2l)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
> +void HELPER(cas2w)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
> +{
> +    do_cas2w(env, regs, a1, a2, false);
> +}
> +
> +void HELPER(cas2w_parallel)(CPUM68KState *env, uint32_t regs, uint32_t a1,
> +                            uint32_t a2)
> +{
> +    do_cas2w(env, regs, a1, a2, true);

Well, cas2w_parallel is now exactly equivalent to gen_helper_exit_atomic.
I probably should have done that parallel check in the translator to begin.


r~
