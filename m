Received: from eggs.gnu.org ([2001:4830:134:3::10]:48383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52e-0000tw-O9
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52d-0008G4-BG
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dX52d-0008Fo-24
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:23 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jul 2017 20:21:42 +0800
Message-Id: <1500294105-13713-12-git-send-email-jasowang@redhat.com>
In-Reply-To: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
References: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 11/14] net/filter-rewriter.c: Make
 filter-rewriter support vnet_hdr_len
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

We add the vnet_hdr_support option for filter-rewriter, default is disabled.
If you use virtio-net-pci or other driver needs vnet_hdr, please enable it.
You can use it for example:
-object filter-rewriter,id=rew0,netdev=hn0,queue=all,vnet_hdr_support

We get the vnet_hdr_len from NetClientState that make us
parse net packet correctly.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/filter-rewriter.c | 37 ++++++++++++++++++++++++++++++++++++-
 qemu-options.hx       |  4 ++--
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 63256c7..55a6cf5 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -17,6 +17,7 @@
 #include "qemu-common.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
+#include "qemu/error-report.h"
 #include "qapi-visit.h"
 #include "qom/object.h"
 #include "qemu/main-loop.h"
@@ -33,6 +34,7 @@ typedef struct RewriterState {
     NetQueue *incoming_queue;
     /* hashtable to save connection */
     GHashTable *connection_track_table;
+    bool vnet_hdr;
 } RewriterState;
 
 static void filter_rewriter_flush(NetFilterState *nf)
@@ -155,10 +157,16 @@ static ssize_t colo_rewriter_receive_iov(NetFilterState *nf,
     ConnectionKey key;
     Packet *pkt;
     ssize_t size = iov_size(iov, iovcnt);
+    ssize_t vnet_hdr_len = 0;
     char *buf = g_malloc0(size);
 
     iov_to_buf(iov, iovcnt, 0, buf, size);
-    pkt = packet_new(buf, size, 0);
+
+    if (s->vnet_hdr) {
+        vnet_hdr_len = nf->netdev->vnet_hdr_len;
+    }
+
+    pkt = packet_new(buf, size, vnet_hdr_len);
     g_free(buf);
 
     /*
@@ -237,6 +245,32 @@ static void colo_rewriter_setup(NetFilterState *nf, Error **errp)
     s->incoming_queue = qemu_new_net_queue(qemu_netfilter_pass_to_next, nf);
 }
 
+static bool filter_rewriter_get_vnet_hdr(Object *obj, Error **errp)
+{
+    RewriterState *s = FILTER_COLO_REWRITER(obj);
+
+    return s->vnet_hdr;
+}
+
+static void filter_rewriter_set_vnet_hdr(Object *obj,
+                                         bool value,
+                                         Error **errp)
+{
+    RewriterState *s = FILTER_COLO_REWRITER(obj);
+
+    s->vnet_hdr = value;
+}
+
+static void filter_rewriter_init(Object *obj)
+{
+    RewriterState *s = FILTER_COLO_REWRITER(obj);
+
+    s->vnet_hdr = false;
+    object_property_add_bool(obj, "vnet_hdr_support",
+                             filter_rewriter_get_vnet_hdr,
+                             filter_rewriter_set_vnet_hdr, NULL);
+}
+
 static void colo_rewriter_class_init(ObjectClass *oc, void *data)
 {
     NetFilterClass *nfc = NETFILTER_CLASS(oc);
@@ -250,6 +284,7 @@ static const TypeInfo colo_rewriter_info = {
     .name = TYPE_FILTER_REWRITER,
     .parent = TYPE_NETFILTER,
     .class_init = colo_rewriter_class_init,
+    .instance_init = filter_rewriter_init,
     .instance_size = sizeof(RewriterState),
 };
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 91a25ee..e0e04c8 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4262,12 +4262,12 @@ Create a filter-redirector we need to differ outdev id from indev id, id can not
 be the same. we can just use indev or outdev, but at least one of indev or outdev
 need to be specified.
 
-@item -object filter-rewriter,id=@var{id},netdev=@var{netdevid}[,queue=@var{all|rx|tx}]
+@item -object filter-rewriter,id=@var{id},netdev=@var{netdevid},queue=@var{all|rx|tx},[vnet_hdr_support]
 
 Filter-rewriter is a part of COLO project.It will rewrite tcp packet to
 secondary from primary to keep secondary tcp connection,and rewrite
 tcp packet to primary from secondary make tcp packet can be handled by
-client.
+client.if it has the vnet_hdr_support flag, we can parse packet with vnet header.
 
 usage:
 colo secondary:
-- 
2.7.4
