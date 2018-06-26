Received: from eggs.gnu.org ([2001:4830:134:3::10]:57472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fXub2-000308-6Z
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 16:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fXuay-0001L8-6G
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 16:29:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40030 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fXuay-0001Kl-09
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 16:29:48 -0400
References: <1528895946-28677-1-git-send-email-eric.auger@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9830d5df-c36d-1bb3-799b-bfe1f7b93b29@redhat.com>
Date: Tue, 26 Jun 2018 22:29:45 +0200
MIME-Version: 1.0
In-Reply-To: <1528895946-28677-1-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] exec: Fix MAP_RAM for cached access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: peterx@redhat.com

Hi,

On 06/13/2018 03:19 PM, Eric Auger wrote:
> When an IOMMUMemoryRegion is in front of a virtio device,
> address_space_cache_init does not set cache->ptr as the memory
> region is not RAM. However when the device performs an access,
> we end up in glue() which performs the translation and then uses
> MAP_RAM. This latter uses the unset ptr and returns a wrong value
> which leads to a SIGSEV in address_space_lduw_internal_cached_slow,
> for instance.
> 
> In slow path cache->ptr is NULL and MAP_RAM must redirect to
> qemu_map_ram_ptr((mr)->ram_block, ofs).
> 
> As MAP_RAM, IS_DIRECT and INVALIDATE are the same in _cached_slow
> and non cached mode, let's remove those macros.
> 
> This fixes the use cases featuring vIOMMU (Intel and ARM SMMU)
> which lead to a SIGSEV.
> 
> Fixes: 48564041a73a (exec: reintroduce MemoryRegion caching)
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

gentle reminder, just to make sure someone is going to pick up this
patch before the freeze ;-) Or please let me know if I miss some concerns.

Thanks

