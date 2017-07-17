Received: from eggs.gnu.org ([2001:4830:134:3::10]:48321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52X-0000n7-IK
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52W-0008BT-7u
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dX52V-0008B3-Vo
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:16 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jul 2017 20:21:39 +0800
Message-Id: <1500294105-13713-9-git-send-email-jasowang@redhat.com>
In-Reply-To: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
References: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 08/14] net/colo-compare.c: Make colo-compare
 support vnet_hdr_len
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

We add the vnet_hdr_support option for colo-compare, default is disabled.
If you use virtio-net-pci or other driver needs vnet_hdr, please enable it.
You can use it for example:
-object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0,vnet_hdr_support

COLO-compare can get vnet header length from filter,
Add vnet_hdr_len to struct packet and output packet with
the vnet_hdr_len.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++-------
 qemu-options.hx    |  4 ++--
 2 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index c5d01da..95911a2 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -73,6 +73,7 @@ typedef struct CompareState {
     CharBackend chr_out;
     SocketReadState pri_rs;
     SocketReadState sec_rs;
+    bool vnet_hdr;
 
     /* connection list: the connections belonged to this NIC could be found
      * in this list.
@@ -99,7 +100,8 @@ enum {
 
 static int compare_chr_send(CompareState *s,
                             const uint8_t *buf,
-                            uint32_t size);
+                            uint32_t size,
+                            uint32_t vnet_hdr_len);
 
 static gint seq_sorter(Packet *a, Packet *b, gpointer data)
 {
@@ -483,7 +485,10 @@ static void colo_compare_connection(void *opaque, void *user_data)
         }
 
         if (result) {
-            ret = compare_chr_send(s, pkt->data, pkt->size);
+            ret = compare_chr_send(s,
+                                   pkt->data,
+                                   pkt->size,
+                                   pkt->vnet_hdr_len);
             if (ret < 0) {
                 error_report("colo_send_primary_packet failed");
             }
@@ -506,7 +511,8 @@ static void colo_compare_connection(void *opaque, void *user_data)
 
 static int compare_chr_send(CompareState *s,
                             const uint8_t *buf,
-                            uint32_t size)
+                            uint32_t size,
+                            uint32_t vnet_hdr_len)
 {
     int ret = 0;
     uint32_t len = htonl(size);
@@ -520,6 +526,18 @@ static int compare_chr_send(CompareState *s,
         goto err;
     }
 
+    if (s->vnet_hdr) {
+        /*
+         * We send vnet header len make other module(like filter-redirector)
+         * know how to parse net packet correctly.
+         */
+        len = htonl(vnet_hdr_len);
+        ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof(len));
+        if (ret != sizeof(len)) {
+            goto err;
+        }
+    }
+
     ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, size);
     if (ret != size) {
         goto err;
@@ -659,13 +677,32 @@ static void compare_set_outdev(Object *obj, const char *value, Error **errp)
     s->outdev = g_strdup(value);
 }
 
+static bool compare_get_vnet_hdr(Object *obj, Error **errp)
+{
+    CompareState *s = COLO_COMPARE(obj);
+
+    return s->vnet_hdr;
+}
+
+static void compare_set_vnet_hdr(Object *obj,
+                                 bool value,
+                                 Error **errp)
+{
+    CompareState *s = COLO_COMPARE(obj);
+
+    s->vnet_hdr = value;
+}
+
 static void compare_pri_rs_finalize(SocketReadState *pri_rs)
 {
     CompareState *s = container_of(pri_rs, CompareState, pri_rs);
 
     if (packet_enqueue(s, PRIMARY_IN)) {
         trace_colo_compare_main("primary: unsupported packet in");
-        compare_chr_send(s, pri_rs->buf, pri_rs->packet_len);
+        compare_chr_send(s,
+                         pri_rs->buf,
+                         pri_rs->packet_len,
+                         pri_rs->vnet_hdr_len);
     } else {
         /* compare connection */
         g_queue_foreach(&s->conn_list, colo_compare_connection, s);
@@ -747,8 +784,8 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
-    net_socket_rs_init(&s->pri_rs, compare_pri_rs_finalize, false);
-    net_socket_rs_init(&s->sec_rs, compare_sec_rs_finalize, false);
+    net_socket_rs_init(&s->pri_rs, compare_pri_rs_finalize, s->vnet_hdr);
+    net_socket_rs_init(&s->sec_rs, compare_sec_rs_finalize, s->vnet_hdr);
 
     g_queue_init(&s->conn_list);
 
@@ -774,7 +811,10 @@ static void colo_flush_packets(void *opaque, void *user_data)
 
     while (!g_queue_is_empty(&conn->primary_list)) {
         pkt = g_queue_pop_head(&conn->primary_list);
-        compare_chr_send(s, pkt->data, pkt->size);
+        compare_chr_send(s,
+                         pkt->data,
+                         pkt->size,
+                         pkt->vnet_hdr_len);
         packet_destroy(pkt, NULL);
     }
     while (!g_queue_is_empty(&conn->secondary_list)) {
@@ -792,6 +832,8 @@ static void colo_compare_class_init(ObjectClass *oc, void *data)
 
 static void colo_compare_init(Object *obj)
 {
+    CompareState *s = COLO_COMPARE(obj);
+
     object_property_add_str(obj, "primary_in",
                             compare_get_pri_indev, compare_set_pri_indev,
                             NULL);
@@ -801,6 +843,10 @@ static void colo_compare_init(Object *obj)
     object_property_add_str(obj, "outdev",
                             compare_get_outdev, compare_set_outdev,
                             NULL);
+
+    s->vnet_hdr = false;
+    object_property_add_bool(obj, "vnet_hdr_support", compare_get_vnet_hdr,
+                             compare_set_vnet_hdr, NULL);
 }
 
 static void colo_compare_finalize(Object *obj)
diff --git a/qemu-options.hx b/qemu-options.hx
index b86c09e..91a25ee 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4282,13 +4282,13 @@ Dump the network traffic on netdev @var{dev} to the file specified by
 The file format is libpcap, so it can be analyzed with tools such as tcpdump
 or Wireshark.
 
-@item -object colo-compare,id=@var{id},primary_in=@var{chardevid},secondary_in=@var{chardevid},
-outdev=@var{chardevid}
+@item -object colo-compare,id=@var{id},primary_in=@var{chardevid},secondary_in=@var{chardevid},outdev=@var{chardevid}[,vnet_hdr_support]
 
 Colo-compare gets packet from primary_in@var{chardevid} and secondary_in@var{chardevid}, than compare primary packet with
 secondary packet. If the packets are same, we will output primary
 packet to outdev@var{chardevid}, else we will notify colo-frame
 do checkpoint and send primary packet to outdev@var{chardevid}.
+if it has the vnet_hdr_support flag, colo compare will send/recv packet with vnet_hdr_len.
 
 we must use it with the help of filter-mirror and filter-redirector.
 
-- 
2.7.4
