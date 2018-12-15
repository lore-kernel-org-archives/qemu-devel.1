Received: from eggs.gnu.org ([2001:4830:134:3::10]:49951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gXykZ-0005Az-8H
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 20:28:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gXykU-0003Mk-9f
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 20:28:15 -0500
Received: from m12-13.163.com ([220.181.12.13]:55608)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gXykT-0003Lz-K4
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 20:28:10 -0500
From: Li Qiang <liq3ea@163.com>
Date: Fri, 14 Dec 2018 17:26:24 -0800
Message-Id: <20181215012625.73315-3-liq3ea@163.com>
In-Reply-To: <20181215012625.73315-1-liq3ea@163.com>
References: <20181215012625.73315-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 2/3] vhost-user: add fds inf
 'vhost_set_vring_file' in qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com, mst@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, jasowang@redhat.com
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

Currently, the vhost-user-test assumes the eventfd is available.
However it's not true because the accel is qtest. So the
'vhost_set_vring_file' will not add fds to the msg and the server
side of vhost-user-test will be broken. This patch avoid this.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/virtio/vhost-user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index e09bed0e4a..3b666f093c 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -23,6 +23,7 @@
 #include "migration/migration.h"
 #include "migration/postcopy-ram.h"
 #include "trace.h"
+#include "sysemu/qtest.h"
 
 #include <sys/ioctl.h>
 #include <sys/socket.h>
@@ -742,7 +743,7 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
         .hdr.size = sizeof(msg.payload.u64),
     };
 
-    if (ioeventfd_enabled() && file->fd > 0) {
+    if ((qtest_enabled() || ioeventfd_enabled()) && file->fd > 0) {
         fds[fd_num++] = file->fd;
     } else {
         msg.payload.u64 |= VHOST_USER_VRING_NOFD_MASK;
-- 
2.17.1
