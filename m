Received: from eggs.gnu.org ([2001:4830:134:3::10]:45176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9uT-0001c5-QQ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9uQ-0003Sb-FE
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:32:09 -0500
Received: from mail-db5eur01on0121.outbound.protection.outlook.com
	([104.47.2.121]:11584
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ej9uQ-0003RX-2e
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:32:06 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Feb 2018 23:30:46 +0300
Message-Id: <20180206203048.11096-33-rkagan@virtuozzo.com>
In-Reply-To: <20180206203048.11096-1-rkagan@virtuozzo.com>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 32/34] loader: allow arbitrary basename for
 fw_cfg file roms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>, Ben Warren <ben@skyportsystems.com>, si-wei liu <si-wei.liu@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, Vadim Rozenfeld <vrozenfe@redhat.com>

rom_add_file assumes that the basename of the file roms in fw_cfg should
be the same as the original basename of the rom file on the filesystem.

However, this is not always convenient: the rom basename may bear
certain meaning in the guest firmware context, e.g. contain device ids,
while the the filename on the host filesystem may be something more
human-readable.

[In particular, this is how I'm planning to supply roms for Hyper-V
VMBus devices, which don't have a spec-defined way of doing this.]

To cater to such usecases, interpret the corresponding argument of
rom_add_file as a path which, if ends with a slash, is interpreted as a
"directory" to which the basename of the rom file is appended; otherwise
this argument is treated as a full fw_cfg path.

TODO: it may be a better idea to use separate arguments for "directory"
and "filename" instead of interpreting the trailing dash.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 include/hw/loader.h |  2 +-
 hw/core/loader.c    | 43 +++++++++++++++++++++----------------------
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index 355fe0f5a2..a309662fa8 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -186,7 +186,7 @@ void pstrcpy_targphys(const char *name,
 extern bool option_rom_has_mr;
 extern bool rom_file_has_mr;
 
-int rom_add_file(const char *file, const char *fw_dir,
+int rom_add_file(const char *file, const char *fw_path,
                  hwaddr addr, int32_t bootindex,
                  bool option_rom, MemoryRegion *mr, AddressSpace *as);
 MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 91669d65aa..436154de48 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -817,7 +817,6 @@ struct Rom {
     MemoryRegion *mr;
     AddressSpace *as;
     int isrom;
-    char *fw_dir;
     char *fw_file;
 
     hwaddr addr;
@@ -882,7 +881,7 @@ static void *rom_set_mr(Rom *rom, Object *owner, const char *name, bool ro)
     return data;
 }
 
-int rom_add_file(const char *file, const char *fw_dir,
+int rom_add_file(const char *file, const char *fw_path,
                  hwaddr addr, int32_t bootindex,
                  bool option_rom, MemoryRegion *mr,
                  AddressSpace *as)
@@ -914,10 +913,6 @@ int rom_add_file(const char *file, const char *fw_dir,
         goto err;
     }
 
-    if (fw_dir) {
-        rom->fw_dir  = g_strdup(fw_dir);
-        rom->fw_file = g_strdup(file);
-    }
     rom->addr     = addr;
     rom->romsize  = lseek(fd, 0, SEEK_END);
     if (rom->romsize == -1) {
@@ -937,20 +932,26 @@ int rom_add_file(const char *file, const char *fw_dir,
     }
     close(fd);
     rom_insert(rom);
-    if (rom->fw_file && fw_cfg) {
+    if (fw_path && fw_cfg) {
         const char *basename;
-        char fw_file_name[FW_CFG_MAX_FILE_PATH];
         void *data;
 
-        basename = strrchr(rom->fw_file, '/');
-        if (basename) {
-            basename++;
+        basename = strrchr(fw_path, '/');
+        if (basename && basename[1] == '\0') {
+            /* given path terminates with '/', append basename(file) */
+            basename = strrchr(file, '/');
+            if (basename) {
+                basename++;
+            } else {
+                basename = file;
+            }
+
+            rom->fw_file = g_strdup_printf("%s%s", fw_path, basename);
         } else {
-            basename = rom->fw_file;
+            rom->fw_file = g_strdup(fw_path);
         }
-        snprintf(fw_file_name, sizeof(fw_file_name), "%s/%s", rom->fw_dir,
-                 basename);
-        snprintf(devpath, sizeof(devpath), "/rom@%s", fw_file_name);
+
+        snprintf(devpath, sizeof(devpath), "/rom@%s", rom->fw_file);
 
         if ((!option_rom || mc->option_rom_has_mr) && mc->rom_file_has_mr) {
             data = rom_set_mr(rom, OBJECT(fw_cfg), devpath, true);
@@ -958,7 +959,7 @@ int rom_add_file(const char *file, const char *fw_dir,
             data = rom->data;
         }
 
-        fw_cfg_add_file(fw_cfg, fw_file_name, data, rom->romsize);
+        fw_cfg_add_file(fw_cfg, rom->fw_file, data, rom->romsize);
     } else {
         if (mr) {
             rom->mr = mr;
@@ -978,8 +979,7 @@ err:
     g_free(rom->data);
     g_free(rom->path);
     g_free(rom->name);
-    if (fw_dir) {
-        g_free(rom->fw_dir);
+    if (fw_path) {
         g_free(rom->fw_file);
     }
     g_free(rom);
@@ -1052,12 +1052,12 @@ int rom_add_elf_program(const char *name, void *data, size_t datasize,
 
 int rom_add_vga(const char *file)
 {
-    return rom_add_file(file, "vgaroms", 0, -1, true, NULL, NULL);
+    return rom_add_file(file, "vgaroms/", 0, -1, true, NULL, NULL);
 }
 
 int rom_add_option(const char *file, int32_t bootindex)
 {
-    return rom_add_file(file, "genroms", 0, bootindex, true, NULL, NULL);
+    return rom_add_file(file, "genroms/", 0, bootindex, true, NULL, NULL);
 }
 
 static void rom_reset(void *unused)
@@ -1255,9 +1255,8 @@ void hmp_info_roms(Monitor *mon, const QDict *qdict)
                            rom->isrom ? "rom" : "ram",
                            rom->name);
         } else {
-            monitor_printf(mon, "fw=%s/%s"
+            monitor_printf(mon, "fw=%s"
                            " size=0x%06zx name=\"%s\"\n",
-                           rom->fw_dir,
                            rom->fw_file,
                            rom->romsize,
                            rom->name);
-- 
2.14.3
