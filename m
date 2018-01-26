Received: from eggs.gnu.org ([2001:4830:134:3::10]:49611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ef43l-0002pr-2t
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ef43h-0008Jj-34
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:28:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ef43g-0008JL-Mf
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:28:44 -0500
References: <1516897189-11035-1-git-send-email-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <33867805-f277-3935-4e1f-72cd3068a4dc@redhat.com>
Date: Fri, 26 Jan 2018 12:01:34 +0100
MIME-Version: 1.0
In-Reply-To: <1516897189-11035-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Drop remaining bits of ia64 host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

On 25/01/2018 17:19, Peter Maydell wrote:
> We dropped support for ia64 host CPUs in the 2.11 release (removing
> the TCG backend for it, and advertising the support as being
> completely removed in the changelog).  However there are a few bits
> and pieces of code still floating about.  Remove those, too.
> 
> We can drop the check in configure for "ia64 or hppa host?"
> entirely, because we don't support hppa hosts either any more.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Queued, thanks.

Paolo

> You could in theory have before this commit tried to still use ia64
> hosts with the TCI interpreter, but there's no point in supporting
> ia64 hosts with TCI but not proper TCG.
> 
> The next bit of cleanup I'd like to do after this is get rid
> of the "uname -m" fallback in the configure cpu-detection code...
> 
> 
>  configure                |  5 -----
>  include/qemu/processor.h |  3 ---
>  include/qemu/timer.h     |  9 ---------
>  accel/tcg/user-exec.c    | 33 ---------------------------------
>  linux-user/syscall.c     |  7 +------
>  5 files changed, 1 insertion(+), 56 deletions(-)
> 
> diff --git a/configure b/configure
> index 044c6fa..2f12c77 100755
> --- a/configure
> +++ b/configure
> @@ -636,8 +636,6 @@ elif check_define _ARCH_PPC ; then
>    fi
>  elif check_define __mips__ ; then
>    cpu="mips"
> -elif check_define __ia64__ ; then
> -  cpu="ia64"
>  elif check_define __s390__ ; then
>    if check_define __s390x__ ; then
>      cpu="s390x"
> @@ -4744,9 +4742,6 @@ if test "$coroutine_pool" = ""; then
>  fi
>  
>  if test "$debug_stack_usage" = "yes"; then
> -  if test "$cpu" = "ia64" -o "$cpu" = "hppa"; then
> -    error_exit "stack usage debugging is not supported for $cpu"
> -  fi
>    if test "$coroutine_pool" = "yes"; then
>      echo "WARN: disabling coroutine pool for stack usage debugging"
>      coroutine_pool=no
> diff --git a/include/qemu/processor.h b/include/qemu/processor.h
> index 8b25702..8e16c92 100644
> --- a/include/qemu/processor.h
> +++ b/include/qemu/processor.h
> @@ -12,9 +12,6 @@
>  #if defined(__i386__) || defined(__x86_64__)
>  # define cpu_relax() asm volatile("rep; nop" ::: "memory")
>  
> -#elif defined(__ia64__)
> -# define cpu_relax() asm volatile("hint @pause" ::: "memory")
> -
>  #elif defined(__aarch64__)
>  # define cpu_relax() asm volatile("yield" ::: "memory")
>  
> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> index 1b518bc..3b5a54b 100644
> --- a/include/qemu/timer.h
> +++ b/include/qemu/timer.h
> @@ -931,15 +931,6 @@ static inline int64_t cpu_get_host_ticks(void)
>      return val;
>  }
>  
> -#elif defined(__ia64)
> -
> -static inline int64_t cpu_get_host_ticks(void)
> -{
> -    int64_t val;
> -    asm volatile ("mov %0 = ar.itc" : "=r"(val) :: "memory");
> -    return val;
> -}
> -
>  #elif defined(__s390__)
>  
>  static inline int64_t cpu_get_host_ticks(void)
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index c973752..eb95cda 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -503,39 +503,6 @@ int cpu_signal_handler(int host_signum, void *pinfo, void *puc)
>      return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
>  }
>  
> -#elif defined(__ia64)
> -
> -#ifndef __ISR_VALID
> -  /* This ought to be in <bits/siginfo.h>... */
> -# define __ISR_VALID    1
> -#endif
> -
> -int cpu_signal_handler(int host_signum, void *pinfo, void *puc)
> -{
> -    siginfo_t *info = pinfo;
> -    ucontext_t *uc = puc;
> -    unsigned long ip;
> -    int is_write = 0;
> -
> -    ip = uc->uc_mcontext.sc_ip;
> -    switch (host_signum) {
> -    case SIGILL:
> -    case SIGFPE:
> -    case SIGSEGV:
> -    case SIGBUS:
> -    case SIGTRAP:
> -        if (info->si_code && (info->si_segvflags & __ISR_VALID)) {
> -            /* ISR.W (write-access) is bit 33:  */
> -            is_write = (info->si_isr >> 33) & 1;
> -        }
> -        break;
> -
> -    default:
> -        break;
> -    }
> -    return handle_cpu_signal(ip, info, is_write, (sigset_t *)&uc->uc_sigmask);
> -}
> -
>  #elif defined(__s390__)
>  
>  int cpu_signal_handler(int host_signum, void *pinfo,
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 7437894..df1edf0 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -36,10 +36,6 @@
>  #include <linux/capability.h>
>  #include <sched.h>
>  #include <sys/timex.h>
> -#ifdef __ia64__
> -int __clone2(int (*fn)(void *), void *child_stack_base,
> -             size_t stack_size, int flags, void *arg, ...);
> -#endif
>  #include <sys/socket.h>
>  #include <sys/un.h>
>  #include <sys/uio.h>
> @@ -246,8 +242,7 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
>  #define __NR_sys_inotify_add_watch __NR_inotify_add_watch
>  #define __NR_sys_inotify_rm_watch __NR_inotify_rm_watch
>  
> -#if defined(__alpha__) || defined (__ia64__) || defined(__x86_64__) || \
> -    defined(__s390x__)
> +#if defined(__alpha__) || defined(__x86_64__) || defined(__s390x__)
>  #define __NR__llseek __NR_lseek
>  #endif
>  
> 
