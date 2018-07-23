Received: from eggs.gnu.org ([2001:4830:134:3::10]:43689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhLR-0004d5-Nd
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhLQ-0005lr-PC
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:22:13 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:46 -0500
Message-Id: <20180723201748.25573-98-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 97/99] tap: fix memory leak on success to
 create a tap device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yunjian Wang <wangyunjian@huawei.com>, Jason Wang <jasowang@redhat.com>

From: Yunjian Wang <wangyunjian@huawei.com>

The memory leak on success to create a tap device. And the nfds and
nvhosts may not be the same and need to be processed separately.

Fixes: 07825977 ("tap: fix memory leak on failure to create a multiqueue tap device")
Fixes: 264986e2 ("tap: multiqueue support")
Cc: qemu-stable@nongnu.org
Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 323e7c117754e4d4ce6b4282d74ad01c99d67714)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 net/tap.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 89c4e19162..e807e0ea2f 100644
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
2.17.1
