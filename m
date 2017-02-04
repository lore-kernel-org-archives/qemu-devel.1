Received: from eggs.gnu.org ([2001:4830:134:3::10]:37112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ca9Os-00038i-SS
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 18:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ca9Op-0006lJ-P8
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 18:05:46 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ca9Op-0006gR-Ha
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 18:05:43 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat,  4 Feb 2017 23:05:33 +0000
Message-Id: <1486249533-5260-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] linux-user: Use correct types in load_symbols()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

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
---
 linux-user/elfload.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c66cbbe..f4c7b0c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2263,6 +2263,7 @@ static int symcmp(const void *s0, const void *s1)
 static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias)
 {
     int i, shnum, nsyms, sym_idx = 0, str_idx = 0;
+    uint64_t segsz;
     struct elf_shdr *shdr;
     char *strings = NULL;
     struct syminfo *s = NULL;
@@ -2294,19 +2295,26 @@ static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias)
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
2.1.4
