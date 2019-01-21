Received: from eggs.gnu.org ([209.51.188.92]:51466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldxz-0004F4-KG
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldxw-0003yX-MA
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:34 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldxv-0003us-Ps
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:32 -0500
Received: by mail-wr1-x444.google.com with SMTP id s12so24493402wrt.4
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:06:28 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	133sm56197732wme.9.2019.01.21.10.06.26 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 21 Jan 2019 10:06:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:05:35 +0100
Message-Id: <1548093980-43088-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/49] vhost-net-user: add stubs for when no
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

hw/net/vhost_net.c needs functions that are declared in net/vhost-user.c: the
vhost-user code is always compiled into QEMU, only the constructor
net_init_vhost_user is unreachable.  Also, net/vhost-user.c needs functions
declared in hw/virtio/vhost-stub.c even if no virtio device exists.

Break this dependency.  First, add a minimal version of net/vhost-user.c,
with no functionality and no dependency on vhost code.  Second, #ifdef out
the calls back to net/vhost-user.c from hw/net/vhost_net.c.

While at it, this patch fixes the CONFIG_VHOST_NET_USE*D* typo.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <1543851204-41186-3-git-send-email-pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
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
index 12fd34f..73bbbd6 100755
--- a/configure
+++ b/configure
@@ -6555,7 +6555,7 @@ if test "$vhost_scsi" = "yes" ; then
   echo "CONFIG_VHOST_SCSI=y" >> $config_host_mak
 fi
 if test "$vhost_net" = "yes" -a "$vhost_user" = "yes"; then
-  echo "CONFIG_VHOST_NET_USED=y" >> $config_host_mak
+  echo "CONFIG_VHOST_NET_USER=y" >> $config_host_mak
 fi
 if test "$vhost_crypto" = "yes" ; then
   echo "CONFIG_VHOST_CRYPTO=y" >> $config_host_mak
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index b901306..2a300ee 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -193,6 +193,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     }
 
     /* Set sane init value. Override when guest acks. */
+#ifdef CONFIG_VHOST_NET_USER
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
index 3acbdcc..ca0e14c 100644
--- a/net/net.c
+++ b/net/net.c
@@ -961,7 +961,7 @@ static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
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
