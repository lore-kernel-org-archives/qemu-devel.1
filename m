Received: from eggs.gnu.org ([2001:4830:134:3::10]:56139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdQ-0000Se-TJ
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdP-00041z-TH
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:48 -0400
Received: from [59.151.112.132] (port=8274 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdP-0003ue-Go
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:47 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 12 May 2017 09:41:27 +0800
Message-ID: <1494553288-30764-12-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V4 11/12] net/filter-rewriter.c: Add new option
 to enable vnet support for filter-rewriter
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

We add the vnet_hdr option for filter-rewriter, default is disable.
If you use virtio-net-pci net driver, please enable it.
You can use it for example:
-object filter-rewriter,id=rew0,netdev=hn0,queue=all,vnet_hdr=on

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/filter-rewriter.c | 38 ++++++++++++++++++++++++++++++++++++++
 qemu-options.hx       |  4 ++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 63256c7..bc6d12a 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -33,6 +33,7 @@ typedef struct RewriterState {
     NetQueue *incoming_queue;
     /* hashtable to save connection */
     GHashTable *connection_track_table;
+    bool vnet_hdr;
 } RewriterState;
 
 static void filter_rewriter_flush(NetFilterState *nf)
@@ -237,6 +238,42 @@ static void colo_rewriter_setup(NetFilterState *nf, Error **errp)
     s->incoming_queue = qemu_new_net_queue(qemu_netfilter_pass_to_next, nf);
 }
 
+static char *filter_rewriter_get_vnet_hdr(Object *obj, Error **errp)
+{
+    RewriterState *s = FILTER_COLO_REWRITER(obj);
+
+    return s->vnet_hdr ? g_strdup("on") : g_strdup("off");
+}
+
+static void filter_rewriter_set_vnet_hdr(Object *obj,
+                                         const char *value,
+                                         Error **errp)
+{
+    RewriterState *s = FILTER_COLO_REWRITER(obj);
+
+    if (strcmp(value, "on") && strcmp(value, "off")) {
+        error_setg(errp, "Invalid value for filter-rewriter vnet_hdr, "
+                         "should be 'on' or 'off'");
+        return;
+    }
+
+    s->vnet_hdr = !strcmp(value, "on");
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
+    object_property_add_str(obj, "vnet_hdr", filter_rewriter_get_vnet_hdr,
+                            filter_rewriter_set_vnet_hdr, NULL);
+}
+
 static void colo_rewriter_class_init(ObjectClass *oc, void *data)
 {
     NetFilterClass *nfc = NETFILTER_CLASS(oc);
@@ -250,6 +287,7 @@ static const TypeInfo colo_rewriter_info = {
     .name = TYPE_FILTER_REWRITER,
     .parent = TYPE_NETFILTER,
     .class_init = colo_rewriter_class_init,
+    .instance_init = filter_rewriter_init,
     .instance_size = sizeof(RewriterState),
 };
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 115b83f..d191050 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4040,12 +4040,12 @@ Create a filter-redirector we need to differ outdev id from indev id, id can not
 be the same. we can just use indev or outdev, but at least one of indev or outdev
 need to be specified.
 
-@item -object filter-rewriter,id=@var{id},netdev=@var{netdevid},rewriter-mode=@var{mode}[,queue=@var{all|rx|tx}]
+@item -object filter-rewriter,id=@var{id},netdev=@var{netdevid},rewriter-mode=@var{mode},vnet_hdr=@var{on|off}[,queue=@var{all|rx|tx}]
 
 Filter-rewriter is a part of COLO project.It will rewrite tcp packet to
 secondary from primary to keep secondary tcp connection,and rewrite
 tcp packet to primary from secondary make tcp packet can be handled by
-client.
+client.if vnet_hdr = on, we can parse packet with vnet header.
 
 usage:
 colo secondary:
-- 
2.7.4
