Received: from eggs.gnu.org ([2001:4830:134:3::10]:51038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e46c8-00059G-2N
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e46c6-0005uE-Rv
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1e46c6-0005tr-LD
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:30 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 16 Oct 2017 16:43:02 +0200
Message-Id: <20171016144302.24284-8-david@redhat.com>
In-Reply-To: <20171016144302.24284-1-david@redhat.com>
References: <20171016144302.24284-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 7/7] memory: reuse section_from_flat_range()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Joe Clifford <joeclifford@gmail.com>, David Hildenbrand <david@redhat.com>

We can use section_from_flat_range() instead of manually initializing.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 memory.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/memory.c b/memory.c
index f39b8592bf..7c8e5878d6 100644
--- a/memory.c
+++ b/memory.c
@@ -2599,14 +2599,8 @@ static void listener_add_address_space(MemoryListener *listener,
 
     view = address_space_get_flatview(as);
     FOR_EACH_FLAT_RANGE(fr, view) {
-        MemoryRegionSection section = {
-            .mr = fr->mr,
-            .fv = view,
-            .offset_within_region = fr->offset_in_region,
-            .size = fr->addr.size,
-            .offset_within_address_space = int128_get64(fr->addr.start),
-            .readonly = fr->readonly,
-        };
+        MemoryRegionSection section = section_from_flat_range(fr, view);
+
         if (listener->region_add) {
             listener->region_add(listener, &section);
         }
-- 
2.13.5