Eric
> 
> ---
> 
> v1 -> v2:
> - directly use qemu_map_ram_ptr in place for MAP_RAM,
>   memory_access_is_direct in place of IS_DIRECT and
>   invalidate_and_set_dirty in place of INVALIDATE. The
>   macros are removed.
> ---
>  exec.c            |  6 ------
>  memory_ldst.inc.c | 47 ++++++++++++++++++++++-------------------------
>  2 files changed, 22 insertions(+), 31 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index f6645ed..f5a7caf 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3660,9 +3660,6 @@ void cpu_physical_memory_unmap(void *buffer, hwaddr len,
>  #define ARG1                     as
>  #define SUFFIX
>  #define TRANSLATE(...)           address_space_translate(as, __VA_ARGS__)
> -#define IS_DIRECT(mr, is_write)  memory_access_is_direct(mr, is_write)
> -#define MAP_RAM(mr, ofs)         qemu_map_ram_ptr((mr)->ram_block, ofs)
> -#define INVALIDATE(mr, ofs, len) invalidate_and_set_dirty(mr, ofs, len)
>  #define RCU_READ_LOCK(...)       rcu_read_lock()
>  #define RCU_READ_UNLOCK(...)     rcu_read_unlock()
>  #include "memory_ldst.inc.c"
> @@ -3799,9 +3796,6 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
>  #define ARG1                     cache
>  #define SUFFIX                   _cached_slow
>  #define TRANSLATE(...)           address_space_translate_cached(cache, __VA_ARGS__)
> -#define IS_DIRECT(mr, is_write)  memory_access_is_direct(mr, is_write)
> -#define MAP_RAM(mr, ofs)         (cache->ptr + (ofs - cache->xlat))
> -#define INVALIDATE(mr, ofs, len) invalidate_and_set_dirty(mr, ofs, len)
>  #define RCU_READ_LOCK()          ((void)0)
>  #define RCU_READ_UNLOCK()        ((void)0)
>  #include "memory_ldst.inc.c"
> diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
> index 1548398..acf865b 100644
> --- a/memory_ldst.inc.c
> +++ b/memory_ldst.inc.c
> @@ -34,7 +34,7 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
>  
>      RCU_READ_LOCK();
>      mr = TRANSLATE(addr, &addr1, &l, false, attrs);
> -    if (l < 4 || !IS_DIRECT(mr, false)) {
> +    if (l < 4 || !memory_access_is_direct(mr, false)) {
>          release_lock |= prepare_mmio_access(mr);
>  
>          /* I/O case */
> @@ -50,7 +50,7 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
>  #endif
>      } else {
>          /* RAM case */
> -        ptr = MAP_RAM(mr, addr1);
> +        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
>          switch (endian) {
>          case DEVICE_LITTLE_ENDIAN:
>              val = ldl_le_p(ptr);
> @@ -110,7 +110,7 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
>  
>      RCU_READ_LOCK();
>      mr = TRANSLATE(addr, &addr1, &l, false, attrs);
> -    if (l < 8 || !IS_DIRECT(mr, false)) {
> +    if (l < 8 || !memory_access_is_direct(mr, false)) {
>          release_lock |= prepare_mmio_access(mr);
>  
>          /* I/O case */
> @@ -126,7 +126,7 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
>  #endif
>      } else {
>          /* RAM case */
> -        ptr = MAP_RAM(mr, addr1);
> +        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
>          switch (endian) {
>          case DEVICE_LITTLE_ENDIAN:
>              val = ldq_le_p(ptr);
> @@ -184,14 +184,14 @@ uint32_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
>  
>      RCU_READ_LOCK();
>      mr = TRANSLATE(addr, &addr1, &l, false, attrs);
> -    if (!IS_DIRECT(mr, false)) {
> +    if (!memory_access_is_direct(mr, false)) {
>          release_lock |= prepare_mmio_access(mr);
>  
>          /* I/O case */
>          r = memory_region_dispatch_read(mr, addr1, &val, 1, attrs);
>      } else {
>          /* RAM case */
> -        ptr = MAP_RAM(mr, addr1);
> +        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
>          val = ldub_p(ptr);
>          r = MEMTX_OK;
>      }
> @@ -220,7 +220,7 @@ static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
>  
>      RCU_READ_LOCK();
>      mr = TRANSLATE(addr, &addr1, &l, false, attrs);
> -    if (l < 2 || !IS_DIRECT(mr, false)) {
> +    if (l < 2 || !memory_access_is_direct(mr, false)) {
>          release_lock |= prepare_mmio_access(mr);
>  
>          /* I/O case */
> @@ -236,7 +236,7 @@ static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
>  #endif
>      } else {
>          /* RAM case */
> -        ptr = MAP_RAM(mr, addr1);
> +        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
>          switch (endian) {
>          case DEVICE_LITTLE_ENDIAN:
>              val = lduw_le_p(ptr);
> @@ -297,12 +297,12 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
>  
>      RCU_READ_LOCK();
>      mr = TRANSLATE(addr, &addr1, &l, true, attrs);
> -    if (l < 4 || !IS_DIRECT(mr, true)) {
> +    if (l < 4 || !memory_access_is_direct(mr, true)) {
>          release_lock |= prepare_mmio_access(mr);
>  
>          r = memory_region_dispatch_write(mr, addr1, val, 4, attrs);
>      } else {
> -        ptr = MAP_RAM(mr, addr1);
> +        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
>          stl_p(ptr, val);
>  
>          dirty_log_mask = memory_region_get_dirty_log_mask(mr);
> @@ -334,7 +334,7 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
>  
>      RCU_READ_LOCK();
>      mr = TRANSLATE(addr, &addr1, &l, true, attrs);
> -    if (l < 4 || !IS_DIRECT(mr, true)) {
> +    if (l < 4 || !memory_access_is_direct(mr, true)) {
>          release_lock |= prepare_mmio_access(mr);
>  
>  #if defined(TARGET_WORDS_BIGENDIAN)
> @@ -349,7 +349,7 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
>          r = memory_region_dispatch_write(mr, addr1, val, 4, attrs);
>      } else {
>          /* RAM case */
> -        ptr = MAP_RAM(mr, addr1);
> +        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
>          switch (endian) {
>          case DEVICE_LITTLE_ENDIAN:
>              stl_le_p(ptr, val);
> @@ -361,7 +361,7 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
>              stl_p(ptr, val);
>              break;
>          }
> -        INVALIDATE(mr, addr1, 4);
> +        invalidate_and_set_dirty(mr, addr1, 4);
>          r = MEMTX_OK;
>      }
>      if (result) {
> @@ -406,14 +406,14 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL,
>  
>      RCU_READ_LOCK();
>      mr = TRANSLATE(addr, &addr1, &l, true, attrs);
> -    if (!IS_DIRECT(mr, true)) {
> +    if (!memory_access_is_direct(mr, true)) {
>          release_lock |= prepare_mmio_access(mr);
>          r = memory_region_dispatch_write(mr, addr1, val, 1, attrs);
>      } else {
>          /* RAM case */
> -        ptr = MAP_RAM(mr, addr1);
> +        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
>          stb_p(ptr, val);
> -        INVALIDATE(mr, addr1, 1);
> +        invalidate_and_set_dirty(mr, addr1, 1);
>          r = MEMTX_OK;
>      }
>      if (result) {
> @@ -439,7 +439,7 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
>  
>      RCU_READ_LOCK();
>      mr = TRANSLATE(addr, &addr1, &l, true, attrs);
> -    if (l < 2 || !IS_DIRECT(mr, true)) {
> +    if (l < 2 || !memory_access_is_direct(mr, true)) {
>          release_lock |= prepare_mmio_access(mr);
>  
>  #if defined(TARGET_WORDS_BIGENDIAN)
> @@ -454,7 +454,7 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
>          r = memory_region_dispatch_write(mr, addr1, val, 2, attrs);
>      } else {
>          /* RAM case */
> -        ptr = MAP_RAM(mr, addr1);
> +        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
>          switch (endian) {
>          case DEVICE_LITTLE_ENDIAN:
>              stw_le_p(ptr, val);
> @@ -466,7 +466,7 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
>              stw_p(ptr, val);
>              break;
>          }
> -        INVALIDATE(mr, addr1, 2);
> +        invalidate_and_set_dirty(mr, addr1, 2);
>          r = MEMTX_OK;
>      }
>      if (result) {
> @@ -512,7 +512,7 @@ static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
>  
>      RCU_READ_LOCK();
>      mr = TRANSLATE(addr, &addr1, &l, true, attrs);
> -    if (l < 8 || !IS_DIRECT(mr, true)) {
> +    if (l < 8 || !memory_access_is_direct(mr, true)) {
>          release_lock |= prepare_mmio_access(mr);
>  
>  #if defined(TARGET_WORDS_BIGENDIAN)
> @@ -527,7 +527,7 @@ static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
>          r = memory_region_dispatch_write(mr, addr1, val, 8, attrs);
>      } else {
>          /* RAM case */
> -        ptr = MAP_RAM(mr, addr1);
> +        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
>          switch (endian) {
>          case DEVICE_LITTLE_ENDIAN:
>              stq_le_p(ptr, val);
> @@ -539,7 +539,7 @@ static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
>              stq_p(ptr, val);
>              break;
>          }
> -        INVALIDATE(mr, addr1, 8);
> +        invalidate_and_set_dirty(mr, addr1, 8);
>          r = MEMTX_OK;
>      }
>      if (result) {
> @@ -576,8 +576,5 @@ void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
>  #undef ARG1
>  #undef SUFFIX
>  #undef TRANSLATE
> -#undef IS_DIRECT
> -#undef MAP_RAM
> -#undef INVALIDATE
>  #undef RCU_READ_LOCK
>  #undef RCU_READ_UNLOCK
> 
