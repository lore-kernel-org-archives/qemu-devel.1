Received: from eggs.gnu.org ([2001:4830:134:3::10]:38819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1et4vW-0004Il-EX
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:14:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1et4vT-0008Ul-Ae
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:14:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2609 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1et4vS-0008TW-VL
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:14:11 -0500
From: linzhecheng <linzhecheng@huawei.com>
Date: Tue, 6 Mar 2018 13:11:25 +0800
Message-ID: <20180306051125.32812-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] tap: delete tap(net client) if
 net_init_tap_one failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com, linzhecheng <linzhecheng@huawei.com>

If net_init_tap_one failed but net_tap_fd_init succeeded, we should
delete the TAPState *s without vhostforce and has_vhostforce flag.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>

diff --git a/net/tap.c b/net/tap.c
index 2b3a36f9b5..1cb8eaf31f 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -651,7 +651,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
     tap_set_sndbuf(s->fd, tap, &err);
     if (err) {
         error_propagate(errp, err);
-        return;
+        goto fail;
     }
 
     if (tap->has_fd || tap->has_fds) {
@@ -688,6 +688,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
             if (vhostfd == -1) {
                 if (tap->has_vhostforce && tap->vhostforce) {
                     error_propagate(errp, err);
+                    goto fail;
                 } else {
                     warn_report_err(err);
                 }
@@ -699,6 +700,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                 if (tap->has_vhostforce && tap->vhostforce) {
                     error_setg_errno(errp, errno,
                                      "tap: open vhost char device failed");
+                    goto fail;
                 } else {
                     warn_report("tap: open vhost char device failed: %s",
                                 strerror(errno));
@@ -713,6 +715,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         if (!s->vhost_net) {
             if (tap->has_vhostforce && tap->vhostforce) {
                 error_setg(errp, VHOST_NET_INIT_FAILED);
+                goto fail;
             } else {
                 warn_report(VHOST_NET_INIT_FAILED);
             }
@@ -720,7 +723,11 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         }
     } else if (vhostfdname) {
         error_setg(errp, "vhostfd(s)= is not valid without vhost");
+        goto fail;
     }
+    return;
+fail:
+    qemu_del_net_client(&s->nc);
 }
 
 static int get_fds(char *str, char *fds[], int max)
-- 
2.12.2.windows.2
