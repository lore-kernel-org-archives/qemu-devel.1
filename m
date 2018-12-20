Received: from eggs.gnu.org ([2001:4830:134:3::10]:46605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1gZn5b-0005qk-VJ
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1gZn5X-00030A-Nz
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:25:27 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c]:37340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <viktor.prutyanov@phystech.edu>)
	id 1gZn5V-0002le-Qf
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:25:22 -0500
Received: by mail-lj1-x22c.google.com with SMTP id t18-v6so74708ljd.4
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 17:25:11 -0800 (PST)
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Date: Thu, 20 Dec 2018 04:24:40 +0300
Message-Id: <20181220012441.13694-6-viktor.prutyanov@phystech.edu>
In-Reply-To: <20181220012441.13694-1-viktor.prutyanov@phystech.edu>
References: <20181220012441.13694-1-viktor.prutyanov@phystech.edu>
Subject: [Qemu-devel] [PATCH v2 5/6] contrib/elf2dmp: fix printf format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rkagan@virtuozzo.com
Cc: eblake@redhat.com, qemu-devel@nongnu.org, Viktor Prutyanov <viktor.prutyanov@phystech.edu>

Format strings for printf are changed for successful build for Windows
hosts.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
---
 contrib/elf2dmp/main.c | 27 +++++++++++++++------------
 contrib/elf2dmp/pdb.c  |  4 +++-
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 9b93dab662..fdafb54900 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -5,6 +5,8 @@
  *
  */
 
+#include <inttypes.h>
+
 #include "qemu/osdep.h"
 #include "err.h"
 #include "addrspace.h"
@@ -41,7 +43,8 @@ static const uint64_t SharedUserData = 0xfffff78000000000;
 #define KUSD_OFFSET_PRODUCT_TYPE 0x264
 
 #define SYM_RESOLVE(base, r, s) ((s = pdb_resolve(base, r, #s)),\
-    s ? printf(#s" = 0x%016lx\n", s) : eprintf("Failed to resolve "#s"\n"), s)
+    s ? printf(#s" = 0x%016"PRIx64"\n", s) :\
+    eprintf("Failed to resolve "#s"\n"), s)
 
 static uint64_t rol(uint64_t x, uint64_t y)
 {
@@ -98,8 +101,8 @@ static KDDEBUGGER_DATA64 *get_kdbg(uint64_t KernBase, struct pdb_reader *pdb,
             return NULL;
         }
 
-        printf("[KiWaitNever] = 0x%016lx\n", kwn);
-        printf("[KiWaitAlways] = 0x%016lx\n", kwa);
+        printf("[KiWaitNever] = 0x%016"PRIx64"\n", kwn);
+        printf("[KiWaitAlways] = 0x%016"PRIx64"\n", kwa);
 
         /*
          * If KDBG header can be decoded, KDBG size is available
@@ -202,7 +205,7 @@ static int fix_dtb(struct va_space *vs, QEMU_Elf *qe)
 
         if (is_system(s)) {
             va_space_set_dtb(vs, s->cr[3]);
-            printf("DTB 0x%016lx has been found from CPU #%zu"
+            printf("DTB 0x%016"PRIx64" has been found from CPU #%zu"
                     " as system task CR3\n", vs->dtb, i);
             return !(va_space_resolve(vs, SharedUserData));
         }
@@ -222,7 +225,7 @@ static int fix_dtb(struct va_space *vs, QEMU_Elf *qe)
         }
 
         va_space_set_dtb(vs, *cr3);
-        printf("DirectoryTableBase = 0x%016lx has been found from CPU #0"
+        printf("DirectoryTableBase = 0x%016"PRIx64" has been found from CPU #0"
                 " as interrupt handling CR3\n", vs->dtb);
         return !(va_space_resolve(vs, SharedUserData));
     }
@@ -393,8 +396,8 @@ static int pe_get_pdb_symstore_hash(uint64_t base, void *start_addr,
         return 1;
     }
 
-    printf("Debug Directory RVA = 0x%016x\n",
-            data_dir[IMAGE_FILE_DEBUG_DIRECTORY].VirtualAddress);
+    printf("Debug Directory RVA = 0x%08"PRIx32"\n",
+            (uint32_t)data_dir[IMAGE_FILE_DEBUG_DIRECTORY].VirtualAddress);
 
     if (va_space_rw(vs,
                 base + data_dir[IMAGE_FILE_DEBUG_DIRECTORY].VirtualAddress,
@@ -488,7 +491,7 @@ int main(int argc, char *argv[])
     }
 
     state = qemu_elf.state[0];
-    printf("CPU #0 CR3 is 0x%016lx\n", state->cr[3]);
+    printf("CPU #0 CR3 is 0x%016"PRIx64"\n", state->cr[3]);
 
     va_space_create(&vs, &ps, state->cr[3]);
     if (fix_dtb(&vs, &qemu_elf)) {
@@ -497,7 +500,7 @@ int main(int argc, char *argv[])
         goto out_elf;
     }
 
-    printf("CPU #0 IDT is at 0x%016lx\n", state->idt.base);
+    printf("CPU #0 IDT is at 0x%016"PRIx64"\n", state->idt.base);
 
     if (va_space_rw(&vs, state->idt.base,
                 &first_idt_desc, sizeof(first_idt_desc), 0)) {
@@ -505,10 +508,10 @@ int main(int argc, char *argv[])
         err = 1;
         goto out_ps;
     }
-    printf("CPU #0 IDT[0] -> 0x%016lx\n", idt_desc_addr(first_idt_desc));
+    printf("CPU #0 IDT[0] -> 0x%016"PRIx64"\n", idt_desc_addr(first_idt_desc));
 
     KernBase = idt_desc_addr(first_idt_desc) & ~(PAGE_SIZE - 1);
-    printf("Searching kernel downwards from 0x%16lx...\n", KernBase);
+    printf("Searching kernel downwards from 0x%016"PRIx64"...\n", KernBase);
 
     for (; KernBase >= 0xfffff78000000000; KernBase -= PAGE_SIZE) {
         nt_start_addr = va_space_resolve(&vs, KernBase);
@@ -521,7 +524,7 @@ int main(int argc, char *argv[])
         }
     }
 
-    printf("KernBase = 0x%16lx, signature is \'%.2s\'\n", KernBase,
+    printf("KernBase = 0x%016"PRIx64", signature is \'%.2s\'\n", KernBase,
             (char *)nt_start_addr);
 
     if (pe_get_pdb_symstore_hash(KernBase, nt_start_addr, pdb_hash, &vs)) {
diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index 52e352df79..64af20f584 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -18,6 +18,8 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
  */
 
+#include <inttypes.h>
+
 #include "qemu/osdep.h"
 #include "pdb.h"
 #include "err.h"
@@ -66,7 +68,7 @@ uint64_t pdb_find_public_v3_symbol(struct pdb_reader *r, const char *name)
             uint32_t sect_rva = segment->dword[1];
             uint64_t rva = sect_rva + sym->public_v3.offset;
 
-            printf("%s: 0x%016x(%d:\'%.8s\') + 0x%08x = 0x%09lx\n", name,
+            printf("%s: 0x%016x(%d:\'%.8s\') + 0x%08x = 0x%09"PRIx64"\n", name,
                     sect_rva, sym->public_v3.segment,
                     ((char *)segment - 8), sym->public_v3.offset, rva);
             return rva;
-- 
2.17.2
