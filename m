Received: from eggs.gnu.org ([2001:4830:134:3::10]:42258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dDAgL-0002gW-1I
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dDAgH-00030P-7g
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:21:04 -0400
Received: from [59.151.112.132] (port=60354 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dDAgG-0002xH-Kd
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:21:01 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 23 May 2017 22:20:35 +0800
Message-ID: <1495549241-23380-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1495549241-23380-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1495549241-23380-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V5 3/9] net/filter-mirror.c: Add new option to
 enable vnet support for filter-redirector
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
Because colo-compare or other modules needs the vnet_hdr_len to parse
packet, so we add this new option send the len to others.
You can use it for example:
-object filter-redirector,id=r0,netdev=hn0,queue=tx,outdev=red0,vnet_hdr=on

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/filter-mirror.c | 33 +++++++++++++++++++++++++++++++++
 qemu-options.hx     |  6 +++---
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 8df0be6..6c8579f 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -381,6 +381,13 @@ static char *filter_redirector_get_outdev(Object *obj, Error **errp)
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
@@ -390,6 +397,21 @@ filter_redirector_set_outdev(Object *obj, const char *value, Error **errp)
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
@@ -409,10 +431,21 @@ static void filter_mirror_init(Object *obj)
 
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
index 81fb96b..a3c4688 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4028,11 +4028,11 @@ queue @var{all|rx|tx} is an option that can be applied to any netfilter.
 
 filter-mirror on netdev @var{netdevid},mirror net packet to chardev@var{chardevid}, if vnet_hdr = on, filter-mirror will mirror packet with vnet_hdr_len.
 
-@item -object filter-redirector,id=@var{id},netdev=@var{netdevid},indev=@var{chardevid},
-outdev=@var{chardevid}[,queue=@var{all|rx|tx}]
+@item -object filter-redirector,id=@var{id},netdev=@var{netdevid},indev=@var{chardevid},outdev=@var{chardevid},vnet_hdr=@var{on|off}[,queue=@var{all|rx|tx}]
 
 filter-redirector on netdev @var{netdevid},redirect filter's net packet to chardev
-@var{chardevid},and redirect indev's packet to filter.
+@var{chardevid},and redirect indev's packet to filter.if vnet_hdr = on,
+filter-redirector will redirect packet with vnet_hdr_len.
 Create a filter-redirector we need to differ outdev id from indev id, id can not
 be the same. we can just use indev or outdev, but at least one of indev or outdev
 need to be specified.
-- 
2.7.4
