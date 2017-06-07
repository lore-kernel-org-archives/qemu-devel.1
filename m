Received: from eggs.gnu.org ([2001:4830:134:3::10]:60794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dIXgS-0000yP-BD
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dIXgR-0003Yh-32
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:55:24 -0400
Received: from [59.151.112.132] (port=8064 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dIXgQ-0003Xm-Mz
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:55:23 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Wed, 7 Jun 2017 17:55:21 +0800
Message-ID: <1496829322-17099-10-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1496829322-17099-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1496829322-17099-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V6 09/10] net/filter-rewriter.c: Make
 filter-rewriter support vnet_hdr_len
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, weifuqiang <weifuqiang@huawei.com>, "eddie
	. dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

We add the vnet_hdr_support option for filter-rewriter, default is disable.
If you use virtio-net-pci net driver, please enable it.
You can use it for example:
-object filter-rewriter,id=rew0,netdev=hn0,queue=all,vnet_hdr_support

We get the vnet_hdr_len from NetClientState that make us
parse net packet correctly.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/filter-rewriter.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 qemu-options.hx       |  4 ++--
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 63256c7..8eaf0e8 100644
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
@@ -155,10 +157,25 @@ static ssize_t colo_rewriter_receive_iov(NetFilterState *nf,
     ConnectionKey key;
     Packet *pkt;
     ssize_t size = iov_size(iov, iovcnt);
+    ssize_t vnet_hdr_len = 0;
     char *buf = g_malloc0(size);
 
     iov_to_buf(iov, iovcnt, 0, buf, size);
-    pkt = packet_new(buf, size, 0);
+
+    if (s->vnet_hdr) {
+        if (nf->direction == NET_FILTER_DIRECTION_RX ||
+            nf->direction == NET_FILTER_DIRECTION_ALL) {
+            vnet_hdr_len = nf->netdev->vnet_hdr_len;
+        } else if (nf->direction == NET_FILTER_DIRECTION_TX) {
+            vnet_hdr_len = nf->netdev->peer->vnet_hdr_len;
+        } else {
+            error_report("filter-rewriter get vnet_hdr_len failed");
+            /* When error occurred we drop the packet  */
+            return 1;
+        }
+    }
+
+    pkt = packet_new(buf, size, vnet_hdr_len);
     g_free(buf);
 
     /*
@@ -237,6 +254,37 @@ static void colo_rewriter_setup(NetFilterState *nf, Error **errp)
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
+    /*
+     * The vnet_hdr is disabled by default, if you want to enable
+     * this option, you must enable all the option on related modules
+     * (like other filter or colo-compare).
+     */
+    s->vnet_hdr = false;
+    object_property_add_bool(obj, "vnet_hdr_support",
+                             filter_rewriter_get_vnet_hdr,
+                             filter_rewriter_set_vnet_hdr, NULL);
+}
+
 static void colo_rewriter_class_init(ObjectClass *oc, void *data)
 {
     NetFilterClass *nfc = NETFILTER_CLASS(oc);
@@ -250,6 +298,7 @@ static const TypeInfo colo_rewriter_info = {
     .name = TYPE_FILTER_REWRITER,
     .parent = TYPE_NETFILTER,
     .class_init = colo_rewriter_class_init,
+    .instance_init = filter_rewriter_init,
     .instance_size = sizeof(RewriterState),
 };
 
diff --git a/qemu-options.hx b/qemu-options.hx
index fbfd604..8655842 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4037,12 +4037,12 @@ Create a filter-redirector we need to differ outdev id from indev id, id can not
 be the same. we can just use indev or outdev, but at least one of indev or outdev
 need to be specified.
 
-@item -object filter-rewriter,id=@var{id},netdev=@var{netdevid},rewriter-mode=@var{mode}[,queue=@var{all|rx|tx}]
+@item -object filter-rewriter,id=@var{id},netdev=@var{netdevid},rewriter-mode=@var{mode},queue=@var{all|rx|tx},[vnet_hdr_support]
 
 Filter-rewriter is a part of COLO project.It will rewrite tcp packet to
 secondary from primary to keep secondary tcp connection,and rewrite
 tcp packet to primary from secondary make tcp packet can be handled by
-client.
+client.if have the vnet_hdr_support flag, we can parse packet with vnet header.
 
 usage:
 colo secondary:
-- 
2.7.4
