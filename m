Received: from eggs.gnu.org ([2001:4830:134:3::10]:48190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dacSa-0004W5-Oe
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 02:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dacSX-0000o2-K8
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 02:39:48 -0400
References: <20170727024224.22900-1-f4bug@amsat.org>
	<20170727024224.22900-15-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <5cd7f2d6-04e7-52a5-c045-973b9ef0d365@vivier.eu>
Date: Thu, 27 Jul 2017 08:39:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170727024224.22900-15-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 v2 14/20] syscall: check inotify()
 and eventfd() return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Le 27/07/2017 à 04:42, Philippe Mathieu-Daudé a écrit :
> linux-user/syscall.c:555:25: warning: Out of bound memory access (accessed memory precedes memory block)
>     target_fd_trans[fd] = trans;
>     ~~~~~~~~~~~~~~~~~~~~^~~~~~~
> 
> Reported-by: Clang Static Analyzer
> Suggested-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> ---
>  linux-user/syscall.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 81f52f7483..dfc1301e63 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11742,7 +11742,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>  #if defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)
>      case TARGET_NR_inotify_init:
>          ret = get_errno(sys_inotify_init());
> -        fd_trans_register(ret, &target_inotify_trans);
> +        if (ret >= 0) {
> +            fd_trans_register(ret, &target_inotify_trans);
> +        }
>          break;
>  #endif
>  #ifdef CONFIG_INOTIFY1
> @@ -11750,7 +11752,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>      case TARGET_NR_inotify_init1:
>          ret = get_errno(sys_inotify_init1(target_to_host_bitmask(arg1,
>                                            fcntl_flags_tbl)));
> -        fd_trans_register(ret, &target_inotify_trans);
> +        if (ret >= 0) {
> +            fd_trans_register(ret, &target_inotify_trans);
> +        }
>          break;
>  #endif
>  #endif
> @@ -11916,7 +11920,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>  #if defined(TARGET_NR_eventfd)
>      case TARGET_NR_eventfd:
>          ret = get_errno(eventfd(arg1, 0));
> -        fd_trans_register(ret, &target_eventfd_trans);
> +        if (ret >= 0) {
> +            fd_trans_register(ret, &target_eventfd_trans);
> +        }
>          break;
>  #endif
>  #if defined(TARGET_NR_eventfd2)
> @@ -11930,7 +11936,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>              host_flags |= O_CLOEXEC;
>          }
>          ret = get_errno(eventfd(arg1, host_flags));
> -        fd_trans_register(ret, &target_eventfd_trans);
> +        if (ret >= 0) {
> +            fd_trans_register(ret, &target_eventfd_trans);
> +        }
>          break;
>      }
>  #endif
> 
