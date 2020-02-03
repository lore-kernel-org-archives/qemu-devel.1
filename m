Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2CBC33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF782080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EJSm87to"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF782080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyV4K-00075W-3d
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:18:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxO-0002Ph-33
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxM-0002YM-6X
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:37 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:44357 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyUxL-0002U6-QR; Mon, 03 Feb 2020 01:11:36 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489yBm5BMCz9sSH; Mon,  3 Feb 2020 17:11:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580710288;
 bh=23nUwhCKXFfSFgRCb+ifS6bV8gQlWPVcFG/SnncDUWI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EJSm87tozHZ3xE7SdzWxc55RtyV+kVptnzZkv5HK3pnFRTMW/t3vHMK2HMAWSVIAc
 iS2vXoAFyljKegDNgZRAZ7WfH7r7Z3C7RP/2uU94YfP6LLkiDhyeTh9Z3Z6oQ4MWFc
 QNYqobFX6eg9R+NcLTa2CPQGpeorOi/oiX0iwtE8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 07/35] target/ppc: Add privileged message send facilities
Date: Mon,  3 Feb 2020 17:10:55 +1100
Message-Id: <20200203061123.59150-8-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203061123.59150-1-david@gibson.dropbear.id.au>
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The Processor Control facility for POWER8 processors and later
provides a mechanism for the hypervisor to send messages to other
threads in the system (msgsnd instruction) and cause hypervisor-level
exceptions. Privileged non-hypervisor programs can also send messages
(msgsndp instruction) but are restricted to the threads of the same
subprocessor and cause privileged-level exceptions.

The Directed Privileged Doorbell Exception State (DPDES) register
reflects the state of pending privileged doorbell exceptions and can
be used to modify that state. The register can be used to read and
modify the state of privileged doorbell exceptions for all threads of
a subprocessor and thus is a shared facility for that subprocessor.
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
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20200120104935.24449-2-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/excp_helper.c        | 66 +++++++++++++++++++++++++--------
 target/ppc/helper.h             |  4 ++
 target/ppc/misc_helper.c        | 36 ++++++++++++++++++
 target/ppc/translate.c          | 26 +++++++++++++
 target/ppc/translate_init.inc.c | 20 ++++++++--
 5 files changed, 132 insertions(+), 20 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 5752ed4a4d..1b07c3ed56 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -900,7 +900,11 @@ static void ppc_hw_interrupt(CPUPPCState *env)
         }
         if (env->pending_interrupts & (1 << PPC_INTERRUPT_DOORBELL)) {
             env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_DOORBELL);
-            powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_DOORI);
+            if (is_book3s_arch2x(env)) {
+                powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_SDOOR);
+            } else {
+                powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_DOORI);
+            }
             return;
         }
         if (env->pending_interrupts & (1 << PPC_INTERRUPT_HDOORBELL)) {
@@ -1221,39 +1225,30 @@ void helper_msgsnd(target_ulong rb)
 }
=20
 /* Server Processor Control */
-static int book3s_dbell2irq(target_ulong rb)
-{
-    int msg =3D rb & DBELL_TYPE_MASK;
=20
+static bool dbell_type_server(target_ulong rb)
+{
     /*
      * A Directed Hypervisor Doorbell message is sent only if the
      * message type is 5. All other types are reserved and the
      * instruction is a no-op
      */
-    return msg =3D=3D DBELL_TYPE_DBELL_SERVER ? PPC_INTERRUPT_HDOORBELL =
: -1;
+    return (rb & DBELL_TYPE_MASK) =3D=3D DBELL_TYPE_DBELL_SERVER;
 }
=20
 void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
 {
-    int irq =3D book3s_dbell2irq(rb);
-
-    if (irq < 0) {
+    if (!dbell_type_server(rb)) {
         return;
     }
=20
-    env->pending_interrupts &=3D ~(1 << irq);
+    env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_HDOORBELL);
 }
=20
-void helper_book3s_msgsnd(target_ulong rb)
+static void book3s_msgsnd_common(int pir, int irq)
 {
-    int irq =3D book3s_dbell2irq(rb);
-    int pir =3D rb & DBELL_PROCIDTAG_MASK;
     CPUState *cs;
=20
-    if (irq < 0) {
-        return;
-    }
-
     qemu_mutex_lock_iothread();
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
@@ -1267,6 +1262,45 @@ void helper_book3s_msgsnd(target_ulong rb)
     }
     qemu_mutex_unlock_iothread();
 }
