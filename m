Received: from eggs.gnu.org ([2001:4830:134:3::10]:59953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRGom-00051e-RQ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRGoj-0007rt-Bq
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:20:52 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gRGoj-0007rB-59
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:20:49 -0500
Received: by mail-wm1-x342.google.com with SMTP id s11so18471405wmh.1
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 05:20:49 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Nov 2018 14:20:40 +0100
Message-Id: <1543238443-4993-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543238443-4993-1-git-send-email-pbonzini@redhat.com>
References: <1543238443-4993-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] vhost-net-user: add stubs for when no
 virtio-net device is present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

hw/net/vhost_net.c needs functions that are declared in net/vhost-user.c: the
vhost-user code is always compiled into QEMU, only the constructor
net_init_vhost_user is unreachable.  Also, net/vhost-user.c needs functions
declared in hw/virtio/vhost-stub.c even if no virtio device exists.

Break this dependency.  First, add a minimal version of net/vhost-user.c,
with no functionality and no dependency on vhost code.  Second, #ifdef out
the calls back to net/vhost-user.c from hw/net/vhost_net.c.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure             |  2 +-
 hw/net/vhost_net.c    |  4 ++++
 net/Makefile.objs     |  4 +++-
 net/net.c             |  2 +-
 net/vhost-user-stub.c | 23 +++++++++++++++++++++++
 5 files changed, 32 insertions(+), 3 deletions(-)
 create mode 100644 net/vhost-user-stub.c

diff --git a/configure b/configure
index 0a3c6a7..cda17ef 100755
--- a/configure
+++ b/configure
@@ -6513,7 +6513,7 @@ if test "$vhost_scsi" = "yes" ; then
   echo "CONFIG_VHOST_SCSI=y" >> $config_host_mak
 fi
 if test "$vhost_net" = "yes" -a "$vhost_user" = "yes"; then
-  echo "CONFIG_VHOST_NET_USED=y" >> $config_host_mak
+  echo "CONFIG_VHOST_NET_USER=y" >> $config_host_mak
 fi
 if test "$vhost_crypto" = "yes" ; then
   echo "CONFIG_VHOST_CRYPTO=y" >> $config_host_mak
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index b901306..fe6202a 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -193,6 +193,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     }
 
     /* Set sane init value. Override when guest acks. */
+#ifdef CONFIG_VHOST_USER
     if (net->nc->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
         features = vhost_user_get_acked_features(net->nc);
         if (~net->dev.features & features) {
@@ -202,6 +203,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
             goto fail;
         }
     }
+#endif
 
     vhost_net_ack_features(net, features);
 
@@ -413,10 +415,12 @@ VHostNetState *get_vhost_net(NetClientState *nc)
     case NET_CLIENT_DRIVER_TAP:
         vhost_net = tap_get_vhost_net(nc);
         break;
+#ifdef CONFIG_VHOST_NET_USER
     case NET_CLIENT_DRIVER_VHOST_USER:
         vhost_net = vhost_user_get_vhost_net(nc);
         assert(vhost_net);
         break;
+#endif
     default:
         break;
     }
diff --git a/net/Makefile.objs b/net/Makefile.objs
index b2bf88a..df2b409 100644
--- a/net/Makefile.objs
+++ b/net/Makefile.objs
@@ -3,7 +3,9 @@ common-obj-y += socket.o
 common-obj-y += dump.o
 common-obj-y += eth.o
 common-obj-$(CONFIG_L2TPV3) += l2tpv3.o
-common-obj-$(CONFIG_POSIX) += vhost-user.o
+common-obj-$(call land,$(CONFIG_VIRTIO_NET),$(CONFIG_VHOST_NET_USER)) += vhost-user.o
+common-obj-$(call land,$(call lnot,$(CONFIG_VIRTIO_NET)),$(CONFIG_VHOST_NET_USER)) += vhost-user-stub.o
+common-obj-$(CONFIG_ALL) += vhost-user-stub.o
 common-obj-$(CONFIG_SLIRP) += slirp.o
 common-obj-$(CONFIG_VDE) += vde.o
 common-obj-$(CONFIG_NETMAP) += netmap.o
diff --git a/net/net.c b/net/net.c
index 07c194a..95a74ad 100644
--- a/net/net.c
+++ b/net/net.c
@@ -955,7 +955,7 @@ static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
         [NET_CLIENT_DRIVER_BRIDGE]    = net_init_bridge,
 #endif
         [NET_CLIENT_DRIVER_HUBPORT]   = net_init_hubport,
-#ifdef CONFIG_VHOST_NET_USED
+#ifdef CONFIG_VHOST_NET_USER
         [NET_CLIENT_DRIVER_VHOST_USER] = net_init_vhost_user,
 #endif
 #ifdef CONFIG_L2TPV3
diff --git a/net/vhost-user-stub.c b/net/vhost-user-stub.c
new file mode 100644
index 0000000..52ab4e1
--- /dev/null
+++ b/net/vhost-user-stub.c
@@ -0,0 +1,23 @@
+/*
+ * vhost-user-stub.c
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "clients.h"
+#include "net/vhost_net.h"
+#include "net/vhost-user.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+
+int net_init_vhost_user(const Netdev *netdev, const char *name,
+                        NetClientState *peer, Error **errp)
+{
+    error_setg(errp, "vhost-user requires frontend driver virtio-net-*");
+    return -1;
+}
-- 
1.8.3.1
