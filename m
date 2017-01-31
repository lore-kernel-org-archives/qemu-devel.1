Received: from eggs.gnu.org ([2001:4830:134:3::10]:43102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYb0i-0006Qi-DK
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYb0f-0006lE-50
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:10:24 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 31 Jan 2017 18:09:55 +0200
Message-Id: <c988ccf62ad4000775d3b322744ea0f5900daaa7.1485878688.git.berto@igalia.com>
In-Reply-To: <cover.1485878688.git.berto@igalia.com>
References: <cover.1485878688.git.berto@igalia.com>
In-Reply-To: <cover.1485878688.git.berto@igalia.com>
References: <cover.1485878688.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 2/2] iov: assert that qiov->size doesn't exceed
 INT_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

The type of qiov->size is size_t but the QEMU I/O code uses int all
over the place to measure request sizes. Overflows are likely going
to be detected by any of the many assert(qiov->size == nbytes), where
nbytes is an int, but let's add proper checks in the QEMUIOVector
initialization, which is where it belongs.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 util/iov.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/util/iov.c b/util/iov.c
index 74e6ca8ed7..6b5cc9203c 100644
--- a/util/iov.c
+++ b/util/iov.c
@@ -283,13 +283,18 @@ void qemu_iovec_init_external(QEMUIOVector *qiov, struct iovec *iov, int niov)
     qiov->niov = niov;
     qiov->nalloc = -1;
     qiov->size = 0;
-    for (i = 0; i < niov; i++)
+    for (i = 0; i < niov; i++) {
+        assert(iov[i].iov_len <= INT_MAX);
+        assert(qiov->size <= INT_MAX - iov[i].iov_len);
         qiov->size += iov[i].iov_len;
+    }
 }
 
 void qemu_iovec_add(QEMUIOVector *qiov, void *base, size_t len)
 {
     assert(qiov->nalloc != -1);
+    assert(len <= INT_MAX);
+    assert(qiov->size <= INT_MAX - len);
 
     if (qiov->niov == qiov->nalloc) {
         qiov->nalloc = 2 * qiov->nalloc + 1;
-- 
2.11.0
