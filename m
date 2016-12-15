Received: from eggs.gnu.org ([2001:4830:134:3::10]:54772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHcHH-0007MD-8x
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 15:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHcHD-0001b0-EP
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 15:05:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cHcHD-0001Zx-9o
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 15:05:15 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 15 Dec 2016 20:05:08 +0000
Message-Id: <20161215200509.2239-2-dgilbert@redhat.com>
In-Reply-To: <20161215200509.2239-1-dgilbert@redhat.com>
References: <20161215200509.2239-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] vmxnet3: Convert ring values to uint32_t's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dmitry@daynix.com
Cc: quintela@redhat.com, amit.shah@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The index's in the Vmxnet3Ring were migrated as 32bit ints
yet are declared as size_t's.  They appear to be derived
from 32bit values loaded from guest memory, so actually
store them as that.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/net/vmxnet3.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 2cb2731..7853174 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -141,17 +141,17 @@ typedef struct VMXNET3Class {
 /* Cyclic ring abstraction */
 typedef struct {
     hwaddr pa;
-    size_t size;
-    size_t cell_size;
-    size_t next;
+    uint32_t size;
+    uint32_t cell_size;
+    uint32_t next;
     uint8_t gen;
 } Vmxnet3Ring;
 
 static inline void vmxnet3_ring_init(PCIDevice *d,
 				     Vmxnet3Ring *ring,
                                      hwaddr pa,
-                                     size_t size,
-                                     size_t cell_size,
+                                     uint32_t size,
+                                     uint32_t cell_size,
                                      bool zero_region)
 {
     ring->pa = pa;
@@ -166,7 +166,7 @@ static inline void vmxnet3_ring_init(PCIDevice *d,
 }
 
 #define VMXNET3_RING_DUMP(macro, ring_name, ridx, r)                         \
-    macro("%s#%d: base %" PRIx64 " size %zu cell_size %zu gen %d next %zu",  \
+    macro("%s#%d: base %" PRIx64 " size %u cell_size %u gen %d next %u",  \
           (ring_name), (ridx),                                               \
           (r)->pa, (r)->size, (r)->cell_size, (r)->gen, (r)->next)
 
-- 
2.9.3
