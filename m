Received: from eggs.gnu.org ([2001:4830:134:3::10]:36717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fyF9g-0000vS-19
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fyF9b-0004BU-QE
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:42:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1fyF9b-0004Ap-JC
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:42:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so14473712wmc.0
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 04:42:23 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Fri,  7 Sep 2018 13:42:13 +0200
Message-Id: <88c65dd59a7bbf55ad055447cccf4be39fcb824b.1536320522.git.tgolembi@redhat.com>
In-Reply-To: <cover.1536320522.git.tgolembi@redhat.com>
References: <cover.1536320522.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 5/5] qga: return disk device in
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
Cc: Eric Blake <eblake@redhat.com>, Olga Krishtal <okrishtal@virtuozzo.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

Report device node of the disk. It is implemented for Linux (needs udev)
and Windows. The node is reported e.g. as "/dev/sda2" on Linux and as
"\\?\PhysicalDriveX" on Windows.

As part of this effort the Windows code was changed to probe disk
extents and return list of all disks. Originally only first disk of
composite volume was returned.

Note that the patch changes get_pci_info() from one state of brokenness
into a different state of brokenness. In other words it still does not do
what it's supposed to do (see comment in code). If anyone knows how to
fix it, please step in.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-posix.c |   7 +-
 qga/commands-win32.c | 163 +++++++++++++++++++++++++++++++++++--------
 qga/qapi-schema.json |   3 +-
 3 files changed, 142 insertions(+), 31 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 37fedd123b..d0d6ba49cb 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -947,7 +947,12 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
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
index fa186154a8..2cde6bd0af 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -477,9 +477,26 @@ static GuestDiskBusType find_bus_type(STORAGE_BUS_TYPE bus)
     return win2qemu[(int)bus];
 }
 
+/* XXX: The following function is BROKEN!
+ *
+ * It does not work and probably has never worked. When we query for list of
+ * disks we get cryptic names like "\Device\0000001d" instead of
+ * "\PhysicalDriveX" or "\HarddiskX". Whether the names can be translated one
+ * way or the other for comparison is an open question.
+ *
+ * When we query volume names (the original version) we are able to match those
+ * but then the property queries report error "Invalid function". (duh!)
+ */
+
+/*
 DEFINE_GUID(GUID_DEVINTERFACE_VOLUME,
         0x53f5630dL, 0xb6bf, 0x11d0, 0x94, 0xf2,
         0x00, 0xa0, 0xc9, 0x1e, 0xfb, 0x8b);
+*/
+DEFINE_GUID(GUID_DEVINTERFACE_DISK,
+        0x53f56307L, 0xb6bf, 0x11d0, 0x94, 0xf2,
+        0x00, 0xa0, 0xc9, 0x1e, 0xfb, 0x8b);
+
 
 static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
 {
@@ -497,7 +514,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
         goto out;
     }
 
