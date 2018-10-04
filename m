Received: from eggs.gnu.org ([2001:4830:134:3::10]:34956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1g81tC-0004Dx-5R
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1g81iQ-0003Vv-M4
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:22:50 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:35805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1g81iQ-0003Ux-Eu
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:22:46 -0400
Received: by mail-wr1-f42.google.com with SMTP id w5-v6so9501521wrt.2
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 04:22:46 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Thu,  4 Oct 2018 13:22:31 +0200
Message-Id: <f6d66487b5d9aa0e8e1c3bda856746ba58cabeae.1538652143.git.tgolembi@redhat.com>
In-Reply-To: <cover.1538652143.git.tgolembi@redhat.com>
References: <cover.1538652143.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 04/11] qga-win: add debugging information
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

The windows code generaly lacks debug information (compared to posix
code). This patch adds some related to HW info in guest-get-fsinfo
command.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-win32.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 49fc747298..2a7a3af614 100644
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
+            debug_error("failed to get bus");
             break;
         }
 
@@ -537,6 +546,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
          * transformed into device function and number */
         if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
                    SPDRP_ADDRESS, &data, (PBYTE)&addr, size, NULL)) {
+            debug_error("failed to get address");
             break;
         }
 
@@ -544,6 +554,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
          * This number is typically a user-perceived slot number. */
         if (!SetupDiGetDeviceRegistryProperty(dev_info, &dev_info_data,
                    SPDRP_UI_NUMBER, &data, (PBYTE)&slot, size, NULL)) {
+            debug_error("failed to get slot");
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
2.19.0
