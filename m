Received: from eggs.gnu.org ([2001:4830:134:3::10]:52424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1crYUw-0003KJ-4T
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 19:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1crYUs-0006mT-Vw
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 19:19:58 -0400
Received: from mail-bn3nam01on0106.outbound.protection.outlook.com
	([104.47.33.106]:2746
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Andrew.Baumann@microsoft.com>)
	id 1crYUs-0006mG-Or
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 19:19:54 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Fri, 24 Mar 2017 16:19:43 -0700
Message-ID: <20170324231943.18768-1-Andrew.Baumann@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3] virtio: fix vring_align() on 64-bit windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>, "Michael S .
	Tsirkin" <mst@redhat.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>

long is 32-bits on 64-bit windows, which caused the top half of the
address to be truncated; this patch changes it to use the
QEMU_ALIGN_UP macro which does not suffer the same problem

Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/hw/virtio/virtio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 15efcf2..7b6edba 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -34,7 +34,7 @@ struct VirtQueue;
 static inline hwaddr vring_align(hwaddr addr,
                                              unsigned long align)
 {
-    return (addr + align - 1) & ~(align - 1);
+    return QEMU_ALIGN_UP(addr, align);
 }
 
 typedef struct VirtQueue VirtQueue;
-- 
2.8.3
