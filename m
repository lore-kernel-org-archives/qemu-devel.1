Received: from eggs.gnu.org ([2001:4830:134:3::10]:57556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g81Z4-0004YH-PG
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g81UU-0007Lm-TG
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:08:26 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:43397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g81UU-0007Gn-Kt
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:08:22 -0400
Received: by mail-wr1-x429.google.com with SMTP id n1-v6so9439705wrt.10
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 04:08:22 -0700 (PDT)
References: <20181003200454.18384-1-cota@braap.org>
	<20181003200454.18384-2-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181003200454.18384-2-cota@braap.org>
Date: Thu, 04 Oct 2018 12:08:20 +0100
Message-ID: <87woqyq89n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] exec: introduce tlb_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


Emilio G. Cota <cota@braap.org> writes:

> Paves the way for the addition of a per-TLB lock.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/exec-all.h | 8 ++++++++
>  accel/tcg/cputlb.c      | 4 ++++
>  exec.c                  | 1 +
>  3 files changed, 13 insertions(+)
>
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 5f78125582..815e5b1e83 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -99,6 +99,11 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>
>  #if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
>  /* cputlb.c */
> +/**
> + * tlb_init - initialize a CPU's TLB
> + * @cpu: CPU whose TLB should be initialized
> + */
> +void tlb_init(CPUState *cpu);
>  /**
>   * tlb_flush_page:
>   * @cpu: CPU whose TLB should be flushed
> @@ -258,6 +263,9 @@ void tlb_set_page(CPUState *cpu, target_ulong vaddr,
>  void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu=
_idx,
>                   uintptr_t retaddr);
>  #else
> +static inline void tlb_init(CPUState *cpu)
> +{
> +}
>  static inline void tlb_flush_page(CPUState *cpu, target_ulong addr)
>  {
>  }
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index f4702ce91f..502eea2850 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -73,6 +73,10 @@ QEMU_BUILD_BUG_ON(sizeof(target_ulong) > sizeof(run_on=
_cpu_data));
>  QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
>  #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
>
> +void tlb_init(CPUState *cpu)
> +{
> +}
> +
>  /* flush_all_helper: run fn across all cpus
>   *
>   * If the wait flag is set then the src cpu's helper will be queued as
> diff --git a/exec.c b/exec.c
> index d0821e69aa..4fd831ef06 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -965,6 +965,7 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
>          tcg_target_initialized =3D true;
>          cc->tcg_initialize();
>      }
> +    tlb_init(cpu);
>
>  #ifndef CONFIG_USER_ONLY
>      if (qdev_get_vmsd(DEVICE(cpu)) =3D=3D NULL) {


--
Alex Benn=C3=A9e
