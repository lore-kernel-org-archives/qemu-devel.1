Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EB4C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47549215A5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47549215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaKbR-0003HW-HP
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 09:17:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iaK9F-0004DK-8x
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iaK97-00072Y-UP
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:47:53 -0500
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:46881)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iaK97-0006nI-J7
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:47:49 -0500
Received: from player688.ha.ovh.net (unknown [10.108.35.128])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 76479234131
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 14:47:46 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id E85E1C94B4FD;
 Thu, 28 Nov 2019 13:47:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 5/7] target/ppc: Add privileged message send facilities
Date: Thu, 28 Nov 2019 14:46:58 +0100
Message-Id: <20191128134700.16091-6-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128134700.16091-1-clg@kaod.org>
References: <20191128134700.16091-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 14988542510787234790
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeijedgheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedu
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.172.162
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Privileged message send facilities exist on POWER8 processors and
later and include a register and instructions which can be used to
generate, observe/modify the state of and clear privileged doorbell
exceptions as described below.

The Directed Privileged Doorbell Exception State (DPDES) register
reflects the state of pending privileged doorbell exceptions and can
also be used to modify that state. The register can be used to read
and modify the state of privileged doorbell exceptions for all threads
of a subprocessor and thus is a shared facility for that subprocessor.
The register can be read/written by the hypervisor and read by the
supervisor if enabled in the HFSCR, otherwise a hypervisor facility
unavailable exception is generated.

The privileged message send and clear instructions (msgsndp & msgclrp)
are used to generate and clear the presence of a directed privileged
doorbell exception, respectively. The msgsndp instruction can be used
to target any thread of the current subprocessor, msgclrp acts on the
thread issuing the instruction. These instructions are privileged, but
will generate a hypervisor facility unavailable exception if not
enabled in the HFSCR and executed in privileged non-hypervisor
state. The HV facility unavailable exception will be addressed in
other patch.

Add and implement this register and instructions by reading or
modifying the pending interrupt state of the cpu.

Note that TCG only supports one thread per core and so we only need to
worry about the cpu making the access.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
[clg: - introduced a book3s_msgsnd_common() helper to reduce code
      	duplication
      - modified book3s_dbell2irq()
      - moved out the support for hypervisor facility unavailable
      	exception
      - modified commit log to add a statement on the HV FU exception
      - checkpatch fixes
      - compile fixes for the ppc-softmmu and linux-user targets ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/helper.h             |  4 +++
 target/ppc/excp_helper.c        | 43 ++++++++++++++++++++++++++++-----
 target/ppc/misc_helper.c        | 22 +++++++++++++++++
 target/ppc/translate.c          | 26 ++++++++++++++++++++
 target/ppc/translate_init.inc.c | 20 ++++++++++++---
 5 files changed, 105 insertions(+), 10 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index cd0dfe383a2a..76518a1df6f0 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -657,6 +657,10 @@ DEF_HELPER_FLAGS_1(load_601_rtcu, TCG_CALL_NO_RWG, t=
l, env)
 DEF_HELPER_FLAGS_1(load_purr, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_2(store_purr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_2(store_ptcr, void, env, tl)
+DEF_HELPER_FLAGS_1(load_dpdes, TCG_CALL_NO_RWG, tl, env)
+DEF_HELPER_FLAGS_2(store_dpdes, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_1(book3s_msgsndp, void, tl)
+DEF_HELPER_2(book3s_msgclrp, void, env, tl)
 #endif
 DEF_HELPER_2(store_sdr1, void, env, tl)
 DEF_HELPER_2(store_pidr, void, env, tl)
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 50b004d00d1e..5a247945e97f 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -898,7 +898,11 @@ static void ppc_hw_interrupt(CPUPPCState *env)
         }
         if (env->pending_interrupts & (1 << PPC_INTERRUPT_DOORBELL)) {
             env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_DOORBELL);
-            powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_DOORI);
+            if (env->insns_flags & PPC_SEGMENT_64B) {
+                powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_SDOOR);
+            } else {
+                powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_DOORI);
+            }
             return;
         }
         if (env->pending_interrupts & (1 << PPC_INTERRUPT_HDOORBELL)) {
@@ -1219,7 +1223,7 @@ void helper_msgsnd(target_ulong rb)
 }
=20
 /* Server Processor Control */
-static int book3s_dbell2irq(target_ulong rb)
+static int book3s_dbell2irq(target_ulong rb, bool hv_dbell)
 {
     int msg =3D rb & DBELL_TYPE_MASK;
=20
@@ -1228,12 +1232,16 @@ static int book3s_dbell2irq(target_ulong rb)
      * message type is 5. All other types are reserved and the
      * instruction is a no-op
      */
-    return msg =3D=3D DBELL_TYPE_DBELL_SERVER ? PPC_INTERRUPT_HDOORBELL =
: -1;
+    if (msg =3D=3D DBELL_TYPE_DBELL_SERVER) {
+        return hv_dbell ? PPC_INTERRUPT_HDOORBELL : PPC_INTERRUPT_DOORBE=
LL;
+    }
+
+    return -1;
 }
