Received: from eggs.gnu.org ([2001:4830:134:3::10]:54639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRe-0000DZ-3j
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRd-0005RB-AS
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:46:50 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  1 Aug 2017 16:46:23 +0200
Message-Id: <20170801144632.3831-7-kwolf@redhat.com>
In-Reply-To: <20170801144632.3831-1-kwolf@redhat.com>
References: <20170801144632.3831-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 06/15] block: fix dangling bs->explicit_options
 in block.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Manos Pitsidianakis <el13635@mail.ntua.gr>

In some error paths it is possible to QDECREF a freed dangling
explicit_options, resulting in a heap overflow crash.  For example
bdrv_open_inherit()'s fail unrefs it, then calls bdrv_unref which calls
bdrv_close which also unrefs it.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block.c b/block.c
index 37e72b7a96..7a78bc647b 100644
--- a/block.c
+++ b/block.c
@@ -2608,6 +2608,7 @@ fail:
     QDECREF(bs->options);
     QDECREF(options);
     bs->options = NULL;
+    bs->explicit_options = NULL;
     bdrv_unref(bs);
     error_propagate(errp, local_err);
     return NULL;
@@ -3087,6 +3088,7 @@ static void bdrv_close(BlockDriverState *bs)
         QDECREF(bs->options);
         QDECREF(bs->explicit_options);
         bs->options = NULL;
+        bs->explicit_options = NULL;
         QDECREF(bs->full_open_options);
         bs->full_open_options = NULL;
     }
-- 
2.13.3
