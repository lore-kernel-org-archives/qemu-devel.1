Received: from eggs.gnu.org ([2001:4830:134:3::10]:42428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ey2iv-0002TF-2O
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ey2is-0000d5-2X
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:53:45 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 19 Mar 2018 16:53:35 -0500
Message-Id: <20180319215335.1119213-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12] rdma: Fix 32-bit compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Yuval Shaia <yuval.shaia@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>

Use the correct printf formats, so that a 32-bit compile doesn't
spit out lots of warnings about %lx being incompatible with uint64_t.
Broken since initial commit ef6d4ccd.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

I don't know if 'make vm-build-ubuntu.i368' would catch this (it failed
for me for other reasons); I found it via a 32-bit rawhide VM.

 hw/rdma/rdma_backend.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index e306fba5344..89020fdcf62 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -656,7 +656,8 @@ void rdma_backend_destroy_qp(RdmaBackendQP *qp)
 #define CHK_ATTR(req, dev, member, fmt) ({ \
     pr_dbg("%s="fmt","fmt"\n", #member, dev.member, req->member); \
     if (req->member > dev.member) { \
-        warn_report("%s = 0x%lx is higher than host device capability 0x%lx", \
+        warn_report("%s = 0x%" PRIx64 " is higher than host device " \
+                    "capability 0x%" PRIx64, \
                     #member, (uint64_t)req->member, (uint64_t)dev.member); \
         req->member = dev.member; \
     } \
-- 
2.14.3
