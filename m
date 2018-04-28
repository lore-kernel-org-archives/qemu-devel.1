Received: from eggs.gnu.org ([2001:4830:134:3::10]:50520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fCKxG-0003RV-31
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 04:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fCKxC-0002ZO-3o
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 04:11:38 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:40590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fCKxB-0002ZE-Tl
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 04:11:34 -0400
Received: by mail-pf0-x241.google.com with SMTP id f189so3152710pfa.7
	for <qemu-devel@nongnu.org>; Sat, 28 Apr 2018 01:11:33 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Sat, 28 Apr 2018 16:10:45 +0800
Message-Id: <20180428081045.8878-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH] migration: fix saving normal page even if it's
 been compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Fix the bug introduced by da3f56cb2e767016 (migration: remove
ram_save_compressed_page()), It should be 'return' rather than
'res'

Sorry for this stupid mistake :(

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 01cc815410..699546cc43 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1490,7 +1490,7 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
      * CPU resource.
      */
     if (block == rs->last_sent_block && save_page_use_compression(rs)) {
-        res = compress_page_with_multi_thread(rs, block, offset);
+        return compress_page_with_multi_thread(rs, block, offset);
     }
 
     return ram_save_page(rs, pss, last_stage);
-- 
2.14.3
