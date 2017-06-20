Received: from eggs.gnu.org ([2001:4830:134:3::10]:41575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dN9fB-0003g8-5r
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 23:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dN9f7-0004Vf-6X
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 23:17:09 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dN9f7-0004VP-20
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 23:17:05 -0400
Received: by mail-qk0-x244.google.com with SMTP id d14so9357648qkb.1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 20:17:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170620000405.3391-1-rth@twiddle.net>
	<20170620000405.3391-19-rth@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0448f34c-da90-ef74-b743-7e1f4cf24531@amsat.org>
Date: Tue, 20 Jun 2017 00:16:59 -0300
MIME-Version: 1.0
In-Reply-To: <20170620000405.3391-19-rth@twiddle.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 18/18] target/s390x: Clean up TB flag
 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net

On 06/19/2017 09:04 PM, Richard Henderson wrote:
> Most of the PSW bits that were being copied into TB->flags
> are not relevant to translation.  Removing those that are
> unnecessary reduces the amount of translation required.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/s390x/cpu.h       | 24 +++++++++---------------
>  target/s390x/translate.c | 16 ++++++++--------
>  2 files changed, 17 insertions(+), 23 deletions(-)
>
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 5b94ace..9faca04 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -346,19 +346,14 @@ void s390x_cpu_debug_excp_handler(CPUState *cs);
>
>  /* tb flags */
>
> -#define FLAG_MASK_PER           (PSW_MASK_PER    >> 32)
> -#define FLAG_MASK_DAT           (PSW_MASK_DAT    >> 32)
> -#define FLAG_MASK_IO            (PSW_MASK_IO     >> 32)
> -#define FLAG_MASK_EXT           (PSW_MASK_EXT    >> 32)
> -#define FLAG_MASK_KEY           (PSW_MASK_KEY    >> 32)
> -#define FLAG_MASK_MCHECK        (PSW_MASK_MCHECK >> 32)
> -#define FLAG_MASK_WAIT          (PSW_MASK_WAIT   >> 32)
> -#define FLAG_MASK_PSTATE        (PSW_MASK_PSTATE >> 32)
> -#define FLAG_MASK_ASC           (PSW_MASK_ASC    >> 32)
> -#define FLAG_MASK_CC            (PSW_MASK_CC     >> 32)
> -#define FLAG_MASK_PM            (PSW_MASK_PM     >> 32)
> -#define FLAG_MASK_64            (PSW_MASK_64     >> 32)
> -#define FLAG_MASK_32            0x00001000
> +#define FLAG_MASK_PSW_SHIFT     31
> +#define FLAG_MASK_PER           (PSW_MASK_PER    >> FLAG_MASK_PSW_SHIFT)
> +#define FLAG_MASK_PSTATE        (PSW_MASK_PSTATE >> FLAG_MASK_PSW_SHIFT)
> +#define FLAG_MASK_ASC           (PSW_MASK_ASC    >> FLAG_MASK_PSW_SHIFT)
> +#define FLAG_MASK_64            (PSW_MASK_64     >> FLAG_MASK_PSW_SHIFT)
> +#define FLAG_MASK_32            (PSW_MASK_32     >> FLAG_MASK_PSW_SHIFT)
> +#define FLAG_MASK_PSW		(FLAG_MASK_PER | FLAG_MASK_PSTATE \
> +                                | FLAG_MASK_ASC | FLAG_MASK_64 | FLAG_MASK_32)
>
>  /* Control register 0 bits */
>  #define CR0_LOWPROT             0x0000000010000000ULL
> @@ -416,8 +411,7 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
>  {
>      *pc = env->psw.addr;
>      *cs_base = env->ex_value;
> -    *flags = ((env->psw.mask >> 32) & ~FLAG_MASK_CC) |
> -             ((env->psw.mask & PSW_MASK_32) ? FLAG_MASK_32 : 0);
> +    *flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
>  }
>
>  #define MAX_ILEN 6
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 9893551..bee163f 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -323,11 +323,11 @@ static inline uint64_t ld_code4(CPUS390XState *env, uint64_t pc)
>  static int get_mem_index(DisasContext *s)
>  {
>      switch (s->tb->flags & FLAG_MASK_ASC) {
> -    case PSW_ASC_PRIMARY >> 32:
> +    case PSW_ASC_PRIMARY >> FLAG_MASK_PSW_SHIFT:
>          return 0;
> -    case PSW_ASC_SECONDARY >> 32:
> +    case PSW_ASC_SECONDARY >> FLAG_MASK_PSW_SHIFT:
>          return 1;
> -    case PSW_ASC_HOME >> 32:
> +    case PSW_ASC_HOME >> FLAG_MASK_PSW_SHIFT:
>          return 2;
>      default:
>          tcg_abort();
> @@ -387,7 +387,7 @@ static inline void gen_trap(DisasContext *s)
>  #ifndef CONFIG_USER_ONLY
>  static void check_privileged(DisasContext *s)
>  {
> -    if (s->tb->flags & (PSW_MASK_PSTATE >> 32)) {
> +    if (s->tb->flags & FLAG_MASK_PSTATE) {
>          gen_program_exception(s, PGM_PRIVILEGED);
>      }
>  }
> @@ -2985,20 +2985,20 @@ static ExitStatus op_mov2e(DisasContext *s, DisasOps *o)
>      o->g_in2 = false;
>
>      switch (s->tb->flags & FLAG_MASK_ASC) {
> -    case PSW_ASC_PRIMARY >> 32:
> +    case PSW_ASC_PRIMARY >> FLAG_MASK_PSW_SHIFT:
>          tcg_gen_movi_i64(ar1, 0);
>          break;
> -    case PSW_ASC_ACCREG >> 32:
> +    case PSW_ASC_ACCREG >> FLAG_MASK_PSW_SHIFT:
>          tcg_gen_movi_i64(ar1, 1);
>          break;
> -    case PSW_ASC_SECONDARY >> 32:
> +    case PSW_ASC_SECONDARY >> FLAG_MASK_PSW_SHIFT:
>          if (b2) {
>              tcg_gen_ld32u_i64(ar1, cpu_env, offsetof(CPUS390XState, aregs[b2]));
>          } else {
>              tcg_gen_movi_i64(ar1, 0);
>          }
>          break;
> -    case PSW_ASC_HOME >> 32:
> +    case PSW_ASC_HOME >> FLAG_MASK_PSW_SHIFT:
>          tcg_gen_movi_i64(ar1, 2);
>          break;
>      }
>
