Received: from eggs.gnu.org ([2001:4830:134:3::10]:60289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1fOI1R-0004eb-Ei
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1fOI1O-00071Q-BD
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:29:21 -0400
From: wangyunjian <wangyunjian@huawei.com>
Date: Thu, 31 May 2018 15:28:22 +0800
Message-ID: <1527751702-15452-1-git-send-email-wangyunjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] tap: fix memory leak on success to create a
 tap device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, qemu-stable@nongnu.org, caihe@huawei.com, Yunjian Wang <wangyunjian@huawei.com>

From: Yunjian Wang <wangyunjian@huawei.com>

The memory leak on success to create a tap device. And the nfds and
nvhosts may not be the same and need to be processed separately.

Fixes: 07825977 ("tap: fix memory leak on failure to create a multiqueue tap device")
Fixes: 264986e2 ("tap: multiqueue support")

CC: QEMU Stable <qemu-stable@nongnu.org>
Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
v2:
 -add commit log and cc qemu-stable with fixes tags
---
 net/tap.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index de05f20..6d7710f 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -803,7 +803,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
     } else if (tap->has_fds) {
         char **fds;
         char **vhost_fds;
-        int nfds, nvhosts;
+        int nfds = 0, nvhosts = 0;
+        int ret = 0;
 
         if (tap->has_ifname || tap->has_script || tap->has_downscript ||
             tap->has_vnet_hdr || tap->has_helper || tap->has_queues ||
@@ -823,6 +824,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             if (nfds != nvhosts) {
                 error_setg(errp, "The number of fds passed does not match "
                            "the number of vhostfds passed");
+                ret = -1;
                 goto free_fail;
             }
         }
@@ -831,6 +833,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             fd = monitor_fd_param(cur_mon, fds[i], &err);
             if (fd == -1) {
                 error_propagate(errp, err);
+                ret = -1;
                 goto free_fail;
             }
 
@@ -841,6 +844,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             } else if (vnet_hdr != tap_probe_vnet_hdr(fd)) {
                 error_setg(errp,
                            "vnet_hdr not consistent across given tap fds");
+                ret = -1;
                 goto free_fail;
             }
 
@@ -850,21 +854,21 @@ int net_init_tap(const Netdev *netdev, const char *name,
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
1.8.3.1
