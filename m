Received: from eggs.gnu.org ([2001:4830:134:3::10]:42862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eV0NN-0000mx-Je
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eV0NM-0000Qu-JZ
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:31:29 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:38016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eV0NM-0000PB-DU
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:31:28 -0500
Received: by mail-pf0-x242.google.com with SMTP id u25so22418458pfg.5
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 11:31:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 29 Dec 2017 11:31:13 -0800
Message-Id: <20171229193113.11753-9-richard.henderson@linaro.org>
In-Reply-To: <20171229193113.11753-1-richard.henderson@linaro.org>
References: <20171229193113.11753-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 8/8] tcg: add cs_base and flags to -d exec output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20171217055023.29225-1-pbonzini@redhat.com>
[rth: Also change the Chain logging in helper_lookup_tb_ptr.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c    | 6 ++++--
 accel/tcg/tcg-runtime.c | 5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 4452cd9856..280200f737 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -146,8 +146,10 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
     uint8_t *tb_ptr = itb->tc.ptr;
 
     qemu_log_mask_and_addr(CPU_LOG_EXEC, itb->pc,
-                           "Trace %p [%d: " TARGET_FMT_lx "] %s\n",
-                           itb->tc.ptr, cpu->cpu_index, itb->pc,
+                           "Trace %d: %p ["
+                           TARGET_FMT_lx "/" TARGET_FMT_lx "/%#x] %s\n",
+                           cpu->cpu_index, itb->tc.ptr,
+                           itb->cs_base, itb->pc, itb->flags,
                            lookup_symbol(itb->pc));
 
 #if defined(DEBUG_DISAS)
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 4172ffda82..d0d4484406 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -156,8 +156,9 @@ void *HELPER(lookup_tb_ptr)(CPUArchState *env)
         return tcg_ctx->code_gen_epilogue;
     }
     qemu_log_mask_and_addr(CPU_LOG_EXEC, pc,
-                           "Chain %p [%d: " TARGET_FMT_lx "] %s\n",
-                           tb->tc.ptr, cpu->cpu_index, pc,
+                           "Chain %d: %p ["
+                           TARGET_FMT_lx "/" TARGET_FMT_lx "/%#x] %s\n",
+                           cpu->cpu_index, tb->tc.ptr, cs_base, pc, flags,
                            lookup_symbol(pc));
     return tb->tc.ptr;
 }
-- 
2.14.3
