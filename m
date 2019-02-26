Received: from eggs.gnu.org ([209.51.188.92]:57406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkE-0004So-4s
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:53:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUk0-0000h8-83
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:53:19 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:15 +1100
Message-Id: <20190226045304.25618-2-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/50] target/ppc: Fix nip on power management
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Those instructions currently raise an exception from within
the helper. This tends to result in a bogus nip value in
the env context (typically the beginning of the TB). Such
a helper needs a gen_update_nip() first.

This fixes it with a different approach which is to throw the
exception from translate.c instead of the helper using
gen_exception_nip() which does the right thing. Exception
EXCP_HLT is also used instead of POWERPC_EXCP_STOP to effectively
exit from the CPU execution loop.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[clg : modified the commit log to comment the use of EXCP_HLT instead
       of POWERPC_EXCP_STOP]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190215161648.9600-2-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/excp_helper.c |  1 -
 target/ppc/translate.c   | 12 ++++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 751d759fcc..8407e0ade9 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -958,7 +958,6 @@ void helper_pminsn(CPUPPCState *env, powerpc_pm_insn_=
t insn)
      * but this doesn't seem to be a problem.
      */
     env->msr |=3D (1ull << MSR_EE);
-    raise_exception(env, EXCP_HLT);
 }
 #endif /* defined(TARGET_PPC64) */
=20
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index f4d70e725a..bffdbd9687 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3566,7 +3566,8 @@ static void gen_doze(DisasContext *ctx)
     t =3D tcg_const_i32(PPC_PM_DOZE);
     gen_helper_pminsn(cpu_env, t);
     tcg_temp_free_i32(t);
-    gen_stop_exception(ctx);
+    /* Stop translation, as the CPU is supposed to sleep from now */
+    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
 #endif /* defined(CONFIG_USER_ONLY) */
 }
=20
@@ -3581,7 +3582,8 @@ static void gen_nap(DisasContext *ctx)
     t =3D tcg_const_i32(PPC_PM_NAP);
     gen_helper_pminsn(cpu_env, t);
     tcg_temp_free_i32(t);
-    gen_stop_exception(ctx);
+    /* Stop translation, as the CPU is supposed to sleep from now */
+    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
 #endif /* defined(CONFIG_USER_ONLY) */
 }
=20
@@ -3601,7 +3603,8 @@ static void gen_sleep(DisasContext *ctx)
     t =3D tcg_const_i32(PPC_PM_SLEEP);
     gen_helper_pminsn(cpu_env, t);
     tcg_temp_free_i32(t);
-    gen_stop_exception(ctx);
+    /* Stop translation, as the CPU is supposed to sleep from now */
+    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
 #endif /* defined(CONFIG_USER_ONLY) */
 }
=20
@@ -3616,7 +3619,8 @@ static void gen_rvwinkle(DisasContext *ctx)
     t =3D tcg_const_i32(PPC_PM_RVWINKLE);
     gen_helper_pminsn(cpu_env, t);
     tcg_temp_free_i32(t);
-    gen_stop_exception(ctx);
+    /* Stop translation, as the CPU is supposed to sleep from now */
+    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
 #endif /* defined(CONFIG_USER_ONLY) */
 }
 #endif /* #if defined(TARGET_PPC64) */
--=20
2.20.1
