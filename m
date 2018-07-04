Received: from eggs.gnu.org ([2001:4830:134:3::10]:36641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faoUR-0005HR-1I
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faoUN-0007yq-Qg
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:35:03 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faoUN-0007yW-Kp
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:34:59 -0400
Received: by mail-qt0-x244.google.com with SMTP id z6-v6so5468660qti.2
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 13:34:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1530732637-28606-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1530732637-28606-8-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <86c88479-0d54-1074-9aae-9c1b281bc75a@amsat.org>
Date: Wed, 4 Jul 2018 17:34:54 -0300
MIME-Version: 1.0
In-Reply-To: <1530732637-28606-8-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 7/8] target/mips: Don't update BadVAddr
 register in Debug Mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

Hi Aleksandar,

On 07/04/2018 04:30 PM, Aleksandar Markovic wrote:
> From: Yongbok Kim <yongbok.kim@mips.com>
> 
> BadVAddr should not be updated if (env->hflags & MIPS_HFLAG_DM) is
> set.
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Philippe Mathieu-Daudé <philippe.mathieu.daude@gmail.com>

Watch out in
http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg06407.html I
used another email:

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/mips/helper.c    |  4 +++-
>  target/mips/op_helper.c | 12 +++++++++---
>  2 files changed, 12 insertions(+), 4 deletions(-)
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
> index 0b8ec7d..a6a57bd 100644
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
> @@ -291,7 +293,9 @@ target_ulong helper_##name(CPUMIPSState *env, target_ulong arg1,              \
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
> @@ -2456,7 +2460,9 @@ void mips_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
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