=20
 void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
 {
-    int irq =3D book3s_dbell2irq(rb);
+    int irq =3D book3s_dbell2irq(rb, 1);
=20
     if (irq < 0) {
         return;
@@ -1242,9 +1250,9 @@ void helper_book3s_msgclr(CPUPPCState *env, target_=
ulong rb)
     env->pending_interrupts &=3D ~(1 << irq);
 }
=20
-void helper_book3s_msgsnd(target_ulong rb)
+static void book3s_msgsnd_common(target_ulong rb, bool hv_dbell)
 {
-    int irq =3D book3s_dbell2irq(rb);
+    int irq =3D book3s_dbell2irq(rb, hv_dbell);
     int pir =3D rb & DBELL_PROCIDTAG_MASK;
     CPUState *cs;
=20
@@ -1265,6 +1273,29 @@ void helper_book3s_msgsnd(target_ulong rb)
     }
     qemu_mutex_unlock_iothread();
 }
+
+void helper_book3s_msgsnd(target_ulong rb)
+{
+    book3s_msgsnd_common(rb, 1);
+}
+
+#if defined(TARGET_PPC64)
+void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
+{
+    int irq =3D book3s_dbell2irq(rb, 0);
+
+    if (irq < 0) {
+        return;
+    }
+
+    env->pending_interrupts &=3D ~(1 << irq);
+}
+
+void helper_book3s_msgsndp(target_ulong rb)
+{
+    book3s_msgsnd_common(rb, 0);
+}
+#endif
 #endif
=20
 void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 2318f3ab45b2..a0e7bd9c32d3 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -105,6 +105,28 @@ void helper_store_pcr(CPUPPCState *env, target_ulong=
 value)
=20
     env->spr[SPR_PCR] =3D value & pcc->pcr_mask;
 }
+
+target_ulong helper_load_dpdes(CPUPPCState *env)
+{
+    if (env->pending_interrupts & (1 << PPC_INTERRUPT_DOORBELL)) {
+        return 1;
+    }
+    return 0;
+}
+
+void helper_store_dpdes(CPUPPCState *env, target_ulong val)
+{
+    PowerPCCPU *cpu =3D env_archcpu(env);
+    CPUState *cs =3D CPU(cpu);
+
+    if (val) {
+        /* Only one cpu for now */
+        env->pending_interrupts |=3D 1 << PPC_INTERRUPT_DOORBELL;
+        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+    } else {
+        env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_DOORBELL);
+    }
+}
 #endif /* defined(TARGET_PPC64) */
=20
 void helper_store_pidr(CPUPPCState *env, target_ulong val)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index f5fe5d06118a..ba759ab2bb0f 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6645,6 +6645,28 @@ static void gen_msgsnd(DisasContext *ctx)
 #endif /* defined(CONFIG_USER_ONLY) */
 }
=20
+#if defined(TARGET_PPC64)
+static void gen_msgclrp(DisasContext *ctx)
+{
+#if defined(CONFIG_USER_ONLY)
+    GEN_PRIV;
+#else
+    CHK_SV;
+    gen_helper_book3s_msgclrp(cpu_env, cpu_gpr[rB(ctx->opcode)]);
+#endif /* defined(CONFIG_USER_ONLY) */
+}
+
+static void gen_msgsndp(DisasContext *ctx)
+{
+#if defined(CONFIG_USER_ONLY)
+    GEN_PRIV;
+#else
+    CHK_SV;
+    gen_helper_book3s_msgsndp(cpu_gpr[rB(ctx->opcode)]);
+#endif /* defined(CONFIG_USER_ONLY) */
+}
+#endif
+
 static void gen_msgsync(DisasContext *ctx)
 {
 #if defined(CONFIG_USER_ONLY)
@@ -7187,6 +7209,10 @@ GEN_HANDLER(vmladduhm, 0x04, 0x11, 0xFF, 0x0000000=
0, PPC_ALTIVEC),
 GEN_HANDLER_E(maddhd_maddhdu, 0x04, 0x18, 0xFF, 0x00000000, PPC_NONE,
               PPC2_ISA300),
 GEN_HANDLER_E(maddld, 0x04, 0x19, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA30=
0),
+GEN_HANDLER2_E(msgsndp, "msgsndp", 0x1F, 0x0E, 0x04, 0x03ff0001,
+               PPC_NONE, PPC2_ISA207S),
+GEN_HANDLER2_E(msgclrp, "msgclrp", 0x1F, 0x0E, 0x05, 0x03ff0001,
+               PPC_NONE, PPC2_ISA207S),
 #endif
=20
 #undef GEN_INT_ARITH_ADD
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 9815df6f77c8..7c74a763ba66 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -464,6 +464,17 @@ static void spr_write_pcr(DisasContext *ctx, int spr=
n, int gprn)
 {
     gen_helper_store_pcr(cpu_env, cpu_gpr[gprn]);
 }
+
+/* DPDES */
+static void spr_read_dpdes(DisasContext *ctx, int gprn, int sprn)
+{
+    gen_helper_load_dpdes(cpu_gpr[gprn], cpu_env);
+}
+
+static void spr_write_dpdes(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_dpdes(cpu_env, cpu_gpr[gprn]);
+}
 #endif
 #endif
=20
@@ -8233,10 +8244,11 @@ static void gen_spr_power8_dpdes(CPUPPCState *env=
)
 {
 #if !defined(CONFIG_USER_ONLY)
     /* Directed Privileged Door-bell Exception State, used for IPI */
-    spr_register(env, SPR_DPDES, "DPDES",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, SPR_NOACCESS,
-                 0x00000000);
+    spr_register_kvm_hv(env, SPR_DPDES, "DPDES",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        &spr_read_dpdes, SPR_NOACCESS,
+                        &spr_read_dpdes, &spr_write_dpdes,
+                        KVM_REG_PPC_DPDES, 0x00000000);
 #endif
 }
=20
--=20
2.21.0


