Received: from eggs.gnu.org ([209.51.188.92]:37001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4D-0008Bz-UD
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4D-0000cr-7v
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:17 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:19:49 +0100
Message-Id: <20190225152053.15976-8-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/71] commit: Replace commit_top_bs on failure
 after deleting the block job
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

From: Alberto Garcia <berto@igalia.com>

If there's an error in commit_start() then the block job must be
deleted before replacing commit_top_bs, otherwise it will fail because
of lack of permissions. This happens since the permission system was
introduced in 8dfba2797761d8a43744e4e6571c8175e448a478.

Fortunately this bug doesn't seem to be possible to reproduce at the
moment without changing the code.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/commit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/commit.c b/block/commit.c
index 53148e610b..5deb05925b 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -374,10 +374,12 @@ fail:
     if (s->top) {
         blk_unref(s->top);
     }
+    job_early_fail(&s->common.job);
+    /* commit_top_bs has to be replaced after deleting the block job,
+     * otherwise this would fail because of lack of permissions. */
     if (commit_top_bs) {
         bdrv_replace_node(commit_top_bs, top, &error_abort);
     }
-    job_early_fail(&s->common.job);
 }
=20
=20
--=20
2.20.1
