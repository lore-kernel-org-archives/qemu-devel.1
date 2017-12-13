Received: from eggs.gnu.org ([2001:4830:134:3::10]:47744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eP16x-0008Ka-LO
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 02:05:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eP16u-0005gp-GT
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 02:05:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eP16t-0005et-Td
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 02:05:44 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Wed, 13 Dec 2017 15:04:50 +0800
Message-ID: <1513148690-23440-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH] vhost-user: quit infinite loop while used
 memslots is more than the backend limit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, arei.gonglei@huawei.com, marcandre.lureau@redhat.com, jasowang@redhat.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com

Steps to 100% reproduce:
(1) start a VM with two VFIO 82599 PCI NICs successfully
(2) hot plug a RAM, which is attached successfully
(3) hot plug another RAM, which is attached successfully
(4) hot plug a vhost-user NIC, which is attached successfully
(5) hot plug another vhost-user NIC, which is hanged

then the qemu process infinitely and quickly print the logs below:
    [...]
    vhost backend memory slots limit is less than current number of present memory slots
    failed to init vhost_net for queue 0
    vhost backend memory slots limit is less than current number of present memory slots
    failed to init vhost_net for queue 0
    vhost backend memory slots limit is less than current number of present memory slots
    failed to init vhost_net for queue 0
    [...]

and the cpu utilization of the systemd-journal process on host is 100%,
the reason is clear:
    "used_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hdev)"
is true in vhost_dev_init, and the main thread in the infinite do and
while loop in net_vhost_user_init.

One way is to increase the vhost backend memory slots limit, some
discussions are here:
    https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04572.html

I think if
    "used_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hdev)"
is true, it does not make sense to try to initialize the vhost-user again
and again, because the main thread can not handle other qmps at all,
which means it can not reduce the number of memslots, it must be failed
at last.

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 hw/virtio/vhost.c         | 3 +++
 include/hw/virtio/vhost.h | 2 ++
 net/vhost-user.c          | 5 +++++
 3 files changed, 10 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e4290ce..1cc4a18 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -47,6 +47,8 @@ static unsigned int used_memslots;
 static QLIST_HEAD(, vhost_dev) vhost_devices =
     QLIST_HEAD_INITIALIZER(vhost_devices);
 
+bool used_memslots_exceeded;
+
 bool vhost_has_free_slot(void)
 {
     unsigned int slots_limit = ~0U;
@@ -1254,6 +1256,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     if (used_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
         error_report("vhost backend memory slots limit is less"
                 " than current number of present memory slots");
+        used_memslots_exceeded = true;
         r = -1;
         goto fail;
     }
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 467dc77..bcc66d9 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -6,6 +6,8 @@
 #include "hw/virtio/virtio.h"
 #include "exec/memory.h"
 
+extern bool used_memslots_exceeded;
+
 /* Generic structures common for any vhost based device. */
 struct vhost_virtqueue {
     int kick;
diff --git a/net/vhost-user.c b/net/vhost-user.c
index c23927c..8b7bfff 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -17,6 +17,7 @@
 #include "qemu/error-report.h"
 #include "qmp-commands.h"
 #include "trace.h"
+#include "include/hw/virtio/vhost.h"
 
 typedef struct VhostUserState {
     NetClientState nc;
@@ -311,6 +312,10 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
         qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
                                  net_vhost_user_event, NULL, nc0->name, NULL,
                                  true);
+        if (used_memslots_exceeded) {
+            error_report("used memslots exceeded the backend limit, quit loop");
+            return -1;
+        }
     } while (!s->started);
 
     assert(s->vhost_net);
-- 
1.8.3.1
