Received: from eggs.gnu.org ([2001:4830:134:3::10]:60302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1feZAJ-0005xJ-TN
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 01:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1feZAG-0005E0-Pj
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 01:01:47 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180713150945.12348-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <38ec941c-7a01-8ba9-cf81-db944ce1329f@amsat.org>
Date: Sun, 15 Jul 2018 02:01:38 -0300
MIME-Version: 1.0
In-Reply-To: <20180713150945.12348-1-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="EKHNjZKOz9iEYIb2FI2R0ELFI2u3vHs5l"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] accel/tcg: Check whether TLB
 entry is RAM consistently with how we set it up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EKHNjZKOz9iEYIb2FI2R0ELFI2u3vHs5l
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, patches@linaro.org
Message-ID: <38ec941c-7a01-8ba9-cf81-db944ce1329f@amsat.org>
Subject: Re: [Qemu-arm] [PATCH] accel/tcg: Check whether TLB entry is RAM
 consistently with how we set it up
References: <20180713150945.12348-1-peter.maydell@linaro.org>
In-Reply-To: <20180713150945.12348-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 07/13/2018 12:09 PM, Peter Maydell wrote:
> We set up TLB entries in tlb_set_page_with_attrs(), where we have
> some logic for determining whether the TLB entry is considered
> to be RAM-backed, and thus has a valid addend field. When we
> look at the TLB entry in get_page_addr_code(), we use different
> logic for determining whether to treat the page as RAM-backed
> and use the addend field. This is confusing, and in fact buggy,
> because the code in tlb_set_page_with_attrs() correctly decides
> that rom_device memory regions not in romd mode are not RAM-backed,
> but the code in get_page_addr_code() thinks they are RAM-backed.
> This typically results in "Bad ram pointer" assertion if the
> guest tries to execute from such a memory region.
>=20
> Fix this by making get_page_addr_code() just look at the
> TLB_MMIO bit in the code_address field of the TLB, which
> tlb_set_page_with_attrs() sets if and only if the addend
> field is not valid for code execution.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This patch is based on:
>  * [PATCH for-3.0 0/2] accel/tcg: fix get_page_addr_code() victim TLB l=
ookups
>  * [PATCH 0/6] accel/tcg: Support execution from MMIO and small MMU reg=
ions
> Based-on: <20180713141636.18665-1-peter.maydell@linaro.org>
> Based-on: <20180710160013.26559-1-peter.maydell@linaro.org>
>=20
> It would be possible to fix the 'bad ram pointer' in a more
> minimalist way (by making memory_region_is_unassigned()
> check "!memory_region_is_romd(mr)" rather than "!mr->rom_device")
> but since for 3.0 the only thing this does is turn that assert
> failure into the "can't execute from non-ram" error-exit it
> doesn't seem worth fixing for 3.0. After 3.0 the small-MMU-region
> exec support makes it more interesting. NB that if your
> rom-device is pflash then being able to execute from it when
> it's not in romd mode is not likely to actually help you, since
> pflash status code returns are seldom valid instructions :-)
>=20
> Philippe: you might like to try this lot with your MIPS
> code that was getting the bad ram addr error?

Yes! You're my hero =3D)

Diff:

 Power-On
 ...
 PFLASH: pflash_write: flash reset asked (98 f0)
 pflash_reset reset
 mips_cpu_handle_mmu_fault pc 94760050 ad a8610914 rw 0 mmu_idx 3
 mips_cpu_handle_mmu_fault address=3Da8610914 physical 0000000008610914 p=
rot 3
 mips_cpu_handle_mmu_fault pc 900034a4 ad 900034a4 rw 2 mmu_idx 3
 mips_cpu_handle_mmu_fault address=3D900034a4 physical 00000000100034a4 p=
rot 3
-qemu-system-mips: Bad ram pointer 0x4a4
+pflash_read offset:0x34a4 cmd:0x00 width:4 wcycle:0
+pflash_data_read32 data offset:0x34a4 value:0x14400057
 ...
+mips_cpu_handle_mmu_fault pc 90003668 ad 90003668 rw 2 mmu_idx 3
+mips_cpu_handle_mmu_fault address=3D90003668 physical 0000000010003668 p=
rot 3
 ...
+HW revision is 9.0.0.0
+
+Flash autodetection returned: 0xFFFFFFF6
+VendorID: 0xC2C2       DeviceID: 0xA8A8
+
+Boot Failed. Go to the lab !!

