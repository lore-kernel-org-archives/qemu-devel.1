Received: from eggs.gnu.org ([2001:4830:134:3::10]:60636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aW-00074N-C3
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aV-0003eb-HG
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:01:56 -0400
Received: from m12-15.163.com ([220.181.12.15]:52585)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aU-0003dN-RQ
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:01:55 -0400
From: Li Qiang <liq3ea@163.com>
Date: Wed, 12 Sep 2018 09:01:14 -0700
Message-Id: <20180912160118.21158-5-liq3ea@163.com>
In-Reply-To: <20180912160118.21158-1-liq3ea@163.com>
References: <20180912160118.21158-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 4/8] hw: pc-testdev: add read memory region
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, lersek@redhat.com, marcandre.lureau@gmail.com, ehabkost@redhat.com, mst@redhat.com, peter.maydell@linaro.org, ppandit@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

From: Li Qiang <liq3ea@gmail.com>

Also change the write callback name.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/misc/pc-testdev.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/hw/misc/pc-testdev.c b/hw/misc/pc-testdev.c
index b81d820084..697eb88c97 100644
--- a/hw/misc/pc-testdev.c
+++ b/hw/misc/pc-testdev.c
@@ -58,7 +58,12 @@ typedef struct PCTestdev {
 #define TESTDEV(obj) \
      OBJECT_CHECK(PCTestdev, (obj), TYPE_TESTDEV)
 
-static void test_irq_line(void *opaque, hwaddr addr, uint64_t data,
+static uint64_t test_irq_line_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
+static void test_irq_line_write(void *opaque, hwaddr addr, uint64_t data,
                           unsigned len)
 {
     PCTestdev *dev = opaque;
@@ -68,7 +73,8 @@ static void test_irq_line(void *opaque, hwaddr addr, uint64_t data,
 }
 
 static const MemoryRegionOps test_irq_ops = {
-    .write = test_irq_line,
+    .read = test_irq_line_read,
+    .write = test_irq_line_write,
     .valid.min_access_size = 1,
     .valid.max_access_size = 1,
     .endianness = DEVICE_LITTLE_ENDIAN,
@@ -110,7 +116,12 @@ static const MemoryRegionOps test_ioport_byte_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void test_flush_page(void *opaque, hwaddr addr, uint64_t data,
+static uint64_t test_flush_page_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
+static void test_flush_page_write(void *opaque, hwaddr addr, uint64_t data,
                             unsigned len)
 {
     hwaddr page = 4096;
@@ -126,7 +137,8 @@ static void test_flush_page(void *opaque, hwaddr addr, uint64_t data,
 }
 
 static const MemoryRegionOps test_flush_ops = {
-    .write = test_flush_page,
+    .read = test_flush_page_read,
+    .write = test_flush_page_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
     .endianness = DEVICE_LITTLE_ENDIAN,
-- 
2.17.1
