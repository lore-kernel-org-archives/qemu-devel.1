Received: from eggs.gnu.org ([2001:4830:134:3::10]:46220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHVG9-0007Ve-GT
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHVG7-00009b-QK
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:44:45 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831]:39215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHVG7-0008Lr-DR
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:44:43 -0400
Received: by mail-qt1-x831.google.com with SMTP id g10-v6so13718785qtq.6
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 07:44:32 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 09:43:45 -0500
Message-Id: <20181030144358.23144-12-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
References: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/24] qga-win: refactor disk properties (bus)
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

Refactor code that queries bus type to be more generic. The function
get_disk_bus_type() has been renamed to build_guest_disk_info().
Following commit(s) will extend this function.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-win32.c | 45 ++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 1a21aac5ad..1e91aa2343 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -613,25 +613,28 @@ out:
     return pci;
 }
 
-static int get_disk_bus_type(HANDLE vol_h, Error **errp)
+static void get_disk_properties(HANDLE vol_h, GuestDiskAddress *disk,
+    Error **errp)
 {
     STORAGE_PROPERTY_QUERY query;
     STORAGE_DEVICE_DESCRIPTOR *dev_desc, buf;
     DWORD received;
+    ULONG size = sizeof(buf);
 
     dev_desc = &buf;
-    dev_desc->Size = sizeof(buf);
     query.PropertyId = StorageDeviceProperty;
     query.QueryType = PropertyStandardQuery;
 
     if (!DeviceIoControl(vol_h, IOCTL_STORAGE_QUERY_PROPERTY, &query,
                          sizeof(STORAGE_PROPERTY_QUERY), dev_desc,
-                         dev_desc->Size, &received, NULL)) {
+                         size, &received, NULL)) {
         error_setg_win32(errp, GetLastError(), "failed to get bus type");
-        return -1;
+        return;
     }
+    disk->bus_type = find_bus_type(dev_desc->BusType);
+    g_debug("bus type %d", disk->bus_type);
 
-    return dev_desc->BusType;
+    return;
 }
 
 /* VSS provider works with volumes, thus there is no difference if
@@ -643,7 +646,6 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
     GuestDiskAddress *disk;
     SCSI_ADDRESS addr, *scsi_ad;
     DWORD len;
-    int bus;
     HANDLE vol_h;
     Error *local_err = NULL;
 
@@ -655,17 +657,16 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
                        0, NULL);
     if (vol_h == INVALID_HANDLE_VALUE) {
         error_setg_win32(errp, GetLastError(), "failed to open volume");
-        goto out_free;
+        goto err;
     }
 
-    g_debug("getting bus type");
-    bus = get_disk_bus_type(vol_h, errp);
-    if (bus < 0) {
-        goto out_close;
+    disk = g_malloc0(sizeof(*disk));
+    get_disk_properties(vol_h, disk, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto err_close;
     }
 
-    disk = g_malloc0(sizeof(*disk));
-    disk->bus_type = find_bus_type(bus);
     g_debug("bus type %d", disk->bus_type);
     /* always set pci_controller as required by schema. get_pci_info() should
      * report -1 values for non-PCI buses rather than fail. fail the command
@@ -675,12 +676,14 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
     disk->pci_controller = get_pci_info(name, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        goto out_close;
+        goto err_close;
     }
-    if (bus == BusTypeScsi || bus == BusTypeAta || bus == BusTypeRAID
+    if (disk->bus_type == GUEST_DISK_BUS_TYPE_SCSI
+            || disk->bus_type == GUEST_DISK_BUS_TYPE_IDE
+            || disk->bus_type == GUEST_DISK_BUS_TYPE_RAID
 #if (_WIN32_WINNT >= 0x0600)
             /* This bus type is not supported before Windows Server 2003 SP1 */
-            || bus == BusTypeSas
+            || disk->bus_type == GUEST_DISK_BUS_TYPE_SAS
 #endif
         ) {
         /* We are able to use the same ioctls for different bus types
@@ -700,11 +703,17 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
     list = g_malloc0(sizeof(*list));
     list->value = disk;
     list->next = NULL;
-out_close:
     CloseHandle(vol_h);
-out_free:
     g_free(name);
     return list;
+
+err_close:
+    g_free(disk);
+    CloseHandle(vol_h);
+err:
+    g_free(name);
+
+    return NULL;
 }
 
 #else
-- 
2.17.1
