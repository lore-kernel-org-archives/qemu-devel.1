Received: from eggs.gnu.org ([2001:4830:134:3::10]:38838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fmzYP-00089e-FW
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fmzYK-000358-If
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:49:29 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:54209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1fmzYK-00034v-Ad
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:49:24 -0400
Received: by mail-wm0-f45.google.com with SMTP id s9-v6so16926164wmh.3
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 03:49:24 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue,  7 Aug 2018 12:49:16 +0200
Message-Id: <9fcdb4fc0d467b1e0f0a4b2e299305e05a62e7eb.1533638952.git.tgolembi@redhat.com>
In-Reply-To: <cover.1533638952.git.tgolembi@redhat.com>
References: <cover.1533638952.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/4] qga: win32: add debugging information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

The windows code generaly lacks debug information (compared to posix
code). This patch adds some related to HW info in guest-get-fsinfo
command.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-win32.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 318d760a74..36d76c22c0 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -498,6 +498,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
         goto out;
     }
 
+    g_debug("enumerating devices");
     dev_info_data.cbSize = sizeof(SP_DEVINFO_DATA);
     for (i = 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); i++) {
         DWORD addr, bus, slot, func, dev, data, size2;
@@ -522,6 +523,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
         if (g_strcmp0(buffer, dev_name)) {
             continue;
         }
+        g_debug("found device %s", dev_name);
 
         /* There is no need to allocate buffer in the next functions. The size
          * is known and ULONG according to
@@ -530,6 +532,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
          */
         if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
                    SPDRP_BUSNUMBER, &data, (PBYTE)&bus, size, NULL)) {
+            g_debug("failed to get bus");
             break;
         }
 
@@ -537,6 +540,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
          * transformed into device function and number */
         if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
                    SPDRP_ADDRESS, &data, (PBYTE)&addr, size, NULL)) {
+            g_debug("failed to get address");
             break;
         }
 
@@ -544,6 +548,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
          * This number is typically a user-perceived slot number. */
         if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
                    SPDRP_UI_NUMBER, &data, (PBYTE)&slot, size, NULL)) {
+            g_debug("failed to get slot");
             break;
         }
 
@@ -608,6 +613,7 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
     scsi_ad = &addr;
     char *name = g_strndup(guid, strlen(guid)-1);
 
+    g_debug("getting disk info for: %s", name);
     vol_h = CreateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
                        0, NULL);
     if (vol_h == INVALID_HANDLE_VALUE) {
@@ -615,6 +621,7 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
         goto out_free;
     }
 
+    g_debug("getting bus type");
     bus = get_disk_bus_type(vol_h, errp);
     if (bus < 0) {
         goto out_close;
@@ -622,6 +629,7 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
 
     disk = g_malloc0(sizeof(*disk));
     disk->bus_type = find_bus_type(bus);
+    g_debug("bus type %d", disk->bus_type);
     if (bus == BusTypeScsi || bus == BusTypeAta || bus == BusTypeRAID
 #if (_WIN32_WINNT >= 0x0600)
             /* This bus type is not supported before Windows Server 2003 SP1 */
@@ -631,6 +639,7 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
         /* We are able to use the same ioctls for different bus types
          * according to Microsoft docs
          * https://technet.microsoft.com/en-us/library/ee851589(v=ws.10).aspx */
+        g_debug("getting pci-controller info");
         if (DeviceIoControl(vol_h, IOCTL_SCSI_GET_ADDRESS, NULL, 0, scsi_ad,
                             sizeof(SCSI_ADDRESS), &len, NULL)) {
             disk->unit = addr.Lun;
-- 
2.18.0
