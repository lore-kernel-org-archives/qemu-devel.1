Received: from eggs.gnu.org ([2001:4830:134:3::10]:60004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSwFb-00024G-Pm
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 23:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSwFY-0005mK-K2
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 23:15:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42256 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fSwFY-0005le-Dy
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 23:15:08 -0400
Date: Wed, 13 Jun 2018 11:15:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180613031501.GF15344@xz-mi>
References: <1528830325-5501-1-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1528830325-5501-1-git-send-email-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] exec: Fix MAP_RAM for cached access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, pbonzini@redhat.com

On Tue, Jun 12, 2018 at 09:05:25PM +0200, Eric Auger wrote:
> When an IOMMUMemoryRegion is in front of a virtio device,
> address_space_cache_init does not set cache->ptr as the memory
> region is not RAM. However when the device performs an access,
> we end up in glue() which performs the translation and then uses
> MAP_RAM. This latter uses the unset ptr and returns a wrong value
> which leads to a SIGSEV in address_space_lduw_internal_cached_slow,
> for instance. Let's test whether the cache->ptr is set, and in
> the negative use the old macro definition. This fixes the
> use cases featuring vIOMMU (Intel and ARM SMMU) which lead to
> a SIGSEV.
> 
> Fixes: 48564041a73a (exec: reintroduce MemoryRegion caching)
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> I am not sure whether it doesn't break any targeted optimization
> but at least it removes the SIGSEV.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  exec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/exec.c b/exec.c
> index f6645ed..46fbd25 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3800,7 +3800,9 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
>  #define SUFFIX                   _cached_slow
>  #define TRANSLATE(...)           address_space_translate_cached(cache, __VA_ARGS__)
>  #define IS_DIRECT(mr, is_write)  memory_access_is_direct(mr, is_write)
> -#define MAP_RAM(mr, ofs)         (cache->ptr + (ofs - cache->xlat))
> +#define MAP_RAM(mr, ofs)         (cache->ptr ? \
> +                                 (cache->ptr + (ofs - cache->xlat)) :  \
> +                                 qemu_map_ram_ptr((mr)->ram_block, ofs))

A pure question: if the MR is not a RAM (I think the only case for
virtio case should be an IOMMU MR), then why we'll call MAP_RAM()
after all?  An glue() example:

void glue(address_space_stb, SUFFIX)(ARG1_DECL,
    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
{
    uint8_t *ptr;
    MemoryRegion *mr;
    hwaddr l = 1;
    hwaddr addr1;
    MemTxResult r;
    bool release_lock = false;

    RCU_READ_LOCK();
    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
    if (!IS_DIRECT(mr, true)) {                <----------------- [1]
        release_lock |= prepare_mmio_access(mr);
        r = memory_region_dispatch_write(mr, addr1, val, 1, attrs);
    } else {
        /* RAM case */
        ptr = MAP_RAM(mr, addr1);
        stb_p(ptr, val);
        INVALIDATE(mr, addr1, 1);
        r = MEMTX_OK;
    }
    if (result) {
        *result = r;
    }
    if (release_lock) {
        qemu_mutex_unlock_iothread();
    }
    RCU_READ_UNLOCK();
}

At [1] we should check first against whether it's direct after all.
AFAIU IOMMU MR should not be direct then it'll go the slow path rather
than calling MAP_RAM()?

Since at it, I have another (pure) question about the address space
cache.  I don't think it's urgent since I think it's never a problem
for virtio, but I'm still asking anyways...

Still taking the stb example:

static inline void address_space_stb_cached(MemoryRegionCache *cache,
    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
{
    assert(addr < cache->len);   <----------------------------- [2]
    if (likely(cache->ptr)) {
        stb_p(cache->ptr + addr, val);
    } else {
        address_space_stb_cached_slow(cache, addr, val, attrs, result);
    }
}

Here at [2] what if the region cached is smaller than provided when
doing address_space_cache_init()?  AFAIU the "len" provided to
address_space_cache_init() can actually shrink (though for virtio it
should never) when do:

    l = len;
    ...
    cache->mrs = *address_space_translate_internal(d, addr, &cache->xlat, &l, true);
    ...
    cache->len = l;

And here not sure whether we should not assert, instead we only run
the fast path if the address falls into the cache region, say:

static inline void address_space_stb_cached(MemoryRegionCache *cache,
    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
{
    if (likely(cache->ptr && addr < cache->len)) {
        stb_p(cache->ptr + addr, val);
    } else {
        address_space_stb_cached_slow(cache, addr, val, attrs, result);
    }
}

Or we should add a check in address_space_cache_init() to make sure
the region won't shrink.

Regards,

-- 
Peter Xu
