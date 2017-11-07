Received: from eggs.gnu.org ([2001:4830:134:3::10]:41933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eBz5B-0001rL-J8
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 03:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eBz56-0005n4-Oi
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 03:18:05 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:52987)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eBz56-0005mR-Ev
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 03:18:00 -0500
References: <1509993206-26637-1-git-send-email-peter.maydell@linaro.org>
	<1509993206-26637-3-git-send-email-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f104a7d9-fbc0-4b58-b2c7-23078564dcd8@vivier.eu>
Date: Tue, 7 Nov 2017 09:17:48 +0100
MIME-Version: 1.0
In-Reply-To: <1509993206-26637-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] linux-user/ppc: Report correct fault
 address for data faults
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
> For faults on loads and stores, ppc_cpu_handle_mmu_fault() in
> target/ppc/user_only_helper.c stores the offending address
> in env->spr[SPR_DAR]. Report this correctly to the guest
> in si_addr, rather than incorrectly using the address of the
> instruction that caused the fault.
> 
> This fixes the test case in
> https://bugs.launchpad.net/qemu/+bug/1077116
> for ppc, ppc64 and ppc64le.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index b6dd9ef..6286661 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -1420,7 +1420,7 @@ void cpu_loop(CPUPPCState *env)
>                  info.si_code = TARGET_SEGV_MAPERR;
>                  break;
>              }
> -            info._sifields._sigfault._addr = env->nip;
> +            info._sifields._sigfault._addr = env->spr[SPR_DAR];
>              queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
>              break;
>          case POWERPC_EXCP_ISI:      /* Instruction storage exception         */
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
