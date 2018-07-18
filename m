Received: from eggs.gnu.org ([2001:4830:134:3::10]:52976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoal-0003Hp-Jn
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoag-0000Gx-DP
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:36354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1ffoag-0000FA-33
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:10 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Wed, 18 Jul 2018 18:41:47 +0300
Message-Id: <20180718154200.26777-5-dplotnikov@virtuozzo.com>
In-Reply-To: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v1 04/17] background snapshot: make a dedicated
 type for ram block list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

The type will be used later to hold a list of ram blocks which
memory content to be used for the vm state saving when making
a background snapshot.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 include/exec/ramlist.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
index 2e2ac6cb99..e0231d3bec 100644
--- a/include/exec/ramlist.h
+++ b/include/exec/ramlist.h
@@ -44,11 +44,13 @@ typedef struct {
     unsigned long *blocks[];
 } DirtyMemoryBlocks;
 
+typedef QLIST_HEAD(, RAMBlock) RamBlockList;
+
 typedef struct RAMList {
     QemuMutex mutex;
     RAMBlock *mru_block;
     /* RCU-enabled, writes protected by the ramlist lock. */
-    QLIST_HEAD(, RAMBlock) blocks;
+    RamBlockList blocks;
     DirtyMemoryBlocks *dirty_memory[DIRTY_MEMORY_NUM];
     uint32_t version;
     QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
-- 
2.17.0
