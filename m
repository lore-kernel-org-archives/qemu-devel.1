Received: from eggs.gnu.org ([2001:4830:134:3::10]:50684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fIy1B-00022G-Qa
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fIy17-0006oY-SU
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:07:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48076 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fIy17-0006oK-Ny
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:07:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5E26E7D858
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 15:07:01 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 16 May 2018 17:06:14 +0200
Message-Id: <1526483174-169008-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v4] numa: clarify error message when node index
 is out of range in -numa dist, ...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com, eblake@redhat.com

When using following CLI:
  -numa dist,src=128,dst=1,val=20
user gets a rather confusing error message:
   "Invalid node 128, max possible could be 128"

Where 128 is number of nodes that QEMU supports (MAX_NODES),
while src/dst is an index up to that limit, so it should be
MAX_NODES - 1 in error message.
Make error message to explicitly state valid range for node
index to be more clear.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v4:
 - e error message suggested by Markus
v3:
 - s/,/./ in error message
 - add '.' at the end of sentence
---
 numa.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/numa.c b/numa.c
index 188bfdf..33572bf 100644
--- a/numa.c
+++ b/numa.c
@@ -141,9 +141,8 @@ static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
     uint8_t val = dist->val;
 
     if (src >= MAX_NODES || dst >= MAX_NODES) {
-        error_setg(errp,
-                   "Invalid node %d, max possible could be %d",
-                   MAX(src, dst), MAX_NODES);
+        error_setg(errp, "Parameter '%s' expects an integer between 0 and %d",
+                   src >= MAX_NODES ? "src" : "dst", MAX_NODES - 1);
         return;
     }
 
-- 
2.7.4
