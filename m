Received: from eggs.gnu.org ([2001:4830:134:3::10]:42738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gEumi-0001qW-3l
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gEumg-0007i0-1w
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1gEumc-0007c8-UQ
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so1273737wrw.3
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 04:23:33 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue, 23 Oct 2018 13:23:14 +0200
Message-Id: <424c3de694d06531e3b21e5d965b4b7f7d7be190.1540293795.git.tgolembi@redhat.com>
In-Reply-To: <cover.1540293795.git.tgolembi@redhat.com>
References: <cover.1540293795.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 05/14] qga-win: fsinfo: pci-info: allow
 partial info
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

From: Sameeh Jubran <sjubran@redhat.com>

The call to SetupDiGetDeviceRegistryProperty might fail because the
value doesn't exist in the registry, in this case we shouldn't exit from
the loop but instead continue to look for other available values in the
registry and set this value as unavailable (-1).

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
(cherry picked from commit d42f51de2d10b318d396f4f439f7a3995fdc0f65)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-win32.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 8289e7d6ea..a8967abf06 100644
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
2.19.0
