Received: from eggs.gnu.org ([2001:4830:134:3::10]:34612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1g81tG-0003yo-Tn
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1g81iV-0003YN-HH
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:22:55 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:39886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1g81iV-0003Xw-8L
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:22:51 -0400
Received: by mail-wm1-f48.google.com with SMTP id q8-v6so8615341wmq.4
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 04:22:51 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Thu,  4 Oct 2018 13:22:35 +0200
Message-Id: <c89305f9773d1a21f15eeb3df0b0f1692152379e.1538652143.git.tgolembi@redhat.com>
In-Reply-To: <cover.1538652143.git.tgolembi@redhat.com>
References: <cover.1538652143.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 08/11] qga-win: refactor disk info
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

Refactor building of disk info into a function that builds the list and
a function that returns infor for single disk. This will be used in
future commit that will handle multi-disk volumes.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-win32.c | 54 +++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 376ca1e288..1e64642b8a 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -632,20 +632,15 @@ out_free:
     return;
 }
 
-/* VSS provider works with volumes, thus there is no difference if
- * the volume consist of spanned disks. Info about the first disk in the
- * volume is returned for the spanned disk group (LVM) */
-static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
+static void get_single_disk_info(char *name, GuestDiskAddress *disk,
+    Error **errp)
 {
-    GuestDiskAddressList *list = NULL;
-    GuestDiskAddress *disk;
     SCSI_ADDRESS addr, *scsi_ad;
     DWORD len;
     HANDLE vol_h;
     Error *local_err = NULL;
 
     scsi_ad = &addr;
-    char *name = g_strndup(guid, strlen(guid)-1);
 
     g_debug("getting disk info for: %s", name);
     vol_h = CreateFile(name, 0, FILE_SHARE_READ, NULL, OPEN_EXISTING,
@@ -655,7 +650,6 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
         goto err;
     }
 
-    disk = g_malloc0(sizeof(*disk));
     get_disk_properties(vol_h, disk, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -676,7 +670,6 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
         g_debug("getting pci-controller info");
         if (DeviceIoControl(vol_h, IOCTL_SCSI_GET_ADDRESS, NULL, 0, scsi_ad,
                             sizeof(SCSI_ADDRESS), &len, NULL)) {
-            Error *local_err = NULL;
             disk->unit = addr.Lun;
             disk->target = addr.TargetId;
             disk->bus = addr.PathId;
@@ -688,6 +681,7 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
                 g_debug("failed to get PCI controller info: %s",
                     error_get_pretty(local_err));
                 error_free(local_err);
+                local_err = NULL;
             } else if (disk->pci_controller != NULL) {
                 g_debug("pci: domain=%lld bus=%lld slot=%lld function=%lld",
                     disk->pci_controller->domain,
@@ -704,20 +698,44 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
         disk->pci_controller = g_malloc0(sizeof(GuestPCIAddress));
     }
 
-    list = g_malloc0(sizeof(*list));
-    list->value = disk;
-    list->next = NULL;
-    CloseHandle(vol_h);
-    g_free(name);
-    return list;
-
 err_close:
-    g_free(disk);
     CloseHandle(vol_h);
 err:
+    return;
+}
+
+/* VSS provider works with volumes, thus there is no difference if
+ * the volume consist of spanned disks. Info about the first disk in the
+ * volume is returned for the spanned disk group (LVM) */
+static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
+{
+    Error *local_err = NULL;
+    GuestDiskAddressList *list = NULL, *cur_item = NULL;
+    GuestDiskAddress *disk = NULL;
+
+    /* strip final backslash */
+    char *name = g_strdup(guid);
+    if (g_str_has_suffix(name, "\\") == TRUE) {
+        name[strlen(name) - 1] = 0;
+    }
+
+    disk = g_malloc0(sizeof(GuestDiskAddress));
+    get_single_disk_info(name, disk, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto out;
+    }
+
+    cur_item = g_malloc0(sizeof(*list));
+    cur_item->value = disk;
+    disk = NULL;
+    list = cur_item;
+
+out:
+    g_free(disk);
     g_free(name);
 
-    return NULL;
+    return list;
 }
 
 #else
-- 
2.19.0
