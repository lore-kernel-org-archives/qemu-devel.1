Received: from eggs.gnu.org ([2001:4830:134:3::10]:38741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gY8hO-0005ht-Oi
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 07:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gY8hN-0007t2-TP
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 07:05:38 -0500
Received: from m12-12.163.com ([220.181.12.12]:34828)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gY8hN-0007pK-3G
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 07:05:37 -0500
From: Li Qiang <liq3ea@163.com>
Date: Sat, 15 Dec 2018 04:03:52 -0800
Message-Id: <20181215120353.82786-3-liq3ea@163.com>
In-Reply-To: <20181215120353.82786-1-liq3ea@163.com>
References: <20181215120353.82786-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH v2 2/3] vhost-user: fix ioeventfd_enabled
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
side of vhost-user-test will be broken. The bug is in 'ioeventfd_enabled'.
We should make this function return true if not using kvm accel.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
v2: change the fix in 'ioeventfd_enabled' per Paolo's review

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
2.17.1
