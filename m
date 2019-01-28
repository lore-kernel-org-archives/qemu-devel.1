Received: from eggs.gnu.org ([209.51.188.92]:38432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3VH-000559-6z
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3VG-0002tr-7o
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36426
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1go3VG-0002tX-2H
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:54 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0S9hxTm024642
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:53 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q9y6trgwy-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:53 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Mon, 28 Jan 2019 09:46:51 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 28 Jan 2019 10:46:14 +0100
In-Reply-To: <20190128094625.4428-1-clg@kaod.org>
References: <20190128094625.4428-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190128094625.4428-9-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/19] target/ppc: Fix nip on power management
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Those instructions currently raise an exception from within
the helper. This tends to result in a bogus nip value in
the env context (typically the beginning of the TB). Such
a helper needs a gen_update_nip() first.

This fixes it with a different approach which is to throw
the exception from translate.c instead of the helper using
gen_exception_nip() which does the right thing.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/excp_helper.c |  1 -
 target/ppc/translate.c   | 12 ++++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 751d759fcc1d..8407e0ade938 100644
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
index 7d40a1fbe6bd..55281a8975e0 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3571,7 +3571,8 @@ static void gen_doze(DisasContext *ctx)
     t =3D tcg_const_i32(PPC_PM_DOZE);
     gen_helper_pminsn(cpu_env, t);
     tcg_temp_free_i32(t);
-    gen_stop_exception(ctx);
+    /* Stop translation, as the CPU is supposed to sleep from now */
+    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
 #endif /* defined(CONFIG_USER_ONLY) */
 }
=20
@@ -3586,7 +3587,8 @@ static void gen_nap(DisasContext *ctx)
     t =3D tcg_const_i32(PPC_PM_NAP);
     gen_helper_pminsn(cpu_env, t);
     tcg_temp_free_i32(t);
-    gen_stop_exception(ctx);
+    /* Stop translation, as the CPU is supposed to sleep from now */
+    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
 #endif /* defined(CONFIG_USER_ONLY) */
 }
=20
@@ -3606,7 +3608,8 @@ static void gen_sleep(DisasContext *ctx)
     t =3D tcg_const_i32(PPC_PM_SLEEP);
     gen_helper_pminsn(cpu_env, t);
     tcg_temp_free_i32(t);
-    gen_stop_exception(ctx);
+    /* Stop translation, as the CPU is supposed to sleep from now */
+    gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
 #endif /* defined(CONFIG_USER_ONLY) */
 }
=20
@@ -3621,7 +3624,8 @@ static void gen_rvwinkle(DisasContext *ctx)
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
