Received: from eggs.gnu.org ([208.118.235.92]:42924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fuzp6-00069q-RQ
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fuznm-000327-Kv
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:42:28 -0400
Received: from mail-eopbgr40138.outbound.protection.outlook.com
	([40.107.4.138]:19424
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <viktor.prutyanov@virtuozzo.com>)
	id 1fuznm-0002zG-Db
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:42:26 -0400
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Date: Wed, 29 Aug 2018 15:41:27 +0300
Message-Id: <1535546488-30208-5-git-send-email-viktor.prutyanov@virtuozzo.com>
In-Reply-To: <1535546488-30208-1-git-send-email-viktor.prutyanov@virtuozzo.com>
References: <1535546488-30208-1-git-send-email-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/5] contrib/elf2dmp: add DMP file name as 2nd
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, armbru@redhat.com, dgilbert@redhat.com, rkagan@virtuozzo.com, viktor.prutyanov@phystech.edu, Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>

Before this patch output DMP file name was strictly 'memory.dmp'.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
---
 contrib/elf2dmp/main.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 62f08e0..64782fc 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -334,24 +334,36 @@ static int fill_context(KDDEBUGGER_DATA64 *kdbg,
     return 0;
 }
 
-static int write_dump(struct pa_space *ps, WinDumpHeader64 *hdr)
+static int write_dump(struct pa_space *ps,
+        WinDumpHeader64 *hdr, const char *name)
 {
-    FILE *dmp_file = fopen("memory.dmp", "wb");
+    FILE *dmp_file = fopen(name, "wb");
 
     if (!dmp_file) {
+        eprintf("Failed to open output file \'%s\'\n", name);
         return 1;
     }
 
-    printf("Writing down to file...\n");
-    fwrite(hdr, sizeof(*hdr), 1, dmp_file);
+    printf("Writing header to file...\n");
 
-    for (size_t i = 0; i < ps->block_nr; i++) {
-        fwrite(ps->block[i].addr, ps->block[i].size, 1, dmp_file);
+    if (fwrite(hdr, sizeof(*hdr), 1, dmp_file) != 1) {
+        eprintf("Failed to write dump header\n");
+        fclose(dmp_file);
+        return 1;
     }
 
-    fclose(dmp_file);
+    for (size_t i = 0; i < ps->block_nr; i++) {
+        struct pa_block *b = &ps->block[i];
 
-    return 0;
+        printf("Writing block #%zu/%zu to file...\n", i, ps->block_nr);
+        if (fwrite(b->addr, b->size, 1, dmp_file) != 1) {
+            eprintf("Failed to write dump header\n");
+            fclose(dmp_file);
+            return 1;
+        }
+    }
+
+    return fclose(dmp_file);
 }
 
 static int pe_get_pdb_symstore_hash(uint64_t base, void *start_addr,
@@ -464,8 +476,8 @@ int main(int argc, char *argv[])
     KDDEBUGGER_DATA64 *kdbg;
     uint64_t KdVersionBlock;
 
-    if (argc != 2) {
-        eprintf("usage:\n\t%s elf_dump\n", argv[0]);
+    if (argc != 3) {
+        eprintf("usage:\n\t%s elf_file dmp_file\n", argv[0]);
         return 1;
     }
 
@@ -561,7 +573,7 @@ int main(int argc, char *argv[])
         goto out_pdb;
     }
 
-    if (write_dump(&ps, &header)) {
+    if (write_dump(&ps, &header, argv[2])) {
         eprintf("Failed to save dump\n");
         err = 1;
         goto out_kdbg;
-- 
2.7.4
