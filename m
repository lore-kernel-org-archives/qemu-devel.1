Received: from eggs.gnu.org ([2001:4830:134:3::10]:53581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1cwPrW-0000m4-PH
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1cwPrT-0001c3-KW
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:07:22 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:36092)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1cwPrS-0001Zg-Mi
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:07:19 -0400
From: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Date: Sat, 8 Apr 2017 09:24:10 +0800
Message-Id: <1491614650-5144-1-git-send-email-lu.zhipeng@zte.com.cn>
Subject: [Qemu-devel] [PATCH] vhost: skip RAM device memory sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: wang.guang55@zte.com.cn, qemu-devel@nongnu.org, ZhiPeng Lu <lu.zhipeng@zte.com.cn>

A RAM device represents a mapping to a physical device, such as to a PCI
* MMIO BAR of an vfio-pci assigned device.
Vhost listens to this region,and increases the region's reference count
while passthrough?for?network adapters (Physical Function, PF or Virtual Function, VF).
After detaching   network adapters with  vhost backend dirver or vhost user dirver,
it unregister vhost listen function  by memory_listener_unregister.
After detaching the passthrough pf  or vf,
the RAM device region's reference by  vhost listener increated can not be released,
due to vhost listen function does not exist.So let's just skip RAM device memory.

Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
---
 hw/virtio/vhost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 613494d..c1ff98f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -611,7 +611,8 @@ static void vhost_set_memory(MemoryListener *listener,
 static bool vhost_section(MemoryRegionSection *section)
 {
     return memory_region_is_ram(section->mr) &&
-        !memory_region_is_rom(section->mr);
+        !memory_region_is_rom(section->mr) &&
+        !memory_region_is_skip_dump(section->mr);
 }
 
 static void vhost_begin(MemoryListener *listener)
-- 
1.8.3.1
