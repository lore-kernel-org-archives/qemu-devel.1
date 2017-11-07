Received: from eggs.gnu.org ([2001:4830:134:3::10]:44738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eBzFD-0005iE-2u
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 03:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eBzF9-0005VY-4B
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 03:28:27 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:65398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eBzF8-0005UT-Qw
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 03:28:23 -0500
References: <1509993206-26637-1-git-send-email-peter.maydell@linaro.org>
	<1509993206-26637-4-git-send-email-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4fcd39ca-7e73-01b2-e9bc-1c690c9d5dec@vivier.eu>
Date: Tue, 7 Nov 2017 09:28:12 +0100
MIME-Version: 1.0
In-Reply-To: <1509993206-26637-4-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/4] linux-user/sparc: Put address for data
 faults where linux-user expects it
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
> In the user-mode-only version of sparc_cpu_handle_mmu_fault(),
> we must save the fault address for a data fault into the CPU
> state's mmu registers, because the code in linux-user/main.c
> expects to find it there in order to populate the si_addr
> field of the guest siginfo.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/sparc/mmu_helper.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
> index 126ea5e..d5b6c1e 100644
> --- a/target/sparc/mmu_helper.c
> +++ b/target/sparc/mmu_helper.c
> @@ -30,10 +30,18 @@
>  int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
>                                 int mmu_idx)
>  {
> +    SPARCCPU *cpu = SPARC_CPU(cs);
> +    CPUSPARCState *env = &cpu->env;
> +
>      if (rw & 2) {
>          cs->exception_index = TT_TFAULT;
>      } else {
>          cs->exception_index = TT_DFAULT;
> +#ifdef TARGET_SPARC64
> +        env->dmmu.mmuregs[4] = address;
> +#else
> +        env->mmuregs[4] = address;
> +#endif
>      }
>      return 1;
>  }
> 

The softmmu version of sparc_cpu_handle_mmu_fault() also updates
mmuregs[3]. Is it needed for this one (for ucontext)?

Thanks,
Laurent
