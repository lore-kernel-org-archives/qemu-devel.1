Received: from eggs.gnu.org ([2001:4830:134:3::10]:45760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMGP-0001Px-MP
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMGO-0006Ue-UW
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:21 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 29 May 2017 17:06:51 +0200
Message-Id: <1496070414-6744-13-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
References: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 12/15] qemu-img: Fix leakage of options on error
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

Reported by Coverity.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-id: 20170515141014.25793-1-famz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qemu-img.c b/qemu-img.c
index 0bf941b..5aef8ef 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -295,6 +295,7 @@ static BlockBackend *img_open_opts(const char *optstr,
         if (qdict_haskey(options, BDRV_OPT_FORCE_SHARE)
             && !qdict_get_bool(options, BDRV_OPT_FORCE_SHARE)) {
             error_report("--force-share/-U conflicts with image options");
+            QDECREF(options);
             return NULL;
         }
         qdict_put(options, BDRV_OPT_FORCE_SHARE, qbool_from_bool(true));
-- 
1.8.3.1
