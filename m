Received: from eggs.gnu.org ([209.51.188.92]:52276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmgLs-0006Th-Hz
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmgLq-0002GR-D0
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:51:32 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gmgLq-0002F8-4W
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:51:30 -0500
Received: by mail-wr1-x444.google.com with SMTP id t6so6737969wrr.12
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 06:51:29 -0800 (PST)
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-10-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181209193749.12277-10-cota@braap.org>
Date: Thu, 24 Jan 2019 14:51:27 +0000
Message-ID: <87o986yuq8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 09/38] cputlb: introduce
 get_page_addr_code_hostp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>


Emilio G. Cota <cota@braap.org> writes:

> This will be used by plugins to get the host address
> of instructions.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/exec/exec-all.h | 13 +++++++++++++
>  accel/tcg/cputlb.c      | 14 +++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 815e5b1e83..afcc01e0e3 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -22,6 +22,7 @@
>
>  #include "qemu-common.h"
>  #include "exec/tb-context.h"
> +#include "exec/cpu_ldst.h"
>  #include "sysemu/cpus.h"
>
>  /* allow to see translation results - the slowdown should be negligible,=
 so we leave it */
> @@ -487,12 +488,24 @@ static inline tb_page_addr_t get_page_addr_code(CPU=
ArchState *env1, target_ulong
>  {
>      return addr;
>  }
> +
> +static inline tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env1,
> +                                                      target_ulong addr,
> +                                                      void **hostp)
> +{
> +    if (hostp) {
> +        *hostp =3D g2h(addr);
> +    }
> +    return addr;
> +}
>  #else
>  static inline void mmap_lock(void) {}
>  static inline void mmap_unlock(void) {}
>
>  /* cputlb.c */
>  tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong addr);
> +tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env1, target_ulong=
 addr,
> +                                        void **hostp);
>

It's probably about time these helpers got proper doc headers. So I take
it the host address of an instruction is where in host memory the code
is or where in host memory the translation for that instruction is?

>  void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length=
);
>  void tlb_set_dirty(CPUState *cpu, target_ulong vaddr);
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index e3582f2f1d..5c61908084 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1069,7 +1069,8 @@ static bool victim_tlb_hit(CPUArchState *env, size_=
t mmu_idx, size_t index,
>   * is actually a ram_addr_t (in system mode; the user mode emulation
>   * version of this function returns a guest virtual address).
>   */
> -tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
> +tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, target_ulong =
addr,
> +                                        void **hostp)
>  {
>      uintptr_t mmu_idx =3D cpu_mmu_index(env, true);
>      uintptr_t index =3D tlb_index(env, mmu_idx, addr);
> @@ -1092,13 +1093,24 @@ tb_page_addr_t get_page_addr_code(CPUArchState *e=
nv, target_ulong addr)
>           *    than a target page, so we must redo the MMU check every in=
sn
>           *  - TLB_MMIO: region is not backed by RAM
>           */
> +        if (hostp) {
> +            *hostp =3D NULL;
> +        }
>          return -1;
>      }
>
>      p =3D (void *)((uintptr_t)addr + entry->addend);
> +    if (hostp) {
> +        *hostp =3D p;
> +    }
>      return qemu_ram_addr_from_host_nofail(p);
>  }
>
> +tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
> +{
> +    return get_page_addr_code_hostp(env, addr, NULL);
> +}
> +
>  /* Probe for whether the specified guest write access is permitted.
>   * If it is not permitted then an exception will be taken in the same
>   * way as if this were a real write access (and we will not return).


--
Alex Benn=C3=A9e
