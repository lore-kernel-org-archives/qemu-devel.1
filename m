Received: from eggs.gnu.org ([2001:4830:134:3::10]:51184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1ddeFD-0001XP-7R
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1ddeFB-00048r-8Q
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:10:31 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:15402 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1ddeFA-00041f-Sx
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:10:29 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Fri,  4 Aug 2017 18:10:13 +0300
Message-Id: <20170804151013.13057-4-den@openvz.org>
In-Reply-To: <20170804151013.13057-1-den@openvz.org>
References: <20170804151013.13057-1-den@openvz.org>
Subject: [Qemu-devel] [PATCH 3/3] parallels: drop check that bdrv_truncate()
 is working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: den@openvz.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This would be actually strange and error prone. If truncate() nowadays
will fail, there is something fatally wrong. Let's check for that during
the actual work.

The only fallback case is when the file is not zero initialized. In this
case we should switch to preallocation via fallocate().

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Markus Armbruster <armbru@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 6794e53c0b..e1e06d23cc 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -703,9 +703,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail_options;
     }
 
-    if (!(flags & BDRV_O_RESIZE) || !bdrv_has_zero_init(bs->file->bs) ||
-            bdrv_truncate(bs->file, bdrv_getlength(bs->file->bs),
-                          PREALLOC_MODE_OFF, NULL) != 0) {
+    if (!bdrv_has_zero_init(bs->file->bs)) {
         s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
     }
 
-- 
2.11.0
