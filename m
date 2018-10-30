Received: from eggs.gnu.org ([2001:4830:134:3::10]:46710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHVHR-0000CY-V2
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHVHL-0001zt-Lq
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:46:05 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735]:44766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHVHJ-0001Jq-Mw
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:45:58 -0400
Received: by mail-qk1-x735.google.com with SMTP id n12so7367654qkh.11
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 07:45:33 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 09:43:42 -0500
Message-Id: <20181030144358.23144-9-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
References: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/24] qga-win: fsinfo: pci-info: allow partial
 info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Sameeh Jubran <sjubran@redhat.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

From: Sameeh Jubran <sjubran@redhat.com>

The call to SetupDiGetDeviceRegistryProperty might fail because the
value doesn't exist in the registry, in this case we shouldn't exit from
the loop but instead continue to look for other available values in the
registry and set this value as unavailable (-1).

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
*squash in fix for when get_pci_info() returns NULL pci_controller field
*fix handling for error_set() cases in get_pci_info(), not just NULL return
*force all -1 PCI addr fields if any single one of them isn't found
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-win32.c | 46 +++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index f0e6f6128b..4fe1517778 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -499,6 +499,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
     char *buffer = NULL;
     GuestPCIAddress *pci = NULL;
     char *name = g_strdup(&guid[4]);
+    bool partial_pci = false;
     pci = g_malloc0(sizeof(*pci));
     pci->domain = -1;
     pci->slot = -1;
@@ -519,7 +520,8 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
 
     dev_info_data.cbSize = sizeof(SP_DEVINFO_DATA);
     for (i = 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); i++) {
-        DWORD addr, bus, slot, func, dev, data, size2;
+        DWORD addr, bus, slot, data, size2;
+        int func, dev;
         while (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
                                             SPDRP_PHYSICAL_DEVICE_OBJECT_NAME,
                                             &data, (PBYTE)buffer, size,
@@ -549,21 +551,24 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
          */
         if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
                    SPDRP_BUSNUMBER, &data, (PBYTE)&bus, size, NULL)) {
-            break;
+            bus = -1;
+            partial_pci = true;
         }
 
         /* The function retrieves the device's address. This value will be
          * transformed into device function and number */
         if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
                    SPDRP_ADDRESS, &data, (PBYTE)&addr, size, NULL)) {
-            break;
+            addr = -1;
+            partial_pci = true;
         }
 
         /* This call returns UINumber of DEVICE_CAPABILITIES structure.
          * This number is typically a user-perceived slot number. */
         if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
                    SPDRP_UI_NUMBER, &data, (PBYTE)&slot, size, NULL)) {
-            break;
+            slot = -1;
+            partial_pci = true;
         }
 
         /* SetupApi gives us the same information as driver with
@@ -573,12 +578,19 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
          * DeviceNumber = (USHORT)(((propertyAddress) >> 16) & 0x0000FFFF);
          * SPDRP_ADDRESS is propertyAddress, so we do the same.*/
 
-        func = addr & 0x0000FFFF;
-        dev = (addr >> 16) & 0x0000FFFF;
-        pci->domain = dev;
-        pci->slot = slot;
-        pci->function = func;
-        pci->bus = bus;
+        if (partial_pci) {
+            pci->domain = -1;
+            pci->slot = -1;
+            pci->function = -1;
+            pci->bus = -1;
+        } else {
+            func = ((int) addr == -1) ? -1 : addr & 0x0000FFFF;
+            dev = ((int) addr == -1) ? -1 : (addr >> 16) & 0x0000FFFF;
+            pci->domain = dev;
+            pci->slot = (int) slot;
+            pci->function = func;
+            pci->bus = (int) bus;
+        }
         break;
     }
 
@@ -622,6 +634,7 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
     DWORD len;
     int bus;
     HANDLE vol_h;
+    Error *local_err = NULL;
 
     scsi_ad = &addr;
     char *name = g_strndup(guid, strlen(guid)-1);
@@ -640,6 +653,16 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
 
     disk = g_malloc0(sizeof(*disk));
     disk->bus_type = find_bus_type(bus);
+    /* always set pci_controller as required by schema. get_pci_info() should
+     * report -1 values for non-PCI buses rather than fail. fail the command
+     * if that doesn't hold since that suggests some other unexpected
+     * breakage
+     */
+    disk->pci_controller = get_pci_info(name, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto out_close;
+    }
     if (bus == BusTypeScsi || bus == BusTypeAta || bus == BusTypeRAID
 #if (_WIN32_WINNT >= 0x0600)
             /* This bus type is not supported before Windows Server 2003 SP1 */
@@ -654,12 +677,9 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
             disk->unit = addr.Lun;
             disk->target = addr.TargetId;
             disk->bus = addr.PathId;
-            disk->pci_controller = get_pci_info(name, errp);
         }
         /* We do not set error in this case, because we still have enough
          * information about volume. */
-    } else {
-         disk->pci_controller = NULL;
     }
 
     list = g_malloc0(sizeof(*list));
-- 
2.17.1
