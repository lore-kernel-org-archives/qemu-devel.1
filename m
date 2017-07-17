Received: from eggs.gnu.org ([2001:4830:134:3::10]:48281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52N-0000dx-Nt
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52M-00083A-Mj
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dX52M-00082e-Cp
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:06 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jul 2017 20:21:36 +0800
Message-Id: <1500294105-13713-6-git-send-email-jasowang@redhat.com>
In-Reply-To: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
References: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 05/14] net/filter-mirror.c: Add new option to
 enable vnet support for filter-redirector
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

We add the vnet_hdr_support option for filter-redirector, default is disabled.
If you use virtio-net-pci net driver or other driver needs vnet_hdr, please enable it.
Because colo-compare or other modules needs the vnet_hdr_len to parse
packet, we add this new option send the len to others.
You can use it for example:
-object filter-redirector,id=r0,netdev=hn0,queue=tx,outdev=red0,vnet_hdr_support

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/filter-mirror.c | 23 +++++++++++++++++++++++
 qemu-options.hx     |  6 +++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 32ecdb3..90e2c92 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -368,6 +368,22 @@ static void filter_redirector_set_outdev(Object *obj,
     s->outdev = g_strdup(value);
 }
 
+static bool filter_redirector_get_vnet_hdr(Object *obj, Error **errp)
+{
+    MirrorState *s = FILTER_REDIRECTOR(obj);
+
+    return s->vnet_hdr;
+}
+
+static void filter_redirector_set_vnet_hdr(Object *obj,
+                                           bool value,
+                                           Error **errp)
+{
+    MirrorState *s = FILTER_REDIRECTOR(obj);
+
+    s->vnet_hdr = value;
+}
+
 static void filter_mirror_init(Object *obj)
 {
     MirrorState *s = FILTER_MIRROR(obj);
@@ -383,10 +399,17 @@ static void filter_mirror_init(Object *obj)
 
 static void filter_redirector_init(Object *obj)
 {
+    MirrorState *s = FILTER_REDIRECTOR(obj);
+
     object_property_add_str(obj, "indev", filter_redirector_get_indev,
                             filter_redirector_set_indev, NULL);
     object_property_add_str(obj, "outdev", filter_redirector_get_outdev,
                             filter_redirector_set_outdev, NULL);
+
+    s->vnet_hdr = false;
+    object_property_add_bool(obj, "vnet_hdr_support",
+                             filter_redirector_get_vnet_hdr,
+                             filter_redirector_set_vnet_hdr, NULL);
 }
 
 static void filter_mirror_fini(Object *obj)
diff --git a/qemu-options.hx b/qemu-options.hx
index 9eee712..b86c09e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4253,11 +4253,11 @@ queue @var{all|rx|tx} is an option that can be applied to any netfilter.
 
 filter-mirror on netdev @var{netdevid},mirror net packet to chardev@var{chardevid}, if it has the vnet_hdr_support flag, filter-mirror will mirror packet with vnet_hdr_len.
 
-@item -object filter-redirector,id=@var{id},netdev=@var{netdevid},indev=@var{chardevid},
-outdev=@var{chardevid}[,queue=@var{all|rx|tx}]
+@item -object filter-redirector,id=@var{id},netdev=@var{netdevid},indev=@var{chardevid},outdev=@var{chardevid},queue=@var{all|rx|tx}[,vnet_hdr_support]
 
 filter-redirector on netdev @var{netdevid},redirect filter's net packet to chardev
-@var{chardevid},and redirect indev's packet to filter.
+@var{chardevid},and redirect indev's packet to filter.if it has the vnet_hdr_support flag,
+filter-redirector will redirect packet with vnet_hdr_len.
 Create a filter-redirector we need to differ outdev id from indev id, id can not
 be the same. we can just use indev or outdev, but at least one of indev or outdev
 need to be specified.
-- 
2.7.4
