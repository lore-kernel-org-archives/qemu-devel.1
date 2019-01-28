Received: from eggs.gnu.org ([209.51.188.92]:46976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mhines@scalecomputing.com>) id 1goFcA-0006i3-4b
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mhines@scalecomputing.com>) id 1goFRS-0006Ji-LO
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:48 -0500
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:53020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mhines@scalecomputing.com>)
	id 1goFRQ-0006Fk-Hx
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:45 -0500
Received: by mail-it1-x144.google.com with SMTP id d11so1189498itf.2
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:31:39 -0800 (PST)
From: mhines@scalecomputing.com
Date: Mon, 28 Jan 2019 14:30:56 -0800
Message-Id: <20190128223056.19452-1-mhines@scalecomputing.com>
In-Reply-To: <20190114090324.16176-1-mhines@scalecomputing.com>
References: <20190114090324.16176-1-mhines@scalecomputing.com>
Subject: [Qemu-devel] [PATCH v3] QGA: Fix guest-get-fsinfo PCI address
 collection in Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Matt Hines <mhines@scalecomputing.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

From: Matt Hines <mhines@scalecomputing.com>

The Windows QEMU guest agent erroneously tries to collect PCI information
directly from the physical drive. However, windows stores SCSI/IDE information
with the drive and PCI information with the underlying storage controller
This changes get_pci_info to use the physical drive's underlying storage
controller to get PCI information.

* Additionally Fixes incorrect size being passed to DeviceIoControl
  when getting volume extents. Can occasionally crash the guest agent

Signed-off-by: Matt Hines <mhines@scalecomputing.com>
---
 configure            |   2 +-
 qga/commands-win32.c | 305 +++++++++++++++++++++++++++++++++------------------
 2 files changed, 199 insertions(+), 108 deletions(-)

diff --git a/configure b/configure
index 5b1d83ea26..46f21c089f 100755
--- a/configure
+++ b/configure
@@ -4694,7 +4694,7 @@ int main(void) {
 EOF
   if compile_prog "" "" ; then
     guest_agent_ntddscsi=yes
-    libs_qga="-lsetupapi $libs_qga"
+    libs_qga="-lsetupapi -lcfgmgr32 $libs_qga"
   fi
 fi
 
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 62e1b51dfe..5f8e797032 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -26,6 +26,7 @@
 #include <winioctl.h>
 #include <ntddscsi.h>
 #include <setupapi.h>
+#include <cfgmgr32.h>
 #include <initguid.h>
 #endif
 #include <lm.h>
@@ -491,56 +492,29 @@ static GuestDiskBusType find_bus_type(STORAGE_BUS_TYPE bus)
     return win2qemu[(int)bus];
 }
 
-/* XXX: The following function is BROKEN!
- *
- * It does not work and probably has never worked. When we query for list of
- * disks we get cryptic names like "\Device\0000001d" instead of
- * "\PhysicalDriveX" or "\HarddiskX". Whether the names can be translated one
- * way or the other for comparison is an open question.
- *
- * When we query volume names (the original version) we are able to match those
- * but then the property queries report error "Invalid function". (duh!)
- */
-
-/*
-DEFINE_GUID(GUID_DEVINTERFACE_VOLUME,
-        0x53f5630dL, 0xb6bf, 0x11d0, 0x94, 0xf2,
-        0x00, 0xa0, 0xc9, 0x1e, 0xfb, 0x8b);
-*/
 DEFINE_GUID(GUID_DEVINTERFACE_DISK,
         0x53f56307L, 0xb6bf, 0x11d0, 0x94, 0xf2,
         0x00, 0xa0, 0xc9, 0x1e, 0xfb, 0x8b);
+DEFINE_GUID(GUID_DEVINTERFACE_STORAGEPORT,
+        0x2accfe60L, 0xc130, 0x11d2, 0xb0, 0x82,
+        0x00, 0xa0, 0xc9, 0x1e, 0xfb, 0x8b);
 
