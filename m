Received: from eggs.gnu.org ([2001:4830:134:3::10]:41482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cifLz-00007I-Jj
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:50:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cifLx-0004mJ-Be
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:49:59 -0500
Received: from [59.151.112.132] (port=36439 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cifLw-0004kD-U6
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:49:57 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 28 Feb 2017 18:48:20 +0800
Message-ID: <1488278902-11223-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1488278902-11223-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1488278902-11223-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/3] COLO-compare: Add new parameter for
 communicate with Xen colo-frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

We add the "notify_dev=chardevID" parameter. colo-compare can connect with
Xen colo-frame through chardev socket.like notify colo-frame do checkpoint events.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 20 ++++++++++++++++++++
 qemu-options.hx    | 38 ++++++++++++++++++++++++++++++++++----
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 6b38723..57d336b 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -68,6 +68,7 @@ typedef struct CompareState {
     char *pri_indev;
     char *sec_indev;
     char *outdev;
+    char *notify_dev;
     CharBackend chr_pri_in;
     CharBackend chr_sec_in;
     CharBackend chr_out;
@@ -585,6 +586,21 @@ static void compare_set_outdev(Object *obj, const char *value, Error **errp)
     s->outdev = g_strdup(value);
 }
 
+static char *compare_get_notify_dev(Object *obj, Error **errp)
+{
+    CompareState *s = COLO_COMPARE(obj);
+
+    return g_strdup(s->notify_dev);
+}
+
+static void compare_set_notify_dev(Object *obj, const char *value, Error **errp)
+{
+    CompareState *s = COLO_COMPARE(obj);
+
+    g_free(s->notify_dev);
+    s->notify_dev = g_strdup(value);
+}
+
 static void compare_pri_rs_finalize(SocketReadState *pri_rs)
 {
     CompareState *s = container_of(pri_rs, CompareState, pri_rs);
@@ -727,6 +743,9 @@ static void colo_compare_init(Object *obj)
     object_property_add_str(obj, "outdev",
                             compare_get_outdev, compare_set_outdev,
                             NULL);
+    object_property_add_str(obj, "notify_dev",
+                            compare_get_notify_dev, compare_set_notify_dev,
+                            NULL);
 }
 
 static void colo_compare_finalize(Object *obj)
@@ -751,6 +770,7 @@ static void colo_compare_finalize(Object *obj)
     g_free(s->pri_indev);
     g_free(s->sec_indev);
     g_free(s->outdev);
+    g_free(s->notify_dev);
 }
 
 static const TypeInfo colo_compare_info = {
diff --git a/qemu-options.hx b/qemu-options.hx
index 5633d39..9a3fdcf 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3963,17 +3963,21 @@ The file format is libpcap, so it can be analyzed with tools such as tcpdump
 or Wireshark.
 
 @item -object colo-compare,id=@var{id},primary_in=@var{chardevid},secondary_in=@var{chardevid},
-outdev=@var{chardevid}
+outdev=@var{chardevid},notify_dev=@var{chardevid}
 
-Colo-compare gets packet from primary_in@var{chardevid} and secondary_in@var{chardevid}, than compare primary packet with
-secondary packet. If the packets are same, we will output primary
-packet to outdev@var{chardevid}, else we will notify colo-frame
+Colo-compare gets packet from primary_in@var{chardevid} and secondary_in@var{chardevid},
+than compare primary packet with secondary packet. If the packets are same,
+we will output primary packet to outdev@var{chardevid},else we will notify colo-frame
 do checkpoint and send primary packet to outdev@var{chardevid}.
+If we use Xen COLO, will use notify_dev to notify Xen colo-frame do checkpoint,
+at the same time send primary packet to outdev@var{chardevid}.
 
 we must use it with the help of filter-mirror and filter-redirector.
 
 @example
 
+KVM COLO
+
 primary:
 -netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown
 -device e1000,id=e0,netdev=hn0,mac=52:a4:00:12:78:66
@@ -3996,6 +4000,32 @@ secondary:
 -object filter-redirector,id=f1,netdev=hn0,queue=tx,indev=red0
 -object filter-redirector,id=f2,netdev=hn0,queue=rx,outdev=red1
 
+
+Xen COLO
+
+primary:
+-netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown
+-device e1000,id=e0,netdev=hn0,mac=52:a4:00:12:78:66
+-chardev socket,id=mirror0,host=3.3.3.3,port=9003,server,nowait
+-chardev socket,id=compare1,host=3.3.3.3,port=9004,server,nowait
+-chardev socket,id=compare0,host=3.3.3.3,port=9001,server,nowait
+-chardev socket,id=compare0-0,host=3.3.3.3,port=9001
+-chardev socket,id=compare_out,host=3.3.3.3,port=9005,server,nowait
+-chardev socket,id=compare_out0,host=3.3.3.3,port=9005
+-chardev socket,id=notify_way,host=3.3.3.3,port=9009,server,nowait
+-object filter-mirror,id=m0,netdev=hn0,queue=tx,outdev=mirror0
+-object filter-redirector,netdev=hn0,id=redire0,queue=rx,indev=compare_out
+-object filter-redirector,netdev=hn0,id=redire1,queue=rx,outdev=compare0
+-object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0,notify_dev=nofity_way
+
+secondary:
+-netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,down script=/etc/qemu-ifdown
+-device e1000,netdev=hn0,mac=52:a4:00:12:78:66
+-chardev socket,id=red0,host=3.3.3.3,port=9003
+-chardev socket,id=red1,host=3.3.3.3,port=9004
+-object filter-redirector,id=f1,netdev=hn0,queue=tx,indev=red0
+-object filter-redirector,id=f2,netdev=hn0,queue=rx,outdev=red1
+
 @end example
 
 If you want to know the detail of above command line, you can read
-- 
2.7.4
