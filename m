Received: from eggs.gnu.org ([2001:4830:134:3::10]:52328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dL6q4-0007tf-0c
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dL6q3-0000TP-2W
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:51:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dL6q2-0000TK-Sb
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:51:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF14F3B470
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 11:51:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 14 Jun 2017 13:51:37 +0200
Message-Id: <20170614115138.19571-5-quintela@redhat.com>
In-Reply-To: <20170614115138.19571-1-quintela@redhat.com>
References: <20170614115138.19571-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] migration: Test for disabled features on
 reception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Right now, if we receive a compressed page while this features are
disabled, Bad Things (TM) can happen.  Just add a test for them.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>

--

I had XBZRLE here also, but it don't need extra resources on
destination, only on source.  Additionally libvirt don't enable it on
destination, so don't put it here.

- initialize invalid_flags at declaration time.
- remove extra space (peter)
---
 migration/ram.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 7f687f5..09b483c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2455,7 +2455,7 @@ static int ram_load_postcopy(QEMUFile *f)
 
 static int ram_load(QEMUFile *f, void *opaque, int version_id)
 {
-    int flags = 0, ret = 0;
+    int flags = 0, ret = 0, invalid_flags = 0;
     static uint64_t seq_iter;
     int len = 0;
     /*
@@ -2472,6 +2472,9 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
         ret = -EINVAL;
     }
 
+    if (!migrate_use_compression()) {
+        invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
+    }
     /* This RCU critical section can be very long running.
      * When RCU reclaims in the code start to become numerous,
      * it will be necessary to reduce the granularity of this
@@ -2492,6 +2495,15 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
         flags = addr & ~TARGET_PAGE_MASK;
         addr &= TARGET_PAGE_MASK;
 
+        if (flags & invalid_flags) {
+            if (flags & invalid_flags & RAM_SAVE_FLAG_COMPRESS_PAGE) {
+                error_report("Received an unexpected compressed page");
+            }
+
+            ret = -EINVAL;
+            break;
+        }
+
         if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
                      RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
             RAMBlock *block = ram_block_from_stream(f, flags);
-- 
2.9.4
