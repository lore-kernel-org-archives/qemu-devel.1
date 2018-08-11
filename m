Received: from eggs.gnu.org ([2001:4830:134:3::10]:55201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fobma-0006yo-5b
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 17:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fobmW-0005Yh-R4
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 17:50:48 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:60455)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fobmW-0005XR-H1
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 17:50:44 -0400
References: <20180612005145.3375-1-richard.henderson@linaro.org>
	<20180612005145.3375-8-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d3081310-15a0-a4cf-b275-6fe07aa7d16e@vivier.eu>
Date: Sat, 11 Aug 2018 23:50:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180612005145.3375-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 07/19] linux-user: Relax single exit
 from "break"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Le 12/06/2018 à 02:51, Richard Henderson a écrit :
> Transform outermost "break" to "return ret".  If the immediately
> preceeding statement was an assignment to ret, return the value
> directly.
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.c | 970 +++++++++++++++++--------------------------
>  1 file changed, 390 insertions(+), 580 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index ec3bc1cbe5..efe882612b 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
...
> @@ -10481,7 +10387,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  if (arg4) {
>                      unlock_user(target_set, arg4, 0);
>                  }
> -                break;
> +                return ret;
>              }
>  # endif
>  # ifdef TARGET_NR_poll
> @@ -10498,8 +10404,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                      /* -ve poll() timeout means "infinite" */
>                      pts = NULL;
>                  }
> -                ret = get_errno(safe_ppoll(pfd, nfds, pts, NULL, 0));
> -                break;
> +                return get_errno(safe_ppoll(pfd, nfds, pts, NULL, 0));
>              }
>  # endif
>              default:

You can't change these breaks by returns because they are in an inner
switch() (see the "default:"), that is followed by:

    if (!is_error(ret)) {
        for(i = 0; i < nfds; i++) {
            target_pfd[i].revents = tswap16(pfd[i].revents);
        }
        }
    unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);

which are needed to copy the result to the target array.
...
> @@ -12444,7 +12265,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  
>              ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, timeout,
>                                               set, SIGSET_T_SIZE));
> -            break;

You can't remove this break because otherwise it falls through the
following case (and you can't put a return because it's in an inner
switch())
>          }
>  #endif
>  #if defined(TARGET_NR_epoll_wait)
> @@ -12468,7 +12288,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              unlock_user(target_ep, arg2, 0);
>          }
>          g_free(ep);
> -        break;
> +        return ret;
>      }
>  #endif
>  #endif

Thanks,
Laurent
