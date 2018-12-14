Received: from eggs.gnu.org ([2001:4830:134:3::10]:38224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofW-0008MP-2t
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofV-0004Dy-6l
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:22 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:39393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXofV-0004Bz-0O
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:21 -0500
Received: by mail-wm1-x335.google.com with SMTP id f81so6003055wmd.4
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:42:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id m6sm3263204wrv.24.2018.12.14.06.42.18
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Dec 2018 06:42:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:41:54 +0000
Message-Id: <20181214144214.1260-3-peter.maydell@linaro.org>
In-Reply-To: <20181214144214.1260-1-peter.maydell@linaro.org>
References: <20181214144214.1260-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/22] exec.c: Rename
 cpu_physical_memory_write_rom_internal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Rename cpu_physical_memory_write_rom_internal() to
address_space_write_rom_internal(), and make it take
MemTxAttrs and return a MemTxResult. This brings its
API into line with address_space_write().

This is an internal function to exec.c; fixing its API
will allow us to change the global function
cpu_physical_memory_write_rom().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20181122133507.30950-2-peter.maydell@linaro.org
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
2.19.2
