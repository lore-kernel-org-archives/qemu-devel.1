Received: from eggs.gnu.org ([2001:4830:134:3::10]:47857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ga2a4-00023P-3n
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 12:57:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ga2a0-0004yu-Q0
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 12:57:55 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ga2a0-0004xR-GM
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 12:57:52 -0500
Received: by mail-pl1-x642.google.com with SMTP id gn14so1215365plb.10
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 09:57:52 -0800 (PST)
References: <20181220163123.9233-1-mark.cave-ayland@ilande.co.uk>
	<20181220163123.9233-9-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <06d2cdee-30f6-2ad7-ba56-3a0ca161fb72@linaro.org>
Date: Thu, 20 Dec 2018 09:57:48 -0800
MIME-Version: 1.0
In-Reply-To: <20181220163123.9233-9-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 8/9] target/ppc: move FP and VMX
 registers into aligned vsr register array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 12/20/18 8:31 AM, Mark Cave-Ayland wrote:
> The VSX register array is a block of 64 128-bit registers where the first 32
> registers consist of the existing 64-bit FP registers extended to 128-bit
> using new VSR registers, and the last 32 registers are the VMX 128-bit
> registers as show below:
> 
>             64-bit               64-bit
>     +--------------------+--------------------+
>     |        FP0         |                    |  VSR0
>     +--------------------+--------------------+
>     |        FP1         |                    |  VSR1
>     +--------------------+--------------------+
>     |        ...         |        ...         |  ...
>     +--------------------+--------------------+
>     |        FP30        |                    |  VSR30
>     +--------------------+--------------------+
>     |        FP31        |                    |  VSR31
>     +--------------------+--------------------+
>     |                  VMX0                   |  VSR32
>     +-----------------------------------------+
>     |                  VMX1                   |  VSR33
>     +-----------------------------------------+
>     |                  ...                    |  ...
>     +-----------------------------------------+
>     |                  VMX30                  |  VSR62
>     +-----------------------------------------+
>     |                  VMX31                  |  VSR63
>     +-----------------------------------------+
> 
> In order to allow for future conversion of VSX instructions to use TCG vector
> operations, recreate the same layout using an aligned version of the existing
> vsr register array.
> 
> Since the old fpr and avr register arrays are removed, the existing callers
> must also be updated to use the correct offset in the vsr register array. This
> also includes switching the relevant VMState fields over to using subarrays
> to make sure that migration is preserved.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  linux-user/ppc/signal.c             | 24 ++++++-------
>  target/ppc/arch_dump.c              | 12 +++----
>  target/ppc/cpu.h                    |  9 ++---
>  target/ppc/gdbstub.c                |  8 ++---
>  target/ppc/internal.h               | 18 +++-------
>  target/ppc/machine.c                | 72 ++++++++++++++++++++++++++++++++++---
>  target/ppc/monitor.c                |  4 +--
>  target/ppc/translate.c              | 14 ++++----
>  target/ppc/translate/dfp-impl.inc.c |  2 +-
>  target/ppc/translate/vmx-impl.inc.c |  7 +++-
>  target/ppc/translate/vsx-impl.inc.c |  4 +--
>  target/ppc/translate_init.inc.c     | 24 ++++++-------
>  12 files changed, 126 insertions(+), 72 deletions(-)
> 
> diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
> index 2ae120a2bc..a053dd5b84 100644
> --- a/linux-user/ppc/signal.c
> +++ b/linux-user/ppc/signal.c
> @@ -258,8 +258,8 @@ static void save_user_regs(CPUPPCState *env, struct target_mcontext *frame)
>      /* Save Altivec registers if necessary.  */
>      if (env->insns_flags & PPC_ALTIVEC) {
>          uint32_t *vrsave;
> -        for (i = 0; i < ARRAY_SIZE(env->avr); i++) {
> -            ppc_avr_t *avr = &env->avr[i];
> +        for (i = 0; i < 32; i++) {
> +            ppc_avr_t *avr = &env->vsr[32 + i];

Because of our subsequent discussion re endianness within these vectors, I
think it would be helpful add some helpers here.

static inline ppc_avr_t *cpu_avr_ptr(CPUPPCState *env, int i)
{
    return &env->vsr[32 + i];
}

>      /* Save VSX second halves */
>      if (env->insns_flags2 & PPC2_VSX) {
>          uint64_t *vsregs = (uint64_t *)&frame->mc_vregs.altivec[34];
> -        for (i = 0; i < ARRAY_SIZE(env->vsr); i++) {
> -            __put_user(env->vsr[i], &vsregs[i]);
> +        for (i = 0; i < 32; i++) {
> +            __put_user(env->vsr[i].u64[1], &vsregs[i]);

static inline uint64_t *cpu_vsrl_ptr(CPUPPCState *env, int i)
{
    return &env->vsr[i].u64[1];
}

>      /* Save floating point registers.  */
>      if (env->insns_flags & PPC_FLOAT) {
> -        for (i = 0; i < ARRAY_SIZE(env->fpr); i++) {
> -            __put_user(env->fpr[i], &frame->mc_fregs[i]);
> +        for (i = 0; i < 32; i++) {
> +            __put_user(env->vsr[i].u64[0], &frame->mc_fregs[i]);

static inline uint64_t *cpu_fpr_ptr(CPUPPCState *env, int i)
{
    return &env->vsr[i].u64[0];
}


Eventually, we will want to make these last two functions be dependent on host
endianness, so that we can remove getVSR and putVSR.  At which point VSR and
AVX registers will have the same representation.  Because at present they
don't, which IMO is, if not a bug, at least a severe mis-feature.


r~
