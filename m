Received: from eggs.gnu.org ([2001:4830:134:3::10]:60380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1d7myF-0006Ih-LR
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1d7myA-0003vD-Rn
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:01:19 -0400
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon,  8 May 2017 11:00:56 -0700
Message-Id: <1494266456-2251-1-git-send-email-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/xtensa: sim: use g_string/g_new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>

Replace malloc/free/sprintf with g_string/g_string_printf/g_string_free.
Replace g_malloc with g_new when allocating the MemoryRegion to get more
type safety.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 hw/xtensa/sim.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index d2d1d3a..b27e28d 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -41,21 +41,21 @@ static void xtensa_create_memory_regions(const XtensaMemory *memory,
                                          const char *name)
 {
     unsigned i;
-    char *num_name = malloc(strlen(name) + sizeof(i) * 3 + 1);
+    GString *num_name = g_string_new(NULL);
 
     for (i = 0; i < memory->num; ++i) {
         MemoryRegion *m;
 
-        sprintf(num_name, "%s%u", name, i);
-        m = g_malloc(sizeof(*m));
-        memory_region_init_ram(m, NULL, num_name,
+        g_string_printf(num_name, "%s%u", name, i);
+        m = g_new(MemoryRegion, 1);
+        memory_region_init_ram(m, NULL, num_name->str,
                                memory->location[i].size,
                                &error_fatal);
         vmstate_register_ram_global(m);
         memory_region_add_subregion(get_system_memory(),
                                     memory->location[i].addr, m);
     }
-    free(num_name);
+    g_string_free(num_name, true);
 }
 
 static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
-- 
2.1.4
