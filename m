Received: from eggs.gnu.org ([2001:4830:134:3::10]:57701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKIF-0007u6-9D
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKIB-0004nF-Vi
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdKIB-0004ml-Py
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:19:59 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 075593D952
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 17:20:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Feb 2017 18:19:37 +0100
Message-Id: <1487006388-7966-2-git-send-email-quintela@redhat.com>
In-Reply-To: <1487006388-7966-1-git-send-email-quintela@redhat.com>
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 01/12] migration: Test for disabled features on
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

Right now, if we receive a compressed page while this features are
disabled, Bad Things (TM) can happen.  Just add a test for them.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

I had XBZRLE here also, but it don't need extra resources on
destination, only on source.  Additionally libvirt don't enable it on
destination, so don't put it here.
---
 migration/ram.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index ef8fadf..5817f8c 100644
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
@@ -2470,6 +2470,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
         ret = -EINVAL;
     }

+    invalid_flags = 0;
+
+    if (!migrate_use_compression()) {
+        invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
+    }
     /* This RCU critical section can be very long running.
      * When RCU reclaims in the code start to become numerous,
      * it will be necessary to reduce the granularity of this
@@ -2490,6 +2495,15 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
         flags = addr & ~TARGET_PAGE_MASK;
         addr &= TARGET_PAGE_MASK;

+        if (flags & invalid_flags) {
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
2.7.4
