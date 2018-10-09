Received: from eggs.gnu.org ([2001:4830:134:3::10]:49836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9tH2-00086V-NK
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9tGy-0007rz-1B
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:46:12 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9tGs-0007l9-UR
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:46:03 -0400
Received: by mail-wm1-x343.google.com with SMTP id 185-v6so2312211wmt.2
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 07:46:01 -0700 (PDT)
References: <20181008232756.30704-1-cota@braap.org>
	<20181008232756.30704-4-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181008232756.30704-4-cota@braap.org>
Date: Tue, 09 Oct 2018 15:45:59 +0100
Message-ID: <87ftxfmb4o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 3/5] cputlb: do not evict empty entries to
 the vtlb
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
> This change will help us keep track of the TLB's use rate.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

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
>  void dump_exec_info(FILE *f, fprintf_function cpu_fprintf);
>  void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf);
>  #endif /* !CONFIG_USER_ONLY */
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 80406f1033..4dc47e603c 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -689,7 +689,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ul=
ong vaddr,
>       * Only evict the old entry to the victim tlb if it's for a
>       * different page; otherwise just overwrite the stale data.
>       */
> -    if (!tlb_hit_page_anyprot(te, vaddr_page)) {
> +    if (!tlb_hit_page_anyprot(te, vaddr_page) && !tlb_entry_is_empty(te)=
) {
>          unsigned vidx =3D env->vtlb_index++ % CPU_VTLB_SIZE;
>          CPUTLBEntry *tv =3D &env->tlb_v_table[mmu_idx][vidx];


--
Alex Benn=C3=A9e
