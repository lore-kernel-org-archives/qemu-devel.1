Received: from eggs.gnu.org ([2001:4830:134:3::10]:54281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dAGha-0008Sk-LB
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dAGhZ-00062e-Nw
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:10:22 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 15 May 2017 22:10:14 +0800
Message-Id: <20170515141014.25793-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-img: Fix leakage of options on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Reported by Coverity.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-img.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qemu-img.c b/qemu-img.c
index b506839..8b0dfa7 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -294,6 +294,7 @@ static BlockBackend *img_open_opts(const char *optstr,
         if (qdict_haskey(options, BDRV_OPT_FORCE_SHARE)
             && !qdict_get_bool(options, BDRV_OPT_FORCE_SHARE)) {
             error_report("--force-share/-U conflicts with image options");
+            QDECREF(options);
             return NULL;
         }
         qdict_put(options, BDRV_OPT_FORCE_SHARE, qbool_from_bool(true));
-- 
2.9.3
