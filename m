Received: from eggs.gnu.org ([2001:4830:134:3::10]:58427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYYHB-0001yH-7t
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYYH8-0000Lj-Mi
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:15:13 -0500
Received: from mail.kernel.org ([198.145.29.136]:39830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYYH8-0000LL-Fz
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:15:10 -0500
Date: Tue, 31 Jan 2017 15:15:06 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485868446-10587-18-git-send-email-mst@redhat.com>
References: <1485868446-10587-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485868446-10587-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v3 17/21] vhost: skip ROM sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>

vhost does not support RO protections on memory at the moment - adding
ROMs would mean that e.g. a buggy guest might change them in-memory - a
condition from which guest reset does not recover. Not nice.

We also definitely don't want to try logging writes into ROMs -
in particular guests set very high addresses for ROM BARs
so logging these writes would waste a lot of memory.

Maybe ROMs could be supported with the iotlb variant -
not sure, but there seems to be no good reason for virtio
to try to do DMA from ROM. So let's just skip ROM memory.

Suggested-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Tested-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/virtio/vhost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b124d97..febe519 100644
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
