Received: from eggs.gnu.org ([2001:4830:134:3::10]:58376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNCq-0004G0-6W
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNCp-0000Xi-1l
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52176 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGNCo-0000X4-Tn
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:22 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  9 May 2018 13:23:26 +0200
Message-Id: <20180509112406.6183-2-quintela@redhat.com>
In-Reply-To: <20180509112406.6183-1-quintela@redhat.com>
References: <20180509112406.6183-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 01/41] migration: fix saving normal page even if
 it's been compressed
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

Fix the bug introduced by da3f56cb2e767016 (migration: remove
ram_save_compressed_page()), It should be 'return' rather than
'res'

Sorry for this stupid mistake :(

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Message-Id: <20180428081045.8878-1-xiaoguangrong@tencent.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 912810c18e..da0b567003 100644
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
2.17.0
