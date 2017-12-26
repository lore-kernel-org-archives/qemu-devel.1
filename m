Received: from eggs.gnu.org ([2001:4830:134:3::10]:50922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eTj6t-0003bN-DU
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 01:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eTj6s-0004XC-Mg
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 01:53:11 -0500
From: Fam Zheng <famz@redhat.com>
Date: Tue, 26 Dec 2017 14:53:00 +0800
Message-Id: <20171226065300.9890-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] osdep: Retry SETLK upon EINTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org

We could hit lock failure if there is a signal that makes fcntl return
-1 and errno set to EINTR. In this case we should retry.

Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>
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
2.14.3
