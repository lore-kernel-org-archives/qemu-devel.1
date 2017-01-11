Received: from eggs.gnu.org ([2001:4830:134:3::10]:54989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPOC-0006c8-NR
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPOA-00010M-LM
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:56 -0500
Received: from mail-wj0-x242.google.com ([2a00:1450:400c:c01::242]:34022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cRPOA-00010C-FG
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:54 -0500
Received: by mail-wj0-x242.google.com with SMTP id qs7so54529543wjc.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 12:20:54 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 11 Jan 2017 21:19:42 +0100
Message-Id: <7edada4d1c26562843de80c9eb2339ca591f883b.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH v2 11/30] target-sparc: implement UA2005
 hypervisor traps
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

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/cpu.h          |  1 +
 target/sparc/int64_helper.c | 37 ++++++++++++++++++++++++++++++++-----
 target/sparc/win_helper.c   |  6 ++++++
 3 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 4f709e1..f26fdcf 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -79,6 +79,7 @@
 #define TT_FILL     0xc0
 #define TT_WOTHER   (1 << 5)
 #define TT_TRAP     0x100
+#define TT_HTRAP    0x180
 #endif
 
 #define PSR_NEG_SHIFT 23
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 29360fa..8300eb4 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -78,8 +78,10 @@ void sparc_cpu_do_interrupt(CPUState *cs)
         static int count;
         const char *name;
 
-        if (intno < 0 || intno >= 0x180) {
+        if (intno < 0 || intno >= 0x1ff) {
             name = "Unknown";
+        } else if (intno >= 0x180) {
+            name = "Hyperprivileged Trap Instruction";
         } else if (intno >= 0x100) {
             name = "Trap Instruction";
         } else if (intno >= 0xc0) {
@@ -135,16 +137,36 @@ void sparc_cpu_do_interrupt(CPUState *cs)
     tsptr->tnpc = env->npc;
     tsptr->tt = intno;
 
+    if (cpu_has_hypervisor(env)) {
+        env->htstate[env->tl] = env->hpstate;
+        /* XXX OpenSPARC T1 - UltraSPARC T3 have MAXPTL=2
+           but this may change in the future */
+        if (env->tl > 2) {
+            env->hpstate |= HS_PRIV;
+        }
+    }
+
     switch (intno) {
     case TT_IVEC:
-        cpu_change_pstate(env, PS_PEF | PS_PRIV | PS_IG);
+        if (!cpu_has_hypervisor(env)) {
+            cpu_change_pstate(env, PS_PEF | PS_PRIV | PS_IG);
+        }
         break;
     case TT_TFAULT:
     case TT_DFAULT:
     case TT_TMISS ... TT_TMISS + 3:
     case TT_DMISS ... TT_DMISS + 3:
     case TT_DPROT ... TT_DPROT + 3:
-        cpu_change_pstate(env, PS_PEF | PS_PRIV | PS_MG);
+        if (cpu_has_hypervisor(env)) {
+            env->hpstate |= HS_PRIV;
+            env->pstate = PS_PEF | PS_PRIV;
+        } else {
+            cpu_change_pstate(env, PS_PEF | PS_PRIV | PS_MG);
+        }
+        break;
+    case TT_INSN_REAL_TRANSLATION_MISS ... TT_DATA_REAL_TRANSLATION_MISS:
+    case TT_HTRAP ... TT_HTRAP + 127:
+        env->hpstate |= HS_PRIV;
         break;
     default:
         cpu_change_pstate(env, PS_PEF | PS_PRIV | PS_AG);
@@ -158,8 +180,13 @@ void sparc_cpu_do_interrupt(CPUState *cs)
     } else if ((intno & 0x1c0) == TT_FILL) {
         cpu_set_cwp(env, cpu_cwp_inc(env, env->cwp + 1));
     }
-    env->pc = env->tbr  & ~0x7fffULL;
-    env->pc |= ((env->tl > 1) ? 1 << 14 : 0) | (intno << 5);
+
+    if (cpu_hypervisor_mode(env)) {
+        env->pc = (env->htba & ~0x3fffULL) | (intno << 5);
+    } else {
+        env->pc = env->tbr  & ~0x7fffULL;
+        env->pc |= ((env->tl > 1) ? 1 << 14 : 0) | (intno << 5);
+    }
     env->npc = env->pc + 4;
     cs->exception_index = -1;
 }
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index 2d5b546..45ee4e6 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -366,6 +366,9 @@ void helper_done(CPUSPARCState *env)
     env->asi = (tsptr->tstate >> 24) & 0xff;
     cpu_change_pstate(env, (tsptr->tstate >> 8) & 0xf3f);
     cpu_put_cwp64(env, tsptr->tstate & 0xff);
+    if (cpu_has_hypervisor(env)) {
+        env->hpstate = env->htstate[env->tl];
+    }
     env->tl--;
 
     trace_win_helper_done(env->tl);
@@ -387,6 +390,9 @@ void helper_retry(CPUSPARCState *env)
     env->asi = (tsptr->tstate >> 24) & 0xff;
     cpu_change_pstate(env, (tsptr->tstate >> 8) & 0xf3f);
     cpu_put_cwp64(env, tsptr->tstate & 0xff);
+    if (cpu_has_hypervisor(env)) {
+        env->hpstate = env->htstate[env->tl];
+    }
     env->tl--;
 
     trace_win_helper_retry(env->tl);
-- 
1.8.3.1
