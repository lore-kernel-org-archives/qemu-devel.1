Received: from eggs.gnu.org ([2001:4830:134:3::10]:38512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1csKyK-0004sw-O1
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 23:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1csKyH-00042a-JT
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 23:05:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1csKyH-00042F-9o
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 23:05:29 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2R33ah0053721
	for <qemu-devel@nongnu.org>; Sun, 26 Mar 2017 23:05:27 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29dmq3hxc7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 26 Mar 2017 23:05:27 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Sun, 26 Mar 2017 23:05:26 -0400
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Mon, 27 Mar 2017 05:05:18 +0200
In-Reply-To: <20170327030518.37268-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170327030518.37268-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170327030518.37268-2-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC v2 1/1] block: pass the right options for
 BlockDriver.bdrv_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-devel@nongnu.org, bjsdjshi@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com

raw_open() expects the caller always passing in the right actual
@options parameter. But when trying to applying snapshot on a RBD
image, bdrv_snapshot_goto() calls raw_open() (by calling the
bdrv_open callback on the BlockDriver) with a NULL @options, and
that will result in a Segmentation fault.

For the other non-raw format drivers, it also make sense to passing
in the actual options, althought they don't trigger the problem so
far.

Let's prepare a @options by adding the "file" key-value pair to a
copy of the actual options that were given for the node (i.e.
bs->options), and pass it to the callback.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 block/snapshot.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/snapshot.c b/block/snapshot.c
index bf5c2ca..dfec139 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -27,6 +27,7 @@
 #include "block/block_int.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/qmp/qstring.h"
 
 QemuOptsList internal_snapshot_opts = {
     .name = "snapshot",
@@ -189,9 +190,14 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
     }
 
     if (bs->file) {
+        QDict *options = qdict_clone_shallow(bs->options);
+        qdict_put(options, "file",
+                  qstring_from_str(bdrv_get_node_name(bs->file->bs)));
+
         drv->bdrv_close(bs);
         ret = bdrv_snapshot_goto(bs->file->bs, snapshot_id);
-        open_ret = drv->bdrv_open(bs, NULL, bs->open_flags, NULL);
+        open_ret = drv->bdrv_open(bs, options, bs->open_flags, NULL);
+        QDECREF(options);
         if (open_ret < 0) {
             bdrv_unref(bs->file->bs);
             bs->drv = NULL;
-- 
2.8.4
