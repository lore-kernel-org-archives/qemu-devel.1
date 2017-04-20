Received: from eggs.gnu.org ([2001:4830:134:3::10]:54245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d16oi-00041d-Dw
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d16od-0001Et-SK
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:47:52 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3442
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d16od-00013x-5s
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:47:47 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Thu, 20 Apr 2017 15:46:54 +0800
Message-ID: <1492674416-9408-3-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492674416-9408-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492674416-9408-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/3] colo-compare: Check main_loop value before
 call g_main_loop_quit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, zhangchen.fnst@cn.fujitsu.com
Cc: qemu-devel@nongnu.org, weidong.huang@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>

If some errors happen before main_loop is initialized in colo
compare thread, qemu will go into finalizing process where
we call g_main_loop_quit(s->main_loop), if main_loop is NULL, there
will be an error report:
"(process:14861): GLib-CRITICAL **: g_main_loop_quit: assertion 'loop != NULL' failed".

We need to check if main_loop is NULL or not before call g_main_loop_quit().

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 net/colo-compare.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index a6bf419..d6a5e4c 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -770,7 +770,9 @@ static void colo_compare_finalize(Object *obj)
                              s->worker_context, true);
     qemu_chr_fe_deinit(&s->chr_out);
 
-    g_main_loop_quit(s->compare_loop);
+    if (s->compare_loop) {
+        g_main_loop_quit(s->compare_loop);
+    }
     qemu_thread_join(&s->thread);
 
     /* Release all unhandled packets after compare thead exited */
-- 
1.8.3.1
