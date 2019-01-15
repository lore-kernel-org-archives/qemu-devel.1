Received: from eggs.gnu.org ([209.51.188.92]:33484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUxH-0006Kk-Ap
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUxG-0002NO-1w
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:04:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUxF-000272-0Q
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:04:57 -0500
Date: Tue, 15 Jan 2019 15:04:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-7-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 06/49] vhost-user: fix ioeventfd_enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Qiang <liq3ea@163.com>

From: Li Qiang <liq3ea@163.com>

Currently, the vhost-user-test assumes the eventfd is available.
However it's not true because the accel is qtest. So the
'vhost_set_vring_file' will not add fds to the msg and the server
side of vhost-user-test will be broken. The bug is in 'ioeventfd_enabled'.
We should make this function return true if not using kvm accel.

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index e09bed0e4a..564a31d12c 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -207,7 +207,7 @@ struct vhost_user {
 
 static bool ioeventfd_enabled(void)
 {
-    return kvm_enabled() && kvm_eventfds_enabled();
+    return !kvm_enabled() || kvm_eventfds_enabled();
 }
 
 static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
-- 
MST
