Received: from eggs.gnu.org ([208.118.235.92]:57457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ehfJu-0004H0-5H
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:41:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ehfIq-0004HS-4f
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:40:13 -0500
Received: from [45.249.212.32] (port=55633 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1ehfIp-0004At-4k
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:39:07 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Fri, 2 Feb 2018 17:50:55 +0800
Message-ID: <1517565055-14588-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3] tap: close fd conditionally when error
 occured
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
The fd should not be closed just because vhost failed to open or
initialize but without vhostforce flag. So the followed up
device_add can fall back to userspace virtio successfully.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 net/tap.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 979e622..c46ab14 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -651,7 +651,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
     tap_set_sndbuf(s->fd, tap, &err);
     if (err) {
         error_propagate(errp, err);
-        return;
+        goto error;
     }
 
     if (tap->has_fd || tap->has_fds) {
@@ -686,15 +686,26 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         if (vhostfdname) {
             vhostfd = monitor_fd_param(cur_mon, vhostfdname, &err);
             if (vhostfd == -1) {
-                error_propagate(errp, err);
-                return;
+                if (tap->has_vhostforce && tap->vhostforce) {
+                    error_propagate(errp, err);
+                    goto error;
+                } else {
+                    warn_report_err(err);
+                    return;
+                }
             }
         } else {
             vhostfd = open("/dev/vhost-net", O_RDWR);
             if (vhostfd < 0) {
-                error_setg_errno(errp, errno,
-                                 "tap: open vhost char device failed");
-                return;
+                if (tap->has_vhostforce && tap->vhostforce) {
+                    error_setg_errno(errp, errno,
+                                     "tap: open vhost char device failed");
+                    goto error;
+                } else {
+                    warn_report("tap: open vhost char device failed: %s",
+                                strerror(errno));
+                    return;
+                }
             }
             fcntl(vhostfd, F_SETFL, O_NONBLOCK);
         }
@@ -702,12 +713,23 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
 
         s->vhost_net = vhost_net_init(&options);
         if (!s->vhost_net) {
-            error_setg(errp,
-                       "vhost-net requested but could not be initialized");
-            return;
+            if (tap->has_vhostforce && tap->vhostforce) {
+                error_setg(errp,
+                           "vhost-net requested but could not be initialized");
+                goto error;
+            } else {
+                warn_report("vhost-net requested but could not be initialized");
+                return;
+            }
         }
     } else if (vhostfdname) {
-        error_setg(errp, "vhostfd(s)= is not valid without vhost");
+        warn_report("vhostfd(s)= is not valid without vhost");
+        return;
+    }
+
+error:
+    if (!tap->has_fd && !tap->has_fds) {
+        close(fd);
     }
 }
 
@@ -877,7 +899,6 @@ free_fail:
                          vnet_hdr, fd, &err);
         if (err) {
             error_propagate(errp, err);
-            close(fd);
             return -1;
         }
     } else {
@@ -916,7 +937,6 @@ free_fail:
                              vhostfdname, vnet_hdr, fd, &err);
             if (err) {
                 error_propagate(errp, err);
-                close(fd);
                 return -1;
             }
         }
-- 
1.8.3.1
