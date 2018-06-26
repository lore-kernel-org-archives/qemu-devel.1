Received: from eggs.gnu.org ([2001:4830:134:3::10]:52254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fXpcK-0003lO-6t
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fXpcJ-0008A9-A6
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:10:52 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:54820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fXpcJ-00089r-3U
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:10:51 -0400
Received: by mail-wm0-x244.google.com with SMTP id i139-v6so2365573wmf.4
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 08:10:51 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 26 Jun 2018 18:10:38 +0300
Message-Id: <20180626151038.24771-3-sameeh@daynix.com>
In-Reply-To: <20180626151038.24771-1-sameeh@daynix.com>
References: <20180626151038.24771-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH 2/2] qga-win: fsinfo: pci-info: allow partial
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
Cc: Yan Vugenfirer <yan@daynix.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

From: Sameeh Jubran <sjubran@redhat.com>

The call to SetupDiGetDeviceRegistryProperty might fail because the
value doesn't exist in the registry, in this case we shouldn't exit from
the loop but instead continue to look for other available values in the
registry and set this value as unavailable (-1).

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 qga/commands-win32.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index c5f1c884e1..55e460dee3 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -505,7 +505,8 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
 
     dev_info_data.cbSize = sizeof(SP_DEVINFO_DATA);
     for (i = 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); i++) {
-        DWORD addr, bus, slot, func, dev, data, size2;
+        DWORD addr, bus, slot, data, size2;
+        int func, dev;
         while (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
                                             SPDRP_PHYSICAL_DEVICE_OBJECT_NAME,
                                             &data, (PBYTE)buffer, size,
@@ -535,21 +536,21 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
          */
         if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
                    SPDRP_BUSNUMBER, &data, (PBYTE)&bus, size, NULL)) {
-            break;
+            bus = -1;
         }
 
         /* The function retrieves the device's address. This value will be
          * transformed into device function and number */
         if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
                    SPDRP_ADDRESS, &data, (PBYTE)&addr, size, NULL)) {
-            break;
+            addr = -1;
         }
 
         /* This call returns UINumber of DEVICE_CAPABILITIES structure.
          * This number is typically a user-perceived slot number. */
         if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
                    SPDRP_UI_NUMBER, &data, (PBYTE)&slot, size, NULL)) {
-            break;
+            slot = -1;
         }
 
         /* SetupApi gives us the same information as driver with
@@ -559,12 +560,12 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
          * DeviceNumber = (USHORT)(((propertyAddress) >> 16) & 0x0000FFFF);
          * SPDRP_ADDRESS is propertyAddress, so we do the same.*/
 
-        func = addr & 0x0000FFFF;
-        dev = (addr >> 16) & 0x0000FFFF;
+        func = ((int) addr == -1) ? -1 : addr & 0x0000FFFF;
+        dev = ((int) addr == -1) ? -1 : (addr >> 16) & 0x0000FFFF;
         pci->domain = dev;
-        pci->slot = slot;
+        pci->slot = (int) slot;
         pci->function = func;
-        pci->bus = bus;
+        pci->bus = (int) bus;
         break;
     }
 
-- 
2.13.6
