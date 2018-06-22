Received: from eggs.gnu.org ([2001:4830:134:3::10]:41277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWDjc-0004YO-3v
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWDjX-0006mw-8v
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:31:44 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWDjX-0006ml-3U
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:31:39 -0400
Received: by mail-qk0-x241.google.com with SMTP id a195-v6so3062230qkg.3
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 21:31:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
	<20180620120620.12806-30-yongbok.kim@mips.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fc8670e3-08b3-27ff-ecfd-fe0d7a2f3afb@amsat.org>
Date: Fri, 22 Jun 2018 01:31:33 -0300
MIME-Version: 1.0
In-Reply-To: <20180620120620.12806-30-yongbok.kim@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 29/35] target/mips: Fix ERET/ERETNC can
 cause ADEL exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@mips.com>, qemu-devel@nongnu.org
Cc: Aleksandar.Markovic@mips.com, Paul.Burton@mips.com, Stefan.Markovic@mips.com, Matthew.Fortune@mips.com, James.Hogan@mips.com, aurelien@aurel32.net

On 06/20/2018 09:06 AM, Yongbok Kim wrote:
> From: Yongbok Kim <yongbok.kim@imgtec.com>
> 
> Fix ERET/ERETNC can cause ADEL exception
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> ---
>  target/mips/op_helper.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 6f5e5a3..09ec20a 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -2434,6 +2434,13 @@ static void set_pc(CPUMIPSState *env, target_ulong error_pc)
>      env->active_tc.PC = error_pc & ~(target_ulong)1;
>      if (env->insn_flags & ISA_NANOMIPS32) {
>          /* Don't clear MIPS_HFLAG_M16 */
> +        if (error_pc & 1) {
> +            if (!(env->hflags & MIPS_HFLAG_DM)) {
> +                env->CP0_BadVAddr = error_pc;
> +            }
> +            env->active_tc.PC = error_pc;
> +            do_raise_exception(env, EXCP_AdEL, 0);
> +        }
>          return;
>      }
>      if (error_pc & 1) {
> @@ -2471,10 +2478,12 @@ void helper_eretnc(CPUMIPSState *env)
>  void helper_deret(CPUMIPSState *env)
>  {
>      debug_pre_eret(env);
> -    set_pc(env, env->CP0_DEPC);
>  
>      env->hflags &= ~MIPS_HFLAG_DM;
>      compute_hflags(env);
> +
> +    set_pc(env, env->CP0_DEPC);

Now set_pc() uses MIPS_HFLAG_DM, so it makes sens to call it _after_
updating env->hflags. Correct.

> +
>      debug_post_eret(env);
>  }
>  #endif /* !CONFIG_USER_ONLY */
> 
