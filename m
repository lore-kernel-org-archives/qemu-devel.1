Received: from eggs.gnu.org ([2001:4830:134:3::10]:38539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.dakinevich@gmail.com>) id 1dtNvU-0007Im-26
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 20:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.dakinevich@gmail.com>) id 1dtNvQ-0006dz-Vm
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 20:59:12 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:36949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.dakinevich@gmail.com>)
	id 1dtNvQ-0006ae-Mr
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 20:59:08 -0400
Received: by mail-lf0-x241.google.com with SMTP id q132so2879940lfe.4
	for <qemu-devel@nongnu.org>; Sat, 16 Sep 2017 17:59:08 -0700 (PDT)
From: Jan Dakinevich <jan.dakinevich@gmail.com>
Date: Sun, 17 Sep 2017 04:01:23 +0300
Message-Id: <1505610083-15519-1-git-send-email-jan.dakinevich@gmail.com>
Subject: [Qemu-devel] [PATCH] 9pfs: fix name_to_path assertion in
 v9fs_complete_rename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Jan Dakinevich <jan.dakinevich@gmail.com>

The third parameter of v9fs_co_name_to_path() must not contain `/'
character.

The issue is most likely related to 9p2000.u protocol only.

Signed-off-by: Jan Dakinevich <jan.dakinevich@gmail.com>
---
 hw/9pfs/9p.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 1ca0a7b..4d4ed85 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2568,13 +2568,11 @@ static int coroutine_fn v9fs_complete_rename(V9fsPDU *pdu, V9fsFidState *fidp,
                                              int32_t newdirfid,
                                              V9fsString *name)
 {
-    char *end;
     int err = 0;
     V9fsPath new_path;
     V9fsFidState *tfidp;
     V9fsState *s = pdu->s;
     V9fsFidState *dirfidp = NULL;
-    char *old_name, *new_name;
 
     v9fs_path_init(&new_path);
     if (newdirfid != -1) {
@@ -2592,18 +2590,15 @@ static int coroutine_fn v9fs_complete_rename(V9fsPDU *pdu, V9fsFidState *fidp,
             goto out;
         }
     } else {
-        old_name = fidp->path.data;
-        end = strrchr(old_name, '/');
-        if (end) {
-            end++;
-        } else {
-            end = old_name;
-        }
-        new_name = g_malloc0(end - old_name + name->size + 1);
-        strncat(new_name, old_name, end - old_name);
-        strncat(new_name + (end - old_name), name->data, name->size);
-        err = v9fs_co_name_to_path(pdu, NULL, new_name, &new_path);
-        g_free(new_name);
+        char *dir_name = g_path_get_dirname(fidp->path.data);
+        V9fsPath dir_path;
+
+        v9fs_path_init(&dir_path);
+        v9fs_path_sprintf(&dir_path, "%s", dir_name);
+        g_free(dir_name);
+
+        err = v9fs_co_name_to_path(pdu, &dir_path, name->data, &new_path);
+        v9fs_path_free(&dir_path);
         if (err < 0) {
             goto out;
         }
-- 
2.1.4
