Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6A8C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1851233A0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="k1JMFcPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1851233A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LQv-0003nb-Rj
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0r-0005By-7j
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0q-0008UK-3m
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:33 -0400
Received: from ozlabs.org ([203.11.71.1]:33781)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L0p-0008BV-NP; Wed, 21 Aug 2019 03:26:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CzjF4BGcz9sRD; Wed, 21 Aug 2019 17:25:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372353;
 bh=6GY9++/Hv1KppOVgXUV+rDcGBLJtsjsXR/b4Qa8ecqI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k1JMFcPWQRQwEf/bcGe7LEaPA3b2+wWqHLXrD6PXtZvEzy3seq85zXthhPV5D8N5x
 5ZY99VWTBfEo3YkcVgXlqmfgIOudzLB4seAOe8zdj/kelx2TXhXdZvkaUleDwwyY33
 nF8tar15+srUojPhvwj5/khp/lTTgKRozF8ihMfU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:38 +1000
Message-Id: <20190821072542.23090-39-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 38/42] target/ppc: Add Directed Privileged
 Door-bell Exception State (DPDES) SPR
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
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

DPDES stores a status of a doorbell message and if it is lost in
migration, the destination CPU won't receive it. This does not hit us
much as IPIs complete too quick to catch a pending one and even if
we missed one, broadcasts happen often enough to wake that CPU.

This defines DPDES and registers with KVM for migration.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20190816061733.53572-1-aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h                |  1 +
 target/ppc/translate_init.inc.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 50245a8c4d..4b35c8e4f4 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1466,6 +1466,7 @@ typedef PowerPCCPU ArchCPU;
 #define SPR_MPC_ICTRL         (0x09E)
 #define SPR_MPC_BAR           (0x09F)
 #define SPR_PSPB              (0x09F)
+#define SPR_DPDES             (0x0B0)
 #define SPR_DAWR              (0x0B4)
 #define SPR_RPR               (0x0BA)
 #define SPR_CIABR             (0x0BB)
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index c9fcd87095..7e41ae1456 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8198,6 +8198,18 @@ static void gen_spr_power8_pspb(CPUPPCState *env)
                      KVM_REG_PPC_PSPB, 0);
 }
=20
+static void gen_spr_power8_dpdes(CPUPPCState *env)
+{
+#if !defined(CONFIG_USER_ONLY)
+    /* Directed Privileged Door-bell Exception State, used for IPI */
+    spr_register_kvm_hv(env, SPR_DPDES, "DPDES",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        &spr_read_generic, SPR_NOACCESS,
+                        &spr_read_generic, &spr_write_generic,
+                        KVM_REG_PPC_DPDES, 0x00000000);
+#endif
+}
+
 static void gen_spr_power8_ic(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
@@ -8629,6 +8641,7 @@ static void init_proc_POWER8(CPUPPCState *env)
     gen_spr_power8_pmu_user(env);
     gen_spr_power8_tm(env);
     gen_spr_power8_pspb(env);
+    gen_spr_power8_dpdes(env);
     gen_spr_vtb(env);
     gen_spr_power8_ic(env);
     gen_spr_power8_book4(env);
@@ -8817,6 +8830,7 @@ static void init_proc_POWER9(CPUPPCState *env)
     gen_spr_power8_pmu_user(env);
     gen_spr_power8_tm(env);
     gen_spr_power8_pspb(env);
+    gen_spr_power8_dpdes(env);
     gen_spr_vtb(env);
     gen_spr_power8_ic(env);
     gen_spr_power8_book4(env);
--=20
2.21.0


