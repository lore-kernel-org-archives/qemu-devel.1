Received: from eggs.gnu.org ([2001:4830:134:3::10]:36704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eZto5-0007KW-HW
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 02:31:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eZto2-00022v-EJ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 02:31:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2149 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1eZto2-00021E-2K
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 02:31:14 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Fri, 12 Jan 2018 15:30:32 +0800
Message-ID: <1515742232-49096-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] tap: close fd conditionally when error occured
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

If netdev_add tap,id=net0,vhost=on failed in net_init_tap_one(),
the followed up device_add virtio-net-pci,netdev=net0 will fail
too, prints:

  TUNSETOFFLOAD ioctl() failed: Bad file descriptor TUNSETOFFLOAD
  ioctl() failed: Bad file descriptor

The reason is that the fd of tap is closed when error occured after
calling net_init_tap_one().

I think the fd should be closed in these two case:
  1.tap_set_sndbuf() failed
  2.tap_set_sndbuf() succeeded but vhost failed to initialize with
    vhostforce flag on
Meanwhile, the fd should not be closed just because vhost failed to
initialize but without vhostforce flag. So the followed up device_add
can fall back to userspace virtio successfully.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 net/tap.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 979e622..3ed72eb 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -651,6 +651,9 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
     tap_set_sndbuf(s->fd, tap, &err);
     if (err) {
         error_propagate(errp, err);
+        if (!tap->has_fd && !tap->has_fds) {
+            close(fd);
+        }
         return;
     }
 
@@ -687,14 +690,14 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
             vhostfd = monitor_fd_param(cur_mon, vhostfdname, &err);
             if (vhostfd == -1) {
                 error_propagate(errp, err);
-                return;
+                goto cleanup;
             }
         } else {
             vhostfd = open("/dev/vhost-net", O_RDWR);
             if (vhostfd < 0) {
                 error_setg_errno(errp, errno,
                                  "tap: open vhost char device failed");
-                return;
+                goto cleanup;
             }
             fcntl(vhostfd, F_SETFL, O_NONBLOCK);
         }
@@ -704,11 +707,18 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         if (!s->vhost_net) {
             error_setg(errp,
                        "vhost-net requested but could not be initialized");
-            return;
+            goto cleanup;
         }
     } else if (vhostfdname) {
         error_setg(errp, "vhostfd(s)= is not valid without vhost");
     }
+
+cleanup:
+    if (!tap->has_fd && !tap->has_fds && tap->has_vhostforce &&
+        tap->vhostforce) {
+        close(fd);
+    }
+    return;
 }
 
 static int get_fds(char *str, char *fds[], int max)
@@ -877,7 +887,6 @@ free_fail:
                          vnet_hdr, fd, &err);
         if (err) {
             error_propagate(errp, err);
-            close(fd);
             return -1;
         }
     } else {
@@ -916,7 +925,6 @@ free_fail:
                              vhostfdname, vnet_hdr, fd, &err);
             if (err) {
                 error_propagate(errp, err);
-                close(fd);
                 return -1;
             }
         }
-- 
1.8.3.1
