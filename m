Received: from eggs.gnu.org ([2001:4830:134:3::10]:44684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eC5tU-0008Rp-H8
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:34:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eC5tO-00081c-W1
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:34:28 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:51516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eC5tO-00081R-S0
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:34:22 -0500
Received: by mail-qt0-x241.google.com with SMTP id h4so15662371qtk.8
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 07:34:22 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1509993206-26637-1-git-send-email-peter.maydell@linaro.org>
	<1509993206-26637-2-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e66c9e23-3938-0786-8880-3895f88827c5@amsat.org>
Date: Tue, 7 Nov 2017 12:34:13 -0300
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, patches@linaro.org

On 11/06/2017 03:33 PM, Peter Maydell wrote:
> For s390x, the address passed to a signal handler in the
> siginfo_t si_addr field is masked (in the kernel this is done in
> do_sigbus() and do_sigsegv() in arch/s390/mm/fault.c). Implement
> this architecture-specific oddity in linux-user.
> 
> This is one of the issues described in
> https://bugs.launchpad.net/qemu/+bug/1705118
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
