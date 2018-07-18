Received: from eggs.gnu.org ([2001:4830:134:3::10]:52985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoal-0003Ht-M3
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoag-0000IW-OY
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:36382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1ffoag-0000FC-BY
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:10 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Wed, 18 Jul 2018 18:41:48 +0300
Message-Id: <20180718154200.26777-6-dplotnikov@virtuozzo.com>
In-Reply-To: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v1 05/17] ram: extend the data structures for
 background snapshotting
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

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 include/exec/ram_addr.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 6cbc02aa0f..5b403d537d 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -36,6 +36,8 @@ struct RAMBlock {
     char idstr[256];
     /* RCU-enabled, writes protected by the ramlist lock */
     QLIST_ENTRY(RAMBlock) next;
+    /* blocks used for background snapshot */
+    QLIST_ENTRY(RAMBlock) bgs_next;
     QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
     int fd;
     size_t page_size;
@@ -49,6 +51,11 @@ struct RAMBlock {
     unsigned long *unsentmap;
     /* bitmap of already received pages in postcopy */
     unsigned long *receivedmap;
+    /* The following 2 are for background snapshot */
+    /* Pages currently being copied */
+    unsigned long *touched_map;
+    /* Pages has been copied already */
+    unsigned long *copied_map;
 };
 
 static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
-- 
2.17.0
