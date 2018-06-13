Received: from eggs.gnu.org ([2001:4830:134:3::10]:33441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSzf2-0001Ig-Kq
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 02:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSzex-0004Og-LR
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 02:53:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42990 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fSzex-0004OJ-GP
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 02:53:35 -0400
Date: Wed, 13 Jun 2018 14:53:28 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180613065328.GJ15344@xz-mi>
References: <1528830325-5501-1-git-send-email-eric.auger@redhat.com>
	<20180613031501.GF15344@xz-mi>
	<2b2c55a8-6ad4-9039-6f12-fd40100fc539@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b2c55a8-6ad4-9039-6f12-fd40100fc539@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] exec: Fix MAP_RAM for cached access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, eric.auger.pro@gmail.com

On Wed, Jun 13, 2018 at 08:31:31AM +0200, Auger Eric wrote:
> Hi Peter,
> 
> On 06/13/2018 05:15 AM, Peter Xu wrote:
> > On Tue, Jun 12, 2018 at 09:05:25PM +0200, Eric Auger wrote:
> >> When an IOMMUMemoryRegion is in front of a virtio device,
> >> address_space_cache_init does not set cache->ptr as the memory
> >> region is not RAM. However when the device performs an access,
> >> we end up in glue() which performs the translation and then uses
> >> MAP_RAM. This latter uses the unset ptr and returns a wrong value
> >> which leads to a SIGSEV in address_space_lduw_internal_cached_slow,
> >> for instance. Let's test whether the cache->ptr is set, and in
> >> the negative use the old macro definition. This fixes the
> >> use cases featuring vIOMMU (Intel and ARM SMMU) which lead to
> >> a SIGSEV.
> >>
> >> Fixes: 48564041a73a (exec: reintroduce MemoryRegion caching)
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>
> >> ---
> >>
> >> I am not sure whether it doesn't break any targeted optimization
> >> but at least it removes the SIGSEV.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> ---
> >>  exec.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/exec.c b/exec.c
> >> index f6645ed..46fbd25 100644
> >> --- a/exec.c
> >> +++ b/exec.c
> >> @@ -3800,7 +3800,9 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
> >>  #define SUFFIX                   _cached_slow
> >>  #define TRANSLATE(...)           address_space_translate_cached(cache, __VA_ARGS__)
> >>  #define IS_DIRECT(mr, is_write)  memory_access_is_direct(mr, is_write)
> >> -#define MAP_RAM(mr, ofs)         (cache->ptr + (ofs - cache->xlat))
> >> +#define MAP_RAM(mr, ofs)         (cache->ptr ? \
> >> +                                 (cache->ptr + (ofs - cache->xlat)) :  \
> >> +                                 qemu_map_ram_ptr((mr)->ram_block, ofs))
> > 
> > A pure question: if the MR is not a RAM (I think the only case for
> > virtio case should be an IOMMU MR), then why we'll call MAP_RAM()
> > after all?  An glue() example:
> > 
> > void glue(address_space_stb, SUFFIX)(ARG1_DECL,
> >     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
> > {
> >     uint8_t *ptr;
> >     MemoryRegion *mr;
> >     hwaddr l = 1;
> >     hwaddr addr1;
> >     MemTxResult r;
> >     bool release_lock = false;
> > 
> >     RCU_READ_LOCK();
> >     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
> >     if (!IS_DIRECT(mr, true)) {                <----------------- [1]
> after the translate, mr points to the actual RAM region, downstream to
> the IOMMU MR. And this one is direct. addr1 is the offset within the RAM
> region if I am not wrong.
> 
> Am i missing something?

I think you are right. Then the change seems reasonable to me.

Thanks,

-- 
Peter Xu
