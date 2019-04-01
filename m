Received: from eggs.gnu.org ([209.51.188.92]:43041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47A-0003ky-D9
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB478-00052B-Ai
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42542
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB477-0004nn-Ro
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4dLF053700
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:48 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rkrjx582g-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:41 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:15 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:14 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-41-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 40/97] block/rbd: pull out
 qemu_rbd_convert_options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jeff Cody <jcody@redhat.com>

From: Jeff Cody <jcody@redhat.com>

Code movement to pull the conversion from Qdict to BlockdevOptionsRbd
into a helper function.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
Message-id: 5b49a980f2cde6610ab1df41bb0277d00b5db893.1536704901.git.jcody@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
(cherry picked from commit f24b03b56cdb28d753b4ff9ae210d555f14cb0d8)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/rbd.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index ca8e5bbace..b199450f9f 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -655,12 +655,34 @@ failed_opts:
     return r;
 }
 
+static int qemu_rbd_convert_options(QDict *options, BlockdevOptionsRbd **opts,
+                                    Error **errp)
+{
+    Visitor *v;
+    Error *local_err = NULL;
+
+    /* Convert the remaining options into a QAPI object */
+    v = qobject_input_visitor_new_flat_confused(options, errp);
+    if (!v) {
+        return -EINVAL;
+    }
+
+    visit_type_BlockdevOptionsRbd(v, NULL, opts, &local_err);
+    visit_free(v);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
                          Error **errp)
 {
     BDRVRBDState *s = bs->opaque;
     BlockdevOptionsRbd *opts = NULL;
-    Visitor *v;
     const QDictEntry *e;
     Error *local_err = NULL;
     char *keypairs, *secretid;
@@ -676,19 +698,9 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         qdict_del(options, "password-secret");
     }
 
-    /* Convert the remaining options into a QAPI object */
-    v = qobject_input_visitor_new_flat_confused(options, errp);
-    if (!v) {
-        r = -EINVAL;
-        goto out;
-    }
-
-    visit_type_BlockdevOptionsRbd(v, NULL, &opts, &local_err);
-    visit_free(v);
-
+    r = qemu_rbd_convert_options(options, &opts, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        r = -EINVAL;
         goto out;
     }
 
-- 
2.17.1
