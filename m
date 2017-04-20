Received: from eggs.gnu.org ([2001:4830:134:3::10]:54249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d16oi-00041k-Io
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d16oh-0001GG-L7
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:47:52 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3445
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d16oh-0001FL-9o
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:47:51 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Thu, 20 Apr 2017 15:46:55 +0800
Message-ID: <1492674416-9408-4-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492674416-9408-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492674416-9408-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/3] colo-compare: fix a memory leak
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

g_timeout_source_new() will initialize GSource's reference count to 1,
and g_source_attach() will increase the count by 1, so it will not be
enough to call just g_source_unref() which only reduce the value by 1.
It will lead to memory leak.

We need to call g_source_destroy() before g_source_unref().

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 net/colo-compare.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index d6a5e4c..97bf0e5 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -562,7 +562,9 @@ static void *colo_compare_thread(void *opaque)
 
     g_main_loop_run(s->compare_loop);
 
+    g_source_destroy(timeout_source);
     g_source_unref(timeout_source);
+
     g_main_loop_unref(s->compare_loop);
     g_main_context_unref(s->worker_context);
     return NULL;
-- 
1.8.3.1
