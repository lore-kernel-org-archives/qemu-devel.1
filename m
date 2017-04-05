Received: from eggs.gnu.org ([2001:4830:134:3::10]:60903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvquc-0002r3-J4
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvqub-00088R-RA
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:48:14 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  5 Apr 2017 14:47:38 -0500
Message-Id: <20170405194741.18956-11-eblake@redhat.com>
In-Reply-To: <20170405194741.18956-1-eblake@redhat.com>
References: <20170405194741.18956-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 10/13] block: Simplify
 bdrv_append_temp_snapshot() logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Noticed while checking Coccinelle results. Naming a label 'out:'
when it is only used on error paths is weird; meanwhile we know
that snapshot_options is NULL on success and that QDECREF(NULL)
is safe.  So merge the two exit paths into one.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 9b87bf6..a13625f 100644
--- a/block.c
+++ b/block.c
@@ -2209,13 +2209,10 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
         goto out;
     }

+out:
+    QDECREF(snapshot_options);
     g_free(tmp_filename);
     return bs_snapshot;
-
-out:
-    QDECREF(snapshot_options);
-    g_free(tmp_filename);
-    return NULL;
 }

 /*
-- 
2.9.3
