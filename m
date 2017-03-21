Received: from eggs.gnu.org ([2001:4830:134:3::10]:59269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1cqSY0-0004rB-8d
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 18:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1cqSXv-0003Uh-Dg
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 18:46:36 -0400
Received: from mail-bn3nam01on0137.outbound.protection.outlook.com
	([104.47.33.137]:11979
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Andrew.Baumann@microsoft.com>)
	id 1cqSXu-0003Ua-TK
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 18:46:31 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Tue, 21 Mar 2017 15:31:51 -0700
Message-Id: <20170321223151.12984-1-Andrew.Baumann@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] virtio: fix vring_align() on 64-bit win32
 platforms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>, Andrew Baumann <Andrew.Baumann@microsoft.com>

"long" is 32-bits on win32, but we need to promote it to a 64-bit hwaddr
before negating, or else the top half of the address is truncated

Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
---
 include/hw/virtio/virtio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 15efcf2..a0a8543 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -34,7 +34,7 @@ struct VirtQueue;
 static inline hwaddr vring_align(hwaddr addr,
                                              unsigned long align)
 {
-    return (addr + align - 1) & ~(align - 1);
+    return (addr + align - 1) & ~(hwaddr)(align - 1);
 }
 
 typedef struct VirtQueue VirtQueue;
-- 
2.7.4
