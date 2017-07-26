Received: from eggs.gnu.org ([2001:4830:134:3::10]:50133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daHu2-0002Or-He
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daHty-0003u4-Pv
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:42:46 -0400
Received: from [59.151.112.132] (port=30138 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daHty-0003sj-EF
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:42:42 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 26 Jul 2017 16:41:52 +0800
Message-ID: <20170726084153.10121-1-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/2] hw/scsi/vmw_pvscsi: Remove the dead error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry@daynix.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

qemu_bh_new() is a wrapper around aio_bh_new(), which returns
null only when g_new() does. It doesn't. So remove the dead
error handling.

Cc: Dmitry Fleytman <dmitry@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 hw/scsi/vmw_pvscsi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 4a106da..d92973e 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1138,10 +1138,6 @@ pvscsi_init(PCIDevice *pci_dev)
     }
 
     s->completion_worker = qemu_bh_new(pvscsi_process_completion_queue, s);
-    if (!s->completion_worker) {
-        pvscsi_cleanup_msi(s);
-        return -ENOMEM;
-    }
 
     scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(pci_dev),
                  &pvscsi_scsi_info, NULL);
-- 
2.9.4