+
+void helper_book3s_msgsnd(target_ulong rb)
+{
+    int pir =3D rb & DBELL_PROCIDTAG_MASK;
+
+    if (!dbell_type_server(rb)) {
+        return;
+    }
+
+    book3s_msgsnd_common(pir, PPC_INTERRUPT_HDOORBELL);
+}
+
+#if defined(TARGET_PPC64)
+void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
+{
+    if (!dbell_type_server(rb)) {
+        return;
+    }
+
+    env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_DOORBELL);
+}
+
+/*
+ * sends a message to other threads that are on the same
+ * multi-threaded processor
+ */
+void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
+{
+    int pir =3D env->spr_cb[SPR_PIR].default_value;
+
+    if (!dbell_type_server(rb)) {
+        return;
+    }
+
+    /* TODO: TCG supports only one thread */
+
+    book3s_msgsnd_common(pir, PPC_INTERRUPT_DOORBELL);
+}
+#endif
 #endif
=20
 void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index cd0dfe383a..cfb4c07085 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -657,6 +657,10 @@ DEF_HELPER_FLAGS_1(load_601_rtcu, TCG_CALL_NO_RWG, t=
l, env)
 DEF_HELPER_FLAGS_1(load_purr, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_2(store_purr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_2(store_ptcr, void, env, tl)
+DEF_HELPER_FLAGS_1(load_dpdes, TCG_CALL_NO_RWG, tl, env)
+DEF_HELPER_FLAGS_2(store_dpdes, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_2(book3s_msgsndp, void, env, tl)
+DEF_HELPER_2(book3s_msgclrp, void, env, tl)
 #endif
 DEF_HELPER_2(store_sdr1, void, env, tl)
 DEF_HELPER_2(store_pidr, void, env, tl)
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 2318f3ab45..0c5919ff08 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -105,6 +105,42 @@ void helper_store_pcr(CPUPPCState *env, target_ulong=
 value)
=20
     env->spr[SPR_PCR] =3D value & pcc->pcr_mask;
 }
+
+/*
+ * DPDES register is shared. Each bit reflects the state of the
+ * doorbell interrupt of a thread of the same core.
+ */
+target_ulong helper_load_dpdes(CPUPPCState *env)
+{
+    target_ulong dpdes =3D 0;
+
+    /* TODO: TCG supports only one thread */
+    if (env->pending_interrupts & (1 << PPC_INTERRUPT_DOORBELL)) {
+        dpdes =3D 1;
+    }
+
+    return dpdes;
+}
+
+void helper_store_dpdes(CPUPPCState *env, target_ulong val)
+{
+    PowerPCCPU *cpu =3D env_archcpu(env);
+    CPUState *cs =3D CPU(cpu);
+
+    /* TODO: TCG supports only one thread */
+    if (val & ~0x1) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid DPDES register value "
+                      TARGET_FMT_lx"\n", val);
+        return;
+    }
+
+    if (val & 0x1) {
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
index 9dcf8dc261..36fa27367c 100644
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
+    gen_helper_book3s_msgsndp(cpu_env, cpu_gpr[rB(ctx->opcode)]);
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
index 2d3efad233..53995f62ea 100644
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
@@ -8238,10 +8249,11 @@ static void gen_spr_power8_dpdes(CPUPPCState *env=
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
2.24.1


