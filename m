Received: from eggs.gnu.org ([209.51.188.92]:51132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyYyW-0004tN-FG
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:24:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyYyT-00071x-6x
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:24:31 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gyYyS-00071g-SS
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:24:29 -0500
Received: by mail-wm1-x344.google.com with SMTP id z84so1506042wmg.4
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 01:24:28 -0800 (PST)
References: <20190215143115.28777-1-alex.bennee@linaro.org>
	<87d0nn6eoi.fsf@zen.linaroharston>
	<20190219182528.GA19925@flamenco>
	<01acc60d-5f00-20ed-4631-6da98ae4da7e@ilande.co.uk>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <01acc60d-5f00-20ed-4631-6da98ae4da7e@ilande.co.uk>
Date: Tue, 26 Feb 2019 09:24:26 +0000
Message-ID: <874l8qnbqt.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/3] softmmu demacro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org


Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> On 19/02/2019 18:25, Emilio G. Cota wrote:
>
>> On Tue, Feb 19, 2019 at 14:22:37 +0000, Alex Benn=C3=A9e wrote:
>>> Emilio,
>>>
>>> Any chance you could run it through your benchmark suite?
>>
>> Something isn't quite right. For instance, gcc in SPEC doesn't
>> complete; it fails after 2s with some errors about the syntax of
>> the source being compiled. Before the patches the error isn't
>> there (the test completes in ~7s, as usual), so I suspect
>> some guest memory accesses aren't going to the right place.
>>
>> I am too busy right now to try to debug this, but if you have
>> patches to test, I can run them. The patches I tested are in
>> your v3 branch on github, i.e. with 430f28154b5 at the head.
>
> I spent a few hours yesterday and today testing this patchset against my =
OpenBIOS
> test images and found that all of them were able to boot, except for one =
MacOS image
> which started exhibiting flashing blocks on a progress bar during boot. T=
racing this
> back, I found the problem was still present when just the first patch "ac=
cel/tcg:
> demacro cputlb" was applied.

Yeah in the original version of the patch I de-macroed each element one
by one which made bisecting errors easier. This is more of a big bang
approach which has made it harder to find which bit of the conversion
broke.

That said I did test it fairly hard on ARM but I guess we see less
unaligned and page-crossing access there.

>
> First of all there were a couple of typos I found in load_helper() and st=
ore_helper()
> which can be fixed up with the following diff:
>
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 351f579fed..f3cc2dd0d9 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1251,7 +1251,7 @@ static tcg_target_ulong load_helper(CPUArchState *e=
nv,
> target_ulong addr,
>          }
>
>          tmp =3D io_readx(env, iotlbentry, mmu_idx, addr, retaddr,
> -                       addr & tlb_addr & TLB_RECHECK,
> +                       tlb_addr & TLB_RECHECK,
>                         code_read ? MMU_INST_FETCH : MMU_DATA_LOAD, size);
>          return handle_bswap(tmp, size, big_endian);
>      }
> @@ -1405,14 +1405,14 @@ tcg_target_ulong
>  helper_le_ldsl_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>                     uintptr_t retaddr)
>  {
> -    return (int32_t)helper_le_lduw_mmu(env, addr, oi, retaddr);
> +    return (int32_t)helper_le_ldul_mmu(env, addr, oi, retaddr);
>  }
>
>  tcg_target_ulong
>  helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>                     uintptr_t retaddr)
>  {
> -    return (int32_t)helper_be_lduw_mmu(env, addr, oi, retaddr);
> +    return (int32_t)helper_be_ldul_mmu(env, addr, oi, retaddr);
>  }
> +    return (int32_t)helper_le_ldul_mmu(env, addr, oi, retaddr);
>  }
>
>  tcg_target_ulong
>  helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>                     uintptr_t retaddr)
>  {
> -    return (int32_t)helper_be_lduw_mmu(env, addr, oi, retaddr);
> +    return (int32_t)helper_be_ldul_mmu(env, addr, oi, retaddr);
>  }

Awesome, I shall apply those.

