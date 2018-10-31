Received: from eggs.gnu.org ([2001:4830:134:3::10]:33457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHrMf-0000vG-7i
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHrMZ-0007CH-E9
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:20:55 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:33790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHrMY-0006wi-Uo
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:20:51 -0400
Received: by mail-oi1-x231.google.com with SMTP id c25-v6so13756981oiy.0
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 07:20:27 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 31 Oct 2018 09:19:11 -0500
Message-Id: <20181031141925.30026-11-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181031141925.30026-1-mdroth@linux.vnet.ibm.com>
References: <20181031141925.30026-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 10/24] qga-win: add debugging information
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

The windows code generaly lacks debug information (compared to posix
code). This patch adds some related to HW info in guest-get-fsinfo
command.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-win32.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 4fe1517778..1a21aac5ad 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -89,6 +89,12 @@ static OpenFlags guest_file_open_modes[] = {
     {"a+b", FILE_GENERIC_APPEND|GENERIC_READ, OPEN_ALWAYS  }
 };
 
+#define debug_error(msg) do { \
+    char *suffix = g_win32_error_message(GetLastError()); \
+    g_debug("%s: %s", (msg), suffix); \
+    g_free(suffix); \
+} while (0)
+
 static OpenFlags *find_open_flag(const char *mode_str)
 {
     int mode;
@@ -518,6 +524,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
         goto out;
     }
 
+    g_debug("enumerating devices");
     dev_info_data.cbSize = sizeof(SP_DEVINFO_DATA);
     for (i = 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); i++) {
         DWORD addr, bus, slot, data, size2;
@@ -543,6 +550,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
         if (g_strcmp0(buffer, dev_name)) {
             continue;
         }
+        g_debug("found device %s", dev_name);
 
         /* There is no need to allocate buffer in the next functions. The size
          * is known and ULONG according to
@@ -551,6 +559,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
          */
         if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
                    SPDRP_BUSNUMBER, &data, (PBYTE)&bus, size, NULL)) {
+            debug_error("failed to get bus");
             bus = -1;
             partial_pci = true;
         }
@@ -559,6 +568,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
          * transformed into device function and number */
         if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
                    SPDRP_ADDRESS, &data, (PBYTE)&addr, size, NULL)) {
+            debug_error("failed to get address");
             addr = -1;
             partial_pci = true;
         }
@@ -567,6 +577,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
          * This number is typically a user-perceived slot number. */
         if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
                    SPDRP_UI_NUMBER, &data, (PBYTE)&slot, size, NULL)) {
+            debug_error("failed to get slot");
             slot = -1;
             partial_pci = true;
         }
@@ -639,6 +650,7 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
     scsi_ad = &addr;
     char *name = g_strndup(guid, strlen(guid)-1);
 
+    g_debug("getting disk info for: %s", name);
     vol_h = CreateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
                        0, NULL);
     if (vol_h == INVALID_HANDLE_VALUE) {
@@ -646,6 +658,7 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
         goto out_free;
     }
 
+    g_debug("getting bus type");
     bus = get_disk_bus_type(vol_h, errp);
     if (bus < 0) {
         goto out_close;
@@ -653,6 +666,7 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
 
     disk = g_malloc0(sizeof(*disk));
     disk->bus_type = find_bus_type(bus);
+    g_debug("bus type %d", disk->bus_type);
     /* always set pci_controller as required by schema. get_pci_info() should
      * report -1 values for non-PCI buses rather than fail. fail the command
      * if that doesn't hold since that suggests some other unexpected
@@ -672,6 +686,7 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
         /* We are able to use the same ioctls for different bus types
          * according to Microsoft docs
          * https://technet.microsoft.com/en-us/library/ee851589(v=ws.10).aspx */
+        g_debug("getting pci-controller info");
         if (DeviceIoControl(vol_h, IOCTL_SCSI_GET_ADDRESS, NULL, 0, scsi_ad,
                             sizeof(SCSI_ADDRESS), &len, NULL)) {
             disk->unit = addr.Lun;
-- 
2.17.1
