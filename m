Received: from eggs.gnu.org ([2001:4830:134:3::10]:42813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gEumk-0001qs-Ji
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gEumi-0007l6-Fg
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1gEumi-0007h8-86
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id d10-v6so1269909wrs.5
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 04:23:38 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue, 23 Oct 2018 13:23:18 +0200
Message-Id: <4a25866e48d9e3bb5c0b35547b723d1f4806b3c8.1540293796.git.tgolembi@redhat.com>
In-Reply-To: <cover.1540293795.git.tgolembi@redhat.com>
References: <cover.1540293795.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 09/14] qga-win: refactor disk properties
 (bus)
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

Refactor code that queries bus type to be more generic. The function
get_disk_bus_type() has been renamed to build_guest_disk_info().
Following commit(s) will extend this function.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-win32.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index a3d28d06b3..5ebacd241f 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -588,25 +588,28 @@ out:
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
@@ -618,8 +621,8 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
     GuestDiskAddress *disk;
     SCSI_ADDRESS addr, *scsi_ad;
     DWORD len;
-    int bus;
     HANDLE vol_h;
+    Error *local_err = NULL;
 
     scsi_ad = &addr;
     char *name = g_strndup(guid, strlen(guid)-1);
@@ -629,26 +632,27 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
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
      * report -1 values for non-PCI buses rather than fail.
      */
     disk->pci_controller = get_pci_info(name, errp);
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
@@ -668,11 +672,17 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
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
2.19.0
