Received: from eggs.gnu.org ([2001:4830:134:3::10]:38849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fmzYQ-0008AQ-He
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fmzYL-00035Z-LD
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:49:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1fmzYL-00035D-ED
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:49:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id g1-v6so11831412wru.2
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 03:49:25 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue,  7 Aug 2018 12:49:17 +0200
Message-Id: <951d1c8265e9ef6b36d61358fd01f267a9b83ca7.1533638952.git.tgolembi@redhat.com>
In-Reply-To: <cover.1533638952.git.tgolembi@redhat.com>
References: <cover.1533638952.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/4] qga: win32: fix crashes when PCI info
 cannot be retrived
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

The guest-get-fsinfo command collects also information about PCI
controller where the disk is attached. When this fails for some reasons
it tries to return just the partial information. However in certain
cases the pointer to the structure was not initialized and was set to
NULL. This breaks the serializer and lead to crasehs of the guest agent.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-win32.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 36d76c22c0..995f62c2e4 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -642,15 +642,32 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
         g_debug("getting pci-controller info");
         if (DeviceIoControl(vol_h, IOCTL_SCSI_GET_ADDRESS, NULL, 0, scsi_ad,
                             sizeof(SCSI_ADDRESS), &len, NULL)) {
+            Error *local_err = NULL;
             disk->unit = addr.Lun;
             disk->target = addr.TargetId;
             disk->bus = addr.PathId;
-            disk->pci_controller = get_pci_info(name, errp);
+            g_debug("unit=%lld target=%lld bus=%lld",
+                disk->unit, disk->target, disk->bus);
+            disk->pci_controller = get_pci_info(name, &local_err);
+
+            if (local_err) {
+                slog("failed to get PCI controller info: %s",
+                    error_get_pretty(local_err));
+                error_free(local_err);
+            } else if (disk->pci_controller != NULL) {
+                g_debug("pci: domain=%lld bus=%lld slot=%lld function=%lld",
+                    disk->pci_controller->domain,
+                    disk->pci_controller->bus,
+                    disk->pci_controller->slot,
+                    disk->pci_controller->function);
+            }
         }
-        /* We do not set error in this case, because we still have enough
-         * information about volume. */
-    } else {
-         disk->pci_controller = NULL;
+    }
+    /* We do not set error in case pci_controller is NULL, because we still
+     * have enough information about volume. */
+    if (disk->pci_controller == NULL) {
+        g_debug("no PCI controller info");
+        disk->pci_controller = g_malloc0(sizeof(GuestPCIAddress));
     }
 
     list = g_malloc0(sizeof(*list));
-- 
2.18.0
