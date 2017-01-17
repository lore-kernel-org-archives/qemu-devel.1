Received: from eggs.gnu.org ([2001:4830:134:3::10]:50376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTN1X-0007Ak-PJ
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:13:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTN1W-0007d9-Tf
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:13:39 -0500
Received: from [59.151.112.132] (port=64480 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTN1W-0007Ql-IL
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:13:38 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Tue, 17 Jan 2017 14:18:52 +0800
Message-ID: <1484633936-25344-8-git-send-email-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <1484633936-25344-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1484633936-25344-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v9 07/11] megasas: undo the overwrites of msi
 user configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Hannes Reinecke <hare@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Commit afea4e14 seems forgetting to undo the overwrites, which is
unsuitable.

CC: Hannes Reinecke <hare@suse.de>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Marcel Apfelbaum <marcel@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 hw/scsi/megasas.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 14d6e0c6d565..c208d520c4df 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2350,11 +2350,10 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
                     "msi=off with this machine type.\n");
             error_propagate(errp, err);
             return;
-        } else if (ret) {
-            /* With msi=auto, we fall back to MSI off silently */
-            s->msi = ON_OFF_AUTO_OFF;
-            error_free(err);
         }
+        assert(!err || s->msix == ON_OFF_AUTO_AUTO);
+        /* With msi=auto, we fall back to MSI off silently */
+        error_free(err);
     }
 
     memory_region_init_io(&s->mmio_io, OBJECT(s), &megasas_mmio_ops, s,
-- 
2.1.0
