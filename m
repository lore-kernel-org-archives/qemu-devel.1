Received: from eggs.gnu.org ([2001:4830:134:3::10]:59517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cvmbX-0006Rd-PZ
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cvmbU-0007Zx-Kc
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:12:15 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:2217 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cvmbU-0007V8-8s
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:12:12 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Wed,  5 Apr 2017 18:12:06 +0300
Message-Id: <1491405126-30591-3-git-send-email-den@openvz.org>
In-Reply-To: <1491405126-30591-1-git-send-email-den@openvz.org>
References: <1491405126-30591-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 2/2] parallels: relax check for auto switch of
 prealloc_mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>

PRL_PREALLOC_MODE_TRUNCATE can be set only through command line. Remove
the check that bdrv_truncate() is working on, this is almost always the
case, while the check could lead to serious consequences during migration
etc when we should not even try to API which technically could change the
image (asserts are possible).

Let us keep this simple.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 9dea09e..e805034 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -695,8 +695,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail_options;
     }
 
-    if (!(flags & BDRV_O_RESIZE) || !bdrv_has_zero_init(bs->file->bs) ||
-            bdrv_truncate(bs->file, bdrv_getlength(bs->file->bs)) != 0) {
+    if (!bdrv_has_zero_init(bs->file->bs) != 0) {
         s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
     }
 
-- 
2.7.4
