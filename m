Received: from eggs.gnu.org ([2001:4830:134:3::10]:50349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTN1W-00079k-QF
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:13:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTN1V-0007cJ-Sh
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:13:38 -0500
Received: from [59.151.112.132] (port=64480 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTN1V-0007Ql-Fh
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:13:37 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Tue, 17 Jan 2017 14:18:50 +0800
Message-ID: <1484633936-25344-6-git-send-email-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <1484633936-25344-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1484633936-25344-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v9 05/11] megasas: change behaviour of msix
 switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Hannes Reinecke <hare@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Resolve the TODO, msix=auto means msix on; if user specify msix=on,
then device creation fail on msix_init failure.
Also undo the overwrites of user configuration of msix.

CC: Michael S. Tsirkin <mst@redhat.com>
CC: Hannes Reinecke <hare@suse.de>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Marcel Apfelbaum <marcel@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 hw/scsi/megasas.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 095dba8b36de..14d6e0c6d565 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2359,18 +2359,31 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
 
     memory_region_init_io(&s->mmio_io, OBJECT(s), &megasas_mmio_ops, s,
                           "megasas-mmio", 0x4000);
+    if (megasas_use_msix(s)) {
+        ret = msix_init(dev, 15, &s->mmio_io, b->mmio_bar, 0x2000,
+                        &s->mmio_io, b->mmio_bar, 0x3800, 0x68, &err);
+        /* Any error other than -ENOTSUP(board's MSI support is broken)
+         * is a programming error */
+        assert(!ret || ret == -ENOTSUP);
+        if (ret && s->msix == ON_OFF_AUTO_ON) {
+            /* Can't satisfy user's explicit msix=on request, fail */
+            error_append_hint(&err, "You have to use msix=auto (default) or "
+                    "msix=off with this machine type.\n");
+            /* No instance_finalize method, need to free the resource here */
+            object_unref(OBJECT(&s->mmio_io));
+            error_propagate(errp, err);
+            return;
+        }
+        assert(!err || s->msix == ON_OFF_AUTO_AUTO);
+        /* With msix=auto, we fall back to MSI off silently */
+        error_free(err);
+    }
+
     memory_region_init_io(&s->port_io, OBJECT(s), &megasas_port_ops, s,
                           "megasas-io", 256);
     memory_region_init_io(&s->queue_io, OBJECT(s), &megasas_queue_ops, s,
                           "megasas-queue", 0x40000);
 
-    if (megasas_use_msix(s) &&
-        msix_init(dev, 15, &s->mmio_io, b->mmio_bar, 0x2000,
-                  &s->mmio_io, b->mmio_bar, 0x3800, 0x68, NULL)) {
-        /* TODO: check msix_init's error, and should fail on msix=on */
-        s->msix = ON_OFF_AUTO_OFF;
-    }
-
     if (pci_is_express(dev)) {
         pcie_endpoint_cap_init(dev, 0xa0);
     }
-- 
2.1.0
