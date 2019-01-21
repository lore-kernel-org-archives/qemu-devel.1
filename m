Received: from eggs.gnu.org ([209.51.188.92]:51506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldy1-0004GI-Ha
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldxz-00040q-E7
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:37 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:35779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldxw-0003uT-Ow
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:33 -0500
Received: by mail-wr1-x429.google.com with SMTP id 96so24515865wrb.2
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:06:27 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	133sm56197732wme.9.2019.01.21.10.06.25 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 21 Jan 2019 10:06:25 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:05:34 +0100
Message-Id: <1548093980-43088-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/49] vhost-net: move stubs to a separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

There is no reason for CONFIG_VHOST_NET to be specific to a single target;
it is a host feature that can be add to all targets, as long as they support
the virtio-net device.  Currently CONFIG_VHOST_NET depends on CONFIG_KVM,
but ioeventfd support is present in the core memory API and works with
other accelerators as well.

As a first step, move the vhost-net stubs to a separate file.  Later, they
will become conditional on CONFIG_VIRTIO_NET, which is not available in .c
files.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1543851204-41186-2-git-send-email-pbonzini@redhat.com>
---
 hw/net/Makefile.objs    |  4 ++-
 hw/net/vhost_net-stub.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/net/vhost_net.c      | 74 ---------------------------------------
 3 files changed, 95 insertions(+), 75 deletions(-)
 create mode 100644 hw/net/vhost_net-stub.c

diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
index fa461d4..c2705e6 100644
--- a/hw/net/Makefile.objs
+++ b/hw/net/Makefile.objs
@@ -37,7 +37,9 @@ obj-$(CONFIG_PSERIES) += spapr_llan.o
 obj-$(CONFIG_XILINX_ETHLITE) += xilinx_ethlite.o
 
 obj-$(CONFIG_VIRTIO_NET) += virtio-net.o
-obj-y += vhost_net.o
+obj-$(CONFIG_VHOST_NET) += vhost_net.o
+common-obj-$(call lnot,$(CONFIG_VHOST_NET)) += vhost_net-stub.o
+common-obj-$(CONFIG_ALL) += vhost_net-stub.o
 
 obj-$(CONFIG_ETSEC) += fsl_etsec/etsec.o fsl_etsec/registers.o \
 			fsl_etsec/rings.o fsl_etsec/miim.o
diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
new file mode 100644
index 0000000..aac0e98
--- /dev/null
+++ b/hw/net/vhost_net-stub.c
@@ -0,0 +1,92 @@
+/*
+ * vhost-net support
+ *
+ * Copyright Red Hat, Inc. 2010
+ *
+ * Authors:
+ *  Michael S. Tsirkin <mst@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "net/net.h"
+#include "net/tap.h"
+#include "net/vhost-user.h"
+
+#include "hw/virtio/virtio-net.h"
+#include "net/vhost_net.h"
+#include "qemu/error-report.h"
+
+
+uint64_t vhost_net_get_max_queues(VHostNetState *net)
+{
+    return 1;
+}
+
+struct vhost_net *vhost_net_init(VhostNetOptions *options)
+{
+    error_report("vhost-net support is not compiled in");
+    return NULL;
+}
+
+int vhost_net_start(VirtIODevice *dev,
+                    NetClientState *ncs,
+                    int total_queues)
+{
+    return -ENOSYS;
+}
+void vhost_net_stop(VirtIODevice *dev,
+                    NetClientState *ncs,
+                    int total_queues)
+{
+}
+
+void vhost_net_cleanup(struct vhost_net *net)
+{
+}
+
+uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
+{
+    return features;
+}
+
+void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
+{
+}
+
+uint64_t vhost_net_get_acked_features(VHostNetState *net)
+{
+    return 0;
+}
+
+bool vhost_net_virtqueue_pending(VHostNetState *net, int idx)
+{
+    return false;
+}
+
+void vhost_net_virtqueue_mask(VHostNetState *net, VirtIODevice *dev,
+                              int idx, bool mask)
+{
+}
+
+int vhost_net_notify_migration_done(struct vhost_net *net, char* mac_addr)
+{
+    return -1;
+}
+
+VHostNetState *get_vhost_net(NetClientState *nc)
+{
+    return 0;
+}
+
+int vhost_set_vring_enable(NetClientState *nc, int enable)
+{
+    return 0;
+}
+
+int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
+{
+    return 0;
+}
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index e037db6..b901306 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -23,7 +23,6 @@
 #include "qemu/error-report.h"
 
 
-#ifdef CONFIG_VHOST_NET
 #include <linux/vhost.h>
 #include <sys/socket.h>
 #include <linux/kvm.h>
@@ -449,76 +448,3 @@ int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
 
     return vhost_ops->vhost_net_set_mtu(&net->dev, mtu);
 }
-
-#else
-uint64_t vhost_net_get_max_queues(VHostNetState *net)
-{
-    return 1;
-}
-
-struct vhost_net *vhost_net_init(VhostNetOptions *options)
-{
-    error_report("vhost-net support is not compiled in");
-    return NULL;
-}
-
-int vhost_net_start(VirtIODevice *dev,
-                    NetClientState *ncs,
-                    int total_queues)
-{
-    return -ENOSYS;
-}
-void vhost_net_stop(VirtIODevice *dev,
-                    NetClientState *ncs,
-                    int total_queues)
-{
-}
-
-void vhost_net_cleanup(struct vhost_net *net)
-{
-}
-
-uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
-{
-    return features;
-}
-
-void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
-{
-}
-
-uint64_t vhost_net_get_acked_features(VHostNetState *net)
-{
-    return 0;
-}
-
-bool vhost_net_virtqueue_pending(VHostNetState *net, int idx)
-{
-    return false;
-}
-
-void vhost_net_virtqueue_mask(VHostNetState *net, VirtIODevice *dev,
-                              int idx, bool mask)
-{
-}
-
-int vhost_net_notify_migration_done(struct vhost_net *net, char* mac_addr)
-{
-    return -1;
-}
-
-VHostNetState *get_vhost_net(NetClientState *nc)
-{
-    return 0;
-}
-
-int vhost_set_vring_enable(NetClientState *nc, int enable)
-{
-    return 0;
-}
-
-int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
-{
-    return 0;
-}
-#endif
-- 
1.8.3.1
