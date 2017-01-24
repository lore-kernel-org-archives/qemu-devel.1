Received: from eggs.gnu.org ([2001:4830:134:3::10]:38890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=8ff6=ZG=redhat.com=mst@kernel.org>)
	id 1cW4co-0002Td-Cf
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:11:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=8ff6=ZG=redhat.com=mst@kernel.org>)
	id 1cW4cl-0004uh-8M
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:11:18 -0500
Received: from mail.kernel.org ([198.145.29.136]:39286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=8ff6=ZG=redhat.com=mst@kernel.org>)
	id 1cW4cl-0004u1-1g
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:11:15 -0500
Date: Tue, 24 Jan 2017 19:11:09 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485277734-16871-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] vhost: skip ROM sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>

vhost does not support RO protections on memory at the moment - adding
ROMs would mean that e.g. a buggy guest might change them in-memory - a
condition from which guest reset does not recover. Not nice.

We also definitely don't want to try logging writes into ROMs - in
particular guests set very high addresses for ROM BARs so logging these
writes would waste a lot of memory.  With phys address in the 32T range
we would need 1Gbyte sized log - scanning it would take ages, and
allocating such huge amount of log memory was also reported to fail on
powerpc.

Maybe ROMs could be supported with the iotlb variant -
not sure, but there seems to be no good reason for virtio
to try to do DMA from ROM. So let's just skip ROM memory.

Suggested-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 9cacf55..94b8c4a 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -612,7 +612,8 @@ static void vhost_set_memory(MemoryListener *listener,
 
 static bool vhost_section(MemoryRegionSection *section)
 {
-    return memory_region_is_ram(section->mr);
+    return memory_region_is_ram(section->mr) &&
+        !memory_region_is_rom(section->mr);
 }
 
 static void vhost_begin(MemoryListener *listener)
-- 
MST
