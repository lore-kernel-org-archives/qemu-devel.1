Received: from eggs.gnu.org ([2001:4830:134:3::10]:45344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TEM-0002wh-Ak
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TEL-0003tz-HM
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:14 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 26 Mar 2018 16:35:47 +0200
Message-Id: <20180326143600.7724-7-kwolf@redhat.com>
In-Reply-To: <20180326143600.7724-1-kwolf@redhat.com>
References: <20180326143600.7724-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 06/19] include/block/block_int: Document
 protocol related functions
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

From: Fabiano Rosas <farosas@linux.vnet.ibm.com>

Clarify that:

- for protocols the brdv_file_open function is used instead
of bdrv_open;

- when protocol_name is set, a driver should expect
to be given only a filename and no other options.

Signed-off-by: Fabiano Rosas <farosas@linux.vnet.ibm.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 27e17addba..c4dd1d4bb8 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -126,6 +126,8 @@ struct BlockDriver {
 
     int (*bdrv_open)(BlockDriverState *bs, QDict *options, int flags,
                      Error **errp);
+
+    /* Protocol drivers should implement this instead of bdrv_open */
     int (*bdrv_file_open)(BlockDriverState *bs, QDict *options, int flags,
                           Error **errp);
     void (*bdrv_close)(BlockDriverState *bs);
@@ -251,6 +253,12 @@ struct BlockDriver {
      */
     int coroutine_fn (*bdrv_co_flush_to_os)(BlockDriverState *bs);
 
+    /*
+     * Drivers setting this field must be able to work with just a plain
+     * filename with '<protocol_name>:' as a prefix, and no other options.
+     * Options may be extracted from the filename by implementing
+     * bdrv_parse_filename.
+     */
     const char *protocol_name;
     int (*bdrv_truncate)(BlockDriverState *bs, int64_t offset,
                          PreallocMode prealloc, Error **errp);
-- 
2.13.6
