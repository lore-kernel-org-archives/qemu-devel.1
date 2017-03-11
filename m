Received: from eggs.gnu.org ([2001:4830:134:3::10]:39431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cmlkh-0003wB-JS
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 13:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cmlkd-0002pg-Lv
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 13:28:27 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:64952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cmlkd-0002ow-BM
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 13:28:23 -0500
References: <20170311034232.14213-1-rth@twiddle.net>
	<20170311034232.14213-2-rth@twiddle.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <926aa266-5def-c638-e155-7ac335d02785@vivier.eu>
Date: Sat, 11 Mar 2017 19:28:06 +0100
MIME-Version: 1.0
In-Reply-To: <20170311034232.14213-2-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] linux-user: Restrict usage of
 sa_restorer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, deller@gmx.de, riku.voipio@iki.fi

Le 11/03/2017 à 04:42, Richard Henderson a écrit :
> Reading and writing to an sa_restorer member that isn't supposed to
> exist corrupts user memory.  Introduce TARGET_ARCH_HAS_SA_RESTORER,
> similar to the kernel's __ARCH_HAS_SA_RESTORER.
> 
> Reported-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  linux-user/signal.c       |  4 ++--
>  linux-user/syscall_defs.h | 13 +++++++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index a67db04..c6b043b 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -777,7 +777,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
>      if (oact) {
>          __put_user(k->_sa_handler, &oact->_sa_handler);
>          __put_user(k->sa_flags, &oact->sa_flags);
> -#if !defined(TARGET_MIPS)
> +#ifdef TARGET_ARCH_HAS_SA_RESTORER
>          __put_user(k->sa_restorer, &oact->sa_restorer);
>  #endif
>          /* Not swapped.  */
> @@ -787,7 +787,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
>          /* FIXME: This is not threadsafe.  */
>          __get_user(k->_sa_handler, &act->_sa_handler);
>          __get_user(k->sa_flags, &act->sa_flags);
> -#if !defined(TARGET_MIPS)
> +#ifdef TARGET_ARCH_HAS_SA_RESTORER
>          __get_user(k->sa_restorer, &act->sa_restorer);
>  #endif
>          /* To be swapped in target_to_host_sigset.  */
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 40c5027..8b1ad74 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -445,6 +445,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
>  #define TARGET_SA_RESTART      2u
>  #define TARGET_SA_NODEFER      0x20u
>  #define TARGET_SA_RESETHAND    4u
> +#define TARGET_ARCH_HAS_SA_RESTORER 1
>  #elif defined(TARGET_MIPS)
>  #define TARGET_SA_NOCLDSTOP	0x00000001
>  #define TARGET_SA_NOCLDWAIT	0x00010000
> @@ -483,6 +484,10 @@ int do_sigaction(int sig, const struct target_sigaction *act,
>  #define TARGET_SA_RESTORER	0x04000000
>  #endif
>  
> +#ifdef TARGET_SA_RESTORER
> +#define TARGET_ARCH_HAS_SA_RESTORER 1
> +#endif
> +
>  #if defined(TARGET_ALPHA)
>  
>  #define TARGET_SIGHUP            1
> @@ -718,19 +723,27 @@ struct target_sigaction {
>  	abi_ulong	_sa_handler;
>  #endif
>  	target_sigset_t	sa_mask;
> +#ifdef TARGET_ARCH_HAS_SA_RESTORER
> +        /* ??? This is always present, but ignored unless O32.  */

If it is always present, why it is defined conditionally?

TARGET_ARCH_HAS_SA_RESTORER is defined only for O32.

> +        abi_ulong sa_restorer;
> +#endif
>  };
>  #else
>  struct target_old_sigaction {
>          abi_ulong _sa_handler;
>          abi_ulong sa_mask;
>          abi_ulong sa_flags;
> +#ifdef TARGET_ARCH_HAS_SA_RESTORER
>          abi_ulong sa_restorer;
> +#endif
>  };
>  
>  struct target_sigaction {
>          abi_ulong _sa_handler;
>          abi_ulong sa_flags;
> +#ifdef TARGET_ARCH_HAS_SA_RESTORER
>          abi_ulong sa_restorer;
> +#endif
>          target_sigset_t sa_mask;
>  };
>  #endif
> 

TARGET_ALPHA has a sa_restorer field, but TARGET_ARCH_HAS_SA_RESTORER is
not defined.

Laurent