>
>  /*
> @@ -1427,6 +1427,7 @@ static void store_helper(CPUArchState *env, target_=
ulong addr,
> uint64_t val,
>      uintptr_t index =3D tlb_index(env, mmu_idx, addr);
>      CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr);
>      target_ulong tlb_addr =3D tlb_addr_write(entry);
> +    const size_t tlb_off =3D offsetof(CPUTLBEntry, addr_write);
>      unsigned a_bits =3D get_alignment_bits(get_memop(oi));
>      uintptr_t haddr;
>
> @@ -1438,7 +1439,8 @@ static void store_helper(CPUArchState *env, target_=
ulong addr,
> uint64_t val,
>
>      /* If the TLB entry is for a different page, reload and try again.  =
*/
>      if (!tlb_hit(tlb_addr, addr)) {
> -        if (!VICTIM_TLB_HIT(addr_write, addr)) {
> +        if (!victim_tlb_hit(env, mmu_idx, index, tlb_off,
> +            addr & TARGET_PAGE_MASK)) {
>              tlb_fill(ENV_GET_CPU(env), addr, size, MMU_DATA_STORE,
>                       mmu_idx, retaddr);
>              index =3D tlb_index(env, mmu_idx, addr);
> @@ -1466,7 +1468,6 @@ static void store_helper(CPUArchState *env, target_=
ulong addr,
> uint64_t val,
>          && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
>                       >=3D TARGET_PAGE_SIZE)) {
>          int i;
> -        uintptr_t index2;
>          CPUTLBEntry *entry2;
>          target_ulong page2, tlb_addr2;
>      do_unaligned_access:
> @@ -1476,15 +1477,13 @@ static void store_helper(CPUArchState *env, targe=
t_ulong
> addr, uint64_t val,
>           * cannot evict the first.
>           */
>          page2 =3D (addr + size) & TARGET_PAGE_MASK;
> -        index2 =3D tlb_index(env, mmu_idx, page2);
> -        entry2 =3D tlb_entry(env, mmu_idx, index2);
> +        entry2 =3D tlb_entry(env, mmu_idx, page2);
>          tlb_addr2 =3D tlb_addr_write(entry2);
>          if (!tlb_hit_page(tlb_addr2, page2)
> -            && !VICTIM_TLB_HIT(addr_write, page2)) {
> +            && !victim_tlb_hit(env, mmu_idx, index, tlb_off,
> +                               page2 & TARGET_PAGE_MASK)) {
>              tlb_fill(ENV_GET_CPU(env), page2, size, MMU_DATA_STORE,
>                       mmu_idx, retaddr);
> -            index2 =3D tlb_index(env, mmu_idx, page2);
> -            entry2 =3D tlb_entry(env, mmu_idx, index2);
>          }

Oops, I thought I'd applied the victim fix to both loads and stores.

>
>          /*
>
>
> Even with this patch applied I was still seeing issues with the progress =
bar, so I
> ended up manually unrolling softmmu_template.h myself until I could see a=
t what point
> things were breaking.
>
> The culprit turned out to be the change in type of res in load_helper() f=
rom the size
> -related type of uint8_t/uint16_t/uint32_t/uint64_t to tcg_target_ulong i=
n the slow
> path as seen from my locally unrolled version:
>
>
> WORKING:
>
> tcg_target_ulong helper_le_ldul_mmu(CPUArchState *env, target_ulong addr,
>                             TCGMemOpIdx oi, uintptr_t retaddr)
> {
>     ....
>
>     /* Handle slow unaligned access (it spans two pages or IO).  */
>     if (4 > 1
>         && unlikely((addr & ~TARGET_PAGE_MASK) + 4 - 1
>                     >=3D TARGET_PAGE_SIZE)) {
>         target_ulong addr1, addr2;
>         uint32_t res1, res2;
>         ^^^^^^^^
>         unsigned shift;
>     do_unaligned_access:
>         addr1 =3D addr & ~(4 - 1);
>         addr2 =3D addr1 + 4;
>         res1 =3D helper_le_ldul_mmu(env, addr1, oi, retaddr);
>         res2 =3D helper_le_ldul_mmu(env, addr2, oi, retaddr);
>         shift =3D (addr & (4 - 1)) * 8;
>
>         /* Little-endian combine.  */
>         res =3D (res1 >> shift) | (res2 << ((4 * 8) - shift));
>         return res;
>     }
>
> }
>
> tcg_target_ulong helper_be_ldul_mmu(CPUArchState *env, target_ulong addr,
>                             TCGMemOpIdx oi, uintptr_t retaddr)
> {
>     ....
>
>     /* Handle slow unaligned access (it spans two pages or IO).  */
>     if (4 > 1
>         && unlikely((addr & ~TARGET_PAGE_MASK) + 4 - 1
>                     >=3D TARGET_PAGE_SIZE)) {
>         target_ulong addr1, addr2;
>         uint32_t res1, res2;
>         ^^^^^^^^
>         unsigned shift;
>     do_unaligned_access:
>         addr1 =3D addr & ~(4 - 1);
>         addr2 =3D addr1 + 4;
>         res1 =3D helper_be_ldul_mmu(env, addr1, oi, retaddr);
>         res2 =3D helper_be_ldul_mmu(env, addr2, oi, retaddr);
>         shift =3D (addr & (4 - 1)) * 8;
>
>         /* Big-endian combine.  */
>         res =3D (res1 << shift) | (res2 >> ((4 * 8) - shift));
>         return res;
>     }
> }
>
>
> CORRUPTED:
>
> tcg_target_ulong helper_le_ldul_mmu(CPUArchState *env, target_ulong addr,
>                             TCGMemOpIdx oi, uintptr_t retaddr)
> {
>     ....
>
>     /* Handle slow unaligned access (it spans two pages or IO).  */
>     if (4 > 1
>         && unlikely((addr & ~TARGET_PAGE_MASK) + 4 - 1
>                     >=3D TARGET_PAGE_SIZE)) {
>         target_ulong addr1, addr2;
>         tcg_target_ulong res1, res2;
>         ^^^^^^^^^^^^^^^^
>         unsigned shift;
>     do_unaligned_access:
>         addr1 =3D addr & ~(4 - 1);
>         addr2 =3D addr1 + 4;
>         res1 =3D helper_le_ldul_mmu(env, addr1, oi, retaddr);
>         res2 =3D helper_le_ldul_mmu(env, addr2, oi, retaddr);
>         shift =3D (addr & (4 - 1)) * 8;
>
>         /* Little-endian combine.  */
>         res =3D (res1 >> shift) | (res2 << ((4 * 8) - shift));
>         return res;
>     }
>
> }
>
> tcg_target_ulong helper_be_ldul_mmu(CPUArchState *env, target_ulong addr,
>                             TCGMemOpIdx oi, uintptr_t retaddr)
> {
>     ....
>
>     /* Handle slow unaligned access (it spans two pages or IO).  */
>     if (4 > 1
>         && unlikely((addr & ~TARGET_PAGE_MASK) + 4 - 1
>                     >=3D TARGET_PAGE_SIZE)) {
>         target_ulong addr1, addr2;
>         tcg_target_ulong res1, res2;
>         ^^^^^^^^^^^^^^^^
>         unsigned shift;
>     do_unaligned_access:
>         addr1 =3D addr & ~(4 - 1);
>         addr2 =3D addr1 + 4;
>         res1 =3D helper_be_ldul_mmu(env, addr1, oi, retaddr);
>         res2 =3D helper_be_ldul_mmu(env, addr2, oi, retaddr);
>         shift =3D (addr & (4 - 1)) * 8;
>
>         /* Big-endian combine.  */
>         res =3D (res1 << shift) | (res2 >> ((4 * 8) - shift));
>         return res;
>     }
> }
>
>
> Presumably the issue here is somehow related to the compiler incorrectly
> extending/reducing the shift when the larger type is involved? Also durin=
g my tests
> the visual corruption was only present for 32-bit accesses, but presumabl=
y all the
> access sizes will need a similar fix.

So I did fix this in the third patch when I out of lined the unaligned
helpers so:

     const tcg_target_ulong size_mask =3D MAKE_64BIT_MASK(0, size * 8);

and

     /* Big-endian combine.  */
     r2 &=3D size_mask;

or

     /* Little-endian combine.  */
     r1 &=3D size_mask;

I guess I should also apply that to patch 1 for bisectability.

Thanks for digging into the failures. It does make me think that we
really could do with some system mode tests to properly exercise all
softmmu code paths:

  * each size access, load and store
  * unaligned accesses, load and store (+ potential arch specific handling)
  * page striding accesses faulting and non-faulting

I'm not sure how much work it would be to get a minimal bare metal
kernel that would be able to do these and report success/fail. When I
did the MTTCG work I used kvm-unit-tests as a fairly complete mini-os
but maybe that's overkill for what we need here. After all we already
have migration kernels that just do a simple tick-tock for testing
migration. It would be nice to have the tests in C with maybe a minimal
per-arch assembly so we can share the tests across various platforms.

--
Alex Benn=C3=A9e
