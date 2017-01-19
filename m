Received: from eggs.gnu.org ([2001:4830:134:3::10]:35092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cUETQ-0008Oe-Fs
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:18:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cUETN-0007XD-D2
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:18:00 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:54797)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cUETN-0007WV-45
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:17:57 -0500
References: <20170119151533.29328-1-bobby.prani@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <75915f80-5166-87bc-aa32-dd0e1223638e@vivier.eu>
Date: Thu, 19 Jan 2017 16:17:46 +0100
MIME-Version: 1.0
In-Reply-To: <20170119151533.29328-1-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 1/2] linux-user: fix settime old value
 location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, peter.maydell@linaro.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

Le 19/01/2017 à 16:15, Pranith Kumar a écrit :
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> old_value is the 4th argument of timer_settime(), not the 2nd.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> ---
>  linux-user/syscall.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 7b77503f94..6666cef4ae 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -12024,10 +12024,14 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>              timer_t htimer = g_posix_timers[timerid];
>              struct itimerspec hspec_new = {{0},}, hspec_old = {{0},};
>  
> -            target_to_host_itimerspec(&hspec_new, arg3);
> +            if (target_to_host_itimerspec(&hspec_new, arg3)) {
> +                goto efault;
> +            }
>              ret = get_errno(
>                            timer_settime(htimer, arg2, &hspec_new, &hspec_old));
> -            host_to_target_itimerspec(arg2, &hspec_old);
> +            if (arg4 && host_to_target_itimerspec(arg4, &hspec_old)) {
> +                goto efault;
> +            }
>          }
>          break;
>      }
> 
