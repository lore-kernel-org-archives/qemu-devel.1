Received: from eggs.gnu.org ([2001:4830:134:3::10]:46088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ergdO-00069S-EG
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:05:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ergdK-0008Bs-D0
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:05:46 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2608 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1ergdK-00089Y-0c
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:05:42 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Fri, 2 Mar 2018 17:04:44 +0800
Message-ID: <1519981484-15528-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5] tap: setting error appropriately when
 calling net_init_tap_one()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, imammedo@redhat.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, jianjay.zhou@huawei.com

If netdev_add tap,id=net0,...,vhost=on failed in net_init_tap_one(),
the followed up device_add virtio-net-pci,netdev=net0 will fail
too, prints:

   TUNSETOFFLOAD ioctl() failed: Bad file descriptor TUNSETOFFLOAD
   ioctl() failed: Bad file descriptor

The reason is that the fd of tap is closed when error occured after
calling net_init_tap_one().

The fd should be closed when calling net_init_tap_one failed:
   - if tap_set_sndbuf() failed
   - if tap_set_sndbuf() succeeded but vhost failed to open or
     initialize with vhostforce flag on
   - with wrong vhost command line parameter
The fd should not be closed just because vhost failed to open or
initialize but without vhostforce flag. So the followed up
device_add can fall back to userspace virtio successfully.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 include/net/vhost_net.h |  3 +++
 net/tap.c               | 22 +++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index afc1499..77e4739 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -4,6 +4,9 @@
 #include "net/net.h"
 #include "hw/virtio/vhost-backend.h"
 
+#define VHOST_NET_INIT_FAILED \
+    "vhost-net requested but could not be initialized"
+
 struct vhost_net;
 typedef struct vhost_net VHostNetState;
 
diff --git a/net/tap.c b/net/tap.c
index 979e622..2b3a36f 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -686,14 +686,23 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         if (vhostfdname) {
             vhostfd = monitor_fd_param(cur_mon, vhostfdname, &err);
             if (vhostfd == -1) {
-                error_propagate(errp, err);
+                if (tap->has_vhostforce && tap->vhostforce) {
+                    error_propagate(errp, err);
+                } else {
+                    warn_report_err(err);
+                }
                 return;
             }
         } else {
             vhostfd = open("/dev/vhost-net", O_RDWR);
             if (vhostfd < 0) {
-                error_setg_errno(errp, errno,
-                                 "tap: open vhost char device failed");
+                if (tap->has_vhostforce && tap->vhostforce) {
+                    error_setg_errno(errp, errno,
+                                     "tap: open vhost char device failed");
+                } else {
+                    warn_report("tap: open vhost char device failed: %s",
+                                strerror(errno));
+                }
                 return;
             }
             fcntl(vhostfd, F_SETFL, O_NONBLOCK);
@@ -702,8 +711,11 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
 
         s->vhost_net = vhost_net_init(&options);
         if (!s->vhost_net) {
-            error_setg(errp,
-                       "vhost-net requested but could not be initialized");
+            if (tap->has_vhostforce && tap->vhostforce) {
+                error_setg(errp, VHOST_NET_INIT_FAILED);
+            } else {
+                warn_report(VHOST_NET_INIT_FAILED);
+            }
             return;
         }
     } else if (vhostfdname) {
-- 
1.8.3.1
