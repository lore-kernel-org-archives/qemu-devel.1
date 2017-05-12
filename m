Received: from eggs.gnu.org ([2001:4830:134:3::10]:56072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdM-0000O7-Ao
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdK-0003tt-Qw
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:44 -0400
Received: from [59.151.112.132] (port=35788 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdJ-0003rG-QJ
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:42 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 12 May 2017 09:41:22 +0800
Message-ID: <1494553288-30764-7-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V4 06/12] net/colo-compare.c: Add new option to
 enable vnet support for colo-compare
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

We add the vnet_hdr option for colo-compare, default is disable.
If you use virtio-net-pci net driver, please enable it.
You can use it for example:
-object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0,vnet_hdr=on

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 34 +++++++++++++++++++++++++++++++++-
 qemu-options.hx    |  3 ++-
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 332f57e..99a6912 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -73,6 +73,7 @@ typedef struct CompareState {
     CharBackend chr_out;
     SocketReadState pri_rs;
     SocketReadState sec_rs;
+    bool vnet_hdr;
 
     /* connection list: the connections belonged to this NIC could be found
      * in this list.
@@ -642,6 +643,28 @@ static void compare_set_outdev(Object *obj, const char *value, Error **errp)
     s->outdev = g_strdup(value);
 }
 
+static char *compare_get_vnet_hdr(Object *obj, Error **errp)
+{
+    CompareState *s = COLO_COMPARE(obj);
+
+    return s->vnet_hdr ? g_strdup("on") : g_strdup("off");
+}
+
+static void compare_set_vnet_hdr(Object *obj,
+                                 const char *value,
+                                 Error **errp)
+{
+    CompareState *s = COLO_COMPARE(obj);
+
+    if (strcmp(value, "on") && strcmp(value, "off")) {
+        error_setg(errp, "Invalid value for colo-compare vnet_hdr, "
+                         "should be 'on' or 'off'");
+        return;
+    }
+
+    s->vnet_hdr = !strcmp(value, "on");
+}
+
 static void compare_pri_rs_finalize(SocketReadState *pri_rs)
 {
     CompareState *s = container_of(pri_rs, CompareState, pri_rs);
@@ -667,7 +690,6 @@ static void compare_sec_rs_finalize(SocketReadState *sec_rs)
     }
 }
 
-
 /*
  * Return 0 is success.
  * Return 1 is failed.
@@ -775,6 +797,8 @@ static void colo_compare_class_init(ObjectClass *oc, void *data)
 
 static void colo_compare_init(Object *obj)
 {
+    CompareState *s = COLO_COMPARE(obj);
+
     object_property_add_str(obj, "primary_in",
                             compare_get_pri_indev, compare_set_pri_indev,
                             NULL);
@@ -784,6 +808,14 @@ static void colo_compare_init(Object *obj)
     object_property_add_str(obj, "outdev",
                             compare_get_outdev, compare_set_outdev,
                             NULL);
+    /*
+     * The vnet_hdr is disabled by default, if you want to enable
+     * this option, you must enable all the option on related modules
+     * (like other filter or colo-compare).
+     */
+    s->vnet_hdr = false;
+    object_property_add_str(obj, "vnet_hdr", compare_get_vnet_hdr,
+                            compare_set_vnet_hdr, NULL);
 }
 
 static void colo_compare_finalize(Object *obj)
diff --git a/qemu-options.hx b/qemu-options.hx
index 0f81c22..115b83f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4061,12 +4061,13 @@ The file format is libpcap, so it can be analyzed with tools such as tcpdump
 or Wireshark.
 
 @item -object colo-compare,id=@var{id},primary_in=@var{chardevid},secondary_in=@var{chardevid},
-outdev=@var{chardevid}
+outdev=@var{chardevid},vnet_hdr=@var{on|off}
 
 Colo-compare gets packet from primary_in@var{chardevid} and secondary_in@var{chardevid}, than compare primary packet with
 secondary packet. If the packets are same, we will output primary
 packet to outdev@var{chardevid}, else we will notify colo-frame
 do checkpoint and send primary packet to outdev@var{chardevid}.
+if vnet_hdr = on, colo compare will send/recv packet with vnet_hdr_len.
 
 we must use it with the help of filter-mirror and filter-redirector.
 
-- 
2.7.4
