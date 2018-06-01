Received: from eggs.gnu.org ([2001:4830:134:3::10]:49999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fOqCp-0007VB-QD
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 15:59:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fOqCl-0003rm-Us
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 15:59:23 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:41963)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fOqCl-0003mF-IN
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 15:59:19 -0400
References: <20180531041822.5761-1-richard.henderson@linaro.org>
	<20180531041822.5761-2-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2d80e2d0-7223-c4d5-578a-82b865a1c627@vivier.eu>
Date: Fri, 1 Jun 2018 21:59:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180531041822.5761-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-user: Implement signals for
 openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: shorne@gmail.com

Le 31/05/2018 à 06:18, Richard Henderson a écrit :
> All of the existing code was boilerplate from elsewhere,
> and would crash the guest upon the first signal.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/openrisc/target_syscall.h |  23 +--
>  linux-user/openrisc/signal.c         | 210 +++++++++++----------------
>  linux-user/signal.c                  |   2 +-
>  target/openrisc/cpu.c                |   1 +
>  4 files changed, 87 insertions(+), 149 deletions(-)
> 
> diff --git a/linux-user/openrisc/target_syscall.h b/linux-user/openrisc/target_syscall.h
> index 03104f80af..f21fab3192 100644
> --- a/linux-user/openrisc/target_syscall.h
> +++ b/linux-user/openrisc/target_syscall.h
> @@ -2,26 +2,9 @@
>  #define OPENRISC_TARGET_SYSCALL_H
>  
>  struct target_pt_regs {
> -    union {
> -        struct {
> -            /* Named registers */
> -            uint32_t sr;       /* Stored in place of r0 */
> -            target_ulong sp;   /* r1 */
> -        };
> -        struct {
> -            /* Old style */
> -            target_ulong offset[2];
> -            target_ulong gprs[30];
> -        };
> -        struct {
> -            /* New style */
> -            target_ulong gpr[32];
> -        };
> -    };
> -    target_ulong pc;
> -    target_ulong orig_gpr11;   /* For restarting system calls */
> -    uint32_t syscallno;        /* Syscall number (used by strace) */
> -    target_ulong dummy;     /* Cheap alignment fix */
> +    abi_ulong gpr[32];
> +    abi_ulong pc;
> +    abi_ulong sr;
>  };

>From where is this coming from?

In linux/arch/openrisc/include/asm/ptrace.h, we have the definition you
remove.

Thanks,
Laurent
