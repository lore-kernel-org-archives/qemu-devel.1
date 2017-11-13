Received: from eggs.gnu.org ([2001:4830:134:3::10]:58572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eEHOC-0003wc-CU
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:15:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eEHO6-0008VN-K9
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:15:12 -0500
Received: from relay2.gtri.gatech.edu ([130.207.199.168]:50325)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eEHO6-0008UW-E9
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:15:06 -0500
From: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
Date: Mon, 13 Nov 2017 11:14:45 -0500
Message-ID: <20171113161446.2862-2-michael.nawrocki@gtri.gatech.edu>
In-Reply-To: <20171113161446.2862-1-michael.nawrocki@gtri.gatech.edu>
References: <20171113161446.2862-1-michael.nawrocki@gtri.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 1/3] Switch AMD CFI flash to use new MMIO API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>

Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
---
 hw/block/pflash_cfi02.c | 97 +++++++++----------------------------------------
 1 file changed, 18 insertions(+), 79 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index c81ddd3a99..a81df913f6 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -138,12 +138,12 @@ static void pflash_timer (void *opaque)
     pfl->cmd = 0;
 }
 
-static uint32_t pflash_read (pflash_t *pfl, hwaddr offset,
-                             int width, int be)
+static uint64_t pflash_read(pflash_t *pfl, hwaddr offset,
+                            int width, int be)
 {
     hwaddr boff;
-    uint32_t ret;
     uint8_t *p;
+    uint64_t ret;
 
     DPRINTF("%s: offset " TARGET_FMT_plx "\n", __func__, offset);
     ret = -1;
@@ -261,7 +261,7 @@ static void pflash_update(pflash_t *pfl, int offset,
 }
 
 static void pflash_write (pflash_t *pfl, hwaddr offset,
-                          uint32_t value, int width, int be)
+                          uint64_t value, int width, int be)
 {
     hwaddr boff;
     uint8_t *p;
@@ -494,102 +494,41 @@ static void pflash_write (pflash_t *pfl, hwaddr offset,
     pfl->cmd = 0;
 }
 
-
-static uint32_t pflash_readb_be(void *opaque, hwaddr addr)
-{
-    return pflash_read(opaque, addr, 1, 1);
-}
-
-static uint32_t pflash_readb_le(void *opaque, hwaddr addr)
-{
-    return pflash_read(opaque, addr, 1, 0);
-}
-
-static uint32_t pflash_readw_be(void *opaque, hwaddr addr)
+static uint64_t pflash_read_le(void *opaque, hwaddr addr, unsigned size)
 {
     pflash_t *pfl = opaque;
-
-    return pflash_read(pfl, addr, 2, 1);
+    return pflash_read(pfl, addr, size, 0);
 }
 
-static uint32_t pflash_readw_le(void *opaque, hwaddr addr)
+static uint64_t pflash_read_be(void *opaque, hwaddr addr, unsigned size)
 {
     pflash_t *pfl = opaque;
-
-    return pflash_read(pfl, addr, 2, 0);
+    return pflash_read(pfl, addr, size, 1);
 }
 
-static uint32_t pflash_readl_be(void *opaque, hwaddr addr)
+static void pflash_write_le(void *opaque, hwaddr addr, uint64_t data,
+                            unsigned size)
 {
     pflash_t *pfl = opaque;
-
-    return pflash_read(pfl, addr, 4, 1);
+    pflash_write(pfl, addr, data, size, 0);
 }
 
-static uint32_t pflash_readl_le(void *opaque, hwaddr addr)
+static void pflash_write_be(void *opaque, hwaddr addr, uint64_t data,
+                            unsigned size)
 {
     pflash_t *pfl = opaque;
-
-    return pflash_read(pfl, addr, 4, 0);
-}
-
-static void pflash_writeb_be(void *opaque, hwaddr addr,
-                             uint32_t value)
-{
-    pflash_write(opaque, addr, value, 1, 1);
-}
-
-static void pflash_writeb_le(void *opaque, hwaddr addr,
-                             uint32_t value)
-{
-    pflash_write(opaque, addr, value, 1, 0);
-}
-
-static void pflash_writew_be(void *opaque, hwaddr addr,
-                             uint32_t value)
-{
-    pflash_t *pfl = opaque;
-
-    pflash_write(pfl, addr, value, 2, 1);
-}
-
-static void pflash_writew_le(void *opaque, hwaddr addr,
-                             uint32_t value)
-{
-    pflash_t *pfl = opaque;
-
-    pflash_write(pfl, addr, value, 2, 0);
-}
-
-static void pflash_writel_be(void *opaque, hwaddr addr,
-                             uint32_t value)
-{
-    pflash_t *pfl = opaque;
-
-    pflash_write(pfl, addr, value, 4, 1);
-}
-
-static void pflash_writel_le(void *opaque, hwaddr addr,
-                             uint32_t value)
-{
-    pflash_t *pfl = opaque;
-
-    pflash_write(pfl, addr, value, 4, 0);
+    pflash_write(pfl, addr, data, size, 1);
 }
 
 static const MemoryRegionOps pflash_cfi02_ops_be = {
-    .old_mmio = {
-        .read = { pflash_readb_be, pflash_readw_be, pflash_readl_be, },
-        .write = { pflash_writeb_be, pflash_writew_be, pflash_writel_be, },
-    },
+    .read = pflash_read_be,
+    .write = pflash_write_be,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
 static const MemoryRegionOps pflash_cfi02_ops_le = {
-    .old_mmio = {
-        .read = { pflash_readb_le, pflash_readw_le, pflash_readl_le, },
-        .write = { pflash_writeb_le, pflash_writew_le, pflash_writel_le, },
-    },
+    .read = pflash_read_le,
+    .write = pflash_write_le,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.14.2
