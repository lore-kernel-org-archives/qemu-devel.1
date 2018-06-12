Received: from eggs.gnu.org ([2001:4830:134:3::10]:55530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSm9u-0001k6-Jg
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSm9q-0003yi-CP
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:28:38 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:41130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSm9q-0003yS-82
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:28:34 -0400
Received: by mail-qt0-x243.google.com with SMTP id y20-v6so24279462qto.8
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 09:28:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180612005145.3375-1-richard.henderson@linaro.org>
	<20180612005145.3375-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <56a6a1d3-9b7d-bb10-e6aa-fb51c4177571@amsat.org>
Date: Tue, 12 Jun 2018 13:28:30 -0300
MIME-Version: 1.0
In-Reply-To: <20180612005145.3375-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 09/19] linux-user: Propagate goto
 unimplemented_nowarn to return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu

On 06/11/2018 09:51 PM, Richard Henderson wrote:
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  linux-user/syscall.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index a6b8268332..06205d3d65 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11807,7 +11807,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>            return 0;
>        }
>  #else
> -      goto unimplemented_nowarn;
> +      return -TARGET_ENOSYS;
>  #endif
>  #endif
>  #ifdef TARGET_NR_get_thread_area
> @@ -11820,12 +11820,12 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              return ts->tp_value;
>          }
>  #else
> -        goto unimplemented_nowarn;
> +        return -TARGET_ENOSYS;
>  #endif
>  #endif
>  #ifdef TARGET_NR_getdomainname
>      case TARGET_NR_getdomainname:
> -        goto unimplemented_nowarn;
> +        return -TARGET_ENOSYS;
>  #endif
>  
>  #ifdef TARGET_NR_clock_settime
> @@ -11910,7 +11910,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>           * holding a mutex that is shared with another process via
>           * shared memory).
>           */
> -        goto unimplemented_nowarn;
> +        return -TARGET_ENOSYS;
>  #endif
>  
>  #if defined(TARGET_NR_utimensat)
> @@ -12564,9 +12564,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      default:
>      unimplemented:
>          gemu_log("qemu: Unsupported syscall: %d\n", num);
> -#if defined(TARGET_NR_setxattr) || defined(TARGET_NR_get_thread_area) || defined(TARGET_NR_getdomainname) || defined(TARGET_NR_set_robust_list)
> -    unimplemented_nowarn:
> -#endif
>          return -TARGET_ENOSYS;
>      }
>  fail:
> 
