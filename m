Received: from eggs.gnu.org ([2001:4830:134:3::10]:33447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fgJYD-0007RS-VW
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 20:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fgJYC-0003gM-UH
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 20:45:42 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Jul 2018 08:45:29 +0800
Message-Id: <1532047529-17961-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1532047529-17961-1-git-send-email-jasowang@redhat.com>
References: <1532047529-17961-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] tap: fix memory leak on success to create a
 tap device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Yunjian Wang <wangyunjian@huawei.com>, qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>

From: Yunjian Wang <wangyunjian@huawei.com>

The memory leak on success to create a tap device. And the nfds and
nvhosts may not be the same and need to be processed separately.

Fixes: 07825977 ("tap: fix memory leak on failure to create a multiqueue tap device")
Fixes: 264986e2 ("tap: multiqueue support")
Cc: qemu-stable@nongnu.org
Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 2126f48..cc8525f 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -805,7 +805,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
     } else if (tap->has_fds) {
         char **fds;
         char **vhost_fds;
-        int nfds, nvhosts;
+        int nfds = 0, nvhosts = 0;
+        int ret = 0;
 
         if (tap->has_ifname || tap->has_script || tap->has_downscript ||
             tap->has_vnet_hdr || tap->has_helper || tap->has_queues ||
@@ -825,6 +826,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             if (nfds != nvhosts) {
                 error_setg(errp, "The number of fds passed does not match "
                            "the number of vhostfds passed");
+                ret = -1;
                 goto free_fail;
             }
         }
@@ -833,6 +835,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             fd = monitor_fd_param(cur_mon, fds[i], &err);
             if (fd == -1) {
                 error_propagate(errp, err);
+                ret = -1;
                 goto free_fail;
             }
 
@@ -843,6 +846,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             } else if (vnet_hdr != tap_probe_vnet_hdr(fd)) {
                 error_setg(errp,
                            "vnet_hdr not consistent across given tap fds");
+                ret = -1;
                 goto free_fail;
             }
 
@@ -852,21 +856,21 @@ int net_init_tap(const Netdev *netdev, const char *name,
                              vnet_hdr, fd, &err);
             if (err) {
                 error_propagate(errp, err);
+                ret = -1;
                 goto free_fail;
             }
         }
-        g_free(fds);
-        g_free(vhost_fds);
-        return 0;
 
 free_fail:
+        for (i = 0; i < nvhosts; i++) {
+            g_free(vhost_fds[i]);
+        }
         for (i = 0; i < nfds; i++) {
             g_free(fds[i]);
-            g_free(vhost_fds[i]);
         }
         g_free(fds);
         g_free(vhost_fds);
-        return -1;
+        return ret;
     } else if (tap->has_helper) {
         if (tap->has_ifname || tap->has_script || tap->has_downscript ||
             tap->has_vnet_hdr || tap->has_queues || tap->has_vhostfds) {
-- 
2.7.4
