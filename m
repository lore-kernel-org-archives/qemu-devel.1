Received: from eggs.gnu.org ([2001:4830:134:3::10]:35957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWB6I-0001Vd-0o
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 20:10:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWB6F-00052P-5h
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 20:10:41 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:51782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWB6E-00050v-SV
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 20:10:39 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  2 Jan 2018 02:10:18 +0100
Message-Id: <20180102011032.30056-4-laurent@vivier.eu>
In-Reply-To: <20180102011032.30056-1-laurent@vivier.eu>
References: <20180102011032.30056-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v5 03/17] linux-user,
 m68k: correctly manage SR in context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>

Use cpu_m68k_get_ccr()/cpu_m68k_set_ccr() to setup and restore correctly
the value of SR in the context structure. Fix target_rt_setup_ucontext().

Fixes: 3219de458c ("linux-user: correctly manage SR in ucontext")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/signal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index dae14d4a89..74fa03f96d 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -5612,13 +5612,14 @@ struct target_rt_sigframe
 static void setup_sigcontext(struct target_sigcontext *sc, CPUM68KState *env,
                              abi_ulong mask)
 {
+    uint32_t sr = (env->sr & 0xff00) | cpu_m68k_get_ccr(env);
     __put_user(mask, &sc->sc_mask);
     __put_user(env->aregs[7], &sc->sc_usp);
     __put_user(env->dregs[0], &sc->sc_d0);
     __put_user(env->dregs[1], &sc->sc_d1);
     __put_user(env->aregs[0], &sc->sc_a0);
     __put_user(env->aregs[1], &sc->sc_a1);
-    __put_user(env->sr, &sc->sc_sr);
+    __put_user(sr, &sc->sc_sr);
     __put_user(env->pc, &sc->sc_pc);
 }
 
@@ -5634,7 +5635,7 @@ restore_sigcontext(CPUM68KState *env, struct target_sigcontext *sc)
     __get_user(env->aregs[1], &sc->sc_a1);
     __get_user(env->pc, &sc->sc_pc);
     __get_user(temp, &sc->sc_sr);
-    env->sr = (env->sr & 0xff00) | (temp & 0xff);
+    cpu_m68k_set_ccr(env, temp);
 }
 
 /*
@@ -5726,7 +5727,7 @@ static inline int target_rt_setup_ucontext(struct target_ucontext *uc,
                                            CPUM68KState *env)
 {
     target_greg_t *gregs = uc->tuc_mcontext.gregs;
-    uint32_t sr = cpu_m68k_get_ccr(env);
+    uint32_t sr = (env->sr & 0xff00) | cpu_m68k_get_ccr(env);
 
     __put_user(TARGET_MCONTEXT_VERSION, &uc->tuc_mcontext.version);
     __put_user(env->dregs[0], &gregs[0]);
-- 
2.14.3
