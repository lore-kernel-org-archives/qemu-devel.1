Received: from eggs.gnu.org ([2001:4830:134:3::10]:56869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dMwuz-0008RP-Ov
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dMwuw-0001de-Ix
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:40:37 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon, 19 Jun 2017 16:40:02 +0300
Message-Id: <4a48992ec2230a16914844214c6fb3ca9e064c14.1497879398.git.berto@igalia.com>
In-Reply-To: <cover.1497879398.git.berto@igalia.com>
References: <cover.1497879398.git.berto@igalia.com>
In-Reply-To: <cover.1497879398.git.berto@igalia.com>
References: <cover.1497879398.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 1/7] qcow2: Remove unused Error variable in
 do_perform_cow()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>

We are using the return value of qcow2_encrypt_sectors() to detect
problems but we are throwing away the returned Error since we have no
way to report it to the user. Therefore we can simply get rid of the
local Error variable and pass NULL instead.

Alternatively we could try to figure out a way to pass the original
error instead of simply returning -EIO, but that would be more
invasive, so let's keep the current approach.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index d779ea19cf..d1c419f52b 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -440,16 +440,14 @@ static int coroutine_fn do_perform_cow(BlockDriverState *bs,
     }
 
     if (bs->encrypted) {
-        Error *err = NULL;
         int64_t sector = (src_cluster_offset + offset_in_cluster)
                          >> BDRV_SECTOR_BITS;
         assert(s->cipher);
         assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
         assert((bytes & ~BDRV_SECTOR_MASK) == 0);
         if (qcow2_encrypt_sectors(s, sector, iov.iov_base, iov.iov_base,
-                                  bytes >> BDRV_SECTOR_BITS, true, &err) < 0) {
+                                  bytes >> BDRV_SECTOR_BITS, true, NULL) < 0) {
             ret = -EIO;
-            error_free(err);
             goto out;
         }
     }
-- 
2.11.0
