Received: from eggs.gnu.org ([2001:4830:134:3::10]:42234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJn-00030e-El
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJm-0004la-Ks
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:31 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:04 -0500
Message-Id: <20180723201748.25573-56-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 55/99] nbd/client: fix
 nbd_negotiate_simple_meta_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake <eblake@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Initialize received variable. Otherwise, is is possible for server to
answer without any contexts, but we will set context_id to something
random (received_id is not initialized too) and return 1, which is
wrong.

To solve it, just initialize received to false. Initialize received_id
too, just to make all possible checkers happy.

Bug was introduced in 78a33ab58782efdb206de14 "nbd: BLOCK_STATUS for
standard get_block_status function: client part" with the whole
function.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180427142002.21930-2-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit 89aa0d87634e2cb98517509dc8bdb876f26ecf8b)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 nbd/client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 3523c863fe..232ff4f46d 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -619,8 +619,8 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
 {
     int ret;
     NBDOptionReply reply;
-    uint32_t received_id;
-    bool received;
+    uint32_t received_id = 0;
+    bool received = false;
     uint32_t export_len = strlen(export);
     uint32_t context_len = strlen(context);
     uint32_t data_len = sizeof(export_len) + export_len +
-- 
2.17.1
