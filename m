Received: from eggs.gnu.org ([2001:4830:134:3::10]:38411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fha1f-0003bx-5Z
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:33:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fha1a-0004o4-LC
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:33:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59008 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fha1a-0004nq-Gi
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:33:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E7FB81A4EA0
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 12:33:14 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 23 Jul 2018 20:33:02 +0800
Message-Id: <20180723123305.24792-2-peterx@redhat.com>
In-Reply-To: <20180723123305.24792-1-peterx@redhat.com>
References: <20180723123305.24792-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.0 1/4] migration: update recv bitmap only
 on dest vm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

We shouldn't update the received bitmap if we're the source VM.  This
fixes a breakage when release-ram is enabled on postcopy.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 52dd678092..be6dfef50a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2827,8 +2827,15 @@ int ram_discard_range(const char *rbname, uint64_t start, size_t length)
         goto err;
     }
 
-    bitmap_clear(rb->receivedmap, start >> qemu_target_page_bits(),
-                 length >> qemu_target_page_bits());
+    /*
+     * On source VM, we don't need to update the received bitmap since
+     * we don't even have one.
+     */
+    if (rb->receivedmap) {
+        bitmap_clear(rb->receivedmap, start >> qemu_target_page_bits(),
+                     length >> qemu_target_page_bits());
+    }
+
     ret = ram_block_discard_range(rb, start, length);
 
 err:
-- 
2.17.1
