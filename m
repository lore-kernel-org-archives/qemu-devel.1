Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6F6C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5499222CE3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="STvSz3V7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5499222CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LBZ-0008UC-2y
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0M-0004Tr-JE
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0K-0007zd-P2
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:02 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:48573)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L0J-0007tU-WA; Wed, 21 Aug 2019 03:26:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Czj94QDHz9sP3; Wed, 21 Aug 2019 17:25:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372349;
 bh=XqyhbOl/gxAdC8MJ8BVPV9g2FOc7Ped5PieEArgy48k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=STvSz3V72iqhpPC6EvXckAeQviXBGOtwtXcUt2TWXq7YwI11Zpj08eOpMQu/zhhgM
 A+VuezACU9iLtmxcJMkQ9QVTcL80Ce/YzTlLNL/naLA4MBjhJp0acb5s98QbyGlYGI
 lagI3EhW+TTyifITE/nQXqvc7fVPpe3kckf3WWj8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:08 +1000
Message-Id: <20190821072542.23090-9-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 08/42] target/ppc: move opcode decode tables to
 PowerPCCPU
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, aik@ozlabs.ru,
 Richard Henderson <richard.henderson@linaro.org>, 1836558@bugs.launchpad.net,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

The opcode decode tables aren't really part of the CPUPPCState but an
internal implementation detail for the translator. This can cause
problems with memcpy in cpu_copy as any table created during
ppc_cpu_realize get written over causing a memory leak. To avoid this
move the tables into PowerPCCPU which is better suited to hold
internal implementation details.

Attempts to fix: https://bugs.launchpad.net/qemu/+bug/1836558
Cc: 1836558@bugs.launchpad.net
Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-Id: <20190716121352.302-1-alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h                |  8 ++++----
 target/ppc/translate.c          |  3 ++-
 target/ppc/translate_init.inc.c | 16 +++++++---------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 4ea33cf696..630a25c246 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1104,10 +1104,6 @@ struct CPUPPCState {
     bool resume_as_sreset;
 #endif
=20
-    /* Those resources are used only during code translation */
-    /* opcode handlers */
-    opc_handler_t *opcodes[PPC_CPU_OPCODES_LEN];
-
     /* Those resources are used only in QEMU core */
     target_ulong hflags;      /* hflags is a MSR & HFLAGS_MASK         *=
/
     target_ulong hflags_nmsr; /* specific hflags, not coming from MSR */
@@ -1191,6 +1187,10 @@ struct PowerPCCPU {
     int32_t node_id; /* NUMA node this CPU belongs to */
     PPCHash64Options *hash64_opts;
=20
+    /* Those resources are used only during code translation */
+    /* opcode handlers */
+    opc_handler_t *opcodes[PPC_CPU_OPCODES_LEN];
+
     /* Fields related to migration compatibility hacks */
     bool pre_2_8_migration;
     target_ulong mig_msr_mask;
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 9f9553afb4..1afb31e855 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7858,6 +7858,7 @@ static bool ppc_tr_breakpoint_check(DisasContextBas=
e *dcbase, CPUState *cs,
 static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs=
)
 {
     DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
+    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
     CPUPPCState *env =3D cs->env_ptr;
     opc_handler_t **table, *handler;
=20
@@ -7875,7 +7876,7 @@ static void ppc_tr_translate_insn(DisasContextBase =
*dcbase, CPUState *cs)
               opc3(ctx->opcode), opc4(ctx->opcode),
               ctx->le_mode ? "little" : "big");
     ctx->base.pc_next +=3D 4;
-    table =3D env->opcodes;
+    table =3D cpu->opcodes;
     handler =3D table[opc1(ctx->opcode)];
     if (is_indirect_opcode(handler)) {
         table =3D ind_table(handler);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 86fc8f2e31..9cd2033bb9 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9440,14 +9440,13 @@ static void fix_opcode_tables(opc_handler_t **ppc=
_opcodes)
 static void create_ppc_opcodes(PowerPCCPU *cpu, Error **errp)
 {
     PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
-    CPUPPCState *env =3D &cpu->env;
     opcode_t *opc;
=20
-    fill_new_table(env->opcodes, PPC_CPU_OPCODES_LEN);
+    fill_new_table(cpu->opcodes, PPC_CPU_OPCODES_LEN);
     for (opc =3D opcodes; opc < &opcodes[ARRAY_SIZE(opcodes)]; opc++) {
         if (((opc->handler.type & pcc->insns_flags) !=3D 0) ||
             ((opc->handler.type2 & pcc->insns_flags2) !=3D 0)) {
-            if (register_insn(env->opcodes, opc) < 0) {
+            if (register_insn(cpu->opcodes, opc) < 0) {
                 error_setg(errp, "ERROR initializing PowerPC instruction=
 "
                            "0x%02x 0x%02x 0x%02x", opc->opc1, opc->opc2,
                            opc->opc3);
@@ -9455,7 +9454,7 @@ static void create_ppc_opcodes(PowerPCCPU *cpu, Err=
or **errp)
             }
         }
     }
-    fix_opcode_tables(env->opcodes);
+    fix_opcode_tables(cpu->opcodes);
     fflush(stdout);
     fflush(stderr);
 }
@@ -10023,7 +10022,6 @@ static void ppc_cpu_unrealize(DeviceState *dev, E=
rror **errp)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(dev);
     PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
-    CPUPPCState *env =3D &cpu->env;
     Error *local_err =3D NULL;
     opc_handler_t **table, **table_2;
     int i, j, k;
@@ -10035,11 +10033,11 @@ static void ppc_cpu_unrealize(DeviceState *dev,=
 Error **errp)
     }
=20
     for (i =3D 0; i < PPC_CPU_OPCODES_LEN; i++) {
-        if (env->opcodes[i] =3D=3D &invalid_handler) {
+        if (cpu->opcodes[i] =3D=3D &invalid_handler) {
             continue;
         }
-        if (is_indirect_opcode(env->opcodes[i])) {
-            table =3D ind_table(env->opcodes[i]);
+        if (is_indirect_opcode(cpu->opcodes[i])) {
+            table =3D ind_table(cpu->opcodes[i]);
             for (j =3D 0; j < PPC_CPU_INDIRECT_OPCODES_LEN; j++) {
                 if (table[j] =3D=3D &invalid_handler) {
                     continue;
@@ -10057,7 +10055,7 @@ static void ppc_cpu_unrealize(DeviceState *dev, E=
rror **errp)
                                              ~PPC_INDIRECT));
                 }
             }
-            g_free((opc_handler_t *)((uintptr_t)env->opcodes[i] &
+            g_free((opc_handler_t *)((uintptr_t)cpu->opcodes[i] &
                 ~PPC_INDIRECT));
         }
     }
--=20
2.21.0


