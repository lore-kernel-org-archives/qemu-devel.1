Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ACAC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2289921741
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2289921741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaKSc-0006uL-8r
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 09:07:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iaK8w-00040K-5p
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:47:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iaK8r-0005fx-F8
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:47:36 -0500
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:51982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iaK8o-0005Wm-Ia
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:47:31 -0500
Received: from player688.ha.ovh.net (unknown [10.108.57.141])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 726B8115E91
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 14:47:25 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id DA29BC94B2BE;
 Thu, 28 Nov 2019 13:47:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 2/7] target/ppc: Work [S]PURR implementation and add HV support
Date: Thu, 28 Nov 2019 14:46:55 +0100
Message-Id: <20191128134700.16091-3-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128134700.16091-1-clg@kaod.org>
References: <20191128134700.16091-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 14982350063184874470
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeijedgheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucffohhmrghinhepohiilhgrsghsrdhorhhgnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieekkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.72.238
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

The Processor Utilisation of Resources Register (PURR) and Scaled
Processor Utilisation of Resources Register (SPURR) provide an estimate
of the resources used by the thread, present on POWER7 and later
processors.

Currently the [S]PURR registers simply count at the rate of the
timebase.

Preserve this behaviour but rework the implementation to store an offset
like the timebase rather than doing the calculation manually. Also allow
hypervisor write access to the register along with the currently
available read access.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
[ clg: rebased on current ppc tree ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 David,

 In the initial discussion, PURR and VTB still needed to be added to
 the migration stream. The patch is changing the representation indeed
 but that seems OK. AFAICT, all the SPRs are migrated. I didn't quite
 understand that part. See http://patchwork.ozlabs.org/patch/1094662
 for more info.

 Nevertheless, you added your Reviewed-by.

 include/hw/ppc/ppc.h            |  3 +--
 target/ppc/cpu.h                |  1 +
 target/ppc/helper.h             |  1 +
 hw/ppc/ppc.c                    | 17 +++++++----------
 target/ppc/timebase_helper.c    |  5 +++++
 target/ppc/translate_init.inc.c | 23 +++++++++++++++--------
 6 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 02481cd27c36..27bef85ca869 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -33,8 +33,7 @@ struct ppc_tb_t {
     /* Hypervisor decrementer management */
     uint64_t hdecr_next;    /* Tick for next hdecr interrupt  */
     QEMUTimer *hdecr_timer;
-    uint64_t purr_load;
-    uint64_t purr_start;
+    int64_t purr_offset;
     void *opaque;
     uint32_t flags;
 };
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 19d6e724bb5a..9128dbefbdb0 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1313,6 +1313,7 @@ void cpu_ppc_store_decr(CPUPPCState *env, target_ul=
ong value);
 target_ulong cpu_ppc_load_hdecr(CPUPPCState *env);
 void cpu_ppc_store_hdecr(CPUPPCState *env, target_ulong value);
 uint64_t cpu_ppc_load_purr(CPUPPCState *env);
+void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value);
 uint32_t cpu_ppc601_load_rtcl(CPUPPCState *env);
 uint32_t cpu_ppc601_load_rtcu(CPUPPCState *env);
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index a5f53bb421a7..356a14d8a639 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -655,6 +655,7 @@ DEF_HELPER_FLAGS_1(load_601_rtcu, TCG_CALL_NO_RWG, tl=
, env)
 #if !defined(CONFIG_USER_ONLY)
 #if defined(TARGET_PPC64)
 DEF_HELPER_FLAGS_1(load_purr, TCG_CALL_NO_RWG, tl, env)
+DEF_HELPER_FLAGS_2(store_purr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_2(store_ptcr, void, env, tl)
 #endif
 DEF_HELPER_2(store_sdr1, void, env, tl)
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 263922052536..353f11b91d40 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -821,12 +821,9 @@ target_ulong cpu_ppc_load_hdecr(CPUPPCState *env)
 uint64_t cpu_ppc_load_purr (CPUPPCState *env)
 {
     ppc_tb_t *tb_env =3D env->tb_env;
-    uint64_t diff;
=20
-    diff =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - tb_env->purr_start;
-
-    return tb_env->purr_load +
-        muldiv64(diff, tb_env->tb_freq, NANOSECONDS_PER_SECOND);
+    return cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                          tb_env->purr_offset);
 }
