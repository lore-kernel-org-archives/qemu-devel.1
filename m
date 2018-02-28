Received: from eggs.gnu.org ([2001:4830:134:3::10]:55287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqw8N-0004oF-Co
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqw8M-0000Ri-AU
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:26:39 -0500
Received: from mga02.intel.com ([134.134.136.20]:30637)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eqw8L-0000CT-Us
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:26:38 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Wed, 28 Feb 2018 15:25:58 +0800
Message-Id: <20180228072558.7434-9-haozhong.zhang@intel.com>
In-Reply-To: <20180228072558.7434-1-haozhong.zhang@intel.com>
References: <20180228072558.7434-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v4 8/8] migration/ram: ensure write persistence
 on loading xbzrle pages to PMEM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, dgilbert@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

When loading a xbzrle encoded page to persistent memory, load the data
via libpmem function pmem_memcpy_nodrain() instead of memcpy().
Combined with a call to pmem_drain() at the end of memory loading, we
can guarantee those xbzrle encoded pages are persistently loaded to PMEM.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 migration/ram.c        | 6 +++---
 migration/xbzrle.c     | 8 ++++++--
 migration/xbzrle.h     | 3 ++-
 tests/Makefile.include | 2 +-
 tests/test-xbzrle.c    | 4 ++--
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 37f3c39cee..70b196c4f5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2391,7 +2391,7 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
     }
 }
 
-static int load_xbzrle(QEMUFile *f, ram_addr_t addr, void *host)
+static int load_xbzrle(QEMUFile *f, ram_addr_t addr, void *host, bool is_pmem)
 {
     unsigned int xh_len;
     int xh_flags;
@@ -2417,7 +2417,7 @@ static int load_xbzrle(QEMUFile *f, ram_addr_t addr, void *host)
 
     /* decode RLE */
     if (xbzrle_decode_buffer(loaded_data, xh_len, host,
-                             TARGET_PAGE_SIZE) == -1) {
+                             TARGET_PAGE_SIZE, is_pmem) == -1) {
         error_report("Failed to load XBZRLE page - decode error!");
         return -1;
     }
@@ -2979,7 +2979,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
             break;
 
         case RAM_SAVE_FLAG_XBZRLE:
-            if (load_xbzrle(f, addr, host) < 0) {
+            if (load_xbzrle(f, addr, host, is_pmem) < 0) {
                 error_report("Failed to decompress XBZRLE page at "
                              RAM_ADDR_FMT, addr);
                 ret = -EINVAL;
diff --git a/migration/xbzrle.c b/migration/xbzrle.c
index 1ba482ded9..ca713c3697 100644
--- a/migration/xbzrle.c
+++ b/migration/xbzrle.c
@@ -12,6 +12,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/pmem.h"
 #include "xbzrle.h"
 
 /*
@@ -126,11 +127,14 @@ int xbzrle_encode_buffer(uint8_t *old_buf, uint8_t *new_buf, int slen,
     return d;
 }
 
-int xbzrle_decode_buffer(uint8_t *src, int slen, uint8_t *dst, int dlen)
+int xbzrle_decode_buffer(uint8_t *src, int slen, uint8_t *dst, int dlen,
+                         bool is_pmem)
 {
     int i = 0, d = 0;
     int ret;
     uint32_t count = 0;
+    void *(*memcpy_func)(void *d, const void *s, size_t n) =
+        is_pmem ? pmem_memcpy_nodrain : memcpy;
 
     while (i < slen) {
 
@@ -167,7 +171,7 @@ int xbzrle_decode_buffer(uint8_t *src, int slen, uint8_t *dst, int dlen)
             return -1;
         }
 
-        memcpy(dst + d, src + i, count);
+        memcpy_func(dst + d, src + i, count);
         d += count;
         i += count;
     }
diff --git a/migration/xbzrle.h b/migration/xbzrle.h
index a0db507b9c..f18f679f47 100644
--- a/migration/xbzrle.h
+++ b/migration/xbzrle.h
@@ -17,5 +17,6 @@
 int xbzrle_encode_buffer(uint8_t *old_buf, uint8_t *new_buf, int slen,
                          uint8_t *dst, int dlen);
 
-int xbzrle_decode_buffer(uint8_t *src, int slen, uint8_t *dst, int dlen);
+int xbzrle_decode_buffer(uint8_t *src, int slen, uint8_t *dst, int dlen,
+                         bool is_pmem);
 #endif
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 37bb85f591..be5b7e484b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -616,7 +616,7 @@ tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj-y)
 tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
 tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(test-crypto-obj-y)
 tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
-tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migration/page_cache.o $(test-util-obj-y)
+tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migration/page_cache.o stubs/pmem.o $(test-util-obj-y)
 tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o $(test-util-obj-y)
 tests/test-int128$(EXESUF): tests/test-int128.o
 tests/rcutorture$(EXESUF): tests/rcutorture.o $(test-util-obj-y)
diff --git a/tests/test-xbzrle.c b/tests/test-xbzrle.c
index f5e08de91e..9afa0c4bcb 100644
--- a/tests/test-xbzrle.c
+++ b/tests/test-xbzrle.c
@@ -101,7 +101,7 @@ static void test_encode_decode_1_byte(void)
                        PAGE_SIZE);
     g_assert(dlen == (uleb128_encode_small(&buf[0], 4095) + 2));
 
-    rc = xbzrle_decode_buffer(compressed, dlen, buffer, PAGE_SIZE);
+    rc = xbzrle_decode_buffer(compressed, dlen, buffer, PAGE_SIZE, false);
     g_assert(rc == PAGE_SIZE);
     g_assert(memcmp(test, buffer, PAGE_SIZE) == 0);
 
@@ -156,7 +156,7 @@ static void encode_decode_range(void)
     dlen = xbzrle_encode_buffer(test, buffer, PAGE_SIZE, compressed,
                                 PAGE_SIZE);
 
-    rc = xbzrle_decode_buffer(compressed, dlen, test, PAGE_SIZE);
+    rc = xbzrle_decode_buffer(compressed, dlen, test, PAGE_SIZE, false);
     g_assert(rc < PAGE_SIZE);
     g_assert(memcmp(test, buffer, PAGE_SIZE) == 0);
 
-- 
2.14.1
