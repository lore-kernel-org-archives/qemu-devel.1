Received: from eggs.gnu.org ([2001:4830:134:3::10]:46585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmE7-0007mP-05
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmE2-0001GU-4w
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:35 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:42185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fPmE1-0001GA-VB
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:30 -0400
Received: by mail-pf0-x243.google.com with SMTP id w7-v6so272827pfn.9
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 02:56:29 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Mon,  4 Jun 2018 17:55:16 +0800
Message-Id: <20180604095520.8563-9-xiaoguangrong@tencent.com>
In-Reply-To: <20180604095520.8563-1-xiaoguangrong@tencent.com>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 08/12] migration: do not flush_compressed_data
 at the end of each iteration
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

flush_compressed_data() needs to wait all compression threads to
finish their work, after that all threads are free until the
migration feed new request to them, reducing its call can improve
the throughput and use CPU resource more effectively

We do not need to flush all threads at the end of iteration, the
data can be kept locally until the memory block is changed

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index f9a8646520..0a38c1c61e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1994,6 +1994,7 @@ static void ram_save_cleanup(void *opaque)
     }
 
     xbzrle_cleanup();
+    flush_compressed_data(*rsp);
     compress_threads_save_cleanup();
     ram_state_cleanup(rsp);
 }
@@ -2690,7 +2691,6 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
         }
         i++;
     }
-    flush_compressed_data(rs);
     rcu_read_unlock();
 
     /*
-- 
2.14.4
