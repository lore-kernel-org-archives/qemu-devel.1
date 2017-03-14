Received: from eggs.gnu.org ([2001:4830:134:3::10]:34197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cnp3X-0006uU-8t
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cnp3W-0003q2-7P
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:12:15 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 15 Mar 2017 00:12:05 +0800
Message-Id: <20170314161205.19415-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2] file-posix: Don't leak fd in
 hdev_get_max_segments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-posix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index c4c0663..d670be3 100644
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
2.9.3
