Received: from eggs.gnu.org ([2001:4830:134:3::10]:33687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmE4-00024z-3C
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmE3-0002rS-9z
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cVmE3-0002pV-4b
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:31 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5845CC057FA7
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 21:32:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Jan 2017 22:32:07 +0100
Message-Id: <1485207141-1941-4-git-send-email-quintela@redhat.com>
In-Reply-To: <1485207141-1941-1-git-send-email-quintela@redhat.com>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 03/17] migration: Test for disabled features on
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
Cc: amit.shah@redhat.com, dgilbert@redhat.com

Right now, if we receive a compressed page or a xbzrle page while this
features are disabled, Bad Things (TM) can happen.  Just add a test for
them.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index ef8fadf..4ad814a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2455,7 +2455,7 @@ static int ram_load_postcopy(QEMUFile *f)

 static int ram_load(QEMUFile *f, void *opaque, int version_id)
 {
-    int flags = 0, ret = 0;
+    int flags = 0, ret = 0, invalid_flags;
     static uint64_t seq_iter;
     int len = 0;
     /*
@@ -2470,6 +2470,15 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
         ret = -EINVAL;
     }

+    invalid_flags = 0;
+
+    if (!migrate_use_xbzrle()) {
+        invalid_flags |= RAM_SAVE_FLAG_XBZRLE;
+    }
+
+    if (!migrate_use_compression()) {
+        invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
+    }
     /* This RCU critical section can be very long running.
      * When RCU reclaims in the code start to become numerous,
      * it will be necessary to reduce the granularity of this
@@ -2490,6 +2499,18 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
         flags = addr & ~TARGET_PAGE_MASK;
         addr &= TARGET_PAGE_MASK;

+        if (flags & invalid_flags) {
+            if (flags & invalid_flags  & RAM_SAVE_FLAG_XBZRLE) {
+                error_report("Received an unexpected XBRLE page");
+            }
+            if (flags & invalid_flags  & RAM_SAVE_FLAG_COMPRESS_PAGE) {
+                error_report("Received an unexpected compressed page");
+            }
+
+            ret = -EINVAL;
+            break;
+        }
+
         if (flags & (RAM_SAVE_FLAG_COMPRESS | RAM_SAVE_FLAG_PAGE |
                      RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
             RAMBlock *block = ram_block_from_stream(f, flags);
-- 
2.9.3
