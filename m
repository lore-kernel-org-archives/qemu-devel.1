Received: from eggs.gnu.org ([2001:4830:134:3::10]:45612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMGH-000166-FW
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMGG-0006RU-IH
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:13 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 29 May 2017 17:06:45 +0200
Message-Id: <1496070414-6744-7-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
References: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 06/15] qcow2: remove extra local_error variable
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

From: Alberto Garcia <berto@igalia.com>

Commit d7086422b1c1e75e320519cfe26176db6ec97a37 added a local_err
variable global to the qcow2_amend_options() function, so there's no
need to have this other one.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-id: 20170511150337.21470-1-berto@igalia.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index a8d61f0..b3ba5da 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3222,7 +3222,6 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
 
     if (s->refcount_bits != refcount_bits) {
         int refcount_order = ctz32(refcount_bits);
-        Error *local_error = NULL;
 
         if (new_version < 3 && refcount_bits != 16) {
             error_report("Different refcount widths than 16 bits require "
@@ -3234,9 +3233,9 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
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
1.8.3.1
