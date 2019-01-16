Received: from eggs.gnu.org ([209.51.188.92]:41742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjiUb-0007oG-7D
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjiUX-0005Xr-59
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:32:16 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gjiUW-0005H3-Ou
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:32:13 -0500
Received: by mail-wr1-x444.google.com with SMTP id q18so6274832wrx.9
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 02:32:11 -0800 (PST)
References: <20190114165017.27298-1-cota@braap.org>
	<20190114165017.27298-2-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190114165017.27298-2-cota@braap.org>
Date: Wed, 16 Jan 2019 10:32:08 +0000
Message-ID: <87fttszydz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 1/3] cputlb: do not evict empty entries
 to the vtlb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Currently we evict an entry to the victim TLB when it doesn't match
> the current address. But it could be that there's no match because
> the current entry is empty (i.e. all -1's, for instance via tlb_flush).
> Do not evict the entry to the vtlb in that case.
>
> This change will help us keep track of the TLB's use rate, which
> we'll use to implement a policy for dynamic TLB sizing.
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/exec/cpu-all.h | 9 +++++++++
>  accel/tcg/cputlb.c     | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 117d2fbbca..e21140049b 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -362,6 +362,15 @@ static inline bool tlb_hit(target_ulong tlb_addr, ta=
rget_ulong addr)
>      return tlb_hit_page(tlb_addr, addr & TARGET_PAGE_MASK);
>  }
>
> +/**
> + * tlb_entry_is_empty - return true if the entry is not in use
> + * @te: pointer to CPUTLBEntry
> + */
> +static inline bool tlb_entry_is_empty(const CPUTLBEntry *te)
> +{
> +    return te->addr_read =3D=3D -1 && te->addr_write =3D=3D -1 && te->ad=
dr_code =3D=3D -1;
> +}
> +

This breaks on a --disable-tcg build. I think the whole block needs to
be in a:

  #if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)

now.

>  void dump_exec_info(FILE *f, fprintf_function cpu_fprintf);
>  void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf);
>  #endif /* !CONFIG_USER_ONLY */
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index af6bd8ccf9..5dc97212a9 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -591,7 +591,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ul=
ong vaddr,
>       * Only evict the old entry to the victim tlb if it's for a
>       * different page; otherwise just overwrite the stale data.
>       */
> -    if (!tlb_hit_page_anyprot(te, vaddr_page)) {
> +    if (!tlb_hit_page_anyprot(te, vaddr_page) && !tlb_entry_is_empty(te)=
) {
>          unsigned vidx =3D env->tlb_d[mmu_idx].vindex++ % CPU_VTLB_SIZE;
>          CPUTLBEntry *tv =3D &env->tlb_v_table[mmu_idx][vidx];


--
Alex Benn=C3=A9e