-
-static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
+static GuestPCIAddress *get_pci_info(int number, Error **errp)
 {
     HDEVINFO dev_info;
     SP_DEVINFO_DATA dev_info_data;
-    DWORD size = 0;
+    SP_DEVICE_INTERFACE_DATA dev_iface_data;
+    HANDLE dev_file;
     int i;
-    char dev_name[MAX_PATH];
-    char *buffer = NULL;
     GuestPCIAddress *pci = NULL;
-    char *name = NULL;
     bool partial_pci = false;
+
     pci = g_malloc0(sizeof(*pci));
     pci->domain = -1;
     pci->slot = -1;
     pci->function = -1;
     pci->bus = -1;
 
-    if (g_str_has_prefix(guid, "\\\\.\\") ||
-        g_str_has_prefix(guid, "\\\\?\\")) {
-        name = g_strdup(guid + 4);
-    } else {
-        name = g_strdup(guid);
-    }
-
-    if (!QueryDosDevice(name, dev_name, ARRAY_SIZE(dev_name))) {
-        error_setg_win32(errp, GetLastError(), "failed to get dos device name");
-        goto out;
-    }
-
     dev_info = SetupDiGetClassDevs(&GUID_DEVINTERFACE_DISK, 0, 0,
                                    DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);
     if (dev_info == INVALID_HANDLE_VALUE) {
@@ -550,90 +524,208 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
 
     g_debug("enumerating devices");
     dev_info_data.cbSize = sizeof(SP_DEVINFO_DATA);
+    dev_iface_data.cbSize = sizeof(SP_DEVICE_INTERFACE_DATA);
     for (i = 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); i++) {
-        DWORD addr, bus, slot, data, size2;
-        int func, dev;
-        while (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
-                                            SPDRP_PHYSICAL_DEVICE_OBJECT_NAME,
-                                            &data, (PBYTE)buffer, size,
-                                            &size2)) {
-            size = MAX(size, size2);
-            if (GetLastError() == ERROR_INSUFFICIENT_BUFFER) {
-                g_free(buffer);
-                /* Double the size to avoid problems on
-                 * W2k MBCS systems per KB 888609.
-                 * https://support.microsoft.com/en-us/kb/259695 */
-                buffer = g_malloc(size * 2);
-            } else {
+        PSP_DEVICE_INTERFACE_DETAIL_DATA pdev_iface_detail_data = NULL;
+        STORAGE_DEVICE_NUMBER sdn;
+        char *parent_dev_id = NULL;
+        HDEVINFO parent_dev_info;
+        SP_DEVINFO_DATA parent_dev_info_data;
+        DWORD j;
+        DWORD size = 0;
+
+        g_debug("getting device path");
+        if (SetupDiEnumDeviceInterfaces(dev_info, &dev_info_data,
+                                        &GUID_DEVINTERFACE_DISK, 0,
+                                        &dev_iface_data)) {
+            while (!SetupDiGetDeviceInterfaceDetail(dev_info, &dev_iface_data,
+                                                    pdev_iface_detail_data,
+                                                    size, &size,
+                                                    &dev_info_data)) {
+                if (GetLastError() == ERROR_INSUFFICIENT_BUFFER) {
+                    pdev_iface_detail_data = g_malloc(size);
+                    pdev_iface_detail_data->cbSize =
+                        sizeof(*pdev_iface_detail_data);
+                } else {
+                    error_setg_win32(errp, GetLastError(),
+                                     "failed to get device interfaces");
+                    goto free_dev_info;
+                }
+            }
+
+            dev_file = CreateFile(pdev_iface_detail_data->DevicePath, 0,
+                                  FILE_SHARE_READ, NULL, OPEN_EXISTING, 0,
+                                  NULL);
+            g_free(pdev_iface_detail_data);
+
+            if (!DeviceIoControl(dev_file, IOCTL_STORAGE_GET_DEVICE_NUMBER,
+                                 NULL, 0, &sdn, sizeof(sdn), &size, NULL)) {
+                CloseHandle(dev_file);
                 error_setg_win32(errp, GetLastError(),
-                        "failed to get device name");
+                                 "failed to get device slot number");
                 goto free_dev_info;
             }
-        }
 
-        if (g_strcmp0(buffer, dev_name)) {
-            continue;
+            CloseHandle(dev_file);
+            if (sdn.DeviceNumber != number) {
+                continue;
+            }
+        } else {
+            error_setg_win32(errp, GetLastError(),
+                             "failed to get device interfaces");
+            goto free_dev_info;
         }
-        g_debug("found device %s", dev_name);
 
-        /* There is no need to allocate buffer in the next functions. The size
-         * is known and ULONG according to
-         * https://support.microsoft.com/en-us/kb/253232
-         * https://msdn.microsoft.com/en-us/library/windows/hardware/ff543095(v=vs.85).aspx
-         */
-        if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
-                   SPDRP_BUSNUMBER, &data, (PBYTE)&bus, size, NULL)) {
-            debug_error("failed to get bus");
-            bus = -1;
-            partial_pci = true;
+        g_debug("found device slot %d. Getting storage controller", number);
+        {
+            CONFIGRET cr;
+            DEVINST dev_inst, parent_dev_inst;
+            ULONG dev_id_size = 0;
+
+            size = 0;
+            while (!SetupDiGetDeviceInstanceId(dev_info, &dev_info_data,
+                                               parent_dev_id, size, &size)) {
+                if (GetLastError() == ERROR_INSUFFICIENT_BUFFER) {
+                    parent_dev_id = g_malloc(size);
+                } else {
+                    error_setg_win32(errp, GetLastError(),
+                                     "failed to get device instance ID");
+                    goto out;
+                }
+            }
+
+            /*
+            * CM API used here as opposed to
+            * SetupDiGetDeviceProperty(..., DEVPKEY_Device_Parent, ...)
+            * which exports are only available in mingw-w64 6+
+            */
+            cr = CM_Locate_DevInst(&dev_inst, parent_dev_id, 0);
+            if (cr != CR_SUCCESS) {
+                g_error("CM_Locate_DevInst failed with code %lx", cr);
+                error_setg_win32(errp, GetLastError(),
+                                 "failed to get device instance");
+                goto out;
+            }
+            cr = CM_Get_Parent(&parent_dev_inst, dev_inst, 0);
+            if (cr != CR_SUCCESS) {
+                g_error("CM_Get_Parent failed with code %lx", cr);
+                error_setg_win32(errp, GetLastError(),
+                                 "failed to get parent device instance");
+                goto out;
+            }
+
+            cr = CM_Get_Device_ID_Size(&dev_id_size, parent_dev_inst, 0);
+            if (cr != CR_SUCCESS) {
+                g_error("CM_Get_Device_ID_Size failed with code %lx", cr);
+                error_setg_win32(errp, GetLastError(),
+                                 "failed to get parent device ID length");
+                goto out;
+            }
+
+            ++dev_id_size;
+            if (dev_id_size > size) {
+                g_free(parent_dev_id);
+                parent_dev_id = g_malloc(dev_id_size);
+            }
+
+            cr = CM_Get_Device_ID(parent_dev_inst, parent_dev_id, dev_id_size,
+                                  0);
+            if (cr != CR_SUCCESS) {
+                g_error("CM_Get_Device_ID failed with code %lx", cr);
+                error_setg_win32(errp, GetLastError(),
+                                 "failed to get parent device ID");
+                goto out;
+            }
         }
 
-        /* The function retrieves the device's address. This value will be
-         * transformed into device function and number */
-        if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
-                   SPDRP_ADDRESS, &data, (PBYTE)&addr, size, NULL)) {
-            debug_error("failed to get address");
-            addr = -1;
-            partial_pci = true;
+        g_debug("querying storage controller %s for PCI information",
+                parent_dev_id);
+        parent_dev_info =
+            SetupDiGetClassDevs(&GUID_DEVINTERFACE_STORAGEPORT, parent_dev_id,
+                                NULL, DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);
+        g_free(parent_dev_id);
+
+        if (parent_dev_info == INVALID_HANDLE_VALUE) {
+            error_setg_win32(errp, GetLastError(),
+                             "failed to get parent device");
+            goto out;
         }
 
-        /* This call returns UINumber of DEVICE_CAPABILITIES structure.
-         * This number is typically a user-perceived slot number. */
-        if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
-                   SPDRP_UI_NUMBER, &data, (PBYTE)&slot, size, NULL)) {
-            debug_error("failed to get slot");
-            slot = -1;
-            partial_pci = true;
+        parent_dev_info_data.cbSize = sizeof(SP_DEVINFO_DATA);
+        if (!SetupDiEnumDeviceInfo(parent_dev_info, 0, &parent_dev_info_data)) {
+            error_setg_win32(errp, GetLastError(),
+                           "failed to get parent device data");
+            goto out;
         }
 
-        /* SetupApi gives us the same information as driver with
-         * IoGetDeviceProperty. According to Microsoft
-         * https://support.microsoft.com/en-us/kb/253232
-         * FunctionNumber = (USHORT)((propertyAddress) & 0x0000FFFF);
-         * DeviceNumber = (USHORT)(((propertyAddress) >> 16) & 0x0000FFFF);
-         * SPDRP_ADDRESS is propertyAddress, so we do the same.*/
-
-        if (partial_pci) {
-            pci->domain = -1;
-            pci->slot = -1;
-            pci->function = -1;
-            pci->bus = -1;
-        } else {
-            func = ((int) addr == -1) ? -1 : addr & 0x0000FFFF;
-            dev = ((int) addr == -1) ? -1 : (addr >> 16) & 0x0000FFFF;
-            pci->domain = dev;
-            pci->slot = (int) slot;
-            pci->function = func;
-            pci->bus = (int) bus;
+        for (j = 0;
+             SetupDiEnumDeviceInfo(parent_dev_info, j, &parent_dev_info_data);
+             j++) {
+            DWORD addr, bus, slot, type;
+            int func, dev;
+
+            /* There is no need to allocate buffer in the next functions. The size
+            * is known and ULONG according to
+            * https://msdn.microsoft.com/en-us/library/windows/hardware/ff543095(v=vs.85).aspx
+            */
+            if (!SetupDiGetDeviceRegistryProperty(
+                  parent_dev_info, &parent_dev_info_data, SPDRP_BUSNUMBER,
+                  &type, (PBYTE)&bus, size, NULL)) {
+                debug_error("failed to get PCI bus");
+                bus = -1;
+                partial_pci = true;
+            }
+
+            /* The function retrieves the device's address. This value will be
+            * transformed into device function and number */
+            if (!SetupDiGetDeviceRegistryProperty(
+                    parent_dev_info, &parent_dev_info_data, SPDRP_ADDRESS,
+                    &type, (PBYTE)&addr, size, NULL)) {
+                debug_error("failed to get PCI address");
+                addr = -1;
+                partial_pci = true;
+            }
+
+            /* This call returns UINumber of DEVICE_CAPABILITIES structure.
+            * This number is typically a user-perceived slot number. */
+            if (!SetupDiGetDeviceRegistryProperty(
+                    parent_dev_info, &parent_dev_info_data, SPDRP_UI_NUMBER,
+                    &type, (PBYTE)&slot, size, NULL)) {
+                debug_error("failed to get PCI slot");
+                slot = -1;
+                partial_pci = true;
+            }
+
+            /* SetupApi gives us the same information as driver with
+            * IoGetDeviceProperty. According to Microsoft
+            * https://docs.microsoft.com/en-us/windows/desktop/api/setupapi/nf-setupapi-setupdigetdeviceregistrypropertya
+            * FunctionNumber = (USHORT)((propertyAddress) & 0x0000FFFF);
+            * DeviceNumber = (USHORT)(((propertyAddress) >> 16) & 0x0000FFFF);
+            * SPDRP_ADDRESS is propertyAddress, so we do the same.*/
+
+            if (partial_pci) {
+                pci->domain = -1;
+                pci->slot = -1;
+                pci->function = -1;
+                pci->bus = -1;
+                continue;
+            } else {
+                func = ((int)addr == -1) ? -1 : addr & 0x0000FFFF;
+                dev = ((int)addr == -1) ? -1 : (addr >> 16) & 0x0000FFFF;
+                pci->domain = dev;
+                pci->slot = (int)slot;
+                pci->function = func;
+                pci->bus = (int)bus;
+                break;
+            }
         }
+        SetupDiDestroyDeviceInfoList(parent_dev_info);
         break;
     }
 
 free_dev_info:
     SetupDiDestroyDeviceInfoList(dev_info);
 out:
-    g_free(buffer);
-    g_free(name);
     return pci;
 }
 
