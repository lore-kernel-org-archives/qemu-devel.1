Received: from eggs.gnu.org ([2001:4830:134:3::10]:45407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eeHpz-0007Ai-0h
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 04:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eeHpu-000209-6c
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 04:59:23 -0500
References: <39441aea4e2d05cc505ed3a373e81d3869eb994a.1516785202.git.agx@sigxcpu.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7a025be3-2f5c-2970-339e-1dee6d80d15b@vivier.eu>
Date: Wed, 24 Jan 2018 10:59:05 +0100
MIME-Version: 1.0
In-Reply-To: <39441aea4e2d05cc505ed3a373e81d3869eb994a.1516785202.git.agx@sigxcpu.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix register used for 6th
 syscall argument on aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

Le 24/01/2018 à 10:14, Guido Günther a écrit :
> Unbreaks the testcase from
> 
>     http://lists.nongnu.org/archive/html/qemu-arm/2018-01/msg00514.html
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  linux-user/host/aarch64/safe-syscall.inc.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/host/aarch64/safe-syscall.inc.S b/linux-user/host/aarch64/safe-syscall.inc.S
> index 58a2329b37..e4fbc31454 100644
> --- a/linux-user/host/aarch64/safe-syscall.inc.S
> +++ b/linux-user/host/aarch64/safe-syscall.inc.S
> @@ -36,7 +36,7 @@ safe_syscall_base:
>  	 *               and return the result in x0
>  	 * and the syscall instruction needs
>  	 *               x8 == syscall number
> -	 *               x0 ... x7 == syscall arguments
> +	 *               x0 ... x5 == syscall arguments
>  	 *               and returns the result in x0
>  	 * Shuffle everything around appropriately.
>  	 */
> @@ -47,7 +47,7 @@ safe_syscall_base:
>  	mov	x2, x4
>  	mov	x3, x5
>  	mov	x4, x6
> -	mov	x6, x7
> +	mov	x5, x7
>  	ldr	x7, [sp]
>  
>  	/* This next sequence of code works in conjunction with the
> 

According to glibc/unix/sysv/linux/aarch64/syscall.S:

  AArch64 system calls take between 0 and 7 arguments.
  ... and any other system call arguments are in register x1..x7.

And it seems for qemu last argument is on the stack.
...
         x2 ... x7, (stack) == syscall arguments
...

Should we have something like this?

@@ -47,8 +47,8 @@ safe_syscall_base:
        mov     x2, x4
        mov     x3, x5
        mov     x4, x6
-       mov     x6, x7
-       ldr     x7, [sp]
+       mov     x5, x7
+       ldr     x6, [sp]

        /* This next sequence of code works in conjunction with the
         * rewind_if_safe_syscall_function(). If a signal is taken

But do we need to set x7 from the stack too?

Thanks,
Laurent
