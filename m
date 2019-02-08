Received: from eggs.gnu.org ([209.51.188.92]:58078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gs8Xd-0003Zu-WF
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:58:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gs8Xb-0003xD-T9
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:58:13 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gs8Xa-0003sh-0a
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:58:11 -0500
Received: by mail-wr1-x441.google.com with SMTP id z18so4145999wrh.2
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 07:58:09 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-74-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190130004811.27372-74-cota@braap.org>
Date: Fri, 08 Feb 2019 15:58:07 +0000
Message-ID: <87womal1bk.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 73/73] cputlb: queue async flush jobs
 without the BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> This yields sizable scalability improvements, as the below results show.
>
> Host: Two Intel E5-2683 v3 14-core CPUs at 2.00 GHz (Haswell)
>
> Workload: Ubuntu 18.04 ppc64 compiling the linux kernel with
> "make -j N", where N is the number of cores in the guest.

I can verify my pigz benchmark starts levelling out at 12-14 guest vCPUs
on the 36 core host box I'm testing on. Not super controlled environment
but certainly showing how far MTTCG has come since it was first
introduced. Good stuff.

> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index dad9b7796c..8491d36bcf 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -260,7 +260,7 @@ static void flush_all_helper(CPUState *src, run_on_cp=
u_func fn,
>
>      CPU_FOREACH(cpu) {
>          if (cpu !=3D src) {
> -            async_run_on_cpu(cpu, fn, d);
> +            async_run_on_cpu_no_bql(cpu, fn, d);
>          }
>      }
>  }
> @@ -336,8 +336,8 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxm=
ap)
>      tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
>
>      if (cpu->created && !qemu_cpu_is_self(cpu)) {
> -        async_run_on_cpu(cpu, tlb_flush_by_mmuidx_async_work,
> -                         RUN_ON_CPU_HOST_INT(idxmap));
> +        async_run_on_cpu_no_bql(cpu, tlb_flush_by_mmuidx_async_work,
> +                                RUN_ON_CPU_HOST_INT(idxmap));
>      } else {
>          tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
>      }
> @@ -481,8 +481,8 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_u=
long addr, uint16_t idxmap)
>      addr_and_mmu_idx |=3D idxmap;
>
>      if (!qemu_cpu_is_self(cpu)) {
> -        async_run_on_cpu(cpu, tlb_flush_page_by_mmuidx_async_work,
> -                         RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
> +        async_run_on_cpu_no_bql(cpu, tlb_flush_page_by_mmuidx_async_work,
> +                                RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
>      } else {
>          tlb_flush_page_by_mmuidx_async_work(
>              cpu, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));


Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

I think that brings my run through this patch series to a conclusion.
Looking good all round.

--
Alex Benn=C3=A9e