Many thanks for fixing this!

Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  include/exec/exec-all.h |  2 --
>  accel/tcg/cputlb.c      | 30 +++++++++---------------------
>  exec.c                  |  6 ------
>  3 files changed, 9 insertions(+), 29 deletions(-)
>=20
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index da73e3bfed2..5f781255826 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -502,8 +502,6 @@ hwaddr memory_region_section_get_iotlb(CPUState *cp=
u,
>                                         hwaddr paddr, hwaddr xlat,
>                                         int prot,
>                                         target_ulong *address);
> -bool memory_region_is_unassigned(MemoryRegion *mr);
> -
>  #endif
> =20
>  /* vl.c */
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 754795ff253..5e5a2a2616c 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -926,10 +926,6 @@ tb_page_addr_t get_page_addr_code(CPUArchState *en=
v, target_ulong addr)
>  {
>      int mmu_idx, index;
>      void *p;
> -    MemoryRegion *mr;
> -    MemoryRegionSection *section;
> -    CPUState *cpu =3D ENV_GET_CPU(env);
> -    CPUIOTLBEntry *iotlbentry;
> =20
>      index =3D (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
>      mmu_idx =3D cpu_mmu_index(env, true);
> @@ -939,29 +935,21 @@ tb_page_addr_t get_page_addr_code(CPUArchState *e=
nv, target_ulong addr)
>          }
>          assert(tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr)=
);
>      }
> +    assert(tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr));
> =20
> -    if (unlikely(env->tlb_table[mmu_idx][index].addr_code & TLB_RECHEC=
K)) {
> +    if (unlikely(env->tlb_table[mmu_idx][index].addr_code &
> +                 (TLB_RECHECK | TLB_MMIO))) {
>          /*
> -         * This is a TLB_RECHECK access, where the MMU protection
> -         * covers a smaller range than a target page. Return -1 to
> -         * indicate that we cannot simply execute from RAM here;
> -         * we will perform the necessary repeat of the MMU check
> -         * when the "execute a single insn" code performs the
> -         * load of the guest insn.
> +         * Return -1 if we can't translate and execute from an entire
> +         * page of RAM here, which will cause us to execute by loading=

> +         * and translating one insn at a time, without caching:
> +         *  - TLB_RECHECK: means the MMU protection covers a smaller r=
ange
> +         *    than a target page, so we must redo the MMU check every =
insn
> +         *  - TLB_MMIO: region is not backed by RAM
>           */
>          return -1;
>      }
> =20
> -    iotlbentry =3D &env->iotlb[mmu_idx][index];
> -    section =3D iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->at=
trs);
> -    mr =3D section->mr;
> -    if (memory_region_is_unassigned(mr)) {
> -        /*
> -         * Not guest RAM, so there is no ram_addr_t for it. Return -1,=

> -         * and we will execute a single insn from this device.
> -         */
> -        return -1;
> -    }
>      p =3D (void *)((uintptr_t)addr + env->tlb_table[mmu_idx][index].ad=
dend);
>      return qemu_ram_addr_from_host_nofail(p);
>  }
> diff --git a/exec.c b/exec.c
> index 4f5df07b6a2..e7be0761c28 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -402,12 +402,6 @@ static MemoryRegionSection *phys_page_find(Address=
SpaceDispatch *d, hwaddr addr)
>      }
>  }
> =20
> -bool memory_region_is_unassigned(MemoryRegion *mr)
> -{
> -    return mr !=3D &io_mem_rom && mr !=3D &io_mem_notdirty && !mr->rom=
_device
> -        && mr !=3D &io_mem_watch;
> -}
> -
>  /* Called from RCU critical section */
>  static MemoryRegionSection *address_space_lookup_region(AddressSpaceDi=
spatch *d,
>                                                          hwaddr addr,
>=20


--EKHNjZKOz9iEYIb2FI2R0ELFI2u3vHs5l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAltK1TMACgkQ4+MsLN6t
wN46zxAAsugLDYzya/xo/NyvhPojipoEgoHZgN2VWPdU8h956e7F2R9t8V7ON8Qn
4ZRGnrJHVoDwsCREnCXc7NXXcH5eQrM9oBs2tnB3FCZt/PEZOBIAoFYdEXfeO8u8
/WoMxGfAC1fIjRbxvca3E0AywKPEnCk/r/WAkMJS/LCtb/PhL2rsKGLeci5io5xR
aGdIkhAmtfX+45mmt4s7Ctich6VQ63XDnpcsjDSGgwFwxNu7ZUP7Ed6yJUZGfssR
uyfjJvZI9udAViAIIv+2Bmb65282dO1m8HaHN0cAa01NFh9A9ADZFYiXlbizQNWq
Liy5k3NN97gbBt8IzLOHOktdkj/1WtwteqrcmtkFzxHbmFYml0qVO3sXm+HrKLXm
o0alt70qtFP8m7KcTYh4uQpbx3YCeZGVJAG4kRXlT+U/+4SDy1OZ+9kVLwSlp1O7
M837dpz4VMuiHjunTBI9jZ+GltSqlR8TzBcF93yGoRuuEYnjxV9fYrhNNW1vXWcz
5RoychollvPsO+K9qKDbjOeFNijkOrRuL+wssiTzrB/1pUB7nLQssvNYbH6mbxLr
Ar4VZEf+FKcypfQX10eV+sbYh1oftxdjy+J4vDS1nP6XcpA0+GAlt4fKZRSEQl6v
QiI9f9FOp/NwiAgDBcu4+kN+f1F2L2SKVOHDjXoeukPt7UPYrK8=
=goC/
-----END PGP SIGNATURE-----

--EKHNjZKOz9iEYIb2FI2R0ELFI2u3vHs5l--
