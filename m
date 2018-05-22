Received: from eggs.gnu.org ([2001:4830:134:3::10]:40640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL4r6-0007Y3-3i
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL4r3-0000ye-0t
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:49:24 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:32982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fL4r2-0000y0-MZ
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:49:20 -0400
Received: by mail-wr0-x244.google.com with SMTP id a15-v6so12016348wrm.0
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 03:49:20 -0700 (PDT)
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-4-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180521140402.23318-4-peter.maydell@linaro.org>
Date: Tue, 22 May 2018 11:49:17 +0100
Message-ID: <87lgccufrm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/27] Make address_space_translate{,
 _cached}() take a MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> As part of plumbing MemTxAttrs down to the IOMMU translate method,
> add MemTxAttrs as an argument to address_space_translate()
> and address_space_translate_cached(). Callers either have an
> attrs value to hand, or don't care and can use MEMTXATTRS_UNSPECIFIED.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Following the chain down I discovered yet another set of not quite
templates leading to the bottom, but not this patches fault...

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/memory.h     |  4 +++-
>  accel/tcg/translate-all.c |  2 +-
>  exec.c                    | 14 +++++++++-----
>  hw/vfio/common.c          |  3 ++-
>  memory_ldst.inc.c         | 18 +++++++++---------
>  target/riscv/helper.c     |  2 +-
>  6 files changed, 25 insertions(+), 18 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index cce355d2d8..9a30a1bb9e 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1908,6 +1908,7 @@ IOMMUTLBEntry address_space_get_iotlb_entry(Address=
Space *as, hwaddr addr,
>   * #MemoryRegion.
>   * @len: pointer to length
>   * @is_write: indicates the transfer direction
> + * @attrs: memory attributes
>   */
>  MemoryRegion *flatview_translate(FlatView *fv,
>                                   hwaddr addr, hwaddr *xlat,
> @@ -1915,7 +1916,8 @@ MemoryRegion *flatview_translate(FlatView *fv,
>
>  static inline MemoryRegion *address_space_translate(AddressSpace *as,
>                                                      hwaddr addr, hwaddr =
*xlat,
> -                                                    hwaddr *len, bool is=
_write)
> +                                                    hwaddr *len, bool is=
_write,
> +                                                    MemTxAttrs attrs)
>  {
>      return flatview_translate(address_space_to_flatview(as),
>                                addr, xlat, len, is_write);
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index f04a922ef7..52f7bd59a9 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1679,7 +1679,7 @@ void tb_invalidate_phys_addr(AddressSpace *as, hwad=
dr addr, MemTxAttrs attrs)
>      hwaddr l =3D 1;
>
>      rcu_read_lock();
> -    mr =3D address_space_translate(as, addr, &addr, &l, false);
> +    mr =3D address_space_translate(as, addr, &addr, &l, false, attrs);
>      if (!(memory_region_is_ram(mr)
>            || memory_region_is_romd(mr))) {
>          rcu_read_unlock();
> diff --git a/exec.c b/exec.c
> index c3a197e67b..d314c7cc39 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3322,7 +3322,8 @@ static inline void cpu_physical_memory_write_rom_in=
ternal(AddressSpace *as,
>      rcu_read_lock();
>      while (len > 0) {
>          l =3D len;
> -        mr =3D address_space_translate(as, addr, &addr1, &l, true);
> +        mr =3D address_space_translate(as, addr, &addr1, &l, true,
> +                                     MEMTXATTRS_UNSPECIFIED);
>
>          if (!(memory_region_is_ram(mr) ||
>                memory_region_is_romd(mr))) {
> @@ -3699,7 +3700,7 @@ void address_space_cache_destroy(MemoryRegionCache =
*cache)
>   */
>  static inline MemoryRegion *address_space_translate_cached(
>      MemoryRegionCache *cache, hwaddr addr, hwaddr *xlat,
> -    hwaddr *plen, bool is_write)
> +    hwaddr *plen, bool is_write, MemTxAttrs attrs)
>  {
>      MemoryRegionSection section;
>      MemoryRegion *mr;
> @@ -3733,7 +3734,8 @@ address_space_read_cached_slow(MemoryRegionCache *c=
ache, hwaddr addr,
>      MemoryRegion *mr;
>
>      l =3D len;
> -    mr =3D address_space_translate_cached(cache, addr, &addr1, &l, false=
);
> +    mr =3D address_space_translate_cached(cache, addr, &addr1, &l, false,
> +                                        MEMTXATTRS_UNSPECIFIED);
>      flatview_read_continue(cache->fv,
>                             addr, MEMTXATTRS_UNSPECIFIED, buf, len,
>                             addr1, l, mr);
> @@ -3750,7 +3752,8 @@ address_space_write_cached_slow(MemoryRegionCache *=
cache, hwaddr addr,
>      MemoryRegion *mr;
>
>      l =3D len;
> -    mr =3D address_space_translate_cached(cache, addr, &addr1, &l, true);
> +    mr =3D address_space_translate_cached(cache, addr, &addr1, &l, true,
> +                                        MEMTXATTRS_UNSPECIFIED);
>      flatview_write_continue(cache->fv,
>                              addr, MEMTXATTRS_UNSPECIFIED, buf, len,
>                              addr1, l, mr);
> @@ -3848,7 +3851,8 @@ bool cpu_physical_memory_is_io(hwaddr phys_addr)
>
>      rcu_read_lock();
>      mr =3D address_space_translate(&address_space_memory,
> -                                 phys_addr, &phys_addr, &l, false);
> +                                 phys_addr, &phys_addr, &l, false,
> +                                 MEMTXATTRS_UNSPECIFIED);
>
>      res =3D !(memory_region_is_ram(mr) || memory_region_is_romd(mr));
>      rcu_read_unlock();
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 07ffa0ba10..8e57265edf 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -324,7 +324,8 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void=
 **vaddr,
>       */
>      mr =3D address_space_translate(&address_space_memory,
>                                   iotlb->translated_addr,
> -                                 &xlat, &len, writable);
> +                                 &xlat, &len, writable,
> +                                 MEMTXATTRS_UNSPECIFIED);
>      if (!memory_region_is_ram(mr)) {
>          error_report("iommu map to non memory area %"HWADDR_PRIx"",
>                       xlat);
> diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
> index 25d6125747..15483987fe 100644
> --- a/memory_ldst.inc.c
> +++ b/memory_ldst.inc.c
> @@ -33,7 +33,7 @@ static inline uint32_t glue(address_space_ldl_internal,=
 SUFFIX)(ARG1_DECL,
>      bool release_lock =3D false;
>
>      RCU_READ_LOCK();
> -    mr =3D TRANSLATE(addr, &addr1, &l, false);
> +    mr =3D TRANSLATE(addr, &addr1, &l, false, attrs);
>      if (l < 4 || !IS_DIRECT(mr, false)) {
>          release_lock |=3D prepare_mmio_access(mr);
>
> @@ -109,7 +109,7 @@ static inline uint64_t glue(address_space_ldq_interna=
l, SUFFIX)(ARG1_DECL,
>      bool release_lock =3D false;
>
>      RCU_READ_LOCK();
> -    mr =3D TRANSLATE(addr, &addr1, &l, false);
> +    mr =3D TRANSLATE(addr, &addr1, &l, false, attrs);
>      if (l < 8 || !IS_DIRECT(mr, false)) {
>          release_lock |=3D prepare_mmio_access(mr);
>
> @@ -183,7 +183,7 @@ uint32_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
>      bool release_lock =3D false;
>
>      RCU_READ_LOCK();
> -    mr =3D TRANSLATE(addr, &addr1, &l, false);
> +    mr =3D TRANSLATE(addr, &addr1, &l, false, attrs);
>      if (!IS_DIRECT(mr, false)) {
>          release_lock |=3D prepare_mmio_access(mr);
>
> @@ -219,7 +219,7 @@ static inline uint32_t glue(address_space_lduw_intern=
al, SUFFIX)(ARG1_DECL,
>      bool release_lock =3D false;
>
>      RCU_READ_LOCK();
> -    mr =3D TRANSLATE(addr, &addr1, &l, false);
> +    mr =3D TRANSLATE(addr, &addr1, &l, false, attrs);
>      if (l < 2 || !IS_DIRECT(mr, false)) {
>          release_lock |=3D prepare_mmio_access(mr);
>
> @@ -296,7 +296,7 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DE=
CL,
>      bool release_lock =3D false;
>
>      RCU_READ_LOCK();
> -    mr =3D TRANSLATE(addr, &addr1, &l, true);
> +    mr =3D TRANSLATE(addr, &addr1, &l, true, attrs);
>      if (l < 4 || !IS_DIRECT(mr, true)) {
>          release_lock |=3D prepare_mmio_access(mr);
>
> @@ -333,7 +333,7 @@ static inline void glue(address_space_stl_internal, S=
UFFIX)(ARG1_DECL,
>      bool release_lock =3D false;
>
>      RCU_READ_LOCK();
> -    mr =3D TRANSLATE(addr, &addr1, &l, true);
> +    mr =3D TRANSLATE(addr, &addr1, &l, true, attrs);
>      if (l < 4 || !IS_DIRECT(mr, true)) {
>          release_lock |=3D prepare_mmio_access(mr);
>
> @@ -405,7 +405,7 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL,
>      bool release_lock =3D false;
>
>      RCU_READ_LOCK();
> -    mr =3D TRANSLATE(addr, &addr1, &l, true);
> +    mr =3D TRANSLATE(addr, &addr1, &l, true, attrs);
>      if (!IS_DIRECT(mr, true)) {
>          release_lock |=3D prepare_mmio_access(mr);
>          r =3D memory_region_dispatch_write(mr, addr1, val, 1, attrs);
> @@ -438,7 +438,7 @@ static inline void glue(address_space_stw_internal, S=
UFFIX)(ARG1_DECL,
>      bool release_lock =3D false;
>
>      RCU_READ_LOCK();
> -    mr =3D TRANSLATE(addr, &addr1, &l, true);
> +    mr =3D TRANSLATE(addr, &addr1, &l, true, attrs);
>      if (l < 2 || !IS_DIRECT(mr, true)) {
>          release_lock |=3D prepare_mmio_access(mr);
>
> @@ -511,7 +511,7 @@ static void glue(address_space_stq_internal, SUFFIX)(=
ARG1_DECL,
>      bool release_lock =3D false;
>
>      RCU_READ_LOCK();
> -    mr =3D TRANSLATE(addr, &addr1, &l, true);
> +    mr =3D TRANSLATE(addr, &addr1, &l, true, attrs);
>      if (l < 8 || !IS_DIRECT(mr, true)) {
>          release_lock |=3D prepare_mmio_access(mr);
>
> diff --git a/target/riscv/helper.c b/target/riscv/helper.c
> index 95889f23b9..29e1a603dc 100644
> --- a/target/riscv/helper.c
> +++ b/target/riscv/helper.c
> @@ -210,7 +210,7 @@ restart:
>                  MemoryRegion *mr;
>                  hwaddr l =3D sizeof(target_ulong), addr1;
>                  mr =3D address_space_translate(cs->as, pte_addr,
> -                    &addr1, &l, false);
> +                    &addr1, &l, false, MEMTXATTRS_UNSPECIFIED);
>                  if (memory_access_is_direct(mr, true)) {
>                      target_ulong *pte_pa =3D
>                          qemu_map_ram_ptr(mr->ram_block, addr1);


--
Alex Benn=C3=A9e