=20
 /* When decrementer expires,
@@ -985,12 +982,12 @@ static void cpu_ppc_hdecr_cb(void *opaque)
     cpu_ppc_hdecr_excp(cpu);
 }
=20
-static void cpu_ppc_store_purr(PowerPCCPU *cpu, uint64_t value)
+void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value)
 {
-    ppc_tb_t *tb_env =3D cpu->env.tb_env;
+    ppc_tb_t *tb_env =3D env->tb_env;
=20
-    tb_env->purr_load =3D value;
-    tb_env->purr_start =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                     &tb_env->purr_offset, value);
 }
=20
 static void cpu_ppc_set_tb_clk (void *opaque, uint32_t freq)
@@ -1007,7 +1004,7 @@ static void cpu_ppc_set_tb_clk (void *opaque, uint3=
2_t freq)
      */
     _cpu_ppc_store_decr(cpu, 0xFFFFFFFF, 0xFFFFFFFF, 32);
     _cpu_ppc_store_hdecr(cpu, 0xFFFFFFFF, 0xFFFFFFFF, 32);
-    cpu_ppc_store_purr(cpu, 0x0000000000000000ULL);
+    cpu_ppc_store_purr(env, 0x0000000000000000ULL);
 }
=20
 static void timebase_save(PPCTimebase *tb)
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 8c3c2fe67c2c..2395295b778c 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -55,6 +55,11 @@ target_ulong helper_load_purr(CPUPPCState *env)
 {
     return (target_ulong)cpu_ppc_load_purr(env);
 }
+
+void helper_store_purr(CPUPPCState *env, target_ulong val)
+{
+    cpu_ppc_store_purr(env, val);
+}
 #endif
=20
 target_ulong helper_load_601_rtcl(CPUPPCState *env)
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 5a560164d4a4..6105e74e9dc6 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -287,6 +287,11 @@ static void spr_read_purr(DisasContext *ctx, int gpr=
n, int sprn)
     gen_helper_load_purr(cpu_gpr[gprn], cpu_env);
 }
=20
+static void spr_write_purr(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_purr(cpu_env, cpu_gpr[gprn]);
+}
+
 /* HDECR */
 static void spr_read_hdecr(DisasContext *ctx, int gprn, int sprn)
 {
@@ -8008,14 +8013,16 @@ static void gen_spr_book3s_purr(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     /* PURR & SPURR: Hack - treat these as aliases for the TB for now */
-    spr_register_kvm(env, SPR_PURR,   "PURR",
-                     &spr_read_purr, SPR_NOACCESS,
-                     &spr_read_purr, SPR_NOACCESS,
-                     KVM_REG_PPC_PURR, 0x00000000);
-    spr_register_kvm(env, SPR_SPURR,   "SPURR",
-                     &spr_read_purr, SPR_NOACCESS,
-                     &spr_read_purr, SPR_NOACCESS,
-                     KVM_REG_PPC_SPURR, 0x00000000);
+    spr_register_kvm_hv(env, SPR_PURR,   "PURR",
+                        &spr_read_purr, SPR_NOACCESS,
+                        &spr_read_purr, SPR_NOACCESS,
+                        &spr_read_purr, &spr_write_purr,
+                        KVM_REG_PPC_PURR, 0x00000000);
+    spr_register_kvm_hv(env, SPR_SPURR,   "SPURR",
+                        &spr_read_purr, SPR_NOACCESS,
+                        &spr_read_purr, SPR_NOACCESS,
+                        &spr_read_purr, &spr_write_purr,
+                        KVM_REG_PPC_SPURR, 0x00000000);
 #endif
 }
=20
--=20
2.21.0


