Received: from eggs.gnu.org ([2001:4830:134:3::10]:34314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwxKO-0004PW-Ii
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 18:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwxKN-0003Ha-Nn
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 18:28:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60608 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fwxKN-0003Gm-IN
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 18:28:11 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Tue,  4 Sep 2018 00:27:57 +0200
Message-Id: <20180903222758.13267-5-quintela@redhat.com>
In-Reply-To: <20180903222758.13267-1-quintela@redhat.com>
References: <20180903222758.13267-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] migration: handle the error condition
 properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

ram_find_and_save_block() can return negative if any error hanppens,
however, it is completely ignored in current code

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20180903092644.25812-5-xiaoguangrong@tencent.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5a54836c28..2add09174d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2372,7 +2372,8 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
  *
  * Called within an RCU critical section.
  *
- * Returns the number of pages written where zero means no dirty pages
+ * Returns the number of pages written where zero means no dirty pages,
+ * or negative on error
  *
  * @rs: current RAM state
  * @last_stage: if we are at the completion stage
@@ -3196,6 +3197,12 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
             done = 1;
             break;
         }
+
+        if (pages < 0) {
+            qemu_file_set_error(f, pages);
+            break;
+        }
+
         rs->target_page_count += pages;
 
         /* we want to check in the 1st loop, just in case it was the 1st time
@@ -3238,7 +3245,7 @@ out:
 /**
  * ram_save_complete: function called to send the remaining amount of ram
  *
- * Returns zero to indicate success
+ * Returns zero to indicate success or negative on error
  *
  * Called with iothread lock
  *
@@ -3249,6 +3256,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 {
     RAMState **temp = opaque;
     RAMState *rs = *temp;
+    int ret = 0;
 
     rcu_read_lock();
 
@@ -3269,6 +3277,10 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         if (pages == 0) {
             break;
         }
+        if (pages < 0) {
+            ret = pages;
+            break;
+        }
     }
 
     flush_compressed_data(rs);
@@ -3280,7 +3292,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     qemu_fflush(f);
 
-    return 0;
+    return ret;
 }
 
 static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
-- 
2.17.1
