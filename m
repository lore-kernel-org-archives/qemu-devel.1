Received: from eggs.gnu.org ([2001:4830:134:3::10]:50589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dI9dZ-00047U-2K
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dI9dX-0002To-Cj
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:14:49 -0400
Received: from [59.151.112.132] (port=32764 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dI9dV-0002Rs-TE
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:14:47 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 6 Jun 2017 16:12:54 +0800
Message-ID: <1496736776-19852-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1496736776-19852-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1496736776-19852-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V3 1/3] COLO-compare: Add new parameter for
 communicate with remote colo-frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

We add the "notify_dev=chardevID" parameter. colo-compare can connect with
remote colo-frame through chardev socket, Xen colo-frame is the first user.
We can notify colo-frame do checkpoint events.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 20 ++++++++++++++++++++
 qemu-options.hx    | 41 +++++++++++++++++++++++++++++++++++------
 2 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 2639c7f..6f8c439 100644
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
@@ -653,6 +654,21 @@ static void compare_set_outdev(Object *obj, const char *value, Error **errp)
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
@@ -795,6 +811,9 @@ static void colo_compare_init(Object *obj)
     object_property_add_str(obj, "outdev",
                             compare_get_outdev, compare_set_outdev,
                             NULL);
+    object_property_add_str(obj, "notify_dev",
+                            compare_get_notify_dev, compare_set_notify_dev,
+                            NULL);
 }
 
 static void colo_compare_finalize(Object *obj)
@@ -819,6 +838,7 @@ static void colo_compare_finalize(Object *obj)
     g_free(s->pri_indev);
     g_free(s->sec_indev);
     g_free(s->outdev);
+    g_free(s->notify_dev);
 }
 
 static const TypeInfo colo_compare_info = {
diff --git a/qemu-options.hx b/qemu-options.hx
index f63f7dc..1f3b3d2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4092,23 +4092,26 @@ Dump the network traffic on netdev @var{dev} to the file specified by
 The file format is libpcap, so it can be analyzed with tools such as tcpdump
 or Wireshark.
 
-@item -object colo-compare,id=@var{id},primary_in=@var{chardevid},secondary_in=@var{chardevid},
-outdev=@var{chardevid}
+@item -object colo-compare,id=@var{id},primary_in=@var{chardevid},secondary_in=@var{chardevid},outdev=@var{chardevid},notify_dev=@var{chardevid}
 
-Colo-compare gets packet from primary_in@var{chardevid} and secondary_in@var{chardevid}, than compare primary packet with
-secondary packet. If the packets are same, we will output primary
-packet to outdev@var{chardevid}, else we will notify colo-frame
+Colo-compare gets packet from primary_in@var{chardevid} and secondary_in@var{chardevid},
+than compare primary packet with secondary packet. If the packets are same,
+we will output primary packet to outdev@var{chardevid},else we will notify colo-frame
 do checkpoint and send primary packet to outdev@var{chardevid}.
+If we use Xen COLO, will use notify_dev to notify remote colo-frame do checkpoint(like Xen),
+at the same time send primary packet to outdev@var{chardevid}.
 
 we must use it with the help of filter-mirror and filter-redirector.
 
 @example
 
+KVM COLO
+
 primary:
 -netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown
 -device e1000,id=e0,netdev=hn0,mac=52:a4:00:12:78:66
 -chardev socket,id=mirror0,host=3.3.3.3,port=9003,server,nowait
--chardev socket,id=compare1,host=3.3.3.3,port=9004,server,nowait
+-chardev socket,id=compare1,host=3.3.3.3,port=9004,server,wait
 -chardev socket,id=compare0,host=3.3.3.3,port=9001,server,nowait
 -chardev socket,id=compare0-0,host=3.3.3.3,port=9001
 -chardev socket,id=compare_out,host=3.3.3.3,port=9005,server,nowait
@@ -4126,6 +4129,32 @@ secondary:
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
