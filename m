Received: from eggs.gnu.org ([2001:4830:134:3::10]:36783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dSH7V-0006pW-PA
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dSH7S-00060A-Cq
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:15:33 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:50149)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dSH7S-0005gK-1q
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:15:30 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Wed, 5 Jul 2017 06:33:32 +0800
Message-Id: <1499207612-3560-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] vhost: fix a memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

vhost exists a call for g_file_get_contents, but not call g_free.

Signed-off-by: Peng Hao<peng.hao2@zte.com.cn>
---
 hw/virtio/vhost-backend.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 4e31de1..2c481d6 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -52,11 +52,13 @@ static int vhost_kernel_memslots_limit(struct vhost_dev *dev)
                             &s, NULL, NULL)) {
         uint64_t val = g_ascii_strtoull(s, NULL, 10);
         if (!((val == G_MAXUINT64 || !val) && errno)) {
+            g_free(s);
             return val;
         }
         error_report("ignoring invalid max_mem_regions value in vhost module:"
                      " %s", s);
     }
+    g_free(s);
     return limit;
 }
 
-- 
1.8.3.1
