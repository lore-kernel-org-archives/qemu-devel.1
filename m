Received: from eggs.gnu.org ([209.51.188.92]:49660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1h0SiO-0005ua-PT
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 10:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1h0SUu-00065R-MK
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 09:53:49 -0500
Received: from mga09.intel.com ([134.134.136.24]:42884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1h0SUu-0005wf-CD
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 09:53:48 -0500
From: Zhang Chen <chen.zhang@intel.com >
Date: Sun,  3 Mar 2019 22:50:15 +0800
Message-Id: <20190303145021.2962-2-chen.zhang@intel.com>
In-Reply-To: <20190303145021.2962-1-chen.zhang@intel.com>
References: <20190303145021.2962-1-chen.zhang@intel.com>
Subject: [Qemu-devel] [PATCH V3 1/7] Migration/colo.c: Fix double close bug
 when occur COLO failover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Cc: Zhang Chen <chen.zhang@intel.com>

From: Zhang Chen <chen.zhang@intel.com>

In migration_incoming_state_destroy(void) will check the mis->to_src_file
to double close the mis->to_src_file when occur COLO failover.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/colo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/colo.c b/migration/colo.c
index 398b239d1c..a916dc178c 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -872,6 +872,7 @@ out:
     /* Must be called after failover BH is completed */
     if (mis->to_src_file) {
         qemu_fclose(mis->to_src_file);
+        mis->to_src_file = NULL;
     }
     migration_incoming_disable_colo();
 
-- 
2.17.GIT
