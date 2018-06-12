Received: from eggs.gnu.org ([2001:4830:134:3::10]:34366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fSobq-0006YH-E8
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 15:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fSobn-0001KH-3t
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 15:05:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45892 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fSobn-0001Jf-0F
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 15:05:35 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 12 Jun 2018 21:05:25 +0200
Message-Id: <1528830325-5501-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH] exec: Fix MAP_RAM for cached access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: peterx@redhat.com

When an IOMMUMemoryRegion is in front of a virtio device,
address_space_cache_init does not set cache->ptr as the memory
region is not RAM. However when the device performs an access,
we end up in glue() which performs the translation and then uses
MAP_RAM. This latter uses the unset ptr and returns a wrong value
which leads to a SIGSEV in address_space_lduw_internal_cached_slow,
for instance. Let's test whether the cache->ptr is set, and in
the negative use the old macro definition. This fixes the
use cases featuring vIOMMU (Intel and ARM SMMU) which lead to
a SIGSEV.

Fixes: 48564041a73a (exec: reintroduce MemoryRegion caching)
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

I am not sure whether it doesn't break any targeted optimization
but at least it removes the SIGSEV.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 exec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index f6645ed..46fbd25 100644
--- a/exec.c
+++ b/exec.c
@@ -3800,7 +3800,9 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
 #define SUFFIX                   _cached_slow
 #define TRANSLATE(...)           address_space_translate_cached(cache, __VA_ARGS__)
 #define IS_DIRECT(mr, is_write)  memory_access_is_direct(mr, is_write)
-#define MAP_RAM(mr, ofs)         (cache->ptr + (ofs - cache->xlat))
+#define MAP_RAM(mr, ofs)         (cache->ptr ? \
+                                 (cache->ptr + (ofs - cache->xlat)) :  \
+                                 qemu_map_ram_ptr((mr)->ram_block, ofs))
 #define INVALIDATE(mr, ofs, len) invalidate_and_set_dirty(mr, ofs, len)
 #define RCU_READ_LOCK()          ((void)0)
 #define RCU_READ_UNLOCK()        ((void)0)
-- 
2.5.5
