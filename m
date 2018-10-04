Received: from eggs.gnu.org ([2001:4830:134:3::10]:34917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1g81tF-0004Be-R0
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1g81iY-0003cH-Fr
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:22:58 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:38541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1g81iY-0003bZ-8j
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:22:54 -0400
Received: by mail-wm1-f50.google.com with SMTP id 193-v6so8598547wme.3
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 04:22:54 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Thu,  4 Oct 2018 13:22:37 +0200
Message-Id: <fe8e4352f962e5f4b720338b2742a01c29674ee7.1538652143.git.tgolembi@redhat.com>
In-Reply-To: <cover.1538652143.git.tgolembi@redhat.com>
References: <cover.1538652143.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 10/11] qga: return disk device in
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

Report device node of the disk. It is implemented for Linux (needs
libudev) and Windows. The node is reported e.g. as "/dev/sda2" on Linux
and as "\\.\PhysicalDriveX" on Windows.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-posix.c |  7 ++++++-
 qga/commands-win32.c | 21 +++++++++++----------
 qga/qapi-schema.json |  3 ++-
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 4d324178f2..31952b07f4 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -950,7 +950,12 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
     if (udev == NULL || udevice == NULL) {
         g_debug("failed to query udev");
     } else {
-        const char *serial;
+        const char *devnode, *serial;
+        devnode = udev_device_get_devnode(udevice);
+        if (devnode != NULL) {
+            disk->dev = g_strdup(devnode);
+            disk->has_dev = true;
+        }
         serial = udev_device_get_property_value(udevice, "ID_SERIAL");
         if (serial != NULL && *serial != 0) {
             disk->serial = g_strdup(serial);
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index a591d8221d..d0d969d0ce 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -649,8 +649,7 @@ out_free:
     return;
 }
 
-static void get_single_disk_info(char *name, GuestDiskAddress *disk,
-    Error **errp)
+static void get_single_disk_info(GuestDiskAddress *disk, Error **errp)
 {
     SCSI_ADDRESS addr, *scsi_ad;
     DWORD len;
@@ -659,8 +658,8 @@ static void get_single_disk_info(char *name, GuestDiskAddress *disk,
 
     scsi_ad = &addr;
 
-    g_debug("getting disk info for: %s", name);
-    disk_h = CreateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
+    g_debug("getting disk info for: %s", disk->dev);
+    disk_h = CreateFile(disk->dev, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
                        0, NULL);
     if (disk_h == INVALID_HANDLE_VALUE) {
         error_setg_win32(errp, GetLastError(), "failed to open disk");
@@ -692,7 +691,7 @@ static void get_single_disk_info(char *name, GuestDiskAddress *disk,
             disk->bus = addr.PathId;
             g_debug("unit=%lld target=%lld bus=%lld",
                 disk->unit, disk->target, disk->bus);
-            disk->pci_controller = get_pci_info(name, &local_err);
+            disk->pci_controller = get_pci_info(disk->dev, &local_err);
 
             if (local_err) {
                 g_debug("failed to get PCI controller info: %s",
@@ -771,7 +770,9 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
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
@@ -793,7 +794,6 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
 
     /* Go through each extent */
     for (i = 0; i < extents->NumberOfDiskExtents; i++) {
-        char *disk_name = NULL;
         disk = g_malloc0(sizeof(GuestDiskAddress));
 
         /* Disk numbers directly correspond to numbers used in UNCs
@@ -804,10 +804,11 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
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
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 3bcda6257e..c6725b3ec8 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -835,6 +835,7 @@
 # @target: target id
 # @unit: unit id
 # @serial: serial number (since: 3.1)
+# @dev: device node (POSIX) or device UNC (Windows) (since: 3.1)
 #
 # Since: 2.2
 ##
@@ -842,7 +843,7 @@
   'data': {'pci-controller': 'GuestPCIAddress',
            'bus-type': 'GuestDiskBusType',
            'bus': 'int', 'target': 'int', 'unit': 'int',
-           '*serial': 'str'} }
+           '*serial': 'str', '*dev': 'str'} }
 
 ##
 # @GuestFilesystemInfo:
-- 
2.19.0
