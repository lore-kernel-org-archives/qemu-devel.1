Received: from eggs.gnu.org ([2001:4830:134:3::10]:58990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cEMoE-0003He-OC
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cEMoD-0006RV-T4
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:57:54 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cEMoD-0006Ny-Pv
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:57:53 -0500
Received: by mail-yw0-f196.google.com with SMTP id b66so29935814ywh.2
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 12:57:32 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue,  6 Dec 2016 15:56:27 -0500
Message-Id: <20161206205627.8443-4-bobby.prani@gmail.com>
In-Reply-To: <20161206205627.8443-1-bobby.prani@gmail.com>
References: <20161206205627.8443-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 3/3] tcg: Explicitly unlock tb_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, mst@redhat.com, cota@braap.org

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 exec.c             | 2 ++
 hw/i386/kvmvapic.c | 1 +
 translate-all.c    | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/exec.c b/exec.c
index 46e2044b1f..f49088b259 100644
--- a/exec.c
+++ b/exec.c
@@ -2115,11 +2115,13 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
                 tb_lock();
                 tb_check_watchpoint(cpu);
                 if (wp->flags & BP_STOP_BEFORE_ACCESS) {
+                    tb_unlock();
                     cpu->exception_index = EXCP_DEBUG;
                     cpu_loop_exit(cpu);
                 } else {
                     cpu_get_tb_cpu_state(env, &pc, &cs_base, &cpu_flags);
                     tb_gen_code(cpu, pc, cs_base, cpu_flags, 1);
+                    tb_unlock();
                     cpu_loop_exit_noexc(cpu);
                 }
             }
diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index c8d908ede6..ffee94dd88 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -454,6 +454,7 @@ static void patch_instruction(VAPICROMState *s, X86CPU *cpu, target_ulong ip)
          *  longjmps back into the cpu_exec loop. */
         tb_lock();
         tb_gen_code(cs, current_pc, current_cs_base, current_flags, 1);
+        tb_unlock();
         cpu_loop_exit_noexc(cs);
     }
 }
diff --git a/translate-all.c b/translate-all.c
index cf828aa927..240c0a5c3d 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -1282,6 +1282,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
  buffer_overflow:
         /* flush must be done */
         tb_flush(cpu);
+        tb_unlock();
         mmap_unlock();
         cpu_loop_exit(cpu);
     }
@@ -1526,6 +1527,7 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
            modifying the memory. It will ensure that it cannot modify
            itself */
         tb_gen_code(cpu, current_pc, current_cs_base, current_flags, 1);
+        tb_unlock();
         cpu_loop_exit_noexc(cpu);
     }
 #endif
@@ -1802,6 +1804,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     /* FIXME: In theory this could raise an exception.  In practice
        we have already translated the block once so it's probably ok.  */
     tb_gen_code(cpu, pc, cs_base, flags, cflags);
+    tb_unlock();
 
     /* TODO: If env->pc != tb->pc (i.e. the faulting instruction was not
      * the first in the TB) then we end up generating a whole new TB and
-- 
2.11.0
