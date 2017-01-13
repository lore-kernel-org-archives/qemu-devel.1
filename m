Received: from eggs.gnu.org ([2001:4830:134:3::10]:59452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRvx3-0008Jz-Du
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:07:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRvx2-0001VC-Aq
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:07:05 -0500
Received: from [59.151.112.132] (port=54421 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRvx0-0001HH-2n
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:07:04 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Fri, 13 Jan 2017 15:11:58 +0800
Message-ID: <1484291524-1261-5-git-send-email-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <1484291524-1261-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1484291524-1261-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 04/10] megasas: change behaviour of msix
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
Reviewed-by: Hannes Reinecke <hare@suse.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 hw/scsi/megasas.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index a946424ab234..14d6e0c6d565 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2359,19 +2359,31 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
 
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
-                  &s->mmio_io, b->mmio_bar, 0x3800, 0x68, &err)) {
-        /*TODO: check msix_init's error, and should fail on msix=on */
-        error_report_err(err);
-        s->msix = ON_OFF_AUTO_OFF;
-    }
-
     if (pci_is_express(dev)) {
         pcie_endpoint_cap_init(dev, 0xa0);
     }
-- 
2.1.0
