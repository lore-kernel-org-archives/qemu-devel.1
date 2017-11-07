Received: from eggs.gnu.org ([2001:4830:134:3::10]:48132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eC63l-0007oD-4B
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:45:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eC63g-0006Rb-Qj
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:45:05 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:51595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eC63g-0006RB-Lx
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:45:00 -0500
Received: by mail-qt0-x242.google.com with SMTP id h4so15710201qtk.8
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 07:45:00 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1509993206-26637-1-git-send-email-peter.maydell@linaro.org>
	<1509993206-26637-5-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <58937b68-43bf-5a55-80b4-74032a5e7145@amsat.org>
Date: Tue, 7 Nov 2017 12:44:56 -0300
MIME-Version: 1.0
In-Reply-To: <1509993206-26637-5-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/4] linux-user: Handle rt_sigaction
 correctly for SPARC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, patches@linaro.org

Hi Peter,

On 11/06/2017 03:33 PM, Peter Maydell wrote:
> SPARC is like Alpha in its handling of the rt_sigaction syscall:
> it takes an extra parameter 'restorer' which needs to be copied
> into the sa_restorer field of the sigaction struct. The order
> of the arguments differs slightly between SPARC and Alpha but
> the implementation is otherwise the same. (Compare the
> rt_sigaction() functions in arch/sparc/kernel/sys_sparc_64.c
> and arch/alpha/kernel/signal.c.)
> 
> Note that this change is somewhat moot until SPARC acquires
> support for actually delivering RT signals.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/syscall.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index d4497de..8beab51 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8556,8 +8556,16 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>      case TARGET_NR_rt_sigaction:
>          {

> -            struct target_sigaction act, oact, *pact = 0;
> +            /* For Alpha and SPARC this is a 5 argument syscall, with
> +             * a 'restorer' parameter which must be copied into the
> +             * sa_restorer field of the sigaction struct.
> +             * For Alpha that 'restorer' is arg5; for SPARC it is arg4,
> +             * and arg5 is the sigsetsize.
> +             * Alpha also has a separate rt_sigaction struct that it uses
> +             * here; SPARC uses the usual sigaction struct.
> +             */

I find it easier to read moving the #if after the comment.
Since using restorer for sparc improve readability we can use it for
alpha as well (code is a bit more consistent):

  #if defined(TARGET_ALPHA)
               target_ulong restorer = arg5;

>              struct target_rt_sigaction *rt_act;
> +            struct target_sigaction act, oact, *pact = 0;
>  
>              if (arg4 != sizeof(target_sigset_t)) {
>                  ret = -TARGET_EINVAL;

...
                   act.sa_restorer = restorer;

Whichever way:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> @@ -8583,18 +8591,29 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>                  unlock_user_struct(rt_act, arg3, 1);
>              }
>  #else
> +#ifdef TARGET_SPARC
> +            target_ulong restorer = arg4;
> +            target_ulong sigsetsize = arg5;
> +#else
> +            target_ulong sigsetsize = arg4;
> +#endif
>              struct target_sigaction *act;
>              struct target_sigaction *oact;
>  
> -            if (arg4 != sizeof(target_sigset_t)) {
> +            if (sigsetsize != sizeof(target_sigset_t)) {
>                  ret = -TARGET_EINVAL;
>                  break;
>              }
>              if (arg2) {
> -                if (!lock_user_struct(VERIFY_READ, act, arg2, 1))
> +                if (!lock_user_struct(VERIFY_READ, act, arg2, 1)) {
>                      goto efault;
> -            } else
> +                }
> +#ifdef TARGET_SPARC
> +                act->sa_restorer = restorer;
> +#endif
> +            } else {
>                  act = NULL;
> +            }
>              if (arg3) {
>                  if (!lock_user_struct(VERIFY_WRITE, oact, arg3, 0)) {
>                      ret = -TARGET_EFAULT;
> 
