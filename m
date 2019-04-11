Received: from eggs.gnu.org ([209.51.188.92]:59582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEYsu-0003aT-H9
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEYst-0001T5-2t
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:32:52 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 11 Apr 2019 15:32:27 +0300
Message-Id: <9dc45741ca93573c3c782f2333129ee6ed1e9274.1554985749.git.berto@igalia.com>
In-Reply-To: <cover.1554985749.git.berto@igalia.com>
References: <cover.1554985749.git.berto@igalia.com>
In-Reply-To: <cover.1554985749.git.berto@igalia.com>
References: <cover.1554985749.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH for-4.1 v2 1/2] commit: Make base read-only if
 there is an early failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

You can reproduce this by passing an invalid filter-node-name (like
"1234") to block-commit. In this case the base image is put in
read-write mode but is never reset back to read-only.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/commit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/commit.c b/block/commit.c
index ba60fef58a..698eda1dfe 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -384,6 +384,9 @@ fail:
     if (s->top) {
         blk_unref(s->top);
     }
+    if (s->base_read_only) {
+        bdrv_reopen_set_read_only(base, true, NULL);
+    }
     job_early_fail(&s->common.job);
     /* commit_top_bs has to be replaced after deleting the block job,
      * otherwise this would fail because of lack of permissions. */
-- 
2.11.0
