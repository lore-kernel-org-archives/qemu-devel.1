Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B12C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB7721D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRcZvka7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB7721D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vnI-0007JR-Sn
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkF-000127-Qn
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkE-0004AB-Ns
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:11 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:51373)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vkE-00048x-Gk
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:10 -0500
Received: by mail-pj1-x1035.google.com with SMTP id l8so557405pjy.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=9gtHkOPRn/G0hWY+fkaGzSLrGPQLSEWHX9NgBS6eyHY=;
 b=pRcZvka7u0uzqNUAy+nFoOQD+RTdQrOVoEgwYH7pOQVC/7NC5n5d7B1PKT+YwRyg55
 o6zqr36tu3F9u6gKhtcHsL1ZgAP3a3H2JKAeWU+seehNCejiQtunEIBrFn2q6Ec1jutF
 3myTwjQv/W2aPDCbUjEPpBJXiUD8P3gzd1scofLOL1vmY4qz16HlfcWY0/uLy1uUOpls
 nLr+FP2FmWa28BiyA7pDdn8gbgH4SqMRVHBl1Y2MCJRhThWHrBzZ2KqQ+VByqwaKpWDf
 Jz6qu0jaA9gqLa5hx9VCF+kj4TGXYcI+cxf07zu6tf8z5peCBsmUhIjhqP31ivWdGwFS
 032w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=9gtHkOPRn/G0hWY+fkaGzSLrGPQLSEWHX9NgBS6eyHY=;
 b=ox85ZAsYA7aThOlLLvnT81WSgYhxkR+g5uFHlTuqp4HwFj8Ml5qm3j8Ebmi7oTYUYz
 Ap+2MQQOcyQgaYOid3ogmvGb4QJmm1pSc/m4YfjAYHzWKavv3S+IKVfEQav3L8o82AyP
 VDUoOud1WBIUYOVWN7Q5NTkMLQyjlk+NLZIqkm0xuycQRMqHBd1+2rZ17RWEUMQy4R0g
 QuNksH7pFDNPiWg/NJbFXQWheuvsL96b4I974vxVASadHj/xvMRzE/nGmaKoF5VTO8e4
 hr6SUfny+tm6fDJ3t9dz3kMjaysc2HYlS2Ao9bi7evJgAVqbrR5LCiarDQqm7Cv7dJ/u
 Bl7Q==
X-Gm-Message-State: ANhLgQ0gnQONRv1Vq468dCFxEJhWfnmIYg5xdH3lO4GxP+uCU16wyOda
 brIV2LCcfD1AhBc1k39Frktp7UGWyIrwGw==
X-Google-Smtp-Source: ADFU+vuB9mhoZ8xSzD6D+oYWP9G7R7Qu7RVr2pqT21/ll2ULfY/0bOh/+lSQqYYiZC4b3Qbmn46B7A==
X-Received: by 2002:a17:902:c383:: with SMTP id g3mr1754349plg.9.1583196547841; 
 Mon, 02 Mar 2020 16:49:07 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id u6sm301251pjy.3.2020.03.02.16.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:07 -0800 (PST)
Subject: [PULL 06/38] target/riscv: Add the virtulisation mode
Date: Mon,  2 Mar 2020 16:48:16 -0800
Message-Id: <20200303004848.136788-7-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200303004848.136788-1-palmerdabbelt@google.com>
References: <20200303004848.136788-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1035
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu.h        |  4 ++++
 target/riscv/cpu_bits.h   |  3 +++
 target/riscv/cpu_helper.c | 18 ++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c7f7ae5c38..a9cbd8584e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -117,6 +117,8 @@ struct CPURISCVState {
 
 #ifndef CONFIG_USER_ONLY
     target_ulong priv;
+    /* This contains QEMU specific information about the virt state. */
+    target_ulong virt;
     target_ulong resetvec;
 
     target_ulong mhartid;
@@ -269,6 +271,8 @@ int riscv_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
+bool riscv_cpu_virt_enabled(CPURISCVState *env);
+void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index eeaa03c0f8..2cdb0de4fe 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -430,6 +430,9 @@
 #define PRV_H 2 /* Reserved */
 #define PRV_M 3
 
+/* Virtulisation Register Fields */
+#define VIRT_ONOFF          1
+
 /* RV32 satp CSR field masks */
 #define SATP32_MODE         0x80000000
 #define SATP32_ASID         0x7fc00000
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index a10582b310..e5311160e7 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -82,6 +82,24 @@ bool riscv_cpu_fp_enabled(CPURISCVState *env)
     return false;
 }
 
+bool riscv_cpu_virt_enabled(CPURISCVState *env)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return false;
+    }
+
+    return get_field(env->virt, VIRT_ONOFF);
+}
+
+void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return;
+    }
+
+    env->virt = set_field(env->virt, VIRT_ONOFF, enable);
+}
+
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
-- 
2.25.0.265.gbab2e86ba0-goog


