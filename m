Received: from eggs.gnu.org ([2001:4830:134:3::10]:43934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhh-0003hh-2e
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhd-00072n-IU
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:57 -0400
Received: from [59.151.112.132] (port=16463 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhd-0006zC-5i
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:53 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 4 Jul 2017 14:53:49 +0800
Message-ID: <1499151236-14671-6-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1499151236-14671-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1499151236-14671-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V7 05/12] net/filter-mirror.c: Add new option
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
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

We add the vnet_hdr_support option for filter-redirector, default is disabled.
If you use virtio-net-pci net driver or other driver needs vnet_hdr, please enable it.
Because colo-compare or other modules needs the vnet_hdr_len to parse
packet, we add this new option send the len to others.
You can use it for example:
-object filter-redirector,id=r0,netdev=hn0,queue=tx,outdev=red0,vnet_hdr_support

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/filter-mirror.c | 23 +++++++++++++++++++++++
 qemu-options.hx     |  6 +++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 4a849d4..4127e15 100644
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
index f0add6f..3a5951c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4242,11 +4242,11 @@ queue @var{all|rx|tx} is an option that can be applied to any netfilter.
 
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
