Received: from eggs.gnu.org ([2001:4830:134:3::10]:54811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPNr-0006Js-V9
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPNq-0000v5-FC
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:35 -0500
Received: from mail-wj0-x244.google.com ([2a00:1450:400c:c01::244]:36489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cRPNp-0000ul-Vm
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:34 -0500
Received: by mail-wj0-x244.google.com with SMTP id dh1so11795484wjb.3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 12:20:33 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 11 Jan 2017 21:19:32 +0100
Message-Id: <af031d3c4c1a12eabded2a677ad3ac50937bf6bf.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH v2 01/30] target-sparc: ignore MMU-faults if
 MMU is disabled in hypervisor mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>

while IMMU/DMMU is disabled
- ignore MMU-faults in hypervisorv mode or if CPU doesn't have hypervisor
- signal TT_INSN_REAL_TRANSLATION_MISS/TT_DATA_REAL_TRANSLATION_MISS otherwise

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/cpu.h         |  2 ++
 target/sparc/ldst_helper.c | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 5fb0ed1..e0b2806 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -68,6 +68,8 @@
 #define TT_DATA_ACCESS 0x32
 #define TT_UNALIGNED 0x34
 #define TT_PRIV_ACT 0x37
+#define TT_INSN_REAL_TRANSLATION_MISS 0x3e
+#define TT_DATA_REAL_TRANSLATION_MISS 0x3f
 #define TT_EXTINT   0x40
 #define TT_IVEC     0x60
 #define TT_TMISS    0x64
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index de7d53a..fdca87f 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1664,14 +1664,25 @@ void sparc_cpu_unassigned_access(CPUState *cs, hwaddr addr,
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
-    int tt = is_exec ? TT_CODE_ACCESS : TT_DATA_ACCESS;
 
 #ifdef DEBUG_UNASSIGNED
     printf("Unassigned mem access to " TARGET_FMT_plx " from " TARGET_FMT_lx
            "\n", addr, env->pc);
 #endif
 
-    cpu_raise_exception_ra(env, tt, GETPC());
+    if (is_exec) { /* XXX has_hypervisor */
+        if (env->lsu & (IMMU_E)) {
+            cpu_raise_exception_ra(env, TT_CODE_ACCESS, GETPC());
+        } else if (cpu_has_hypervisor(env) && !(env->hpstate & HS_PRIV)) {
+            cpu_raise_exception_ra(env, TT_INSN_REAL_TRANSLATION_MISS, GETPC());
+        }
+    } else {
+        if (env->lsu & (DMMU_E)) {
+            cpu_raise_exception_ra(env, TT_DATA_ACCESS, GETPC());
+        } else if (cpu_has_hypervisor(env) && !(env->hpstate & HS_PRIV)) {
+            cpu_raise_exception_ra(env, TT_DATA_REAL_TRANSLATION_MISS, GETPC());
+        }
+    }
 }
 #endif
 #endif
-- 
1.8.3.1
