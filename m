Received: from eggs.gnu.org ([2001:4830:134:3::10]:42365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52I-0000CA-PH
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52E-00025c-5U
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:06 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  8 Aug 2017 15:58:26 +0200
Message-Id: <20170808135838.11525-7-kwolf@redhat.com>
In-Reply-To: <20170808135838.11525-1-kwolf@redhat.com>
References: <20170808135838.11525-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 06/18] block/vhdx: check error return of
 bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

From: Jeff Cody <jcody@redhat.com>

Signed-off-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vhdx-log.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index a27dc059cd..14b724ef7b 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -558,7 +558,11 @@ static int vhdx_log_flush(BlockDriverState *bs, BDRVVHDXState *s,
                     ret = -EINVAL;
                     goto exit;
                 }
-                bdrv_truncate(bs->file, new_file_size, PREALLOC_MODE_OFF, NULL);
+                ret = bdrv_truncate(bs->file, new_file_size, PREALLOC_MODE_OFF,
+                                    NULL);
+                if (ret < 0) {
+                    goto exit;
+                }
             }
         }
         qemu_vfree(desc_entries);
-- 
2.13.4
