Received: from eggs.gnu.org ([2001:4830:134:3::10]:46079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1esgYU-0007CB-If
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:12:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1esgYT-0005jt-D8
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:12:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52666 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1esgYT-0005jX-82
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:12:49 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  5 Mar 2018 11:12:04 +0800
Message-Id: <1520219524-17160-10-git-send-email-jasowang@redhat.com>
In-Reply-To: <1520219524-17160-1-git-send-email-jasowang@redhat.com>
References: <1520219524-17160-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 9/9] tap: setting error appropriately when
 calling net_init_tap_one()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Jay Zhou <jianjay.zhou@huawei.com>, Jason Wang <jasowang@redhat.com>

From: Jay Zhou <jianjay.zhou@huawei.com>

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
Signed-off-by: Jason Wang <jasowang@redhat.com>
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
2.7.4
