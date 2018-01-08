Received: from eggs.gnu.org ([2001:4830:134:3::10]:50715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eYfJI-0001nC-6t
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:50:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eYfJE-00038Z-II
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:50:24 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Mon,  8 Jan 2018 23:50:07 +0200
Message-Id: <20180108215007.46471-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH] fw_cfg: fix memory corruption when all fw_cfg
 slots are used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, ehabkost@redhat.com, lersek@redhat.com, kraxel@redhat.com, qemu-stable@nongnu.org

When all the fw_cfg slots are used, a write is made outside the
bounds of the fw_cfg files array as part of the sort algorithm.

Fix it by avoiding an unnecessary array element move.
Fix also an assert while at it.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/nvram/fw_cfg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 753ac0e4ea..4313484b21 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -784,7 +784,7 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
      * index and "i - 1" is the one being copied from, thus the
      * unusual start and end in the for statement.
      */
-    for (i = count + 1; i > index; i--) {
+    for (i = count; i > index; i--) {
         s->files->f[i] = s->files->f[i - 1];
         s->files->f[i].select = cpu_to_be16(FW_CFG_FILE_FIRST + i);
         s->entries[0][FW_CFG_FILE_FIRST + i] =
@@ -833,7 +833,6 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
     assert(s->files);
 
     index = be32_to_cpu(s->files->count);
-    assert(index < fw_cfg_file_slots(s));
 
     for (i = 0; i < index; i++) {
         if (strcmp(filename, s->files->f[i].name) == 0) {
@@ -843,6 +842,9 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
             return ptr;
         }
     }
+
+    assert(index < fw_cfg_file_slots(s));
+
     /* add new one */
     fw_cfg_add_file_callback(s, filename, NULL, NULL, NULL, data, len, true);
     return NULL;
-- 
2.13.5
