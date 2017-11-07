Received: from eggs.gnu.org ([2001:4830:134:3::10]:39046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eByts-00081L-Dn
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 03:06:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eBytp-0007QK-83
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 03:06:24 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:52986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eByto-0007PJ-VR
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 03:06:21 -0500
References: <1509993206-26637-1-git-send-email-peter.maydell@linaro.org>
	<1509993206-26637-2-git-send-email-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <39381f18-a7c3-40bb-6df8-71d273e708ce@vivier.eu>
Date: Tue, 7 Nov 2017 09:06:09 +0100
MIME-Version: 1.0
In-Reply-To: <1509993206-26637-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/4] linux-user/s390x: Mask si_addr for
 SIGSEGV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>

Le 06/11/2017 à 19:33, Peter Maydell a écrit :
> For s390x, the address passed to a signal handler in the
> siginfo_t si_addr field is masked (in the kernel this is done in
> do_sigbus() and do_sigsegv() in arch/s390/mm/fault.c). Implement
> this architecture-specific oddity in linux-user.
> 
> This is one of the issues described in
> https://bugs.launchpad.net/qemu/+bug/1705118
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index aa02f25..b6dd9ef 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -3238,6 +3238,10 @@ void cpu_loop(CPUAlphaState *env)
>  #endif /* TARGET_ALPHA */
>  
>  #ifdef TARGET_S390X
> +
> +/* s390x masks the fault address it reports in si_addr for SIGSEGV and SIGBUS */
> +#define S390X_FAIL_ADDR_MASK -4096LL
> +
>  void cpu_loop(CPUS390XState *env)
>  {
>      CPUState *cs = CPU(s390_env_get_cpu(env));
> @@ -3294,7 +3298,7 @@ void cpu_loop(CPUS390XState *env)
>                  sig = TARGET_SIGSEGV;
>                  /* XXX: check env->error_code */
>                  n = TARGET_SEGV_MAPERR;
> -                addr = env->__excp_addr;
> +                addr = env->__excp_addr & S390X_FAIL_ADDR_MASK;
>                  goto do_signal;
>              case PGM_EXECUTE:
>              case PGM_SPECIFICATION:
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
