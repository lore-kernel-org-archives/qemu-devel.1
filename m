Received: from eggs.gnu.org ([2001:4830:134:3::10]:53530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dehIw-0003XP-FE
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dehIr-0003KO-Qk
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:38:42 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon,  7 Aug 2017 08:38:22 -0400
Message-Id: <e6f9362b49ae3837a0b20171cc2223aef2aa2e9a.1502109078.git.jcody@redhat.com>
In-Reply-To: <cover.1502109078.git.jcody@redhat.com>
References: <cover.1502109078.git.jcody@redhat.com>
In-Reply-To: <cover.1502109078.git.jcody@redhat.com>
References: <cover.1502109078.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 4/4] block/vhdx: check error return
 of bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, kwolf@redhat.com, eblake@redhat.com

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/vhdx-log.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index a27dc05..14b724e 100644
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
2.9.4
