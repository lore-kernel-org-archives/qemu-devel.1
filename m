Received: from eggs.gnu.org ([2001:4830:134:3::10]:53619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxtvq-0006bz-Hx
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 09:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxtvm-0000mE-Ny
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 09:02:46 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu,  6 Sep 2018 09:02:14 -0400
Message-Id: <20180906130225.5118-6-jsnow@redhat.com>
In-Reply-To: <20180906130225.5118-1-jsnow@redhat.com>
References: <20180906130225.5118-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 05/16] block/mirror: don't install backing
 chain on abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jtc@redhat.com, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

In cases where we abort the block/mirror job, there's no point in
installing the new backing chain before we finish aborting.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/mirror.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/mirror.c b/block/mirror.c
index cba555b4ef..bd3e908710 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -642,7 +642,7 @@ static void mirror_exit(Job *job)
      * required before it could become a backing file of target_bs. */
     bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
                             &error_abort);
-    if (s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
+    if (ret == 0 && s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
         BlockDriverState *backing = s->is_none_mode ? src : s->base;
         if (backing_bs(target_bs) != backing) {
             bdrv_set_backing_hd(target_bs, backing, &local_err);
-- 
2.14.4
