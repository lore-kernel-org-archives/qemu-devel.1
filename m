Received: from eggs.gnu.org ([2001:4830:134:3::10]:51425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.guang55@zte.com.cn>) id 1cwPik-0005QL-JN
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.guang55@zte.com.cn>) id 1cwPih-0006At-GY
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:58:18 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:41297)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.guang55@zte.com.cn>) id 1cwPig-00069h-Ot
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:58:15 -0400
From: Wang guang <wang.guang55@zte.com.cn>
Date: Sat, 8 Apr 2017 09:16:23 +0800
Message-Id: <1491614183-4580-2-git-send-email-wang.guang55@zte.com.cn>
In-Reply-To: <1491614183-4580-1-git-send-email-wang.guang55@zte.com.cn>
References: <1491614183-4580-1-git-send-email-wang.guang55@zte.com.cn>
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
Cc: qemu-devel@nongnu.org, ZhiPeng Lu <lu.zhipeng@zte.com.cn>

From: ZhiPeng Lu <lu.zhipeng@zte.com.cn>

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
