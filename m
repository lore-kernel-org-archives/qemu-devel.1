Received: from eggs.gnu.org ([2001:4830:134:3::10]:48442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1crPtq-00037S-QO
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1crPtp-0006wG-R4
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:09:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1crPtp-0006w3-Ll
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:09:05 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 24 Mar 2017 14:08:52 +0000
Message-Id: <20170324140854.28134-3-stefanha@redhat.com>
In-Reply-To: <20170324140854.28134-1-stefanha@redhat.com>
References: <20170324140854.28134-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 2/3] trace: Fix incorrect megasas trace
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Eric Blake <eblake@redhat.com>

hw/scsi/trace-events lists cmd as the first parameter for both
megasas_iovec_overflow and megasas_iovec_underflow, but the caller
was mistakenly passing cmd->iov_size twice instead of the command
index.  Also, trace_megasas_abort_invalid is called with parameters
in the wrong order.  Broken since its introduction in commit
e8f943c3.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/megasas.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index e3d59b7..84b8caf 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -291,7 +291,7 @@ static int megasas_map_sgl(MegasasState *s, MegasasCmd *cmd, union mfi_sgl *sgl)
     if (cmd->iov_size > iov_size) {
         trace_megasas_iovec_overflow(cmd->index, iov_size, cmd->iov_size);
     } else if (cmd->iov_size < iov_size) {
-        trace_megasas_iovec_underflow(cmd->iov_size, iov_size, cmd->iov_size);
+        trace_megasas_iovec_underflow(cmd->index, iov_size, cmd->iov_size);
     }
     cmd->iov_offset = 0;
     return 0;
@@ -1924,8 +1924,8 @@ static int megasas_handle_abort(MegasasState *s, MegasasCmd *cmd)
         abort_ctx &= (uint64_t)0xFFFFFFFF;
     }
     if (abort_cmd->context != abort_ctx) {
-        trace_megasas_abort_invalid_context(cmd->index, abort_cmd->index,
-                                            abort_cmd->context);
+        trace_megasas_abort_invalid_context(cmd->index, abort_cmd->context,
+                                            abort_cmd->index);
         s->event_count++;
         return MFI_STAT_ABORT_NOT_POSSIBLE;
     }
-- 
2.9.3
