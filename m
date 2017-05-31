Received: from eggs.gnu.org ([2001:4830:134:3::10]:56810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1dG18r-0005jp-Hy
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1dG18n-0006Cs-L4
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:46:17 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1dG18n-0006Bj-0O
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:46:13 -0400
From: Yunjian Wang <wangyunjian@huawei.com>
Date: Wed, 31 May 2017 18:45:32 +0800
Message-ID: <1496227532-15192-1-git-send-email-wangyunjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] vhost-user: fix watcher need be removed
 when vhost-user hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, caihe@huawei.com, w00273186 <wangyunjian@huawei.com>

From: w00273186 <wangyunjian@huawei.com>

"nc" is freed after hotplug vhost-user, but the watcher don't be removed.
The QEMU crash when the watcher access the "nc" on socket disconnect.

Call Trace:
    #0  object_get_class (obj=obj@entry=0x2) at qom/object.c:751
    #1  0x00007fc031c79f41 in qemu_chr_fe_disconnect (be=<optimized out>) at chardev/char.c:1048
    #2  0x00007fc031bd62e0 in net_vhost_user_watch (chan=<optimized out>, cond=<optimized out>, opaque=<optimized out>) at net/vhost-user.c:191
    #3  0x00007fc02c23e99a in g_main_context_dispatch () from /lib64/libglib-2.0.so.0
    #4  0x00007fc031ccfc0c in glib_pollfds_poll () at util/main-loop.c:213
    #5  os_host_main_loop_wait (timeout=<optimized out>) at util/main-loop.c:261
    #6  main_loop_wait (nonblocking=nonblocking@entry=0) at util/main-loop.c:517
    #7  0x00007fc03193bc87 in main_loop () at vl.c:1899
    #8  main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:4719

Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
 net/vhost-user.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index 00a0c1c..8da314d 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -153,6 +153,10 @@ static void vhost_user_cleanup(NetClientState *nc)
     if (nc->queue_index == 0) {
         Chardev *chr = qemu_chr_fe_get_driver(&s->chr);
 
+        if (s->watch) {
+            g_source_remove(s->watch);
+            s->watch = 0;
+        }
         qemu_chr_fe_deinit(&s->chr);
         object_unparent(OBJECT(chr));
     }
-- 
1.8.3.1
