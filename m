Received: from eggs.gnu.org ([2001:4830:134:3::10]:46672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1Zl8-0003e1-Sc
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 11:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1Zl4-0003mE-Gb
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 11:46:38 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:39889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f1Zl4-0003l5-9j
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 11:46:34 -0400
Received: by mail-wr0-x243.google.com with SMTP id c24so5832194wrc.6
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 08:46:34 -0700 (PDT)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-15-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1519709965-29833-15-git-send-email-cota@braap.org>
Date: Thu, 29 Mar 2018 16:46:31 +0100
Message-ID: <87o9j67ulk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 14/16] cputlb: remove tb_lock from
 tlb_flush functions
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

> The acquisition of tb_lock was added when the async tlb_flush
> was introduced in e3b9ca810 ("cputlb: introduce tlb_flush_* async work.")
>
> tb_lock was there to allow us to do memset() on the tb_jmp_cache's.
> However, since f3ced3c5928 ("tcg: consistently access cpu->tb_jmp_cache
> atomically") all accesses to tb_jmp_cache are atomic, so tb_lock
> is not needed here. Get rid of it.

\o/

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/cputlb.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 0543903..f5c3a09 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -125,8 +125,6 @@ static void tlb_flush_nocheck(CPUState *cpu)
>      atomic_set(&env->tlb_flush_count, env->tlb_flush_count + 1);
>      tlb_debug("(count: %zu)\n", tlb_flush_count());
>
> -    tb_lock();
> -
>      memset(env->tlb_table, -1, sizeof(env->tlb_table));
>      memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
>      cpu_tb_jmp_cache_clear(cpu);
> @@ -135,8 +133,6 @@ static void tlb_flush_nocheck(CPUState *cpu)
>      env->tlb_flush_addr =3D -1;
>      env->tlb_flush_mask =3D 0;
>
> -    tb_unlock();
> -
>      atomic_mb_set(&cpu->pending_tlb_flush, 0);
>  }
>
> @@ -180,8 +176,6 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *=
cpu, run_on_cpu_data data)
>
>      assert_cpu_is_self(cpu);
>
> -    tb_lock();
> -
>      tlb_debug("start: mmu_idx:0x%04lx\n", mmu_idx_bitmask);
>
>      for (mmu_idx =3D 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
> @@ -197,8 +191,6 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *=
cpu, run_on_cpu_data data)
>      cpu_tb_jmp_cache_clear(cpu);
>
>      tlb_debug("done\n");
> -
> -    tb_unlock();
>  }
>
>  void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)


--
Alex Benn=C3=A9e
