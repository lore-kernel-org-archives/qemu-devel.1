Received: from eggs.gnu.org ([209.51.188.92]:41315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB453-0001or-Au
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB452-0003jH-1S
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB451-0003cw-KQ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:55 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1qkI122257
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:44 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksyg8s6f-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:43 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:42 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:35 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-62-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 61/97] net: drop too large packet early
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>, Li Qiang <liq3ea@163.com>, Peter Maydell <peter.maydell@linaro.org>

From: Jason Wang <jasowang@redhat.com>

We try to detect and drop too large packet (>INT_MAX) in 1592a9947036
("net: ignore packet size greater than INT_MAX") during packet
delivering. Unfortunately, this is not sufficient as we may hit
another integer overflow when trying to queue such large packet in
qemu_net_queue_append_iov():

- size of the allocation may overflow on 32bit
- packet->size is integer which may overflow even on 64bit

Fixing this by moving the check to qemu_sendv_packet_async() which is
the entrance of all networking codes and reduce the limit to
NET_BUFSIZE to be more conservative. This works since:

- For the callers that call qemu_sendv_packet_async() directly, they
  only care about if zero is returned to determine whether to prevent
  the source from producing more packets. A callback will be triggered
  if peer can accept more then source could be enabled. This is
  usually used by high speed networking implementation like virtio-net
  or netmap.
- For the callers that call qemu_sendv_packet() that calls
  qemu_sendv_packet_async() indirectly, they often ignore the return
  value. In this case qemu will just the drop packets if peer can't
  receive.

Qemu will copy the packet if it was queued. So it was safe for both
kinds of the callers to assume the packet was sent.

Since we move the check from qemu_deliver_packet_iov() to
qemu_sendv_packet_async(), it would be safer to make
qemu_deliver_packet_iov() static to prevent any external user in the
future.

This is a revised patch of CVE-2018-17963.

Cc: qemu-stable@nongnu.org
Cc: Li Qiang <liq3ea@163.com>
Fixes: 1592a9947036 ("net: ignore packet size greater than INT_MAX")
Reported-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20181204035347.6148-2-jasowang@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 25c01bd19d0e4b66f357618aeefda1ef7a41e21a)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 include/net/net.h |  6 ------
 net/net.c         | 28 +++++++++++++++++-----------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 1425960f76..3e4638b8c6 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -169,12 +169,6 @@ void qemu_check_nic_model(NICInfo *nd, const char *model);
 int qemu_find_nic_model(NICInfo *nd, const char * const *models,
                         const char *default_model);
 
-ssize_t qemu_deliver_packet_iov(NetClientState *sender,
-                            unsigned flags,
-                            const struct iovec *iov,
-                            int iovcnt,
-                            void *opaque);
-
 void print_net_client(Monitor *mon, NetClientState *nc);
 void hmp_info_network(Monitor *mon, const QDict *qdict);
 void net_socket_rs_init(SocketReadState *rs,
diff --git a/net/net.c b/net/net.c
index 46db72811b..f8275843fb 100644
--- a/net/net.c
+++ b/net/net.c
@@ -231,6 +231,11 @@ static void qemu_net_client_destructor(NetClientState *nc)
 {
     g_free(nc);
 }
+static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
+                                       unsigned flags,
+                                       const struct iovec *iov,
+                                       int iovcnt,
+                                       void *opaque);
 
 static void qemu_net_client_setup(NetClientState *nc,
                                   NetClientInfo *info,
@@ -705,22 +710,18 @@ static ssize_t nc_sendv_compat(NetClientState *nc, const struct iovec *iov,
     return ret;
 }
 
-ssize_t qemu_deliver_packet_iov(NetClientState *sender,
-                                unsigned flags,
-                                const struct iovec *iov,
-                                int iovcnt,
-                                void *opaque)
+static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
+                                       unsigned flags,
+                                       const struct iovec *iov,
+                                       int iovcnt,
+                                       void *opaque)
 {
     NetClientState *nc = opaque;
-    size_t size = iov_size(iov, iovcnt);
     int ret;
 
-    if (size > INT_MAX) {
-        return size;
-    }
 
     if (nc->link_down) {
-        return size;
+        return iov_size(iov, iovcnt);
     }
 
     if (nc->receive_disabled) {
@@ -745,10 +746,15 @@ ssize_t qemu_sendv_packet_async(NetClientState *sender,
                                 NetPacketSent *sent_cb)
 {
     NetQueue *queue;
+    size_t size = iov_size(iov, iovcnt);
     int ret;
 
+    if (size > NET_BUFSIZE) {
+        return size;
+    }
+
     if (sender->link_down || !sender->peer) {
-        return iov_size(iov, iovcnt);
+        return size;
     }
 
     /* Let filters handle the packet first */
-- 
2.17.1
