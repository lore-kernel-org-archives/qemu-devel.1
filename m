Received: from eggs.gnu.org ([209.51.188.92]:38801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjwz-0005h5-Dx
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjwq-0002ec-8V
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:15 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:16 +1100
Message-Id: <20190218143049.17142-11-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/43] ppc: fix crash during branch stepping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Roman Kapl <rka@sysgo.com>, David Gibson <david@gibson.dropbear.id.au>

From: Roman Kapl <rka@sysgo.com>

The PPC BRANCH exception could bubble up, but this is an QEMU internal ex=
ception
and QEMU then crased. Instead it should trigger TRACE exception, accordin=
g to
PPC 2.07 book. It could happen only when using branch stepping, which is =
not
commonly used.

Change gen_prep_dbgex do do trigger TRACE. The excp, argument is now remo=
ved,
since the type of exception can be inferred from the singlestep_enabled f=
lags.
removed the guards around gen_exception, since they are unnecessary.

Fixes: 0e3bf48909 ("ppc: add DBCR based debugging").
Signed-off-by: Roman Kapl <rka@sysgo.com>
Message-Id: <20190212121255.2279-1-rka@sysgo.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 5429ceb1ab..d5f29d3536 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -287,26 +287,22 @@ static void gen_exception_nip(DisasContext *ctx, ui=
nt32_t excp,
     ctx->exception =3D (excp);
 }
=20
-/* Translates the EXCP_TRACE/BRANCH exceptions used on most PowerPCs to
- * EXCP_DEBUG, if we are running on cores using the debug enable bit (e.=
g.
- * BookE).
+/*
+ * Tells the caller what is the appropriate exception to generate and pr=
epares
+ * SPR registers for this exception.
+ *
+ * The exception can be either POWERPC_EXCP_TRACE (on most PowerPCs) or
+ * POWERPC_EXCP_DEBUG (on BookE).
  */
-static uint32_t gen_prep_dbgex(DisasContext *ctx, uint32_t excp)
+static uint32_t gen_prep_dbgex(DisasContext *ctx)
 {
-    if ((ctx->singlestep_enabled & CPU_SINGLE_STEP)
-        && (excp =3D=3D POWERPC_EXCP_BRANCH)) {
-        /* Trace excpt. has priority */
-        excp =3D POWERPC_EXCP_TRACE;
-    }
     if (ctx->flags & POWERPC_FLAG_DE) {
         target_ulong dbsr =3D 0;
-        switch (excp) {
-        case POWERPC_EXCP_TRACE:
+        if (ctx->singlestep_enabled & CPU_SINGLE_STEP) {
             dbsr =3D DBCR0_ICMP;
-            break;
-        case POWERPC_EXCP_BRANCH:
+        } else {
+            /* Must have been branch */
             dbsr =3D DBCR0_BRT;
-            break;
         }
         TCGv t0 =3D tcg_temp_new();
         gen_load_spr(t0, SPR_BOOKE_DBSR);
@@ -315,7 +311,7 @@ static uint32_t gen_prep_dbgex(DisasContext *ctx, uin=
t32_t excp)
         tcg_temp_free(t0);
         return POWERPC_EXCP_DEBUG;
     } else {
-        return excp;
+        return POWERPC_EXCP_TRACE;
     }
 }
=20
@@ -3652,10 +3648,8 @@ static void gen_lookup_and_goto_ptr(DisasContext *=
ctx)
         if (sse & GDBSTUB_SINGLE_STEP) {
             gen_debug_exception(ctx);
         } else if (sse & (CPU_SINGLE_STEP | CPU_BRANCH_STEP)) {
-            uint32_t excp =3D gen_prep_dbgex(ctx, POWERPC_EXCP_BRANCH);
-            if (excp !=3D POWERPC_EXCP_NONE) {
-                gen_exception(ctx, excp);
-            }
+            uint32_t excp =3D gen_prep_dbgex(ctx);
+            gen_exception(ctx, excp);
         }
         tcg_gen_exit_tb(NULL, 0);
     } else {
@@ -7790,9 +7784,8 @@ static void ppc_tr_translate_insn(DisasContextBase =
*dcbase, CPUState *cs)
                  ctx->exception !=3D POWERPC_SYSCALL &&
                  ctx->exception !=3D POWERPC_EXCP_TRAP &&
                  ctx->exception !=3D POWERPC_EXCP_BRANCH)) {
-        uint32_t excp =3D gen_prep_dbgex(ctx, POWERPC_EXCP_TRACE);
-        if (excp !=3D POWERPC_EXCP_NONE)
-            gen_exception_nip(ctx, excp, ctx->base.pc_next);
+        uint32_t excp =3D gen_prep_dbgex(ctx);
+        gen_exception_nip(ctx, excp, ctx->base.pc_next);
     }
=20
     if (tcg_check_temp_count()) {
--=20
2.20.1
