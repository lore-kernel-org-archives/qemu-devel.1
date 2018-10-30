Received: from eggs.gnu.org ([2001:4830:134:3::10]:46271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHVGB-0007W7-56
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHVG7-0000AF-UI
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:44:47 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831]:45432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHVG7-00005q-FQ
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:44:43 -0400
Received: by mail-qt1-x831.google.com with SMTP id l9-v6so13691529qtj.12
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 07:44:41 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 09:43:48 -0500
Message-Id: <20181030144358.23144-15-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
References: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/24] qga-win: handle multi-disk volumes
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

Probe the volume for disk extents and return list of all disks.
Originally only first disk of composite volume was returned.

Note that the patch changes get_pci_info() from one state of brokenness
into a different state of brokenness. In other words it still does not do
what it's supposed to do (see comment in code). If anyone knows how to
fix it, please step in.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-win32.c | 126 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 108 insertions(+), 18 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 21a88d31e1..90432bbfce 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -491,9 +491,26 @@ static GuestDiskBusType find_bus_type(STORAGE_BUS_TYPE bus)
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
@@ -517,7 +534,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
         goto out;
     }
 
-    dev_info = SetupDiGetClassDevs(&GUID_DEVINTERFACE_VOLUME, 0, 0,
+    dev_info = SetupDiGetClassDevs(&GUID_DEVINTERFACE_DISK, 0, 0,
                                    DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);
     if (dev_info == INVALID_HANDLE_VALUE) {
         error_setg_win32(errp, GetLastError(), "failed to get devices tree");
@@ -672,20 +689,20 @@ static void get_single_disk_info(char *name, GuestDiskAddress *disk,
 {
     SCSI_ADDRESS addr, *scsi_ad;
     DWORD len;
-    HANDLE vol_h;
+    HANDLE disk_h;
     Error *local_err = NULL;
 
     scsi_ad = &addr;
 
     g_debug("getting disk info for: %s", name);
-    vol_h = CreateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
+    disk_h = CreateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
                        0, NULL);
-    if (vol_h == INVALID_HANDLE_VALUE) {
-        error_setg_win32(errp, GetLastError(), "failed to open volume");
-        goto err;
+    if (disk_h == INVALID_HANDLE_VALUE) {
+        error_setg_win32(errp, GetLastError(), "failed to open disk");
+        return;
     }
 
-    get_disk_properties(vol_h, disk, &local_err);
+    get_disk_properties(disk_h, disk, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto err_close;
@@ -714,7 +731,7 @@ static void get_single_disk_info(char *name, GuestDiskAddress *disk,
          * according to Microsoft docs
          * https://technet.microsoft.com/en-us/library/ee851589(v=ws.10).aspx */
         g_debug("getting pci-controller info");
-        if (DeviceIoControl(vol_h, IOCTL_SCSI_GET_ADDRESS, NULL, 0, scsi_ad,
+        if (DeviceIoControl(disk_h, IOCTL_SCSI_GET_ADDRESS, NULL, 0, scsi_ad,
                             sizeof(SCSI_ADDRESS), &len, NULL)) {
             disk->unit = addr.Lun;
             disk->target = addr.TargetId;
@@ -725,8 +742,7 @@ static void get_single_disk_info(char *name, GuestDiskAddress *disk,
     }
 
 err_close:
-    CloseHandle(vol_h);
-err:
+    CloseHandle(disk_h);
     return;
 }
 
@@ -738,6 +754,10 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
     Error *local_err = NULL;
     GuestDiskAddressList *list = NULL, *cur_item = NULL;
     GuestDiskAddress *disk = NULL;
+    int i;
+    HANDLE vol_h;
+    DWORD size;
+    PVOLUME_DISK_EXTENTS extents = NULL;
 
     /* strip final backslash */
     char *name = g_strdup(guid);
@@ -745,20 +765,90 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
         name[strlen(name) - 1] = 0;
     }
 
-    disk = g_malloc0(sizeof(GuestDiskAddress));
-    get_single_disk_info(name, disk, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    g_debug("opening %s", name);
+    vol_h = CreateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
+                       0, NULL);
+    if (vol_h == INVALID_HANDLE_VALUE) {
+        error_setg_win32(errp, GetLastError(), "failed to open volume");
         goto out;
     }
 
-    cur_item = g_malloc0(sizeof(*list));
-    cur_item->value = disk;
-    disk = NULL;
-    list = cur_item;
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
+                + extents->NumberOfDiskExtents*sizeof(DISK_EXTENT);
+            g_free(extents);
+            extents = g_malloc0(size);
+            if (!DeviceIoControl(
+                    vol_h, IOCTL_VOLUME_GET_VOLUME_DISK_EXTENTS, NULL,
+                    0, extents, size, NULL, NULL)) {
+                error_setg_win32(errp, GetLastError(),
+                    "failed to get disk extents");
+                return NULL;
+            }
+        } else if (last_err == ERROR_INVALID_FUNCTION) {
+            /* Possibly CD-ROM or a shared drive. Try to pass the volume */
+            g_debug("volume not on disk");
+            disk = g_malloc0(sizeof(GuestDiskAddress));
+            get_single_disk_info(name, disk, &local_err);
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
+            error_setg_win32(errp, GetLastError(),
+                "failed to get disk extents");
+            goto out;
+        }
+    }
+    g_debug("Number of extents: %lu", extents->NumberOfDiskExtents);
+
+    /* Go through each extent */
+    for (i = 0; i < extents->NumberOfDiskExtents; i++) {
+        char *disk_name = NULL;
+        disk = g_malloc0(sizeof(GuestDiskAddress));
+
+        /* Disk numbers directly correspond to numbers used in UNCs
+         *
+         * See documentation for DISK_EXTENT:
+         * https://docs.microsoft.com/en-us/windows/desktop/api/winioctl/ns-winioctl-_disk_extent
+         *
+         * See also Naming Files, Paths and Namespaces:
+         * https://docs.microsoft.com/en-us/windows/desktop/FileIO/naming-a-file#win32-device-namespaces
+         */
+        disk_name = g_strdup_printf("\\\\.\\PhysicalDrive%lu",
+            extents->Extents[i].DiskNumber);
+        get_single_disk_info(disk_name, disk, &local_err);
+        g_free(disk_name);
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
 
 out:
     qapi_free_GuestDiskAddress(disk);
+    g_free(extents);
     g_free(name);
 
     return list;
-- 
2.17.1
