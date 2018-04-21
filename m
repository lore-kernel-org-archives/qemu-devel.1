Received: from eggs.gnu.org ([2001:4830:134:3::10]:55704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fA1oz-0002g8-RX
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 19:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fA1ow-00007Z-Nx
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 19:21:33 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fA1ow-00007O-Ix
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 19:21:30 -0400
Received: by mail-qk0-x242.google.com with SMTP id b131so8105739qkg.2
	for <qemu-devel@nongnu.org>; Sat, 21 Apr 2018 16:21:30 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 21 Apr 2018 20:21:20 -0300
Message-Id: <20180421232120.22208-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] elf-loader: Avoid calling qsort(NULL, 0,
 ...) call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

This fixes the following ASan warning:

  $ qemu-system-xtensa -M kc705 -m 128M -semihosting -nographic -monitor null -kernel Image.elf
  include/hw/elf_ops.h:179:5: runtime error: null pointer passed as argument 1, which is declared to never be null

Reported-by: AddressSanitizer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/elf_ops.h | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index b6e19e35d0..f0ac7c6c4e 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -110,7 +110,7 @@ static int glue(load_symbols, SZ)(struct elfhdr *ehdr, int fd, int must_swab,
     struct elf_shdr *symtab, *strtab, *shdr_table = NULL;
     struct elf_sym *syms = NULL;
     struct syminfo *s;
-    int nsyms, i;
+    int nsyms, i, ret = -1;
     char *str = NULL;
 
     shdr_table = load_at(fd, ehdr->e_shoff,
@@ -143,6 +143,7 @@ static int glue(load_symbols, SZ)(struct elfhdr *ehdr, int fd, int must_swab,
     if (!str) {
         goto fail;
     }
+    ret = 0;
 
     i = 0;
     while (i < nsyms) {
@@ -170,30 +171,34 @@ static int glue(load_symbols, SZ)(struct elfhdr *ehdr, int fd, int must_swab,
         }
         i++;
     }
-    syms = g_realloc(syms, nsyms * sizeof(*syms));
+    if (nsyms) {
+        syms = g_realloc(syms, nsyms * sizeof(*syms));
 
-    qsort(syms, nsyms, sizeof(*syms), glue(symcmp, SZ));
-    for (i = 0; i < nsyms - 1; i++) {
-        if (syms[i].st_size == 0) {
-            syms[i].st_size = syms[i + 1].st_value - syms[i].st_value;
+        qsort(syms, nsyms, sizeof(*syms), glue(symcmp, SZ));
+        for (i = 0; i < nsyms - 1; i++) {
+            if (syms[i].st_size == 0) {
+                syms[i].st_size = syms[i + 1].st_value - syms[i].st_value;
+            }
         }
+
+        /* Commit */
+        s = g_malloc0(sizeof(*s));
+        s->lookup_symbol = glue(lookup_symbol, SZ);
+        glue(s->disas_symtab.elf, SZ) = syms;
+        s->disas_num_syms = nsyms;
+        s->disas_strtab = str;
+        s->next = syminfos;
+        syminfos = s;
+
+        goto out;
     }
 
-    /* Commit */
-    s = g_malloc0(sizeof(*s));
-    s->lookup_symbol = glue(lookup_symbol, SZ);
-    glue(s->disas_symtab.elf, SZ) = syms;
-    s->disas_num_syms = nsyms;
-    s->disas_strtab = str;
-    s->next = syminfos;
-    syminfos = s;
-    g_free(shdr_table);
-    return 0;
  fail:
     g_free(syms);
     g_free(str);
+ out:
     g_free(shdr_table);
-    return -1;
+    return ret;
 }
 
 static int glue(elf_reloc, SZ)(struct elfhdr *ehdr, int fd, int must_swab,
-- 
2.17.0