@@ -691,7 +783,8 @@ out_free:
     return;
 }
 
-static void get_single_disk_info(GuestDiskAddress *disk, Error **errp)
+static void get_single_disk_info(int disk_number,
+                                 GuestDiskAddress *disk, Error **errp)
 {
     SCSI_ADDRESS addr, *scsi_ad;
     DWORD len;
@@ -720,7 +813,7 @@ static void get_single_disk_info(GuestDiskAddress *disk, Error **errp)
      * if that doesn't hold since that suggests some other unexpected
      * breakage
      */
-    disk->pci_controller = get_pci_info(disk->dev, &local_err);
+    disk->pci_controller = get_pci_info(disk_number, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto err_close;
@@ -736,7 +829,7 @@ static void get_single_disk_info(GuestDiskAddress *disk, Error **errp)
         /* We are able to use the same ioctls for different bus types
          * according to Microsoft docs
          * https://technet.microsoft.com/en-us/library/ee851589(v=ws.10).aspx */
-        g_debug("getting pci-controller info");
+        g_debug("getting SCSI info");
         if (DeviceIoControl(disk_h, IOCTL_SCSI_GET_ADDRESS, NULL, 0, scsi_ad,
                             sizeof(SCSI_ADDRESS), &len, NULL)) {
             disk->unit = addr.Lun;
@@ -784,12 +877,10 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
     size = sizeof(VOLUME_DISK_EXTENTS);
     extents = g_malloc0(size);
     if (!DeviceIoControl(vol_h, IOCTL_VOLUME_GET_VOLUME_DISK_EXTENTS, NULL,
-                         0, extents, size, NULL, NULL)) {
+                         0, extents, size, &size, NULL)) {
         DWORD last_err = GetLastError();
         if (last_err == ERROR_MORE_DATA) {
             /* Try once more with big enough buffer */
-            size = sizeof(VOLUME_DISK_EXTENTS)
-                + extents->NumberOfDiskExtents*sizeof(DISK_EXTENT);
             g_free(extents);
             extents = g_malloc0(size);
             if (!DeviceIoControl(
@@ -805,7 +896,7 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
             disk = g_malloc0(sizeof(GuestDiskAddress));
             disk->has_dev = true;
             disk->dev = g_strdup(name);
-            get_single_disk_info(disk, &local_err);
+            get_single_disk_info(0xffffffff, disk, &local_err);
             if (local_err) {
                 g_debug("failed to get disk info, ignoring error: %s",
                     error_get_pretty(local_err));
@@ -839,9 +930,9 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
          */
         disk->has_dev = true;
         disk->dev = g_strdup_printf("\\\\.\\PhysicalDrive%lu",
-            extents->Extents[i].DiskNumber);
+                                    extents->Extents[i].DiskNumber);
 
-        get_single_disk_info(disk, &local_err);
+        get_single_disk_info(extents->Extents[i].DiskNumber, disk, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             goto out;
-- 
2.11.0.windows.1