-    dev_info = SetupDiGetClassDevs(&GUID_DEVINTERFACE_VOLUME, 0, 0,
+    dev_info = SetupDiGetClassDevs(&GUID_DEVINTERFACE_DISK, 0, 0,
                                    DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);
     if (dev_info == INVALID_HANDLE_VALUE) {
         error_setg_win32(errp, GetLastError(), "failed to get devices tree");
@@ -632,31 +649,24 @@ out_free:
     return;
 }
 
-/* VSS provider works with volumes, thus there is no difference if
- * the volume consist of spanned disks. Info about the first disk in the
- * volume is returned for the spanned disk group (LVM) */
-static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
+static void get_single_disk_info(GuestDiskAddress *disk, Error **errp)
 {
-    GuestDiskAddressList *list = NULL;
-    GuestDiskAddress *disk;
     SCSI_ADDRESS addr, *scsi_ad;
     DWORD len;
-    HANDLE vol_h;
+    HANDLE disk_h;
     Error *local_err = NULL;
 
     scsi_ad = &addr;
-    char *name = g_strndup(guid, strlen(guid)-1);
 
-    g_debug("getting disk info for: %s", name);
-    vol_h = CreateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
+    g_debug("getting disk info for: %s", disk->dev);
+    disk_h = CreateFile(disk->dev, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
                        0, NULL);
-    if (vol_h == INVALID_HANDLE_VALUE) {
-        error_setg_win32(errp, GetLastError(), "failed to open volume");
-        goto err;
+    if (disk_h == INVALID_HANDLE_VALUE) {
+        error_setg_win32(errp, GetLastError(), "failed to open disk");
+        return;
     }
 
-    disk = g_malloc0(sizeof(*disk));
-    get_disk_properties(vol_h, disk, &local_err);
+    get_disk_properties(disk_h, disk, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto err_close;
@@ -674,20 +684,20 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
          * according to Microsoft docs
          * https://technet.microsoft.com/en-us/library/ee851589(v=ws.10).aspx */
         g_debug("getting pci-controller info");
-        if (DeviceIoControl(vol_h, IOCTL_SCSI_GET_ADDRESS, NULL, 0, scsi_ad,
+        if (DeviceIoControl(disk_h, IOCTL_SCSI_GET_ADDRESS, NULL, 0, scsi_ad,
                             sizeof(SCSI_ADDRESS), &len, NULL)) {
-            Error *local_err = NULL;
             disk->unit = addr.Lun;
             disk->target = addr.TargetId;
             disk->bus = addr.PathId;
             g_debug("unit=%lld target=%lld bus=%lld",
                 disk->unit, disk->target, disk->bus);
-            disk->pci_controller = get_pci_info(name, &local_err);
+            disk->pci_controller = get_pci_info(disk->dev, &local_err);
 
             if (local_err) {
                 g_debug("failed to get PCI controller info: %s",
                     error_get_pretty(local_err));
                 error_free(local_err);
+                local_err = NULL;
             } else if (disk->pci_controller != NULL) {
                 g_debug("pci: domain=%lld bus=%lld slot=%lld function=%lld",
                     disk->pci_controller->domain,
@@ -704,19 +714,107 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
         disk->pci_controller = g_malloc0(sizeof(GuestPCIAddress));
     }
 
-    list = g_malloc0(sizeof(*list));
-    list->value = disk;
-    list->next = NULL;
-    CloseHandle(vol_h);
-    return list;
-
 err_close:
+    CloseHandle(disk_h);
+    return;
+}
+
+static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
+{
+    Error *local_err = NULL;
+    GuestDiskAddressList *list = NULL, *cur_item = NULL;
+    GuestDiskAddress *disk = NULL;
+    int i;
+    HANDLE vol_h;
+    DWORD size;
+    PVOLUME_DISK_EXTENTS extents = NULL;
+
+    /* strip final backslash */
+    char *name = g_strndup(guid, strlen(guid)-1);
+
+    g_debug("opening %s", name);
+    vol_h = CreateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
+                       0, NULL);
+    if (vol_h == INVALID_HANDLE_VALUE) {
+        error_setg_win32(errp, GetLastError(), "failed to open volume");
+        goto out;
+    }
+
+    /* Get list of extents */
+    g_debug("getting disk extents");
+    size = sizeof(VOLUME_DISK_EXTENTS);
+    extents = g_malloc0(size);
+    if (!DeviceIoControl(vol_h, IOCTL_VOLUME_GET_VOLUME_DISK_EXTENTS, NULL,
+                         0, extents, size, NULL, NULL)) {
+        DWORD last_err = GetLastError();
+        if (last_err == ERROR_MORE_DATA) {
+            /* Try once more with big enough buffer */
+            size = sizeof(VOLUME_DISK_EXTENTS)
+                + extents->NumberOfDiskExtents * sizeof(DISK_EXTENT);
+            g_free(extents);
+            extents = g_malloc0(size);
+            if (!DeviceIoControl(
+                    vol_h, IOCTL_VOLUME_GET_VOLUME_DISK_EXTENTS, NULL,
+                    0, extents, size, NULL, NULL)) {
+                error_setg_win32(errp, GetLastError(), "failed to get disk extents");
+                return NULL;
+            }
+        } else if (last_err == ERROR_INVALID_FUNCTION) {
+            /* Possibly CD-ROM or a shared drive. Try to pass the volume */
+            g_debug("volume not on disk");
+            disk = g_malloc0(sizeof(GuestDiskAddress));
+            disk->has_dev = true;
+            disk->dev = g_strdup(name);
+            get_single_disk_info(disk, &local_err);
+            if (local_err) {
+                g_debug("failed to get disk info, ignoring error: %s",
+                    error_get_pretty(local_err));
+                error_free(local_err);
+                goto out;
+            }
+            list = g_malloc0(sizeof(*list));
+            list->value = disk;
+            disk = NULL;
+            list->next = NULL;
+            goto out;
+        } else {
+            error_setg_win32(errp, GetLastError(), "failed to get disk extents");
+            goto out;
+        }
+    }
+    g_debug("Number of extents: %lu", extents->NumberOfDiskExtents);
+
+    /* Go through each extent */
+    for (i = 0; i < extents->NumberOfDiskExtents; i++) {
+        disk = g_malloc0(sizeof(GuestDiskAddress));
+
+        /* Disk numbers directly correspond to numbers used in UNCs
+         * See documentation for DISK_EXTENT:
+         * https://docs.microsoft.com/en-us/windows/desktop/api/winioctl/ns-winioctl-_disk_extent
+         */
+        disk->has_dev = true;
+        disk->dev = g_strdup_printf("\\\\?\\PhysicalDrive%lu",
+            extents->Extents[i].DiskNumber);
+
+        get_single_disk_info(disk, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            goto out;
+        }
+        cur_item = g_malloc0(sizeof(*list));
+        cur_item->value = disk;
+        disk = NULL;
+        cur_item->next = list;
+        list = cur_item;
+    }
+
+
+out:
+    g_free(extents);
     g_free(disk);
-    CloseHandle(vol_h);
-err:
     g_free(name);
 
-    return NULL;
+    return list;
 }
 
 #else
@@ -783,6 +881,12 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
     }
     fs->type = g_strdup(fs_name);
     fs->disk = build_guest_disk_info(guid, errp);
+    if (fs->disk == NULL) {
+        g_free(fs);
+        fs = NULL;
+        goto free;
+    }
+
 free:
     g_free(mnt_point);
     return fs;
@@ -803,7 +907,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
     do {
         GuestFilesystemInfo *info = build_guest_fsinfo(guid, errp);
         if (info == NULL) {
-            continue;
+            goto out;
         }
         new = g_malloc(sizeof(*ret));
         new->value = info;
@@ -815,6 +919,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
         error_setg_win32(errp, GetLastError(), "failed to find next volume");
     }
 
+out:
     FindVolumeClose(vol_h);
     return ret;
 }
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
2.18.0
