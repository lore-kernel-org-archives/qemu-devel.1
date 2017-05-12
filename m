Received: from eggs.gnu.org ([2001:4830:134:3::10]:56032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdG-0000JE-5T
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdE-0003lo-PK
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:38 -0400
Received: from [59.151.112.132] (port=14198 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdE-0003YR-D6
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:36 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 12 May 2017 09:41:18 +0800
Message-ID: <1494553288-30764-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V4 02/12] net/filter-mirror.c: Add new option
 to enable vnet support for filter-mirror
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

We add the vnet_hdr option for filter-mirror, default is disable.
If you use virtio-net-pci net driver, please enable it.
You can use it for example:
-object filter-mirror,id=m0,netdev=hn0,queue=tx,outdev=mirror0,vnet_hdr=on

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/filter-mirror.c | 34 ++++++++++++++++++++++++++++++++++
 qemu-options.hx     |  5 +++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 72fa7c2..3766414 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -38,6 +38,7 @@ typedef struct MirrorState {
     NetFilterState parent_obj;
     char *indev;
     char *outdev;
+    bool vnet_hdr;
     CharBackend chr_in;
     CharBackend chr_out;
     SocketReadState rs;
@@ -308,6 +309,13 @@ static char *filter_mirror_get_outdev(Object *obj, Error **errp)
     return g_strdup(s->outdev);
 }
 
+static char *filter_mirror_get_vnet_hdr(Object *obj, Error **errp)
+{
+    MirrorState *s = FILTER_MIRROR(obj);
+
+    return s->vnet_hdr ? g_strdup("on") : g_strdup("off");
+}
+
 static void
 filter_mirror_set_outdev(Object *obj, const char *value, Error **errp)
 {
@@ -322,6 +330,21 @@ filter_mirror_set_outdev(Object *obj, const char *value, Error **errp)
     }
 }
 
+static void filter_mirror_set_vnet_hdr(Object *obj,
+                                       const char *value,
+                                       Error **errp)
+{
+    MirrorState *s = FILTER_MIRROR(obj);
+
+    if (strcmp(value, "on") && strcmp(value, "off")) {
+        error_setg(errp, "Invalid value for filter-mirror vnet_hdr, "
+                         "should be 'on' or 'off'");
+        return;
+    }
+
+    s->vnet_hdr = !strcmp(value, "on");
+}
+
 static char *filter_redirector_get_outdev(Object *obj, Error **errp)
 {
     MirrorState *s = FILTER_REDIRECTOR(obj);
@@ -340,8 +363,19 @@ filter_redirector_set_outdev(Object *obj, const char *value, Error **errp)
 
 static void filter_mirror_init(Object *obj)
 {
+    MirrorState *s = FILTER_MIRROR(obj);
+
     object_property_add_str(obj, "outdev", filter_mirror_get_outdev,
                             filter_mirror_set_outdev, NULL);
+
+    /*
+     * The vnet_hdr is disabled by default, if you want to enable
+     * this option, you must enable all the option on related modules
+     * (like other filter or colo-compare).
+     */
+    s->vnet_hdr = false;
+    object_property_add_str(obj, "vnet_hdr", filter_mirror_get_vnet_hdr,
+                             filter_mirror_set_vnet_hdr, NULL);
 }
 
 static void filter_redirector_init(Object *obj)
diff --git a/qemu-options.hx b/qemu-options.hx
index 70c0ded..1e08481 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4024,10 +4024,11 @@ queue @var{all|rx|tx} is an option that can be applied to any netfilter.
 @option{tx}: the filter is attached to the transmit queue of the netdev,
              where it will receive packets sent by the netdev.
 
-@item -object filter-mirror,id=@var{id},netdev=@var{netdevid},outdev=@var{chardevid}[,queue=@var{all|rx|tx}]
+@item -object filter-mirror,id=@var{id},netdev=@var{netdevid},outdev=@var{chardevid},vnet_hdr=@var{on|off}[,queue=@var{all|rx|tx}]
 
 filter-mirror on netdev @var{netdevid},mirror net packet to chardev
-@var{chardevid}
+@var{chardevid}, if vnet_hdr = on, filter-mirror will mirror packet
+with vnet_hdr_len.
 
 @item -object filter-redirector,id=@var{id},netdev=@var{netdevid},indev=@var{chardevid},
 outdev=@var{chardevid}[,queue=@var{all|rx|tx}]
-- 
2.7.4
