Received: from eggs.gnu.org ([2001:4830:134:3::10]:35859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQa8K-0008NU-4e
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQa8G-0007et-5u
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:09:24 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:58479)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dQa8F-0007e2-RI
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:09:20 -0400
References: <20170628204452.41230-1-raj.khem@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d8913f99-d989-c79a-b0a0-78179e16ef72@vivier.eu>
Date: Thu, 29 Jun 2017 16:09:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170628204452.41230-1-raj.khem@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] replace struct ucontext with ucontext_t
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Khem Raj <raj.khem@gmail.com>, qemu-devel@nongnu.org
Cc: Kamil Rytarowski <kamil@netbsd.org>, Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>

Le 28/06/2017 à 22:44, Khem Raj a écrit :
> The ucontext_t type had a tag struct ucontext until now
> but newer glibc will drop it so we need to adjust and use
> the exposed type instead
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> Cc: Kamil Rytarowski <kamil@netbsd.org>
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  linux-user/host/aarch64/hostdep.h |  2 +-
>  linux-user/host/arm/hostdep.h     |  2 +-
>  linux-user/host/i386/hostdep.h    |  2 +-
>  linux-user/host/ppc64/hostdep.h   |  2 +-
>  linux-user/host/s390x/hostdep.h   |  2 +-
>  linux-user/host/x86_64/hostdep.h  |  2 +-
>  linux-user/signal.c               | 10 +++++-----
>  tests/tcg/test-i386.c             |  4 ++--
>  user-exec.c                       | 18 +++++++++---------
>  9 files changed, 22 insertions(+), 22 deletions(-)
> 
...
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 3d18d1b3ee..2c55a4f600 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -3346,7 +3346,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
>      *
>      *   a0 = signal number
>      *   a1 = pointer to siginfo_t
> -    *   a2 = pointer to struct ucontext
> +    *   a2 = pointer to ucontext_t
>      *
>      * $25 and PC point to the signal handler, $29 points to the
>      * struct sigframe.
> @@ -3733,7 +3733,7 @@ struct target_signal_frame {
>  
>  struct rt_signal_frame {
>      siginfo_t info;
> -    struct ucontext uc;
> +    ucontext_t uc;
>      uint32_t tramp[2];
>  };
>  
> @@ -3949,7 +3949,7 @@ struct rt_signal_frame {
>      siginfo_t *pinfo;
>      void *puc;
>      siginfo_t info;
> -    struct ucontext uc;
> +    ucontext_t uc;
>      uint16_t retcode[4];      /* Trampoline code. */
>  };
>  

I think these two rt_signal_frame are unused and can be removed.

Thanks,
Laurent
