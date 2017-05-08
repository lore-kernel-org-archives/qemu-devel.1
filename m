Received: from eggs.gnu.org ([2001:4830:134:3::10]:36112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d7dCj-0003q5-3y
	for qemu-devel@nongnu.org; Mon, 08 May 2017 03:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d7dCf-0005h2-5U
	for qemu-devel@nongnu.org; Mon, 08 May 2017 03:35:37 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  8 May 2017 09:35:29 +0200
Message-Id: <20170508073529.23449-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] xtensa: use g_malloc/g_new/g_free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-trivial@nongnu.org

Replace malloc/free with g_malloc/g_free to get a program exit on
out of memory.

Replace g_malloc with g_new when allocating the MemoryRegion to
get more type safety.

Reported by Coverity.

Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-trivial@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/xtensa/sim.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index d2d1d3a6fd..97307728f7 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -41,13 +41,13 @@ static void xtensa_create_memory_regions(const XtensaMemory *memory,
                                          const char *name)
 {
     unsigned i;
-    char *num_name = malloc(strlen(name) + sizeof(i) * 3 + 1);
+    char *num_name = g_malloc(strlen(name) + sizeof(i) * 3 + 1);
 
     for (i = 0; i < memory->num; ++i) {
         MemoryRegion *m;
 
         sprintf(num_name, "%s%u", name, i);
-        m = g_malloc(sizeof(*m));
+        m = g_new(MemoryRegion, 1);
         memory_region_init_ram(m, NULL, num_name,
                                memory->location[i].size,
                                &error_fatal);
@@ -55,7 +55,7 @@ static void xtensa_create_memory_regions(const XtensaMemory *memory,
         memory_region_add_subregion(get_system_memory(),
                                     memory->location[i].addr, m);
     }
-    free(num_name);
+    g_free(num_name);
 }
 
 static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
-- 
2.12.2
