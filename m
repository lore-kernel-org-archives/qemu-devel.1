Received: from eggs.gnu.org ([2001:4830:134:3::10]:46101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOA9v-0004Tn-74
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOA9t-0008Sm-Hd
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fOA9t-0008SX-CJ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:33 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 30 May 2018 20:05:17 -0300
Message-Id: <20180530230528.30166-2-ehabkost@redhat.com>
In-Reply-To: <20180530230528.30166-1-ehabkost@redhat.com>
References: <20180530230528.30166-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 01/12] numa: clarify error message when node
 index is out of range in -numa dist, ...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

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
Message-Id: <1526483174-169008-1-git-send-email-imammedo@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 numa.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/numa.c b/numa.c
index aac22a9612..efc78b2f17 100644
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
2.17.1
