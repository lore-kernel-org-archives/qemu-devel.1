Received: from eggs.gnu.org ([2001:4830:134:3::10]:59686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRvxL-0000B8-DT
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRvxH-0001vo-5a
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:07:23 -0500
Received: from [59.151.112.132] (port=3578 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRvxG-0001o3-M6
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:07:19 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Fri, 13 Jan 2017 15:12:04 +0800
Message-ID: <1484291524-1261-11-git-send-email-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <1484291524-1261-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1484291524-1261-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 10/10] megasas: remove unnecessary
 megasas_use_msix()
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

Also move certain hunk above, to place msix init related code together.

CC: Hannes Reinecke <hare@suse.de>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Marcel Apfelbaum <marcel@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 hw/scsi/megasas.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

msix_init() doesn't set the MSI-X enable bit, so use msix_enabled()
is not right here, restore the old check without the
megasas_use_msix() wrapper.

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index c208d520c4df..73eab7844ee3 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -155,11 +155,6 @@ static bool megasas_use_queue64(MegasasState *s)
     return s->flags & MEGASAS_MASK_USE_QUEUE64;
 }
 
-static bool megasas_use_msix(MegasasState *s)
-{
-    return s->msix != ON_OFF_AUTO_OFF;
-}
-
 static bool megasas_is_jbod(MegasasState *s)
 {
     return s->flags & MEGASAS_MASK_USE_JBOD;
@@ -2305,9 +2300,7 @@ static void megasas_scsi_uninit(PCIDevice *d)
 {
     MegasasState *s = MEGASAS(d);
 
-    if (megasas_use_msix(s)) {
-        msix_uninit(d, &s->mmio_io, &s->mmio_io);
-    }
+    msix_uninit(d, &s->mmio_io, &s->mmio_io);
     msi_uninit(d);
 }
 
@@ -2358,7 +2351,7 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
 
     memory_region_init_io(&s->mmio_io, OBJECT(s), &megasas_mmio_ops, s,
                           "megasas-mmio", 0x4000);
-    if (megasas_use_msix(s)) {
+    if (s->msix != ON_OFF_AUTO_OFF) {
         ret = msix_init(dev, 15, &s->mmio_io, b->mmio_bar, 0x2000,
                         &s->mmio_io, b->mmio_bar, 0x3800, 0x68, &err);
         /* Any error other than -ENOTSUP(board's MSI support is broken)
@@ -2378,6 +2371,10 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
         error_free(err);
     }
 
+    if (s->msix != ON_OFF_AUTO_OFF) {
+        msix_vector_use(dev, 0);
+    }
+
     memory_region_init_io(&s->port_io, OBJECT(s), &megasas_port_ops, s,
                           "megasas-io", 256);
     memory_region_init_io(&s->queue_io, OBJECT(s), &megasas_queue_ops, s,
@@ -2393,10 +2390,6 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(dev, b->mmio_bar, bar_type, &s->mmio_io);
     pci_register_bar(dev, 3, bar_type, &s->queue_io);
 
-    if (megasas_use_msix(s)) {
-        msix_vector_use(dev, 0);
-    }
-
     s->fw_state = MFI_FWSTATE_READY;
     if (!s->sas_addr) {
         s->sas_addr = ((NAA_LOCALLY_ASSIGNED_ID << 24) |
-- 
2.1.0
