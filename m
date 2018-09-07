Received: from eggs.gnu.org ([2001:4830:134:3::10]:36688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fyF9d-0000tW-5l
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fyF9Z-00048j-3f
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:42:25 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:53157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1fyF9Y-00046e-OU
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:42:20 -0400
Received: by mail-wm0-f53.google.com with SMTP id y139-v6so14323940wmc.2
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 04:42:20 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Fri,  7 Sep 2018 13:42:11 +0200
Message-Id: <6614d7912a3ce65158ff17f977fd9b7c1aa45559.1536320522.git.tgolembi@redhat.com>
In-Reply-To: <cover.1536320522.git.tgolembi@redhat.com>
References: <cover.1536320522.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 3/5] qga: win32: add debugging information
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

The windows code generaly lacks debug information (compared to posix
code). This patch adds some related to HW info in guest-get-fsinfo
command.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-win32.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 9c959122d9..e16c58275e 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -89,6 +89,12 @@ static OpenFlags guest_file_open_modes[] = {
     {"a+b", FILE_GENERIC_APPEND|GENERIC_READ, OPEN_ALWAYS  }
 };
 
+#define g_debug_err(msg) do { \
+    char *suffix = g_win32_error_message(GetLastError()); \
+    g_debug("%s: %s", (msg), suffix); \
+    g_free(suffix); \
+} while(0)
+
 static OpenFlags *find_open_flag(const char *mode_str)
 {
     int mode;
@@ -498,6 +504,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
         goto out;
     }
 
+    g_debug("enumerating devices");
     dev_info_data.cbSize = sizeof(SP_DEVINFO_DATA);
     for (i = 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); i++) {
         DWORD addr, bus, slot, func, dev, data, size2;
@@ -522,6 +529,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
         if (g_strcmp0(buffer, dev_name)) {
             continue;
         }
+        g_debug("found device %s", dev_name);
 
         /* There is no need to allocate buffer in the next functions. The size
          * is known and ULONG according to
@@ -530,6 +538,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
          */
         if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
                    SPDRP_BUSNUMBER, &data, (PBYTE)&bus, size, NULL)) {
+            g_debug_err("failed to get bus");
             break;
         }
 
@@ -537,6 +546,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
          * transformed into device function and number */
         if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
                    SPDRP_ADDRESS, &data, (PBYTE)&addr, size, NULL)) {
+            g_debug_err("failed to get address");
             break;
         }
 
@@ -544,6 +554,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
          * This number is typically a user-perceived slot number. */
         if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
                    SPDRP_UI_NUMBER, &data, (PBYTE)&slot, size, NULL)) {
+            g_debug_err("failed to get slot");
             break;
         }
 
@@ -608,6 +619,7 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
     scsi_ad = &addr;
     char *name = g_strndup(guid, strlen(guid)-1);
 
+    g_debug("getting disk info for: %s", name);
     vol_h = CreateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
                        0, NULL);
     if (vol_h == INVALID_HANDLE_VALUE) {
@@ -615,6 +627,7 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
         goto out_free;
     }
 
+    g_debug("getting bus type");
     bus = get_disk_bus_type(vol_h, errp);
     if (bus < 0) {
         goto out_close;
@@ -622,6 +635,7 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
 
     disk = g_malloc0(sizeof(*disk));
     disk->bus_type = find_bus_type(bus);
+    g_debug("bus type %d", disk->bus_type);
     if (bus == BusTypeScsi || bus == BusTypeAta || bus == BusTypeRAID
 #if (_WIN32_WINNT >= 0x0600)
             /* This bus type is not supported before Windows Server 2003 SP1 */
@@ -631,6 +645,7 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
         /* We are able to use the same ioctls for different bus types
          * according to Microsoft docs
          * https://technet.microsoft.com/en-us/library/ee851589(v=ws.10).aspx */
+        g_debug("getting pci-controller info");
         if (DeviceIoControl(vol_h, IOCTL_SCSI_GET_ADDRESS, NULL, 0, scsi_ad,
                             sizeof(SCSI_ADDRESS), &len, NULL)) {
             Error *local_err = NULL;
-- 
2.18.0
