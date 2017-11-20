Received: from eggs.gnu.org ([2001:4830:134:3::10]:35641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsQ5-0000pA-AO
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsQ4-0007nO-Cd
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:11:53 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 20 Nov 2017 21:10:01 +0100
Message-Id: <20171120201004.14999-23-mreitz@redhat.com>
In-Reply-To: <20171120201004.14999-1-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v7 for-2.12 22/25] block: Do not copy
 exact_filename from format file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

If the a format BDS's file BDS is in turn a format BDS, we cannot simply
use the same filename, because when opening a BDS tree based on a
filename alone, qemu will create only one format node on top of one
protocol node (disregarding a potential backing file).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 275cae460a..526ce43e9b 100644
--- a/block.c
+++ b/block.c
@@ -5104,9 +5104,20 @@ void bdrv_refresh_filename(BlockDriverState *bs)
 
         bs->exact_filename[0] = '\0';
 
-        /* If no specific options have been given for this BDS, the filename of
-         * the underlying file should suffice for this one as well */
-        if (bs->file->bs->exact_filename[0] && !generate_json_filename) {
+        /* We can use the underlying file's filename if:
+         * - it has a filename,
+         * - the file is a protocol BDS, and
+         * - opening that file (as this BDS's format) will automatically create
+         *   the BDS tree we have right now, that is:
+         *   - the user did not significantly change this BDS's behavior with
+         *     some explicit options
+         *   - no non-file child of this BDS has been overridden by the user
+         *   Both of these conditions are represented by generate_json_filename.
+         */
+        if (bs->file->bs->exact_filename[0] &&
+            bs->file->bs->drv->bdrv_file_open &&
+            !generate_json_filename)
+        {
             strcpy(bs->exact_filename, bs->file->bs->exact_filename);
         }
     }
-- 
2.13.6
