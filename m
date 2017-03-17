Received: from eggs.gnu.org ([2001:4830:134:3::10]:52822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1corjg-0004Z3-Oo
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1corjf-0000mV-IO
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:16:04 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Mar 2017 14:15:41 +0100
Message-Id: <1489756546-27142-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1489756546-27142-1-git-send-email-kwolf@redhat.com>
References: <1489756546-27142-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 3/8] file-posix: Don't leak fd in
 hdev_get_max_segments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

This fixes a leaked fd introduced in commit 9103f1ce.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index ac6bd9f..53febd3 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -703,6 +703,9 @@ static int hdev_get_max_segments(const struct stat *st)
     }
 
 out:
+    if (fd != -1) {
+        close(fd);
+    }
     g_free(sysfspath);
     return ret;
 #else
-- 
1.8.3.1
