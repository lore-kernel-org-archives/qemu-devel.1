Received: from eggs.gnu.org ([2001:4830:134:3::10]:56011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdE-0000Hm-Fn
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdD-0003jk-I8
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:36 -0400
Received: from [59.151.112.132] (port=14198 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdC-0003YR-Ic
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:35 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 12 May 2017 09:41:20 +0800
Message-ID: <1494553288-30764-5-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V4 04/12] net/filter-mirror.c: Add new option
 to enable vnet support for filter-redirector
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

We add the vnet_hdr option for filter-redirector, default is disable.
If you use virtio-net-pci net driver, please enable it.
You can use it for example:
-object filter-redirector,id=r0,netdev=hn0,queue=tx,outdev=red0,vnet_hdr=on

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/filter-mirror.c | 33 +++++++++++++++++++++++++++++++++
 qemu-options.hx     |  5 +++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 64323fc..a65853c 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -377,6 +377,13 @@ static char *filter_redirector_get_outdev(Object *obj, Error **errp)
     return g_strdup(s->outdev);
 }
 
+static char *filter_redirector_get_vnet_hdr(Object *obj, Error **errp)
+{
+    MirrorState *s = FILTER_REDIRECTOR(obj);
+
+    return s->vnet_hdr ? g_strdup("on") : g_strdup("off");
+}
+
 static void
 filter_redirector_set_outdev(Object *obj, const char *value, Error **errp)
 {
@@ -386,6 +393,21 @@ filter_redirector_set_outdev(Object *obj, const char *value, Error **errp)
     s->outdev = g_strdup(value);
 }
 
+static void filter_redirector_set_vnet_hdr(Object *obj,
+                                           const char *value,
+                                           Error **errp)
+{
+    MirrorState *s = FILTER_REDIRECTOR(obj);
+
+    if (strcmp(value, "on") && strcmp(value, "off")) {
+        error_setg(errp, "Invalid value for filter-redirector vnet_hdr, "
+                         "should be 'on' or 'off'");
+        return;
+    }
+
+    s->vnet_hdr = !strcmp(value, "on");
+}
+
 static void filter_mirror_init(Object *obj)
 {
     MirrorState *s = FILTER_MIRROR(obj);
@@ -405,10 +427,21 @@ static void filter_mirror_init(Object *obj)
 
 static void filter_redirector_init(Object *obj)
 {
+    MirrorState *s = FILTER_REDIRECTOR(obj);
+
     object_property_add_str(obj, "indev", filter_redirector_get_indev,
                             filter_redirector_set_indev, NULL);
     object_property_add_str(obj, "outdev", filter_redirector_get_outdev,
                             filter_redirector_set_outdev, NULL);
+
+    /*
+     * The vnet_hdr is disabled by default, if you want to enable
+     * this option, you must enable all the option on related modules
+     * (like other filter or colo-compare).
+     */
+    s->vnet_hdr = false;
+    object_property_add_str(obj, "vnet_hdr", filter_redirector_get_vnet_hdr,
+                            filter_redirector_set_vnet_hdr, NULL);
 }
 
 static void filter_mirror_fini(Object *obj)
diff --git a/qemu-options.hx b/qemu-options.hx
index 1e08481..0f81c22 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4031,10 +4031,11 @@ filter-mirror on netdev @var{netdevid},mirror net packet to chardev
 with vnet_hdr_len.
 
 @item -object filter-redirector,id=@var{id},netdev=@var{netdevid},indev=@var{chardevid},
-outdev=@var{chardevid}[,queue=@var{all|rx|tx}]
+outdev=@var{chardevid},vnet_hdr=@var{on|off}[,queue=@var{all|rx|tx}]
 
 filter-redirector on netdev @var{netdevid},redirect filter's net packet to chardev
-@var{chardevid},and redirect indev's packet to filter.
+@var{chardevid},and redirect indev's packet to filter.if vnet_hdr = on,
+filter-redirector will redirect packet with vnet_hdr_len.
 Create a filter-redirector we need to differ outdev id from indev id, id can not
 be the same. we can just use indev or outdev, but at least one of indev or outdev
 need to be specified.
-- 
2.7.4
