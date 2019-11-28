Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7B3C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0EA2176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0EA2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaKDa-0005qv-LG
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 08:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iaK8l-0003wd-8y
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:47:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iaK8h-0005OR-NV
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:47:26 -0500
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:56534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iaK8h-0004yE-Cb
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:47:23 -0500
Received: from player688.ha.ovh.net (unknown [10.108.57.211])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 22B6F124561
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 14:47:17 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id 35B34C94B209;
 Thu, 28 Nov 2019 13:47:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/7] target/ppc: Implement the VTB for HV access
Date: Thu, 28 Nov 2019 14:46:54 +0100
Message-Id: <20191128134700.16091-2-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128134700.16091-1-clg@kaod.org>
References: <20191128134700.16091-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 14980379737802836966
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeijedgheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.43.93
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

The virtual timebase register (VTB) is a 64-bit register which
increments at the same rate as the timebase register, present on POWER8
and later processors.

The register is able to be read/written by the hypervisor and read by
the supervisor. All other accesses are illegal.

Currently the VTB is just an alias for the timebase (TB) register.

Implement the VTB so that is can be read/written independent of the TB.
Make use of the existing method for accessing timebase facilities where
by the compensation is stored and used to compute the value on reads/is
updated on writes.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
[ clg: rebased on current ppc tree ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/ppc.h            |  1 +
 target/ppc/cpu.h                |  2 ++
 target/ppc/helper.h             |  2 ++
 hw/ppc/ppc.c                    | 16 ++++++++++++++++
 linux-user/ppc/cpu_loop.c       |  5 +++++
 target/ppc/timebase_helper.c    | 10 ++++++++++
 target/ppc/translate_init.inc.c | 19 +++++++++++++++----
 7 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 585be6ab98c5..02481cd27c36 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -24,6 +24,7 @@ struct ppc_tb_t {
     /* Time base management */
     int64_t  tb_offset;    /* Compensation                    */
     int64_t  atb_offset;   /* Compensation                    */
+    int64_t  vtb_offset;
     uint32_t tb_freq;      /* TB frequency                    */
     /* Decrementer management */
     uint64_t decr_next;    /* Tick for next decr interrupt    */
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index e3e82327b723..19d6e724bb5a 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1305,6 +1305,8 @@ uint64_t cpu_ppc_load_atbl(CPUPPCState *env);
 uint32_t cpu_ppc_load_atbu(CPUPPCState *env);
 void cpu_ppc_store_atbl(CPUPPCState *env, uint32_t value);
 void cpu_ppc_store_atbu(CPUPPCState *env, uint32_t value);
+uint64_t cpu_ppc_load_vtb(CPUPPCState *env);
+void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t value);
 bool ppc_decr_clear_on_delivery(CPUPPCState *env);
 target_ulong cpu_ppc_load_decr(CPUPPCState *env);
 void cpu_ppc_store_decr(CPUPPCState *env, target_ulong value);
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index f843814b8aa8..a5f53bb421a7 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -649,6 +649,7 @@ DEF_HELPER_FLAGS_1(load_tbl, TCG_CALL_NO_RWG, tl, env=
)
 DEF_HELPER_FLAGS_1(load_tbu, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_1(load_atbl, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_1(load_atbu, TCG_CALL_NO_RWG, tl, env)
+DEF_HELPER_FLAGS_1(load_vtb, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_1(load_601_rtcl, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_1(load_601_rtcu, TCG_CALL_NO_RWG, tl, env)
 #if !defined(CONFIG_USER_ONLY)
@@ -669,6 +670,7 @@ DEF_HELPER_FLAGS_1(load_decr, TCG_CALL_NO_RWG, tl, en=
v)
 DEF_HELPER_FLAGS_2(store_decr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_1(load_hdecr, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_2(store_hdecr, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_2(store_vtb, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_2(store_hid0_601, void, env, tl)
 DEF_HELPER_3(store_403_pbr, void, env, i32, tl)
 DEF_HELPER_FLAGS_1(load_40x_pit, TCG_CALL_NO_RWG, tl, env)
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 8dd982fc1e40..263922052536 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -694,6 +694,22 @@ void cpu_ppc_store_atbu (CPUPPCState *env, uint32_t =
value)
                      &tb_env->atb_offset, ((uint64_t)value << 32) | tb);
 }
=20
+uint64_t cpu_ppc_load_vtb(CPUPPCState *env)
+{
+    ppc_tb_t *tb_env =3D env->tb_env;
+
+    return cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                          tb_env->vtb_offset);
+}
+
+void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t value)
+{
+    ppc_tb_t *tb_env =3D env->tb_env;
+
+    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                     &tb_env->vtb_offset, value);
+}
+
 static void cpu_ppc_tb_stop (CPUPPCState *env)
 {
     ppc_tb_t *tb_env =3D env->tb_env;
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index d5704def2902..5b27f8603e33 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -47,6 +47,11 @@ uint32_t cpu_ppc_load_atbu(CPUPPCState *env)
     return cpu_ppc_get_tb(env) >> 32;
 }
=20
+uint64_t cpu_ppc_load_vtb(CPUPPCState *env)
+{
+    return cpu_ppc_get_tb(env);
+}
+
 uint32_t cpu_ppc601_load_rtcu(CPUPPCState *env)
 __attribute__ (( alias ("cpu_ppc_load_tbu") ));
=20
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 73363e08ae71..8c3c2fe67c2c 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -45,6 +45,11 @@ target_ulong helper_load_atbu(CPUPPCState *env)
     return cpu_ppc_load_atbu(env);
 }
=20
+target_ulong helper_load_vtb(CPUPPCState *env)
+{
+    return cpu_ppc_load_vtb(env);
+}
+
 #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
 target_ulong helper_load_purr(CPUPPCState *env)
 {
@@ -113,6 +118,11 @@ void helper_store_hdecr(CPUPPCState *env, target_ulo=
ng val)
     cpu_ppc_store_hdecr(env, val);
 }
=20
+void helper_store_vtb(CPUPPCState *env, target_ulong val)
+{
+    cpu_ppc_store_vtb(env, val);
+}
+
 target_ulong helper_load_40x_pit(CPUPPCState *env)
 {
     return load_40x_pit(env);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index ba726dec4d00..5a560164d4a4 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -312,6 +312,16 @@ static void spr_write_hdecr(DisasContext *ctx, int s=
prn, int gprn)
     }
 }
=20
+static void spr_read_vtb(DisasContext *ctx, int gprn, int sprn)
+{
+    gen_helper_load_vtb(cpu_gpr[gprn], cpu_env);
+}
+
+static void spr_write_vtb(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_vtb(cpu_env, cpu_gpr[gprn]);
+}
+
 #endif
 #endif
=20
@@ -8169,10 +8179,11 @@ static void gen_spr_power8_ebb(CPUPPCState *env)
 /* Virtual Time Base */
 static void gen_spr_vtb(CPUPPCState *env)
 {
-    spr_register_kvm(env, SPR_VTB, "VTB",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_tbl, SPR_NOACCESS,
-                 KVM_REG_PPC_VTB, 0x00000000);
+    spr_register_kvm_hv(env, SPR_VTB, "VTB",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        &spr_read_vtb, SPR_NOACCESS,
+                        &spr_read_vtb, &spr_write_vtb,
+                        KVM_REG_PPC_VTB, 0x00000000);
 }
=20
 static void gen_spr_power8_fscr(CPUPPCState *env)
--=20
2.21.0


