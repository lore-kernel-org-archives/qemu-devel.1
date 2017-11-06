Received: from eggs.gnu.org ([2001:4830:134:3::10]:42534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eBjzT-000109-Ar
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:11:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eBjzP-00048b-7m
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:11:11 -0500
Received: from relay2.gtri.gatech.edu ([130.207.199.168]:39035)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eBjzP-00048A-3d
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:11:07 -0500
From: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
Date: Mon, 6 Nov 2017 11:10:39 -0500
Message-ID: <20171106161039.32596-1-michael.nawrocki@gtri.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] Enable 8-byte wide MMIO for 16550 serial
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>

Some drivers for the PPMC7400 PowerPC evaluation board accesses the
serial registers through the floating point unit (stfd/ldfd), which is
an 8-byte wide access. This patch enables that behavior.

Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
---
 hw/char/serial.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 376bd2f240..eb72191ee7 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1005,7 +1005,7 @@ static void serial_mm_write(void *opaque, hwaddr addr,
                             uint64_t value, unsigned size)
 {
     SerialState *s = opaque;
-    value &= ~0u >> (32 - (size * 8));
+    value &= 255;
     serial_ioport_write(s, addr >> s->it_shift, value, 1);
 }
 
@@ -1014,16 +1014,22 @@ static const MemoryRegionOps serial_mm_ops[3] = {
         .read = serial_mm_read,
         .write = serial_mm_write,
         .endianness = DEVICE_NATIVE_ENDIAN,
+        .valid.max_access_size = 8,
+        .impl.max_access_size = 8,
     },
     [DEVICE_LITTLE_ENDIAN] = {
         .read = serial_mm_read,
         .write = serial_mm_write,
         .endianness = DEVICE_LITTLE_ENDIAN,
+        .valid.max_access_size = 8,
+        .impl.max_access_size = 8,
     },
     [DEVICE_BIG_ENDIAN] = {
         .read = serial_mm_read,
         .write = serial_mm_write,
         .endianness = DEVICE_BIG_ENDIAN,
+        .valid.max_access_size = 8,
+        .impl.max_access_size = 8,
     },
 };
 
-- 
2.14.2
