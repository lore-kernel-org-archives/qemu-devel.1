Received: from eggs.gnu.org ([2001:4830:134:3::10]:41047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eC5m8-0002Vv-4X
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:26:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eC5m4-0003BJ-Vn
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:26:52 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:48270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eC5m4-0003Ax-RC
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:26:48 -0500
Received: by mail-qk0-x241.google.com with SMTP id a142so6912494qkb.5
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 07:26:48 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1509993206-26637-1-git-send-email-peter.maydell@linaro.org>
	<1509993206-26637-4-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <915815fa-b28d-62e7-e39f-01aa55ebc388@amsat.org>
Date: Tue, 7 Nov 2017 12:26:44 -0300
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, patches@linaro.org

On 11/06/2017 03:33 PM, Peter Maydell wrote:
> In the user-mode-only version of sparc_cpu_handle_mmu_fault(),
> we must save the fault address for a data fault into the CPU
> state's mmu registers, because the code in linux-user/main.c
> expects to find it there in order to populate the si_addr
> field of the guest siginfo.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
