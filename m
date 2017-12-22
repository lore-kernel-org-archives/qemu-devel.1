Received: from eggs.gnu.org ([2001:4830:134:3::10]:60204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1eSAw2-000684-CI
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 19:11:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1eSAw1-0007zs-AW
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 19:11:34 -0500
From: Jack Schwartz <jack.schwartz@oracle.com>
Date: Thu, 21 Dec 2017 16:11:36 -0800
Message-Id: <1513901496-13538-2-git-send-email-jack.schwartz@oracle.com>
In-Reply-To: <1513901496-13538-1-git-send-email-jack.schwartz@oracle.com>
References: <1513901496-13538-1-git-send-email-jack.schwartz@oracle.com>
Subject: [Qemu-devel] [PATCH v1 1/1] block: Add numeric errno field to
 BLOCK_IO_ERROR events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, karl.heubaum@oracle.com, konrad.wilk@oracle.com

BLOCK_IO_ERROR events currently contain a "reason" string which is
strerror(errno) of the error.  This enhancement provides those events with
the numeric errno value as well, since it is easier to parse for error type
than a string.

Signed-off-by: Jack Schwartz <jack.schwartz@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
---
 block/block-backend.c |  2 +-
 qapi/block-core.json  | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index baef8e7..f628668 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1572,7 +1572,7 @@ static void send_qmp_error_event(BlockBackend *blk,
     qapi_event_send_block_io_error(blk_name(blk),
                                    bdrv_get_node_name(blk_bs(blk)), optype,
                                    action, blk_iostatus_is_enabled(blk),
-                                   error == ENOSPC, strerror(error),
+                                   error == ENOSPC, error, strerror(error),
                                    &error_abort);
 }
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index a8cdbc3..b7beca7 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3660,6 +3660,11 @@
 #           io-status is present, please see query-block documentation
 #           for more information (since: 2.2)
 #
+# @errno: int describing the error cause, provided for applications.
+#         (Note: while most errnos are posix compliant between OSs, it
+#         is possible some errno values can vary among different OSs.)
+#         (since 2.12)
+#
 # @reason: human readable string describing the error cause.
 #          (This field is a debugging aid for humans, it should not
 #           be parsed by applications) (since: 2.2)
@@ -3675,14 +3680,17 @@
 #      "data": { "device": "ide0-hd1",
 #                "node-name": "#block212",
 #                "operation": "write",
-#                "action": "stop" },
+#                "action": "stop",
+#                "nospace": false,
+#                "errno": 5,
+#                "reason": "Input/output error" },
 #      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
 #
 ##
 { 'event': 'BLOCK_IO_ERROR',
   'data': { 'device': 'str', 'node-name': 'str', 'operation': 'IoOperationType',
             'action': 'BlockErrorAction', '*nospace': 'bool',
-            'reason': 'str' } }
+            'errno': 'int', 'reason': 'str' } }
 
 ##
 # @BLOCK_JOB_COMPLETED:
-- 
1.8.3.1
