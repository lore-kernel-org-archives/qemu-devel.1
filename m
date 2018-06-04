Received: from eggs.gnu.org ([2001:4830:134:3::10]:46490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmDm-0007S3-N5
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmDm-000180-2x
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:14 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:39554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fPmDl-00017a-Su
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:14 -0400
Received: by mail-pg0-x22e.google.com with SMTP id w12-v6so13037391pgc.6
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 02:56:13 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Mon,  4 Jun 2018 17:55:11 +0800
Message-Id: <20180604095520.8563-4-xiaoguangrong@tencent.com>
In-Reply-To: <20180604095520.8563-1-xiaoguangrong@tencent.com>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 03/12] migration: fix counting xbzrle
 cache_miss_rate
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

Sync up xbzrle_cache_miss_prev only after migration iteration goes
forward

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index dbf24d8c87..dd1283dd45 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1189,9 +1189,9 @@ static void migration_bitmap_sync(RAMState *rs)
                    (double)(xbzrle_counters.cache_miss -
                             rs->xbzrle_cache_miss_prev) /
                    (rs->iterations - rs->iterations_prev);
+                rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
             }
             rs->iterations_prev = rs->iterations;
-            rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
         }
 
         /* reset period counters */
-- 
2.14.4
