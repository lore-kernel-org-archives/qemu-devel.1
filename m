Received: from eggs.gnu.org ([2001:4830:134:3::10]:59655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrf-0004UZ-1d
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZre-0007K2-01
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:47 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dcZrd-0007JB-Pl
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:45 -0400
Received: by mail-wm0-x241.google.com with SMTP id x64so3782691wmg.1
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 09:17:45 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  1 Aug 2017 18:17:20 +0200
Message-Id: <1501604245-33460-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
References: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 12/17] hw/scsi/vmw_pvscsi: Remove the dead error
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
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, Markus Armbruster <armbru@redhat.com>

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

qemu_bh_new() is a wrapper around aio_bh_new(), which returns
null only when g_new() does. It doesn't. So remove the dead
error handling.

Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-Id: <20170726084153.10121-1-maozy.fnst@cn.fujitsu.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
