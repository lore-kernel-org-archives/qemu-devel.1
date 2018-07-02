Received: from eggs.gnu.org ([2001:4830:134:3::10]:60732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fa11T-0007ka-2t
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fa11S-0000Dz-4n
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:45:51 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:52520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fa11R-0000DZ-T6
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:45:50 -0400
Received: by mail-wm0-x234.google.com with SMTP id w16-v6so8879074wmc.2
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:45:49 -0700 (PDT)
Received: from 640k.lan ([82.84.124.111]) by smtp.gmail.com with ESMTPSA id
	q17-v6sm19087521wrr.7.2018.07.02.08.45.47 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 02 Jul 2018 08:45:48 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  2 Jul 2018 17:45:40 +0200
Message-Id: <1530546340-4366-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530546340-4366-1-git-send-email-pbonzini@redhat.com>
References: <1530546340-4366-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 50/50] tcg: simplify !CONFIG_TCG handling of
 tb_invalidate_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

There is no need for a stub, since tb_invalidate_phys_addr can be excised
altogether when TCG is disabled.  This is a bit cleaner since it avoids
using code that is clearly specific to user-mode emulation (it calls
mmap_lock/unlock) for the !CONFIG_TCG case.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/stubs/tcg-stub.c  | 6 ------
 exec.c                  | 6 +++++-
 include/exec/exec-all.h | 8 +++-----
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 8ee85ed..76ae461 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -16,7 +16,6 @@
 #include "tcg/tcg.h"
 #include "exec/cpu-common.h"
 #include "exec/exec-all.h"
-#include "translate-all.h"
 
 void tb_flush(CPUState *cpu)
 {
@@ -25,8 +24,3 @@ void tb_flush(CPUState *cpu)
 void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
 {
 }
-
-void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
-                                   int is_cpu_write_access)
-{
-}
diff --git a/exec.c b/exec.c
index ee72688..4f5df07 100644
--- a/exec.c
+++ b/exec.c
@@ -1027,7 +1027,7 @@ const char *parse_cpu_model(const char *cpu_model)
     return cpu_type;
 }
 
-#if defined(CONFIG_USER_ONLY) || !defined(CONFIG_TCG)
+#if defined(CONFIG_USER_ONLY)
 void tb_invalidate_phys_addr(target_ulong addr)
 {
     mmap_lock();
@@ -1046,6 +1046,10 @@ void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
     MemoryRegion *mr;
     hwaddr l = 1;
 
+    if (!tcg_enabled()) {
+        return;
+    }
+
     rcu_read_lock();
     mr = address_space_translate(as, addr, &addr, &l, false, attrs);
     if (!(memory_region_is_ram(mr)
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index cb497de..da73e3b 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -412,13 +412,11 @@ static inline uint32_t curr_cflags(void)
 }
 
 /* TranslationBlock invalidate API */
-#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
-void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs);
-#else
-void tb_invalidate_phys_addr(target_ulong addr);
-#endif
 #if defined(CONFIG_USER_ONLY)
+void tb_invalidate_phys_addr(target_ulong addr);
 void tb_invalidate_phys_range(target_ulong start, target_ulong end);
+#else
+void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs);
 #endif
 void tb_flush(CPUState *cpu);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
-- 
1.8.3.1
