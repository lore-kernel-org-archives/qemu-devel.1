Received: from eggs.gnu.org ([2001:4830:134:3::10]:38312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1dYQJL-0004Sm-1N
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 01:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1dYQJH-00023y-RI
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 01:17:10 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1dYQJH-0001zM-8L
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 01:17:07 -0400
From: w00273186 <wangyunjian@huawei.com>
Date: Fri, 21 Jul 2017 13:16:31 +0800
Message-ID: <1500614191-13392-1-git-send-email-wangyunjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] vhost-user: fix watcher need be removed when
 vhost-user hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: caihe@huawei.com, Yunjian Wang <wangyunjian@huawei.com>

From: Yunjian Wang <wangyunjian@huawei.com>

"nc" is freed after hotplug vhost-user, but the watcher don't be removed.
The QEMU crash when the watcher access the "nc" on socket disconnect.

    Program received signal SIGSEGV, Segmentation fault.
    #0  object_get_class (obj=obj@entry=0x2) at qom/object.c:750
    #1  0x00007f9bb4180da1 in qemu_chr_fe_disconnect (be=<optimized out>) at chardev/char-fe.c:372
    #2  0x00007f9bb40d1100 in net_vhost_user_watch (chan=<optimized out>, cond=<optimized out>, opaque=<optimized out>) at net/vhost-user.c:188
    #3  0x00007f9baf97f99a in g_main_context_dispatch () from /usr/lib64/libglib-2.0.so.0
    #4  0x00007f9bb41d7ebc in glib_pollfds_poll () at util/main-loop.c:213
    #5  os_host_main_loop_wait (timeout=<optimized out>) at util/main-loop.c:261
    #6  main_loop_wait (nonblocking=nonblocking@entry=0) at util/main-loop.c:515
    #7  0x00007f9bb3e266a7 in main_loop () at vl.c:1917
    #8  main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:4786

Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
 net/vhost-user.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index 36f32a2..c23927c 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -151,6 +151,10 @@ static void vhost_user_cleanup(NetClientState *nc)
         s->vhost_net = NULL;
     }
     if (nc->queue_index == 0) {
+        if (s->watch) {
+            g_source_remove(s->watch);
+            s->watch = 0;
+        }
         qemu_chr_fe_deinit(&s->chr, true);
     }
 
-- 
1.8.3.1
