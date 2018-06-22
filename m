Received: from eggs.gnu.org ([2001:4830:134:3::10]:38206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWDUS-0005hY-JN
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWDUP-00012k-DT
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:16:04 -0400
Received: from mail-qk0-x236.google.com ([2607:f8b0:400d:c09::236]:39529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWDUP-00012d-73
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:16:01 -0400
Received: by mail-qk0-x236.google.com with SMTP id g14-v6so3043833qkm.6
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 21:16:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
	<20180620120620.12806-21-yongbok.kim@mips.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <427a9783-fe26-bd1a-119b-74dfe26297ba@amsat.org>
Date: Fri, 22 Jun 2018 01:15:55 -0300
MIME-Version: 1.0
In-Reply-To: <20180620120620.12806-21-yongbok.kim@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 20/35] target/mips: Fix not to update
 BadVAddr in Debug Mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@mips.com>, qemu-devel@nongnu.org
Cc: Aleksandar.Markovic@mips.com, Paul.Burton@mips.com, Stefan.Markovic@mips.com, Matthew.Fortune@mips.com, James.Hogan@mips.com, aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>

On 06/20/2018 09:06 AM, Yongbok Kim wrote:
> From: Yongbok Kim <yongbok.kim@imgtec.com>
> 
> BadVaddr shouldn't be updated in Debug Mode

Long-standing issue!

> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/mips/helper.c    |  4 +++-
>  target/mips/op_helper.c | 20 +++++++++++++++-----
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index 8cf91ce..e215af9 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -502,7 +502,9 @@ static void raise_mmu_exception(CPUMIPSState *env, target_ulong address,
>          break;
>      }
>      /* Raise exception */
> -    env->CP0_BadVAddr = address;
> +    if (!(env->hflags & MIPS_HFLAG_DM)) {
> +        env->CP0_BadVAddr = address;
> +    }
>      env->CP0_Context = (env->CP0_Context & ~0x007fffff) |
>                         ((address >> 9) & 0x007ffff0);
>      env->CP0_EntryHi = (env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask) |
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 71a9d66..c9a111c 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -271,7 +271,9 @@ static inline hwaddr do_translate_address(CPUMIPSState *env,
>  target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int mem_idx)  \
>  {                                                                             \
>      if (arg & almask) {                                                       \
> -        env->CP0_BadVAddr = arg;                                              \
> +        if (!(env->hflags & MIPS_HFLAG_DM)) {                                 \
> +            env->CP0_BadVAddr = arg;                                          \
> +        }                                                                     \
>          do_raise_exception(env, EXCP_AdEL, GETPC());                          \
>      }                                                                         \
>      env->lladdr = do_translate_address(env, arg, 0, GETPC());                 \
> @@ -288,7 +290,9 @@ void helper_llwp(CPUMIPSState *env, target_ulong addr, uint32_t reg1,
>                   uint32_t reg2, uint32_t mem_idx)
>  {
>      if (addr & 0x7) {
> -        env->CP0_BadVAddr = addr;
> +        if (!(env->hflags & MIPS_HFLAG_DM)) {
> +            env->CP0_BadVAddr = addr;
> +        }
>          do_raise_exception(env, EXCP_AdEL, GETPC());
>      }
>      env->lladdr = do_translate_address(env, addr, 0, GETPC());
> @@ -304,7 +308,9 @@ target_ulong helper_##name(CPUMIPSState *env, target_ulong arg1,              \
>      target_long tmp;                                                          \
>                                                                                \
>      if (arg2 & almask) {                                                      \
> -        env->CP0_BadVAddr = arg2;                                             \
> +        if (!(env->hflags & MIPS_HFLAG_DM)) {                                 \
> +            env->CP0_BadVAddr = arg2;                                         \
> +        }                                                                     \
>          do_raise_exception(env, EXCP_AdES, GETPC());                          \
>      }                                                                         \
>      if (do_translate_address(env, arg2, 1, GETPC()) == env->lladdr) {         \
> @@ -329,7 +335,9 @@ target_ulong helper_scwp(CPUMIPSState *env, target_ulong addr,
>      uint32_t tmp2;
>  
>      if (addr & 0x7) {
> -        env->CP0_BadVAddr = addr;
> +        if (!(env->hflags & MIPS_HFLAG_DM)) {
> +            env->CP0_BadVAddr = addr;
> +        }
>          do_raise_exception(env, EXCP_AdES, GETPC());
>      }
>      if (do_translate_address(env, addr, 1, GETPC()) == env->lladdr) {
> @@ -2472,7 +2480,9 @@ void mips_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>      int error_code = 0;
>      int excp;
>  
> -    env->CP0_BadVAddr = addr;
> +    if (!(env->hflags & MIPS_HFLAG_DM)) {
> +        env->CP0_BadVAddr = addr;
> +    }
>  
>      if (access_type == MMU_DATA_STORE) {
>          excp = EXCP_AdES;
> 
