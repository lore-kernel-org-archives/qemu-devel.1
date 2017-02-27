Received: from eggs.gnu.org ([2001:4830:134:3::10]:39791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ciTrh-0001Qm-5b
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ciTrc-00046S-GQ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:33:57 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:59488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ciTrc-00041A-7e
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:33:52 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 27 Feb 2017 23:33:35 +0100
Message-Id: <20170227223337.17434-5-laurent@vivier.eu>
In-Reply-To: <20170227223337.17434-1-laurent@vivier.eu>
References: <20170227223337.17434-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 4/6] linux-user: correctly manage SR in ucontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Use cpu_m68k_get_ccr()/cpu_m68k_set_ccr() to setup and restore correctly
the value of SR in the ucontext structure

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20170225110517.2832-2-laurent@vivier.eu>
---
 linux-user/signal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 5dae87e..99adfc2 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -5676,6 +5676,7 @@ static inline int target_rt_setup_ucontext(struct target_ucontext *uc,
                                            CPUM68KState *env)
 {
     target_greg_t *gregs = uc->tuc_mcontext.gregs;
+    uint32_t sr = cpu_m68k_get_ccr(env);
 
     __put_user(TARGET_MCONTEXT_VERSION, &uc->tuc_mcontext.version);
     __put_user(env->dregs[0], &gregs[0]);
@@ -5695,7 +5696,7 @@ static inline int target_rt_setup_ucontext(struct target_ucontext *uc,
     __put_user(env->aregs[6], &gregs[14]);
     __put_user(env->aregs[7], &gregs[15]);
     __put_user(env->pc, &gregs[16]);
-    __put_user(env->sr, &gregs[17]);
+    __put_user(sr, &gregs[17]);
 
     return 0;
 }
@@ -5729,7 +5730,7 @@ static inline int target_rt_restore_ucontext(CPUM68KState *env,
     __get_user(env->aregs[7], &gregs[15]);
     __get_user(env->pc, &gregs[16]);
     __get_user(temp, &gregs[17]);
-    env->sr = (env->sr & 0xff00) | (temp & 0xff);
+    cpu_m68k_set_ccr(env, temp);
 
     return 0;
 
-- 
2.9.3
