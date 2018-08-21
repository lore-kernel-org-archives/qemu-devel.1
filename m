Received: from eggs.gnu.org ([2001:4830:134:3::10]:47329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fs1l3-00045l-Dz
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fs1l2-00058q-Jp
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:11:21 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:42927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fs1l2-00056y-9i
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:11:20 -0400
Received: by mail-pl0-x241.google.com with SMTP id g23-v6so5466269plq.9
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 01:11:20 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 21 Aug 2018 16:10:29 +0800
Message-Id: <20180821081029.26121-11-xiaoguangrong@tencent.com>
In-Reply-To: <20180821081029.26121-1-xiaoguangrong@tencent.com>
References: <20180821081029.26121-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v4 10/10] migration: handle the error condition
 properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

ram_find_and_save_block() can return negative if any error hanppens,
however, it is completely ignored in current code

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 0a31767351..74899b485f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2412,7 +2412,8 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
  *
  * Called within an RCU critical section.
  *
- * Returns the number of pages written where zero means no dirty pages
+ * Returns the number of pages written where zero means no dirty pages,
+ * or negative on error
  *
  * @rs: current RAM state
  * @last_stage: if we are at the completion stage
@@ -3236,6 +3237,12 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
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
@@ -3278,7 +3285,7 @@ out:
 /**
  * ram_save_complete: function called to send the remaining amount of ram
  *
- * Returns zero to indicate success
+ * Returns zero to indicate success or negative on error
  *
  * Called with iothread lock
  *
@@ -3289,6 +3296,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 {
     RAMState **temp = opaque;
     RAMState *rs = *temp;
+    int ret = 0;
 
     rcu_read_lock();
 
@@ -3309,6 +3317,10 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         if (pages == 0) {
             break;
         }
+        if (pages < 0) {
+            ret = pages;
+            break;
+        }
     }
 
     flush_compressed_data(rs);
@@ -3320,7 +3332,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     qemu_fflush(f);
 
-    return 0;
+    return ret;
 }
 
 static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
-- 
2.14.4
