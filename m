Received: from eggs.gnu.org ([2001:4830:134:3::10]:46667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecZf8-0007rl-Oa
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecZf8-00081j-2c
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:37:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecZf7-00081D-Sh
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:37:05 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 19 Jan 2018 14:33:45 -0200
Message-Id: <20180119163345.10649-20-ehabkost@redhat.com>
In-Reply-To: <20180119163345.10649-1-ehabkost@redhat.com>
References: <20180119163345.10649-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v2 19/19] fw_cfg: fix memory corruption when all
 fw_cfg slots are used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>

From: Marcel Apfelbaum <marcel@redhat.com>

When all the fw_cfg slots are used, a write is made outside the
bounds of the fw_cfg files array as part of the sort algorithm.

Fix it by avoiding an unnecessary array element move.
Fix also an assert while at it.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Message-Id: <20180108215007.46471-1-marcel@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
2.14.3
