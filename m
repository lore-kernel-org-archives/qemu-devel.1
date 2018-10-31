Received: from eggs.gnu.org ([2001:4830:134:3::10]:33352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHrMZ-0000pl-Ax
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHrMY-0007Aa-3E
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:20:51 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:40302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHrMW-00073G-63
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:20:48 -0400
Received: by mail-oi1-x232.google.com with SMTP id u130-v6so8989805oie.7
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 07:20:36 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 31 Oct 2018 09:19:14 -0500
Message-Id: <20181031141925.30026-14-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181031141925.30026-1-mdroth@linux.vnet.ibm.com>
References: <20181031141925.30026-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 13/24] qga-win: refactor disk info
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

Refactor building of disk info into a function that builds the list and
a function that returns infor for single disk. This will be used in
future commit that will handle multi-disk volumes.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-win32.c | 52 +++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 2d7b56d538..21a88d31e1 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -667,20 +667,15 @@ out_free:
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
@@ -690,7 +685,6 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
         goto err;
     }
 
-    disk = g_malloc0(sizeof(*disk));
     get_disk_properties(vol_h, disk, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -730,20 +724,44 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
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
2.17.1
