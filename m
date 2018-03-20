Received: from eggs.gnu.org ([2001:4830:134:3::10]:51775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyLC0-0000OG-WE
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyLC0-0000Y1-9M
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:37:01 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 20 Mar 2018 18:36:31 +0100
Message-Id: <20180320173632.25480-12-kwolf@redhat.com>
In-Reply-To: <20180320173632.25480-1-kwolf@redhat.com>
References: <20180320173632.25480-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 11/12] vhdx: Check for 4 GB maximum
 log size on creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, jcody@redhat.com, eblake@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

It's unclear what the real maximum is, but we use an uint32_t to store
the log size in vhdx_co_create(), so we should check that the given
value fits in 32 bits.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vhdx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/vhdx.c b/block/vhdx.c
index 0e48179b81..a1a0302799 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1829,6 +1829,10 @@ static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
     if (!vhdx_opts->has_log_size) {
         log_size = DEFAULT_LOG_SIZE;
     } else {
+        if (vhdx_opts->log_size > UINT32_MAX) {
+            error_setg(errp, "Log size must be smaller than 4 GB");
+            return -EINVAL;
+        }
         log_size = vhdx_opts->log_size;
     }
     if (log_size < MiB || (log_size % MiB) != 0) {
-- 
2.13.6
