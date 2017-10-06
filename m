Received: from eggs.gnu.org ([2001:4830:134:3::10]:41572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPj-0008Dt-Ga
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPi-0005nX-8N
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:19 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:25 -0300
Message-Id: <20171006235023.11952-31-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 30/88] QEMU Guest Agent: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: added qga/commands-posix.c and qga/commands-win32.c]
---
 qga/commands-posix.c | 20 ++++++++++----------
 qga/commands-win32.c | 12 ++++++------
 qga/commands.c       |  2 +-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index ab0c63d931..3a4deb6ae0 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -906,16 +906,16 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
         }
     }
 
-    pciaddr = g_malloc0(sizeof(*pciaddr));
+    pciaddr = g_new0(GuestPCIAddress, 1);
     pciaddr->domain = pci[0];
     pciaddr->bus = pci[1];
     pciaddr->slot = pci[2];
     pciaddr->function = pci[3];
 
-    disk = g_malloc0(sizeof(*disk));
+    disk = g_new0(GuestDiskAddress, 1);
     disk->pci_controller = pciaddr;
 
-    list = g_malloc0(sizeof(*list));
+    list = g_new0(GuestDiskAddressList, 1);
     list->value = disk;
 
     if (strcmp(driver, "ata_piix") == 0) {
@@ -1380,7 +1380,7 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
         return NULL;
     }
 
-    response = g_malloc0(sizeof(*response));
+    response = g_new0(GuestFilesystemTrimResponse, 1);
 
     QTAILQ_FOREACH(mount, &mounts, next) {
         result = g_malloc0(sizeof(*result));
@@ -1897,12 +1897,12 @@ GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
         GuestLogicalProcessor *vcpu;
         GuestLogicalProcessorList *entry;
 
-        vcpu = g_malloc0(sizeof *vcpu);
+        vcpu = g_new0(GuestLogicalProcessor, 1);
         vcpu->logical_id = current++;
         vcpu->has_can_offline = true; /* lolspeak ftw */
         transfer_vcpu(vcpu, true, &local_err);
 
-        entry = g_malloc0(sizeof *entry);
+        entry = g_new0(GuestLogicalProcessorList, 1);
         entry->value = vcpu;
 
         *link = entry;
@@ -2267,13 +2267,13 @@ GuestMemoryBlockList *qmp_guest_get_memory_blocks(Error **errp)
             continue;
         }
 
-        mem_blk = g_malloc0(sizeof *mem_blk);
+        mem_blk = g_new0(GuestMemoryBlock, 1);
         /* The d_name is "memoryXXX",  phys_index is block id, same as XXX */
         mem_blk->phys_index = strtoul(&de->d_name[6], NULL, 10);
         mem_blk->has_can_offline = true; /* lolspeak ftw */
         transfer_memory_block(mem_blk, true, NULL, &local_err);
 
-        entry = g_malloc0(sizeof *entry);
+        entry = g_new0(GuestMemoryBlockList, 1);
         entry->value = mem_blk;
 
         *link = entry;
@@ -2308,13 +2308,13 @@ qmp_guest_set_memory_blocks(GuestMemoryBlockList *mem_blks, Error **errp)
         GuestMemoryBlockResponseList *entry;
         GuestMemoryBlock *current_mem_blk = mem_blks->value;
 
-        result = g_malloc0(sizeof(*result));
+        result = g_new0(GuestMemoryBlockResponse, 1);
         result->phys_index = current_mem_blk->phys_index;
         transfer_memory_block(current_mem_blk, false, result, &local_err);
         if (local_err) { /* should never happen */
             goto err;
         }
-        entry = g_malloc0(sizeof *entry);
+        entry = g_new0(GuestMemoryBlockResponseList, 1);
         entry->value = result;
 
         *link = entry;
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 619dbd2bc2..908f110b8b 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -617,7 +617,7 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
         goto out_close;
     }
 
-    disk = g_malloc0(sizeof(*disk));
+    disk = g_new0(GuestDiskAddress, 1);
     disk->bus_type = find_bus_type(bus);
     if (bus == BusTypeScsi || bus == BusTypeAta || bus == BusTypeRAID
 #if (_WIN32_WINNT >= 0x0600)
@@ -641,7 +641,7 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
          disk->pci_controller = NULL;
     }
 
-    list = g_malloc0(sizeof(*list));
+    list = g_new0(GuestDiskAddressList, 1);
     list->value = disk;
     list->next = NULL;
 out_close:
@@ -694,7 +694,7 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
     }
 
     fs_name[sizeof(fs_name) - 1] = 0;
-    fs = g_malloc(sizeof(*fs));
+    fs = g_new(GuestFilesystemInfo, 1);
     fs->name = g_strdup(guid);
     if (len == 0) {
         fs->mountpoint = g_strdup("System Reserved");
@@ -877,7 +877,7 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
             continue;
         }
 
-        uc_path = g_malloc(sizeof(WCHAR) * char_count);
+        uc_path = g_new(WCHAR, char_count);
         if (!GetVolumePathNamesForVolumeNameW(guid, uc_path, char_count,
                                               &char_count) || !*uc_path) {
             /* strange, but this condition could be faced even with size == 2 */
@@ -1348,12 +1348,12 @@ GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
                     GuestLogicalProcessor *vcpu;
                     GuestLogicalProcessorList *entry;
 
-                    vcpu = g_malloc0(sizeof *vcpu);
+                    vcpu = g_new0(GuestLogicalProcessor, 1);
                     vcpu->logical_id = current++;
                     vcpu->online = true;
                     vcpu->has_can_offline = true;
 
-                    entry = g_malloc0(sizeof *entry);
+                    entry = g_new0(GuestLogicalProcessorList, 1);
                     entry->value = vcpu;
 
                     *link = entry;
diff --git a/qga/commands.c b/qga/commands.c
index ff89e805cf..d4c78ac935 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -239,7 +239,7 @@ static char **guest_exec_get_args(const strList *entry, bool log)
 
     str = g_malloc(str_size);
     *str = 0;
-    args = g_malloc(count * sizeof(char *));
+    args = g_new(char *, count);
     for (it = entry; it != NULL; it = it->next) {
         args[i++] = it->value;
         pstrcat(str, str_size, it->value);
-- 
2.14.2
