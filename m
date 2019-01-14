Received: from eggs.gnu.org ([209.51.188.92]:44735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4r-0005Zq-PK
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4l-0007Qi-4c
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz4k-0007MQ-UD
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:35 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:01:58 +0100
Message-Id: <1547460140-1473-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 03/25] vhost-user: fix ioeventfd_enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

From: Li Qiang <liq3ea@163.com>

Currently, the vhost-user-test assumes the eventfd is available.
However it's not true because the accel is qtest. So the
'vhost_set_vring_file' will not add fds to the msg and the server
side of vhost-user-test will be broken. The bug is in 'ioeventfd_enabled'.
We should make this function return true if not using kvm accel.

Signed-off-by: Li Qiang <liq3ea@163.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/virtio/vhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index e09bed0..564a31d 100644
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
1.8.3.1
