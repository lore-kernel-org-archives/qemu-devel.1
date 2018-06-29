Received: from eggs.gnu.org ([2001:4830:134:3::10]:47156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYzfx-0005Nq-6h
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYzfs-0002x8-77
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:07:25 -0400
Received: from mail-qk0-x231.google.com ([2607:f8b0:400d:c09::231]:44176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYzfr-0002wT-VO
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:07:20 -0400
Received: by mail-qk0-x231.google.com with SMTP id i188-v6so5620358qkc.11
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 13:07:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 29 Jun 2018 17:07:10 -0300
Message-Id: <20180629200710.27626-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] tcg: Fix --disable-tcg build breakage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Emilio G . Cota" <cota@braap.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Fix the --disable-tcg breakage introduced by 8bca9a03ec60d:

    $ configure --disable-tcg
    [...]
    $ make -C i386-softmmu exec.o
    make: Entering directory 'i386-softmmu'
      CC      exec.o
    In file included from source/qemu/exec.c:62:0:
    source/qemu/include/exec/ram_addr.h:96:6: error: conflicting types for ‘tb_invalidate_phys_range’
     void tb_invalidate_phys_range(ram_addr_t start, ram_addr_t end);
          ^~~~~~~~~~~~~~~~~~~~~~~~
    In file included from source/qemu/exec.c:24:0:
    source/qemu/include/exec/exec-all.h:309:6: note: previous declaration of ‘tb_invalidate_phys_range’ was here
     void tb_invalidate_phys_range(target_ulong start, target_ulong end);
          ^~~~~~~~~~~~~~~~~~~~~~~~
    source/qemu/exec.c:1043:6: error: conflicting types for ‘tb_invalidate_phys_addr’
     void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
          ^~~~~~~~~~~~~~~~~~~~~~~
    In file included from source/qemu/exec.c:24:0:
    source/qemu/include/exec/exec-all.h:308:6: note: previous declaration of ‘tb_invalidate_phys_addr’ was here
     void tb_invalidate_phys_addr(target_ulong addr);
          ^~~~~~~~~~~~~~~~~~~~~~~
    make: *** [source/qemu/rules.mak:69: exec.o] Error 1
    make: Leaving directory 'i386-softmmu'

Tested to build x86_64-softmmu and i386-softmmu targets.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/exec/exec-all.h | 13 +++++++++----
 accel/stubs/tcg-stub.c  |  6 ++++++
 exec.c                  |  2 +-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 6a7e7a866e..cb497dee0b 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -255,7 +255,6 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
 void tlb_set_page(CPUState *cpu, target_ulong vaddr,
                   hwaddr paddr, int prot,
                   int mmu_idx, target_ulong size);
-void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs);
 void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
                  uintptr_t retaddr);
 #else
@@ -304,9 +303,6 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                        uint16_t idxmap)
 {
 }
-
-void tb_invalidate_phys_addr(target_ulong addr);
-void tb_invalidate_phys_range(target_ulong start, target_ulong end);
 #endif
 
 #define CODE_GEN_ALIGN           16 /* must be >= of the size of a icache line */
@@ -415,6 +411,15 @@ static inline uint32_t curr_cflags(void)
          | (use_icount ? CF_USE_ICOUNT : 0);
 }
 
+/* TranslationBlock invalidate API */
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
+void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs);
+#else
+void tb_invalidate_phys_addr(target_ulong addr);
+#endif
+#if defined(CONFIG_USER_ONLY)
+void tb_invalidate_phys_range(target_ulong start, target_ulong end);
+#endif
 void tb_flush(CPUState *cpu);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 76ae461749..8ee85ed665 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -16,6 +16,7 @@
 #include "tcg/tcg.h"
 #include "exec/cpu-common.h"
 #include "exec/exec-all.h"
+#include "translate-all.h"
 
 void tb_flush(CPUState *cpu)
 {
@@ -24,3 +25,8 @@ void tb_flush(CPUState *cpu)
 void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
 {
 }
+
+void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
+                                   int is_cpu_write_access)
+{
+}
diff --git a/exec.c b/exec.c
index cdcf769daa..ee726888a5 100644
--- a/exec.c
+++ b/exec.c
@@ -1027,7 +1027,7 @@ const char *parse_cpu_model(const char *cpu_model)
     return cpu_type;
 }
 
-#if defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_USER_ONLY) || !defined(CONFIG_TCG)
 void tb_invalidate_phys_addr(target_ulong addr)
 {
     mmap_lock();
-- 
2.18.0
