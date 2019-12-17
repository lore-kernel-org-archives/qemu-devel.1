Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575DAC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21CFC2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AtcrKPeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CFC2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5Ae-00070m-Mr
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jm-0002AG-CH
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jk-0007Yo-2p
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:34 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:44639 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4jj-00076W-9d; Mon, 16 Dec 2019 23:45:32 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWd6btmz9sTX; Tue, 17 Dec 2019 15:43:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557821;
 bh=H93vcA7eu+QF3H1KRJ06dJ+D+jFIDrmans7KndV5UnE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AtcrKPebrh8+S6l288JGCKjlftDliHrPYlQTLU9nxwElZBbjM3rGZZYUeqbuQvuek
 V2wtZi1U2gIjS194XX6hKrDoOD39LI/75b2YomjzJ5SVJhXE4J38OFMYUDZgzQYww/
 RdLFg6y4nAWrik9CUHBdp0PRHwCBe4AOrdgvGHIE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 69/88] target/ppc: Add SPR TBU40
Date: Tue, 17 Dec 2019 15:43:03 +1100
Message-Id: <20191217044322.351838-70-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The spr TBU40 is used to set the upper 40 bits of the timebase
register, present on POWER5+ and later processors.

This register can only be written by the hypervisor, and cannot be read.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191128134700.16091-5-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc.c                    | 13 +++++++++++++
 target/ppc/cpu.h                |  1 +
 target/ppc/helper.h             |  1 +
 target/ppc/timebase_helper.c    |  5 +++++
 target/ppc/translate_init.inc.c | 19 +++++++++++++++++++
 5 files changed, 39 insertions(+)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 2856d69495..4c5fa29399 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -698,6 +698,19 @@ void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t va=
lue)
                      &tb_env->vtb_offset, value);
 }
=20
+void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value)
+{
+    ppc_tb_t *tb_env =3D env->tb_env;
+    uint64_t tb;
+
+    tb =3D cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        tb_env->tb_offset);
+    tb &=3D 0xFFFFFFUL;
+    tb |=3D (value & ~0xFFFFFFUL);
+    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                     &tb_env->tb_offset, tb);
+}
+
 static void cpu_ppc_tb_stop (CPUPPCState *env)
 {
     ppc_tb_t *tb_env =3D env->tb_env;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index e99850c3ae..103bfe9dc2 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1310,6 +1310,7 @@ target_ulong cpu_ppc_load_decr(CPUPPCState *env);
 void cpu_ppc_store_decr(CPUPPCState *env, target_ulong value);
 target_ulong cpu_ppc_load_hdecr(CPUPPCState *env);
 void cpu_ppc_store_hdecr(CPUPPCState *env, target_ulong value);
+void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value);
 uint64_t cpu_ppc_load_purr(CPUPPCState *env);
 void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value);
 uint32_t cpu_ppc601_load_rtcl(CPUPPCState *env);
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 356a14d8a6..cd0dfe383a 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -672,6 +672,7 @@ DEF_HELPER_FLAGS_2(store_decr, TCG_CALL_NO_RWG, void,=
 env, tl)
 DEF_HELPER_FLAGS_1(load_hdecr, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_2(store_hdecr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(store_vtb, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_2(store_tbu40, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_2(store_hid0_601, void, env, tl)
 DEF_HELPER_3(store_403_pbr, void, env, i32, tl)
 DEF_HELPER_FLAGS_1(load_40x_pit, TCG_CALL_NO_RWG, tl, env)
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 2395295b77..703bd9ed18 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -128,6 +128,11 @@ void helper_store_vtb(CPUPPCState *env, target_ulong=
 val)
     cpu_ppc_store_vtb(env, val);
 }
=20
+void helper_store_tbu40(CPUPPCState *env, target_ulong val)
+{
+    cpu_ppc_store_tbu40(env, val);
+}
+
 target_ulong helper_load_40x_pit(CPUPPCState *env)
 {
     return load_40x_pit(env);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index c850a9d065..d33d65dff7 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -327,6 +327,11 @@ static void spr_write_vtb(DisasContext *ctx, int spr=
n, int gprn)
     gen_helper_store_vtb(cpu_env, cpu_gpr[gprn]);
 }
=20
+static void spr_write_tbu40(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_tbu40(cpu_env, cpu_gpr[gprn]);
+}
+
 #endif
 #endif
=20
@@ -7853,6 +7858,16 @@ static void gen_spr_power5p_ear(CPUPPCState *env)
                  0x00000000);
 }
=20
+static void gen_spr_power5p_tb(CPUPPCState *env)
+{
+    /* TBU40 (High 40 bits of the Timebase register */
+    spr_register_hv(env, SPR_TBU40, "TBU40",
+                    SPR_NOACCESS, SPR_NOACCESS,
+                    SPR_NOACCESS, SPR_NOACCESS,
+                    SPR_NOACCESS, &spr_write_tbu40,
+                    0x00000000);
+}
+
 #if !defined(CONFIG_USER_ONLY)
 static void spr_write_hmer(DisasContext *ctx, int sprn, int gprn)
 {
@@ -8404,6 +8419,7 @@ static void init_proc_power5plus(CPUPPCState *env)
     gen_spr_power5p_common(env);
     gen_spr_power5p_lpar(env);
     gen_spr_power5p_ear(env);
+    gen_spr_power5p_tb(env);
=20
     /* env variables */
     env->dcache_line_size =3D 128;
@@ -8516,6 +8532,7 @@ static void init_proc_POWER7(CPUPPCState *env)
     gen_spr_power5p_common(env);
     gen_spr_power5p_lpar(env);
     gen_spr_power5p_ear(env);
+    gen_spr_power5p_tb(env);
     gen_spr_power6_common(env);
     gen_spr_power6_dbg(env);
     gen_spr_power7_book4(env);
@@ -8657,6 +8674,7 @@ static void init_proc_POWER8(CPUPPCState *env)
     gen_spr_power5p_common(env);
     gen_spr_power5p_lpar(env);
     gen_spr_power5p_ear(env);
+    gen_spr_power5p_tb(env);
     gen_spr_power6_common(env);
     gen_spr_power6_dbg(env);
     gen_spr_power8_tce_address_control(env);
@@ -8847,6 +8865,7 @@ static void init_proc_POWER9(CPUPPCState *env)
     gen_spr_power5p_common(env);
     gen_spr_power5p_lpar(env);
     gen_spr_power5p_ear(env);
+    gen_spr_power5p_tb(env);
     gen_spr_power6_common(env);
     gen_spr_power6_dbg(env);
     gen_spr_power8_tce_address_control(env);
--=20
2.23.0


