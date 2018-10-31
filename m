Received: from eggs.gnu.org ([2001:4830:134:3::10]:60247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHfUg-0000Mc-Pt
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHfUb-00026L-5O
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:24 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831]:33439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHfUa-000267-WF
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:21 -0400
Received: by mail-qt1-x831.google.com with SMTP id i15-v6so16012861qtr.0
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 18:40:20 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 20:38:12 -0500
Message-Id: <20181031013821.24023-16-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181031013821.24023-1-mdroth@linux.vnet.ibm.com>
References: <20181031013821.24023-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 15/24] qga-win: return disk device in
 guest-get-fsinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

From: Tomáš Golembiovský <tgolembi@redhat.com>

Report device UNC of the disk. It is reported as "\\.\PhysicalDriveX".

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-win32.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 90432bbfce..30d6c639c3 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -684,8 +684,7 @@ out_free:
     return;
 }
 
-static void get_single_disk_info(char *name, GuestDiskAddress *disk,
-    Error **errp)
+static void get_single_disk_info(GuestDiskAddress *disk, Error **errp)
 {
     SCSI_ADDRESS addr, *scsi_ad;
     DWORD len;
@@ -694,8 +693,8 @@ static void get_single_disk_info(char *name, GuestDiskAddress *disk,
 
     scsi_ad = &addr;
 
-    g_debug("getting disk info for: %s", name);
-    disk_h = CreateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
+    g_debug("getting disk info for: %s", disk->dev);
+    disk_h = CreateFile(disk->dev, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
                        0, NULL);
     if (disk_h == INVALID_HANDLE_VALUE) {
         error_setg_win32(errp, GetLastError(), "failed to open disk");
@@ -714,7 +713,7 @@ static void get_single_disk_info(char *name, GuestDiskAddress *disk,
      * if that doesn't hold since that suggests some other unexpected
      * breakage
      */
-    disk->pci_controller = get_pci_info(name, &local_err);
+    disk->pci_controller = get_pci_info(disk->dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto err_close;
@@ -797,7 +796,9 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
             /* Possibly CD-ROM or a shared drive. Try to pass the volume */
             g_debug("volume not on disk");
             disk = g_malloc0(sizeof(GuestDiskAddress));
-            get_single_disk_info(name, disk, &local_err);
+            disk->has_dev = true;
+            disk->dev = g_strdup(name);
+            get_single_disk_info(disk, &local_err);
             if (local_err) {
                 g_debug("failed to get disk info, ignoring error: %s",
                     error_get_pretty(local_err));
@@ -819,7 +820,6 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
 
     /* Go through each extent */
     for (i = 0; i < extents->NumberOfDiskExtents; i++) {
-        char *disk_name = NULL;
         disk = g_malloc0(sizeof(GuestDiskAddress));
 
         /* Disk numbers directly correspond to numbers used in UNCs
@@ -830,10 +830,11 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
          * See also Naming Files, Paths and Namespaces:
          * https://docs.microsoft.com/en-us/windows/desktop/FileIO/naming-a-file#win32-device-namespaces
          */
-        disk_name = g_strdup_printf("\\\\.\\PhysicalDrive%lu",
+        disk->has_dev = true;
+        disk->dev = g_strdup_printf("\\\\.\\PhysicalDrive%lu",
             extents->Extents[i].DiskNumber);
-        get_single_disk_info(disk_name, disk, &local_err);
-        g_free(disk_name);
+
+        get_single_disk_info(disk, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             goto out;
-- 
2.17.1
