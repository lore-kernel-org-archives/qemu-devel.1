Received: from eggs.gnu.org ([2001:4830:134:3::10]:41771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eeuON-00058q-Qa
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 22:09:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eeuOK-0006vw-Jf
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 22:09:27 -0500
Received: from [45.249.212.32] (port=52547 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1eeuOK-0006qJ-72
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 22:09:24 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Fri, 26 Jan 2018 11:08:16 +0800
Message-ID: <1516936096-48900-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] tap: close fd conditionally when error
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
  - if tap_set_sndbuf() succeeded but vhost failed to initialize with
    vhostforce flag on
The fd should not be closed just because vhost failed to initialize
but without vhostforce flag. So the followed up device_add can fall
back to userspace virtio successfully.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 net/tap.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 979e622..8042c7d 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -648,12 +648,6 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
     TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
     int vhostfd;
 
-    tap_set_sndbuf(s->fd, tap, &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-
     if (tap->has_fd || tap->has_fds) {
         snprintf(s->nc.info_str, sizeof(s->nc.info_str), "fd=%d", fd);
     } else if (tap->has_helper) {
@@ -781,6 +775,12 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
         vnet_hdr = tap_probe_vnet_hdr(fd);
 
+        tap_set_sndbuf(fd, tap, &err);
+        if (err) {
+            error_propagate(errp, err);
+            return -1;
+        }
+
         net_init_tap_one(tap, peer, "tap", name, NULL,
                          script, downscript,
                          vhostfdname, vnet_hdr, fd, &err);
@@ -832,6 +832,12 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto free_fail;
             }
 
+            tap_set_sndbuf(fd, tap, &err);
+            if (err) {
+                error_propagate(errp, err);
+                goto free_fail;
+            }
+
             net_init_tap_one(tap, peer, "tap", name, ifname,
                              script, downscript,
                              tap->has_vhostfds ? vhost_fds[i] : NULL,
@@ -872,12 +878,21 @@ free_fail:
         fcntl(fd, F_SETFL, O_NONBLOCK);
         vnet_hdr = tap_probe_vnet_hdr(fd);
 
+        tap_set_sndbuf(fd, tap, &err);
+        if (err) {
+            error_propagate(errp, err);
+            close(fd);
+            return -1;
+        }
+
         net_init_tap_one(tap, peer, "bridge", name, ifname,
                          script, downscript, vhostfdname,
                          vnet_hdr, fd, &err);
         if (err) {
             error_propagate(errp, err);
-            close(fd);
+            if (tap->has_vhostforce && tap->vhostforce) {
+                close(fd);
+            }
             return -1;
         }
     } else {
@@ -910,13 +925,22 @@ free_fail:
                 }
             }
 
+            tap_set_sndbuf(fd, tap, &err);
+            if (err) {
+                error_propagate(errp, err);
+                close(fd);
+                return -1;
+            }
+
             net_init_tap_one(tap, peer, "tap", name, ifname,
                              i >= 1 ? "no" : script,
                              i >= 1 ? "no" : downscript,
                              vhostfdname, vnet_hdr, fd, &err);
             if (err) {
                 error_propagate(errp, err);
-                close(fd);
+                if (tap->has_vhostforce && tap->vhostforce) {
+                    close(fd);
+                }
                 return -1;
             }
         }
-- 
1.8.3.1
