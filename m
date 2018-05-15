Received: from eggs.gnu.org ([2001:4830:134:3::10]:38303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fIXOw-0008KS-B9
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fIXOs-0005aL-Tj
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:41:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53384 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fIXOs-0005Zj-Oq
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:41:46 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 15 May 2018 12:40:58 +0200
Message-Id: <1526380858-44651-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH] numa: clarify error message when node index is
 out of range in -numa dist, ...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, he.chen@linux.intel.com

When using following CLI:
  -numa dist,src=128,dst=1,val=20
user getsi a rather confusing error message:
   "Invalid node 128, max possible could be 128"

Where 128 is number of nodes that QEMU supports (MAX_NODES),
while src/dst is an index up to that limit, so it should be
MAX_NODES - 1 in error message.
Make error message to explicitly state valid range for node
index to be more clear.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 numa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/numa.c b/numa.c
index a3637cc..dedc149 100644
--- a/numa.c
+++ b/numa.c
@@ -142,8 +142,8 @@ static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
 
     if (src >= MAX_NODES || dst >= MAX_NODES) {
         error_setg(errp,
-                   "Invalid node %d, max possible could be %d",
-                   MAX(src, dst), MAX_NODES);
+                   "Invalid node %d, should be in range [0 - %d]",
+                   MAX(src, dst), MAX_NODES - 1);
         return;
     }
 
-- 
2.7.4
