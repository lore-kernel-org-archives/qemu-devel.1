Received: from eggs.gnu.org ([2001:4830:134:3::10]:54426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fo3Tn-0005UE-EC
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fo3Tk-0006yA-98
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:13:07 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:43762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fo3Tj-0006xd-W0
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:13:04 -0400
Received: by mail-wr1-x432.google.com with SMTP id b15-v6so7625144wrv.10
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 02:13:03 -0700 (PDT)
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-13-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180809042206.15726-13-richard.henderson@linaro.org>
Date: Fri, 10 Aug 2018 10:13:01 +0100
Message-ID: <87600ipote.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/20] target/arm: Rewrite
 helper_sve_ld1*_r using pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent.desnogues@gmail.com, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Uses tlb_vaddr_to_host for correct operation with softmmu.
> Optimize for accesses within a single page or pair of pages.
>
> Perf report comparison for cortex-strings test-strlen
> with aarch64-linux-user:
>
<snip>
> +/*
> + * Common helper for all contiguous one-register predicated loads.
> + */
> +static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong add=
r,
> +                      uint32_t desc, const uintptr_t retaddr,
> +                      const int esz, const int msz,
> +                      sve_ld1_host_fn *host_fn,
> +                      sve_ld1_tlb_fn *tlb_fn)
> +{
> +    void *vd =3D &env->vfp.zregs[simd_data(desc)];
> +    const int diffsz =3D esz - msz;
> +    const intptr_t reg_max =3D simd_oprsz(desc);
> +    const intptr_t mem_max =3D reg_max >> diffsz;
> +    const int mmu_idx =3D cpu_mmu_index(env, false);
> +    ARMVectorReg scratch;
> +    void *host, *result;
> +    intptr_t split;
> +
> +    set_helper_retaddr(retaddr);
> +
> +    host =3D tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmu_idx);
> +    if (test_host_page(host)) {
> +        split =3D max_for_page(addr, 0, mem_max);
> +        if (likely(split =3D=3D mem_max)) {
> +            /* The load is entirely within a valid page.  For softmmu,
> +             * no faults.  For user-only, if the first byte does not
> +             * fault then none of them will fault, so Vd will never be
> +             * partially modified.
> +             */
> +            host_fn(vd, vg, host, 0, mem_max);
> +            set_helper_retaddr(0);
> +            return;
> +        }
> +    }
> +
> +    /* Perform the predicated read into a temporary, thus ensuring
> +     * if the load of the last element faults, Vd is not modified.
> +     */
> +    result =3D &scratch;
> +#ifdef CONFIG_USER_ONLY
> +    host_fn(vd, vg, host, 0, mem_max);
> +#else
> +    memset(result, 0, reg_max);
> +    for (intptr_t reg_off =3D find_next_active(vg, 0, reg_max, esz);

Hmm this blew up CI complaining about c99-isms, but QEMU is supposed to
be c99 compliant.

  https://travis-ci.org/stsquad/qemu/builds/414248994

--
Alex Benn=C3=A9e
