Received: from eggs.gnu.org ([2001:4830:134:3::10]:38520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eYwy4-0001fE-TQ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:41:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eYwy0-00067U-6M
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:41:40 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2143 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1eYwxz-00062C-Oj
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:41:36 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Wed, 10 Jan 2018 00:40:11 +0800
Message-ID: <1515516013-16604-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 2/4][RFC] tap: do not close fd if only vhost
 failed to initialize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, liuzhe13@huawei.com, jianjay.zhou@huawei.com

Making the followed up device_add to fall back to userspace
virtio when netdev_add fails if vhost force flag does not set.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 net/tap.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 979e622..03f226f 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -642,7 +642,8 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              const char *model, const char *name,
                              const char *ifname, const char *script,
                              const char *downscript, const char *vhostfdname,
-                             int vnet_hdr, int fd, Error **errp)
+                             int vnet_hdr, int fd, Error **errp,
+                             bool *vhost_init_failed)
 {
     Error *err = NULL;
     TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
@@ -687,6 +688,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
             vhostfd = monitor_fd_param(cur_mon, vhostfdname, &err);
             if (vhostfd == -1) {
                 error_propagate(errp, err);
+                *vhost_init_failed = true;
                 return;
             }
         } else {
@@ -694,6 +696,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
             if (vhostfd < 0) {
                 error_setg_errno(errp, errno,
                                  "tap: open vhost char device failed");
+                *vhost_init_failed = true;
                 return;
             }
             fcntl(vhostfd, F_SETFL, O_NONBLOCK);
@@ -704,6 +707,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         if (!s->vhost_net) {
             error_setg(errp,
                        "vhost-net requested but could not be initialized");
+            *vhost_init_failed = true;
             return;
         }
     } else if (vhostfdname) {
@@ -748,6 +752,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
     Error *err = NULL;
     const char *vhostfdname;
     char ifname[128];
+    bool vhost_init_failed = false;
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
     tap = &netdev->u.tap;
@@ -783,7 +788,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
         net_init_tap_one(tap, peer, "tap", name, NULL,
                          script, downscript,
-                         vhostfdname, vnet_hdr, fd, &err);
+                         vhostfdname, vnet_hdr, fd, &err, &vhost_init_failed);
         if (err) {
             error_propagate(errp, err);
             return -1;
@@ -835,7 +840,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             net_init_tap_one(tap, peer, "tap", name, ifname,
                              script, downscript,
                              tap->has_vhostfds ? vhost_fds[i] : NULL,
-                             vnet_hdr, fd, &err);
+                             vnet_hdr, fd, &err, &vhost_init_failed);
             if (err) {
                 error_propagate(errp, err);
                 goto free_fail;
@@ -874,10 +879,12 @@ free_fail:
 
         net_init_tap_one(tap, peer, "bridge", name, ifname,
                          script, downscript, vhostfdname,
-                         vnet_hdr, fd, &err);
+                         vnet_hdr, fd, &err, &vhost_init_failed);
         if (err) {
             error_propagate(errp, err);
-            close(fd);
+            if (tap->has_vhostforce && tap->vhostforce && vhost_init_failed) {
+                close(fd);
+            }
             return -1;
         }
     } else {
@@ -913,10 +920,14 @@ free_fail:
             net_init_tap_one(tap, peer, "tap", name, ifname,
                              i >= 1 ? "no" : script,
                              i >= 1 ? "no" : downscript,
-                             vhostfdname, vnet_hdr, fd, &err);
+                             vhostfdname, vnet_hdr, fd, &err,
+                             &vhost_init_failed);
             if (err) {
                 error_propagate(errp, err);
-                close(fd);
+                if (tap->has_vhostforce && tap->vhostforce &&
+                        vhost_init_failed) {
+                    close(fd);
+                }
                 return -1;
             }
         }
-- 
1.8.3.1
