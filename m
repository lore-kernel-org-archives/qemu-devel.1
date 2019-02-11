Received: from eggs.gnu.org ([209.51.188.92]:58885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gt5Mu-0008SH-8i
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 01:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gt5Mt-0002NS-Ev
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 01:47:04 -0500
Received: from mga12.intel.com ([192.55.52.136]:11247)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gt5Mt-0001vx-6f
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 01:47:03 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Mon, 11 Feb 2019 14:46:29 +0800
Message-Id: <20190211064629.20186-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] pc-dimm: use same mechanism for
 [get|set]_addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

[get|set]_addr are two counterpart to access PCDIMMDevice.addr.

Since we have already set up a property PC_DIMM_ADDR_PROP for this
field and use this mechanism in set_addr, it would be more proper to use
the same mechanism in get_addr.

This patch uses object_property_get_uint() to replace the direct memory
access to make [get|set]_addr with the same mechanism.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

---
v2: replace NULL with error_abort to handle error properly
---
 hw/mem/pc-dimm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 0c9b9e8292..152400b1fc 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -204,9 +204,7 @@ static MemoryRegion *pc_dimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
 
 static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
 {
-    const PCDIMMDevice *dimm = PC_DIMM(md);
-
-    return dimm->addr;
+    return object_property_get_uint(OBJECT(md), PC_DIMM_ADDR_PROP, &error_abort);
 }
 
 static void pc_dimm_md_set_addr(MemoryDeviceState *md, uint64_t addr,
-- 
2.19.1
