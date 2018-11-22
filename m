Received: from eggs.gnu.org ([2001:4830:134:3::10]:51868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gPp8c-0007vU-7p
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:35:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gPp8a-0001hP-6s
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:35:22 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Nov 2018 13:35:06 +0000
Message-Id: <20181122133507.30950-2-peter.maydell@linaro.org>
In-Reply-To: <20181122133507.30950-1-peter.maydell@linaro.org>
References: <20181122133507.30950-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-4.0 1/2] exec.c: Rename
 cpu_physical_memory_write_rom_internal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

Rename cpu_physical_memory_write_rom_internal() to
address_space_write_rom_internal(), and make it take
MemTxAttrs and return a MemTxResult. This brings its
API into line with address_space_write().

This is an internal function to exec.c; fixing its API
will allow us to change the global function
cpu_physical_memory_write_rom().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 exec.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/exec.c b/exec.c
index bb6170dbffe..92679508ba3 100644
--- a/exec.c
+++ b/exec.c
@@ -3388,8 +3388,12 @@ enum write_rom_type {
     FLUSH_CACHE,
 };
 
-static inline void cpu_physical_memory_write_rom_internal(AddressSpace *as,
-    hwaddr addr, const uint8_t *buf, int len, enum write_rom_type type)
+static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
+                                                           hwaddr addr,
+                                                           MemTxAttrs attrs,
+                                                           const uint8_t *buf,
+                                                           int len,
+                                                           enum write_rom_type type)
 {
     hwaddr l;
     uint8_t *ptr;
@@ -3399,8 +3403,7 @@ static inline void cpu_physical_memory_write_rom_internal(AddressSpace *as,
     rcu_read_lock();
     while (len > 0) {
         l = len;
-        mr = address_space_translate(as, addr, &addr1, &l, true,
-                                     MEMTXATTRS_UNSPECIFIED);
+        mr = address_space_translate(as, addr, &addr1, &l, true, attrs);
 
         if (!(memory_region_is_ram(mr) ||
               memory_region_is_romd(mr))) {
@@ -3423,13 +3426,15 @@ static inline void cpu_physical_memory_write_rom_internal(AddressSpace *as,
         addr += l;
     }
     rcu_read_unlock();
+    return MEMTX_OK;
 }
 
 /* used for ROM loading : can write in RAM and ROM */
 void cpu_physical_memory_write_rom(AddressSpace *as, hwaddr addr,
                                    const uint8_t *buf, int len)
 {
-    cpu_physical_memory_write_rom_internal(as, addr, buf, len, WRITE_DATA);
+    address_space_write_rom_internal(as, addr, MEMTXATTRS_UNSPECIFIED,
+                                     buf, len, WRITE_DATA);
 }
 
 void cpu_flush_icache_range(hwaddr start, int len)
@@ -3444,8 +3449,9 @@ void cpu_flush_icache_range(hwaddr start, int len)
         return;
     }
 
-    cpu_physical_memory_write_rom_internal(&address_space_memory,
-                                           start, NULL, len, FLUSH_CACHE);
+    address_space_write_rom_internal(&address_space_memory,
+                                     start, MEMTXATTRS_UNSPECIFIED,
+                                     NULL, len, FLUSH_CACHE);
 }
 
 typedef struct {
-- 
2.19.1
