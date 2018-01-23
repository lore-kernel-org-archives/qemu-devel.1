Received: from eggs.gnu.org ([2001:4830:134:3::10]:57690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9k-0003Qq-BI
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9a-0005lq-Ra
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:32 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 Jan 2018 15:01:33 +0100
Message-Id: <20180123140201.31163-2-kwolf@redhat.com>
In-Reply-To: <20180123140201.31163-1-kwolf@redhat.com>
References: <20180123140201.31163-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/29] osdep: Retry SETLK upon EINTR
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

We could hit lock failure if there is a signal that makes fcntl return
-1 and errno set to EINTR. In this case we should retry.

Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 util/osdep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/util/osdep.c b/util/osdep.c
index 1231f9f876..a73de0e1ba 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -244,7 +244,9 @@ static int qemu_lock_fcntl(int fd, int64_t start, int64_t len, int fl_type)
         .l_type   = fl_type,
     };
     qemu_probe_lock_ops();
-    ret = fcntl(fd, fcntl_op_setlk, &fl);
+    do {
+        ret = fcntl(fd, fcntl_op_setlk, &fl);
+    } while (ret == -1 && errno == EINTR);
     return ret == -1 ? -errno : 0;
 }
 
-- 
2.13.6
