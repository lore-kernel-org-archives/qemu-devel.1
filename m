Received: from eggs.gnu.org ([2001:4830:134:3::10]:37903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fhK8l-0003Gs-Ph
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 15:35:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fhK8k-0000zq-PA
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 15:35:35 -0400
Received: from mail-pl0-x230.google.com ([2607:f8b0:400e:c01::230]:35438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fhK8k-0000zS-FK
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 15:35:34 -0400
Received: by mail-pl0-x230.google.com with SMTP id w3-v6so7296826plq.2
	for <qemu-devel@nongnu.org>; Sun, 22 Jul 2018 12:35:34 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 23 Jul 2018 03:33:45 +0800
Message-Id: <20180722193350.6028-16-zhangckid@gmail.com>
In-Reply-To: <20180722193350.6028-1-zhangckid@gmail.com>
References: <20180722193350.6028-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V10 15/20] net/net.c: Add net client type check
 function for COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <chen.zhang@intel.com>

From: Zhang Chen <chen.zhang@intel.com>

We add is_colo_support_client_type() to check the net client type for
COLO-compare. Currently we just support TAP.
Suggested by Jason.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 include/net/net.h  |  1 +
 net/colo-compare.c |  5 +++++
 net/net.c          | 14 ++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index 1425960f76..dcbc7ba9c0 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -212,6 +212,7 @@ void hmp_host_net_add(Monitor *mon, const QDict *qdict);
 void hmp_host_net_remove(Monitor *mon, const QDict *qdict);
 void netdev_add(QemuOpts *opts, Error **errp);
 void qmp_netdev_add(QDict *qdict, QObject **ret, Error **errp);
+bool is_colo_support_client_type(void);
 
 int net_hub_id_for_client(NetClientState *nc, int *id);
 NetClientState *net_hub_port_find(int hub_id);
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 426eab5973..b8c0240725 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -996,6 +996,11 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
+    if (!is_colo_support_client_type()) {
+        error_setg(errp, "COLO-compare: Net client type is not supported");
+        return;
+    }
+
     net_socket_rs_init(&s->pri_rs, compare_pri_rs_finalize, s->vnet_hdr);
     net_socket_rs_init(&s->sec_rs, compare_sec_rs_finalize, s->vnet_hdr);
 
diff --git a/net/net.c b/net/net.c
index 2a3133990c..a77ea88fff 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1733,3 +1733,17 @@ int net_fill_rstate(SocketReadState *rs, const uint8_t *buf, int size)
     assert(size == 0);
     return 0;
 }
+
+/* Currently, COLO just support TAP */
+bool is_colo_support_client_type(void)
+{
+    NetClientState *nc;
+
+    QTAILQ_FOREACH(nc, &net_clients, next) {
+        if (nc->info->type != NET_CLIENT_DRIVER_TAP) {
+            return false;
+        }
+    }
+
+    return true;
+}
-- 
2.17.1
