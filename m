Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0380BC55194
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 18:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE82206B6
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 18:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="as/4EEur";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DU6IPR79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE82206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSlkG-0000A5-Tn
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 14:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1jSlc7-0007bl-J7
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 14:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1jSlc7-0007kl-0E
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 14:02:47 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1jSlc6-0007kY-Ic; Sun, 26 Apr 2020 14:02:46 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id DAA5E5C00DC;
 Sun, 26 Apr 2020 14:02:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Sun, 26 Apr 2020 14:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=YJVAGvfb9bjTz
 51yw5JUJb1UoAmVUGH4uOpQhcGQr10=; b=as/4EEurjLhI6ooV4fEMOKlc1So/O
 r5eGcDXymWATg+PaMJkA+mlxn6J0YCmymsrXZezP9eP/gk48bKfwGnhDjTHmFIuj
 blcLADcmDH2UXUwbS4qYZJG8D1AqPfRd8SQQXf3Q7+FPwRxw0PsuE0ZJvFu223jZ
 w5mgmpQZzq5DodXZ2Fvg2BMQycopNXFfhNfKT4P+IUnomhAXymZyy2OInhy5GK/L
 U9fymQ8TaYt+/WuaPECwj5TJicYs1VZexITB5svjpTo3l4FDNmU6oADGg25pmEHm
 AhiKTqDS8F9DJnThdo+Evb6R3OgnQvrBXrZ/Mfk03F6ms2ehyACVaGaNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=YJVAGvfb9bjTz51yw5JUJb1UoAmVUGH4uOpQhcGQr10=; b=DU6IPR79
 ycU47gTcEkyI9vuPvoHes7ff89659vRO/NFgKcXxkcnrajqUYJIU321cbusv5wSR
 xGaJ939pszfnA8XE5ObDRZbvTpO15qFBEPDAg9iZHYwA2YQJ6Tdk7yrCT99/kEEt
 6SLP1D+2aMqysj4U2+hN2mIo1qraXlPIhGlm5iY74Wnf2NWFiEQBdGvVG0/s/eg3
 0ThE8NLHACIQ3KAL82465rSFWSb00uCCNzVdnmq4bM3nAXbr+B7beFK3oUKrtJc/
 BVniMUjBBQEl8djwf62/cMlrhJ4lGFUvH0C8ws0vj5Cou/84c7eZ2YDHC2wREtkP
 xp9xuAUxx1Y7nw==
X-ME-Sender: <xms:xcylXg0ssguFZfaKG1F_G_nro6Pg_hUGzIKoEnIh5vP6rJ-48sk4CA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrheejgdduvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
 ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucfkphepjeefrdelfedrkeegrddvtdekne
 cuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghlihhs
 thgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:xcylXvHptAjNUewzyXRaJxW8AvcOr0bb_MGaeq2U54sovEKM0B6_UA>
 <xmx:xcylXn9Yg-R3fl7uCPUgXqHnY3atTL2GSHi6k8LVKJcbeoOEQX2ljw>
 <xmx:xcylXrk-ZZ-6Xt6tnmDmNUBQI8xcWQrtgv1cV2uXrMp8uOLAM39Azg>
 <xmx:xcylXpECwE3QwrncIL3Cs0W7EAB0ph-_hRxhBlVO6Efc4fQfjN7pyA>
Received: from ThinkpadX1Yoga3.localdomain (c-73-93-84-208.hsd1.ca.comcast.net
 [73.93.84.208])
 by mail.messagingengine.com (Postfix) with ESMTPA id 21EC43065E2A;
 Sun, 26 Apr 2020 14:02:45 -0400 (EDT)
From: Alistair Francis <alistair@alistair23.me>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 2/9] target/riscv: Don't overwrite the reset vector
Date: Sat, 25 Apr 2020 04:29:05 -0700
Message-Id: <1a409f7fa7837de1625dc066b68f52a71dfdc587.1587920572.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1587920572.git.alistair.francis@wdc.com>
References: <cover.1587920572.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=66.111.4.29; envelope-from=alistair@alistair23.me;
 helo=out5-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 14:02:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 66.111.4.29
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

If the reset vector is set in the init function don't set it again in
realise.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 059d71f2c7..8f837edf8d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -111,6 +111,14 @@ static void set_feature(CPURISCVState *env, int feature)
     env->features |= (1ULL << feature);
 }
 
+static int get_resetvec(CPURISCVState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    return env->resetvec;
+#endif
+    return 0;
+}
+
 static void set_resetvec(CPURISCVState *env, int resetvec)
 {
 #ifndef CONFIG_USER_ONLY
@@ -123,7 +131,6 @@ static void riscv_any_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_11_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
 }
 
 #if defined(TARGET_RISCV32)
@@ -140,7 +147,6 @@ static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_priv_version(env, PRIV_VERSION_1_09_1);
-    set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
     set_feature(env, RISCV_FEATURE_PMP);
 }
@@ -150,7 +156,6 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
     set_feature(env, RISCV_FEATURE_PMP);
 }
@@ -160,7 +165,6 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV32 | RVI | RVM | RVA | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_PMP);
 }
 
@@ -169,7 +173,6 @@ static void rv32imafcu_nommu_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_PMP);
 }
 
@@ -187,7 +190,6 @@ static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_priv_version(env, PRIV_VERSION_1_09_1);
-    set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
     set_feature(env, RISCV_FEATURE_PMP);
 }
@@ -197,7 +199,6 @@ static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
     set_feature(env, RISCV_FEATURE_PMP);
 }
@@ -207,7 +208,6 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV64 | RVI | RVM | RVA | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_PMP);
 }
 
@@ -399,7 +399,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     }
 
     set_priv_version(env, priv_version);
-    set_resetvec(env, DEFAULT_RSTVEC);
+    if (!get_resetvec(env)) {
+        set_resetvec(env, DEFAULT_RSTVEC);
+    }
 
     if (cpu->cfg.mmu) {
         set_feature(env, RISCV_FEATURE_MMU);
-- 
2.26.2


