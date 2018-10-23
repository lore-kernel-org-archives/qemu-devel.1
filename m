Received: from eggs.gnu.org ([2001:4830:134:3::10]:42823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gEuml-0001rP-61
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gEumj-0007lt-5i
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1gEumi-0007l0-Ur
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id a9so1257166wrx.9
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 04:23:40 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue, 23 Oct 2018 13:23:20 +0200
Message-Id: <9a5ef741f75e87ef47f2f36b4075d55789b30870.1540293796.git.tgolembi@redhat.com>
In-Reply-To: <cover.1540293795.git.tgolembi@redhat.com>
References: <cover.1540293795.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 11/14] qga-win: refactor disk info
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
 qga/commands-win32.c | 58 ++++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index e7d9cdea62..bb9bf0218a 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -637,20 +637,15 @@ out_free:
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
@@ -660,7 +655,6 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
         goto err;
     }
 
-    disk = g_malloc0(sizeof(*disk));
     get_disk_properties(vol_h, disk, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -671,7 +665,11 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
     /* always set pci_controller as required by schema. get_pci_info() should
      * report -1 values for non-PCI buses rather than fail.
      */
-    disk->pci_controller = get_pci_info(name, errp);
+    disk->pci_controller = get_pci_info(name, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto err_close;
+    }
     if (disk->bus_type == GUEST_DISK_BUS_TYPE_SCSI
             || disk->bus_type == GUEST_DISK_BUS_TYPE_IDE
             || disk->bus_type == GUEST_DISK_BUS_TYPE_RAID
@@ -694,20 +692,44 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
          * information about volume. */
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
+    if (g_str_has_suffix(name, "\\")) {
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
+    qapi_free_GuestDiskAddress(disk);
     g_free(name);
 
-    return NULL;
+    return list;
 }
 
 #else
-- 
2.19.0
