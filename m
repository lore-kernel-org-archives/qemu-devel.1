Received: from eggs.gnu.org ([2001:4830:134:3::10]:41223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1ct2EK-0001ow-HN
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 21:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1ct2EE-0005pF-RO
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 21:16:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56583
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1ct2EE-0005os-Ka
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 21:16:50 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2T194R1017505
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 21:16:49 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29ft6fxqmx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 21:16:49 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 28 Mar 2017 19:16:49 -0600
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Wed, 29 Mar 2017 03:16:37 +0200
In-Reply-To: <20170329011637.89377-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170329011637.89377-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170329011637.89377-2-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 1/1] block: pass the right options for
 BlockDriver.bdrv_open()
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

For the other non-raw format drivers, it also makes sense to passing
in the actual options, althought they don't trigger the problem so
far.

Let's prepare a @options by adding the "file" key-value pair to a
copy of the actual options that were given for the node (i.e.
bs->options), and pass it to the callback.

BlockDriver.bdrv_open() expects bs->file to be NULL and just
overwrites it with the result from bdrv_open_child(). If that
bdrv_open_child() fails, the field becomes NULL. While we are at
it, we also correct the cleanning up action for a call failure of
BlockDriver.bdrv_open() by replacing bdrv_unref() with
bdrv_unref_child().

Suggested-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 block/snapshot.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/snapshot.c b/block/snapshot.c
index bf5c2ca..281626c 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -27,6 +27,7 @@
 #include "block/block_int.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/qmp/qstring.h"
 
 QemuOptsList internal_snapshot_opts = {
     .name = "snapshot",
@@ -189,11 +190,20 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
     }
 
     if (bs->file) {
+        QDict *options = qdict_clone_shallow(bs->options);
+        QDict *file_options;
+
+        qdict_extract_subqdict(options, &file_options, "file.");
+        QDECREF(file_options);
+        qdict_put(options, "file",
+                  qstring_from_str(bdrv_get_node_name(bs->file->bs)));
+
         drv->bdrv_close(bs);
         ret = bdrv_snapshot_goto(bs->file->bs, snapshot_id);
-        open_ret = drv->bdrv_open(bs, NULL, bs->open_flags, NULL);
+        open_ret = drv->bdrv_open(bs, options, bs->open_flags, NULL);
+        QDECREF(options);
         if (open_ret < 0) {
-            bdrv_unref(bs->file->bs);
+            bdrv_unref_child(bs, bs->file);
             bs->drv = NULL;
             return open_ret;
         }
-- 
2.8.4
