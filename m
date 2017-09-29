Received: from eggs.gnu.org ([2001:4830:134:3::10]:47566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxyaV-0002lA-TV
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxyaV-0004RF-34
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:56:31 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 29 Sep 2017 18:53:44 +0200
Message-Id: <20170929165347.29658-23-mreitz@redhat.com>
In-Reply-To: <20170929165347.29658-1-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 22/25] block: Do not copy exact_filename
 from format file
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
List-ID: <qemu-devel.nongnu.org>

If the a format BDS's file BDS is in turn a format BDS, we cannot simply
use the same filename, because when opening a BDS tree based on a
filename alone, qemu will create only one format node on top of one
protocol node (disregarding a potential backing file).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 415f9c49f0..cfcbd3a09f 100644
--- a/block.c
+++ b/block.c
@@ -5034,9 +5034,20 @@ void bdrv_refresh_filename(BlockDriverState *bs)
 
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
