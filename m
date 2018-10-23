Received: from eggs.gnu.org ([2001:4830:134:3::10]:42913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gEumq-0001x2-FS
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gEuml-0007pC-G5
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1gEuml-0007nD-8H
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id w186-v6so1379144wmf.0
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 04:23:43 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue, 23 Oct 2018 13:23:22 +0200
Message-Id: <a02ce6104ac1c3e5d82f0ef12f86f3d8091130d8.1540293796.git.tgolembi@redhat.com>
In-Reply-To: <cover.1540293795.git.tgolembi@redhat.com>
References: <cover.1540293795.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 13/14] qga-win: return disk device in
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
Cc: Eric Blake <eblake@redhat.com>, Sameeh Jubran <sjubran@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Olga Krishtal <okrishtal@virtuozzo.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

Report device UNC of the disk. It is reported as "\\.\PhysicalDriveX".

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-win32.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 09566b3f47..12aba8cc50 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -654,8 +654,7 @@ out_free:
     return;
 }
 
-static void get_single_disk_info(char *name, GuestDiskAddress *disk,
-    Error **errp)
+static void get_single_disk_info(GuestDiskAddress *disk, Error **errp)
 {
     SCSI_ADDRESS addr, *scsi_ad;
     DWORD len;
@@ -664,8 +663,8 @@ static void get_single_disk_info(char *name, GuestDiskAddress *disk,
 
     scsi_ad = &addr;
 
-    g_debug("getting disk info for: %s", name);
-    disk_h = CreateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
+    g_debug("getting disk info for: %s", disk->dev);
+    disk_h = CreateFile(disk->dev, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
                        0, NULL);
     if (disk_h == INVALID_HANDLE_VALUE) {
         error_setg_win32(errp, GetLastError(), "failed to open disk");
@@ -682,7 +681,7 @@ static void get_single_disk_info(char *name, GuestDiskAddress *disk,
     /* always set pci_controller as required by schema. get_pci_info() should
      * report -1 values for non-PCI buses rather than fail.
      */
-    disk->pci_controller = get_pci_info(name, &local_err);
+    disk->pci_controller = get_pci_info(disk->dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto err_close;
@@ -765,7 +764,9 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
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
@@ -787,7 +788,6 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
 
     /* Go through each extent */
     for (i = 0; i < extents->NumberOfDiskExtents; i++) {
-        char *disk_name = NULL;
         disk = g_malloc0(sizeof(GuestDiskAddress));
 
         /* Disk numbers directly correspond to numbers used in UNCs
@@ -798,10 +798,11 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
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
2.19.0
