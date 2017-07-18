Received: from eggs.gnu.org ([2001:4830:134:3::10]:51632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dXVKh-0000YI-Bk
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dXVKg-00012f-Ay
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:26:47 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2017 17:26:32 +0100
Message-Id: <1500395194-21455-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500395194-21455-1-git-send-email-peter.maydell@linaro.org>
References: <1500395194-21455-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.10 2/4] bsd-user/elfload.c: Fix
 set-but-not-used warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

Fix various warnings about set-but-not-used variables on OpenBSD:

bsd-user/elfload.c:1158:15: warning: variable 'mapped_addr' set but not used [-Wunused-but-set-variable]
bsd-user/elfload.c:1165:9: warning: variable 'status' set but not used [-Wunused-but-set-variable]
bsd-user/elfload.c:1168:15: warning: variable 'elf_stack' set but not used [-Wunused-but-set-variable]

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 bsd-user/elfload.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 41a1309..7cccf3e 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -1155,21 +1155,20 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
     unsigned int interpreter_type = INTERPRETER_NONE;
     unsigned char ibcs2_interpreter;
     int i;
-    abi_ulong mapped_addr;
     struct elf_phdr * elf_ppnt;
     struct elf_phdr *elf_phdata;
     abi_ulong elf_bss, k, elf_brk;
     int retval;
     char * elf_interpreter;
     abi_ulong elf_entry, interp_load_addr = 0;
-    int status;
     abi_ulong start_code, end_code, start_data, end_data;
     abi_ulong reloc_func_desc = 0;
-    abi_ulong elf_stack;
+#ifdef LOW_ELF_STACK
+    abi_ulong elf_stack = ~((abi_ulong)0UL);
+#endif
     char passed_fileno[6];
 
     ibcs2_interpreter = 0;
-    status = 0;
     load_addr = 0;
     load_bias = 0;
     elf_ex = *((struct elfhdr *) bprm->buf);          /* exec-header */
@@ -1221,7 +1220,6 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
     elf_brk = 0;
 
 
-    elf_stack = ~((abi_ulong)0UL);
     elf_interpreter = NULL;
     start_code = ~((abi_ulong)0UL);
     end_code = 0;
@@ -1546,7 +1544,7 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
                and some applications "depend" upon this behavior.
                Since we do not have the power to recompile these, we
                emulate the SVr4 behavior.  Sigh.  */
-            mapped_addr = target_mmap(0, qemu_host_page_size, PROT_READ | PROT_EXEC,
+            target_mmap(0, qemu_host_page_size, PROT_READ | PROT_EXEC,
                                       MAP_FIXED | MAP_PRIVATE, -1, 0);
     }
 
-- 
2.7.4
