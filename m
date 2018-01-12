Received: from eggs.gnu.org ([2001:4830:134:3::10]:44386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ea0o3-0001Mg-CU
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:59:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ea0nz-0002ls-Hm
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:59:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1ea0nz-0002l0-BX
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:59:39 -0500
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri, 12 Jan 2018 15:56:57 +0100
Message-Id: <20180112145658.17121-4-maxime.coquelin@redhat.com>
In-Reply-To: <20180112145658.17121-1-maxime.coquelin@redhat.com>
References: <20180112145658.17121-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] vhost-net: add vhost_net_set_queue_num
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, mlureau@redhat.com, zhengxiang9@huawei.com, lersek@redhat.com, pbonzini@redhat.com, Maxime Coquelin <maxime.coquelin@redhat.com>

This patch adds a new help to notify the backend with
the number of queue pairs setup by the guest driver.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 hw/net/vhost_net.c      | 17 +++++++++++++++++
 include/net/vhost_net.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index e037db63a3..d60e237a34 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -124,6 +124,18 @@ uint64_t vhost_net_get_max_queues(VHostNetState *net)
     return net->dev.max_queues;
 }
 
+int vhost_net_set_queue_num(NetClientState *nc, uint64_t queues)
+{
+    VHostNetState *net = get_vhost_net(nc);
+    const VhostOps *vhost_ops = net->dev.vhost_ops;
+
+    if (vhost_ops->vhost_set_queue_num) {
+        return vhost_ops->vhost_set_queue_num(&net->dev, queues);
+    }
+
+    return 0;
+}
+
 uint64_t vhost_net_get_acked_features(VHostNetState *net)
 {
     return net->dev.acked_features;
@@ -456,6 +468,11 @@ uint64_t vhost_net_get_max_queues(VHostNetState *net)
     return 1;
 }
 
+int vhost_net_set_queue_num(NetClientState *nc, uint64_t queues)
+{
+    return 0;
+}
+
 struct vhost_net *vhost_net_init(VhostNetOptions *options)
 {
     error_report("vhost-net support is not compiled in");
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index afc1499eb9..39e639d014 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -15,6 +15,7 @@ typedef struct VhostNetOptions {
 } VhostNetOptions;
 
 uint64_t vhost_net_get_max_queues(VHostNetState *net);
+int vhost_net_set_queue_num(NetClientState *nc, uint64_t queues);
 struct vhost_net *vhost_net_init(VhostNetOptions *options);
 
 int vhost_net_start(VirtIODevice *dev, NetClientState *ncs, int total_queues);
-- 
2.14.3
