Received: from eggs.gnu.org ([2001:4830:134:3::10]:44178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEanV-00072R-My
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEanU-0003Sb-Qa
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:30:53 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  4 May 2018 08:30:31 -0500
Message-Id: <20180504133034.1328397-2-eblake@redhat.com>
In-Reply-To: <20180504133034.1328397-1-eblake@redhat.com>
References: <20180504133034.1328397-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 1/4] nbd/client: fix
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

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
---
 nbd/client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index b9e175d1c27..7f35b5c3232 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -613,8 +613,8 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
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
2.14.3
