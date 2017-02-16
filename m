Received: from eggs.gnu.org ([2001:4830:134:3::10]:53769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceNCk-0000gn-Cn
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:38:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceNCg-0002LP-B7
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:38:42 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:52445)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ceNCg-0002Kr-0O
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:38:38 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 16 Feb 2017 15:38:15 +0100
Message-Id: <20170216143816.2384-14-laurent@vivier.eu>
In-Reply-To: <20170216143816.2384-1-laurent@vivier.eu>
References: <20170216143816.2384-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 13/14] linux-user: Use correct types in
 load_symbols()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>

From: Peter Maydell <peter.maydell@linaro.org>

Coverity doesn't like the code in load_symbols() which assumes
it can use 'int' for a variable that might hold an offset into
the guest ELF file, because in a 64-bit guest that could
overflow. Guest binaries with 2GB sections aren't very likely
and this isn't a security issue because we fully trust the
guest linux-user binary anyway, but we might as well use the
right types, which will placate Coverity. Use uint64_t to
hold section sizes, and bail out if the symbol table is too
large rather than just overflowing an int.

(Coverity issue CID1005776)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <1486249533-5260-1-git-send-email-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8271227..f520d77 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2262,6 +2262,7 @@ static int symcmp(const void *s0, const void *s1)
 static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias)
 {
     int i, shnum, nsyms, sym_idx = 0, str_idx = 0;
+    uint64_t segsz;
     struct elf_shdr *shdr;
     char *strings = NULL;
     struct syminfo *s = NULL;
@@ -2293,19 +2294,26 @@ static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias)
         goto give_up;
     }
 
-    i = shdr[str_idx].sh_size;
-    s->disas_strtab = strings = g_try_malloc(i);
-    if (!strings || pread(fd, strings, i, shdr[str_idx].sh_offset) != i) {
+    segsz = shdr[str_idx].sh_size;
+    s->disas_strtab = strings = g_try_malloc(segsz);
+    if (!strings ||
+        pread(fd, strings, segsz, shdr[str_idx].sh_offset) != segsz) {
         goto give_up;
     }
 
-    i = shdr[sym_idx].sh_size;
-    syms = g_try_malloc(i);
-    if (!syms || pread(fd, syms, i, shdr[sym_idx].sh_offset) != i) {
+    segsz = shdr[sym_idx].sh_size;
+    syms = g_try_malloc(segsz);
+    if (!syms || pread(fd, syms, segsz, shdr[sym_idx].sh_offset) != segsz) {
         goto give_up;
     }
 
-    nsyms = i / sizeof(struct elf_sym);
+    if (segsz / sizeof(struct elf_sym) > INT_MAX) {
+        /* Implausibly large symbol table: give up rather than ploughing
+         * on with the number of symbols calculation overflowing
+         */
+        goto give_up;
+    }
+    nsyms = segsz / sizeof(struct elf_sym);
     for (i = 0; i < nsyms; ) {
         bswap_sym(syms + i);
         /* Throw away entries which we do not need.  */
-- 
2.9.3
