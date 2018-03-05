Received: from eggs.gnu.org ([2001:4830:134:3::10]:45948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1esgY0-0006pF-RG
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1esgXw-0005J4-G5
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:12:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57184 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1esgXw-0005Hz-9y
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:12:16 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  5 Mar 2018 11:11:56 +0800
Message-Id: <1520219524-17160-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1520219524-17160-1-git-send-email-jasowang@redhat.com>
References: <1520219524-17160-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 1/9] net: Move error reporting from
 net_init_client/netdev to the calling site
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Thomas Huth <thuth@redhat.com>

It looks strange that net_init_client() and net_init_netdev() both
take an "Error **errp" parameter, but then do the error reporting
with "error_report_err(local_err)" on their own. Let's move the
error reporting to the calling site instead to simplify this code
a little bit.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/net/net.h |  2 +-
 net/net.c         | 29 +++++------------------------
 vl.c              |  3 ++-
 3 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 3fc48e4..bdd4d9f 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -206,7 +206,7 @@ extern const char *legacy_bootp_filename;
 
 int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp);
 int net_client_parse(QemuOptsList *opts_list, const char *str);
-int net_init_clients(void);
+int net_init_clients(Error **errp);
 void net_check_clients(void);
 void net_cleanup(void);
 void hmp_host_net_add(Monitor *mon, const QDict *qdict);
diff --git a/net/net.c b/net/net.c
index 7d42925..e213a61 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1520,46 +1520,27 @@ void net_check_clients(void)
 
 static int net_init_client(void *dummy, QemuOpts *opts, Error **errp)
 {
-    Error *local_err = NULL;
-
-    net_client_init(opts, false, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        return -1;
-    }
-
-    return 0;
+    return net_client_init(opts, false, errp);
 }
 
 static int net_init_netdev(void *dummy, QemuOpts *opts, Error **errp)
 {
-    Error *local_err = NULL;
-    int ret;
-
-    ret = net_client_init(opts, true, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        return -1;
-    }
-
-    return ret;
+    return net_client_init(opts, true, errp);
 }
 
-int net_init_clients(void)
+int net_init_clients(Error **errp)
 {
-    QemuOptsList *net = qemu_find_opts("net");
-
     net_change_state_entry =
         qemu_add_vm_change_state_handler(net_vm_change_state_handler, NULL);
 
     QTAILQ_INIT(&net_clients);
 
     if (qemu_opts_foreach(qemu_find_opts("netdev"),
-                          net_init_netdev, NULL, NULL)) {
+                          net_init_netdev, NULL, errp)) {
         return -1;
     }
 
-    if (qemu_opts_foreach(net, net_init_client, NULL, NULL)) {
+    if (qemu_opts_foreach(qemu_find_opts("net"), net_init_client, NULL, errp)) {
         return -1;
     }
 
diff --git a/vl.c b/vl.c
index a33ac00..1931621 100644
--- a/vl.c
+++ b/vl.c
@@ -4489,7 +4489,8 @@ int main(int argc, char **argv, char **envp)
 
     colo_info_init();
 
-    if (net_init_clients() < 0) {
+    if (net_init_clients(&err) < 0) {
+        error_report_err(err);
         exit(1);
     }
 
-- 
2.7.4
