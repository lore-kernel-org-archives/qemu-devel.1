Received: from eggs.gnu.org ([2001:4830:134:3::10]:43925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhh-0003hb-0I
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhe-00073R-DS
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:57 -0400
Received: from [59.151.112.132] (port=28283 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhe-0006vy-14
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:54 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 4 Jul 2017 14:53:48 +0800
Message-ID: <1499151236-14671-5-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1499151236-14671-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1499151236-14671-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V7 04/12] net/filter-mirror.c: Make filter
 mirror support vnet support.
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

We add the vnet_hdr_support option for filter-mirror, default is disabled.
If you use virtio-net-pci or other driver needs vnet_hdr, please enable it.
You can use it for example:
-object filter-mirror,id=m0,netdev=hn0,queue=tx,outdev=mirror0,vnet_hdr_support

If it has vnet_hdr_support flag, we will change the sending packet format from
struct {int size; const uint8_t buf[];} to {int size; int vnet_hdr_len; const uint8_t buf[];}.
make other module(like colo-compare) know how to parse net packet correctly.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/filter-mirror.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 qemu-options.hx     |  5 ++---
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 69cf4ca..4a849d4 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -41,12 +41,14 @@ typedef struct MirrorState {
     CharBackend chr_in;
     CharBackend chr_out;
     SocketReadState rs;
+    bool vnet_hdr;
 } MirrorState;
 
 static int filter_send(MirrorState *s,
                        const struct iovec *iov,
                        int iovcnt)
 {
+    NetFilterState *nf = NETFILTER(s);
     int ret = 0;
     ssize_t size = 0;
     uint32_t len = 0;
@@ -63,6 +65,23 @@ static int filter_send(MirrorState *s,
         goto err;
     }
 
+    if (s->vnet_hdr) {
+        /*
+         * If vnet_hdr = on, we send vnet header len to make other
+         * module(like colo-compare) know how to parse net
+         * packet correctly.
+         */
+        ssize_t vnet_hdr_len;
+
+        vnet_hdr_len = nf->netdev->vnet_hdr_len;
+
+        len = htonl(vnet_hdr_len);
+        ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof(len));
+        if (ret != sizeof(len)) {
+            goto err;
+        }
+    }
+
     buf = g_malloc(size);
     iov_to_buf(iov, iovcnt, 0, buf, size);
     ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, size);
@@ -229,7 +248,7 @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
         }
     }
 
-    net_socket_rs_init(&s->rs, redirector_rs_finalize, false);
+    net_socket_rs_init(&s->rs, redirector_rs_finalize, s->vnet_hdr);
 
     if (s->indev) {
         chr = qemu_chr_find(s->indev);
@@ -318,6 +337,20 @@ static void filter_mirror_set_outdev(Object *obj,
     }
 }
 
+static bool filter_mirror_get_vnet_hdr(Object *obj, Error **errp)
+{
+    MirrorState *s = FILTER_MIRROR(obj);
+
+    return s->vnet_hdr;
+}
+
+static void filter_mirror_set_vnet_hdr(Object *obj, bool value, Error **errp)
+{
+    MirrorState *s = FILTER_MIRROR(obj);
+
+    s->vnet_hdr = value;
+}
+
 static char *filter_redirector_get_outdev(Object *obj, Error **errp)
 {
     MirrorState *s = FILTER_REDIRECTOR(obj);
@@ -337,8 +370,15 @@ static void filter_redirector_set_outdev(Object *obj,
 
 static void filter_mirror_init(Object *obj)
 {
+    MirrorState *s = FILTER_MIRROR(obj);
+
     object_property_add_str(obj, "outdev", filter_mirror_get_outdev,
                             filter_mirror_set_outdev, NULL);
+
+    s->vnet_hdr = false;
+    object_property_add_bool(obj, "vnet_hdr_support",
+                             filter_mirror_get_vnet_hdr,
+                             filter_mirror_set_vnet_hdr, NULL);
 }
 
 static void filter_redirector_init(Object *obj)
diff --git a/qemu-options.hx b/qemu-options.hx
index 297bd8a..f0add6f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4238,10 +4238,9 @@ queue @var{all|rx|tx} is an option that can be applied to any netfilter.
 @option{tx}: the filter is attached to the transmit queue of the netdev,
              where it will receive packets sent by the netdev.
 
-@item -object filter-mirror,id=@var{id},netdev=@var{netdevid},outdev=@var{chardevid}[,queue=@var{all|rx|tx}]
+@item -object filter-mirror,id=@var{id},netdev=@var{netdevid},outdev=@var{chardevid},queue=@var{all|rx|tx}[,vnet_hdr_support]
 
-filter-mirror on netdev @var{netdevid},mirror net packet to chardev
-@var{chardevid}
+filter-mirror on netdev @var{netdevid},mirror net packet to chardev@var{chardevid}, if it has the vnet_hdr_support flag, filter-mirror will mirror packet with vnet_hdr_len.
 
 @item -object filter-redirector,id=@var{id},netdev=@var{netdevid},indev=@var{chardevid},
 outdev=@var{chardevid}[,queue=@var{all|rx|tx}]
-- 
2.7.4
