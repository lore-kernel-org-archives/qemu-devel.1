Received: from eggs.gnu.org ([208.118.235.92]:43254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fvQsQ-0004jy-5A
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 13:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fvQsN-0001Ju-HD
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 13:37:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51558 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fvQsN-0001Jl-CX
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 13:36:59 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 30 Aug 2018 18:36:57 +0100
Message-Id: <20180830173657.22939-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] migration/rdma: Fix uninitialised
 rdma_return_path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, cohuck@redhat.com, jemmy858585@gmail.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Clang correctly errors out moaning that rdma_return_path
is used uninitialised in the earlier error paths.
Make it NULL so that the error path ignores it.

Fixes: 55cc1b5937a8e709e4c102e74b206281073aab82
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reprorted by: Cornelia Huck <cohuck@redhat.com>
---
 migration/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index ae07515e83..9b2e7e10aa 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4012,7 +4012,7 @@ static void rdma_accept_incoming_migration(void *opaque)
 void rdma_start_incoming_migration(const char *host_port, Error **errp)
 {
     int ret;
-    RDMAContext *rdma, *rdma_return_path;
+    RDMAContext *rdma, *rdma_return_path = NULL;
     Error *local_err = NULL;
 
     trace_rdma_start_incoming_migration();
-- 
2.17.1
