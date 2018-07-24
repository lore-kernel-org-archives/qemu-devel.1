Received: from eggs.gnu.org ([2001:4830:134:3::10]:45996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fi29J-0008Sx-Rr
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fi29I-0002lG-PS
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35420 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fi29I-0002km-JV
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:04 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jul 2018 19:34:51 +0100
Message-Id: <20180724183454.120276-5-dgilbert@redhat.com>
In-Reply-To: <20180724183454.120276-1-dgilbert@redhat.com>
References: <20180724183454.120276-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] migration: update recv bitmap only on dest
 vm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, kraxel@redhat.com, lidongchen@tencent.com

From: Peter Xu <peterx@redhat.com>

We shouldn't update the received bitmap if we're the source VM.  This
fixes a breakage when release-ram is enabled on postcopy.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180723123305.24792-2-peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index fdd108475c..24dea2730c 100644
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
