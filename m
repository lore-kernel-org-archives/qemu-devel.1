Received: from eggs.gnu.org ([2001:4830:134:3::10]:51126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d8pdT-0004lD-7g
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d8pdO-0002b5-8w
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:04:11 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 11 May 2017 18:03:37 +0300
Message-Id: <20170511150337.21470-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] qcow2: remove extra local_error variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

Commit d7086422b1c1e75e320519cfe26176db6ec97a37 added a local_err
variable global to the qcow2_amend_options() function, so there's no
need to have this other one.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 1c2697732b..5e9cc26c4e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3215,7 +3215,6 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
 
     if (s->refcount_bits != refcount_bits) {
         int refcount_order = ctz32(refcount_bits);
-        Error *local_error = NULL;
 
         if (new_version < 3 && refcount_bits != 16) {
             error_report("Different refcount widths than 16 bits require "
@@ -3227,9 +3226,9 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
         helper_cb_info.current_operation = QCOW2_CHANGING_REFCOUNT_ORDER;
         ret = qcow2_change_refcount_order(bs, refcount_order,
                                           &qcow2_amend_helper_cb,
-                                          &helper_cb_info, &local_error);
+                                          &helper_cb_info, &local_err);
         if (ret < 0) {
-            error_report_err(local_error);
+            error_report_err(local_err);
             return ret;
         }
     }
-- 
2.11.0
