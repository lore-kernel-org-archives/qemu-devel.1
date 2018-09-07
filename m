Received: from eggs.gnu.org ([2001:4830:134:3::10]:36673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fyF9c-0000tU-Q5
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fyF9Y-000488-Pn
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:42:24 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:55717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1fyF9Y-000434-37
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:42:20 -0400
Received: by mail-wm0-f42.google.com with SMTP id f21-v6so14428247wmc.5
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 04:42:17 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Fri,  7 Sep 2018 13:42:09 +0200
Message-Id: <a8cf3b35e7559bfaf20f2d71a0b4809fdd4f38e6.1536320522.git.tgolembi@redhat.com>
In-Reply-To: <cover.1536320522.git.tgolembi@redhat.com>
References: <cover.1536320522.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/5] qga: win32: fix crashes when PCI info
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
Cc: Eric Blake <eblake@redhat.com>, Olga Krishtal <okrishtal@virtuozzo.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

The guest-get-fsinfo command collects also information about PCI
controller where the disk is attached. When this fails for some reasons
it tries to return just the partial information. However in certain
cases the pointer to the structure was not initialized and was set to
NULL. This breaks the serializer and leads to a crash of the guest agent.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-win32.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 98d9735389..9c959122d9 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -633,15 +633,32 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
          * https://technet.microsoft.com/en-us/library/ee851589(v=ws.10).aspx */
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
+                g_debug("failed to get PCI controller info: %s",
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
