Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6AEC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:51:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5560B2467B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a8izAkQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5560B2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7irS-0005Im-EA
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:51:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifX-0008Hy-E2
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifW-000272-5k
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:19 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:35766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifV-00026P-VB
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:18 -0500
Received: by mail-wr1-x42e.google.com with SMTP id r7so3700178wro.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=zxcAJSx6I1dBt0++qxyzNQdup6sZi0n4/zNIAaI5fJc=;
 b=a8izAkQ+LahKJLwJkFwoQH2ql7SBI0sxUA6t2hCxx85lkFKE6x/iASCVu310eO1u36
 pN//E3hTlLi0Eg5RtnjOSaGVTf/WdufwrCAUjJRdOqo0dPIlDo93CDDYNUY0rWhmQh5w
 9PAu4oC83AI++SU9Twq026YeCX5k0IfHLlkXDMEuU05jQR+L+ud2AaLLy1z9TdIQCm4k
 0ykJM0A3P24SKBaOfoAu5GHH6dz29fOWc+tsTXjkFHoDfyfQ0CKop4XzkdRZ0gIRUWPu
 e5BBvw0jQ6YWBangLOUkA4N3mFS6jg+qqunRvpthzDnxZWBqRp3FJe8ayxyJxGgZLVk0
 cVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zxcAJSx6I1dBt0++qxyzNQdup6sZi0n4/zNIAaI5fJc=;
 b=K/clyhASe7gZyo/i85EoQ4+cTjhczHP23KLZKLe4uWtBNDBeJQ0iZNBpzl4TDRDl4y
 tHVroaQ7jyjxajouo1HemN588ngbt8jKz7+fZC+sJIerVw/MXrvUI/YbujadnRUlamm4
 1XGOwpTU1ZgGT8lM+Bx1cLkkeU6zaSHwLVTnBJAU8EUJZ7vSjJvg6I5NOUDt0Fg080QN
 6DJPnuN7fFIhMN2jHzT7h6qDiC36NtTzogq8FOWGC/P+0iSvmXs93KUCbaYnYcbh5b3n
 tRD7KvzWdpXnGxWcfKgrX1lYymWoV+sbWEbj/RurOzYVcELQiMzsi3kfMbiYvTvqXiu9
 AGTQ==
X-Gm-Message-State: APjAAAVLFfmkrjK4eJ7DLoXVSh9SCByNqPXV/m+VrMWbuxBl/x6Q/Jst
 wiMd55f0MqfYzuH+cgeCB82Y4Cpfv9K3zQ==
X-Google-Smtp-Source: APXvYqz0mZm6uzXMTYmEEvkxRXVUia+nsICpj+tbEFEW1PTOCBNhp6SV8X2dxgR1/gWfcCFvYOFeFA==
X-Received: by 2002:adf:f012:: with SMTP id j18mr5551363wro.314.1582907956619; 
 Fri, 28 Feb 2020 08:39:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.39.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:39:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/33] target/arm: Implement v8.3-RCPC
Date: Fri, 28 Feb 2020 16:38:37 +0000
Message-Id: <20200228163840.23585-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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

The v8.3-RCPC extension implements three new load instructions
which provide slightly weaker consistency guarantees than the
existing load-acquire operations. For QEMU we choose to simply
implement them with a full LDAQ barrier.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200224172846.13053-3-peter.maydell@linaro.org
---
 target/arm/cpu.h           |  5 +++++
 linux-user/elfload.c       |  1 +
 target/arm/cpu64.c         |  1 +
 target/arm/translate-a64.c | 24 ++++++++++++++++++++++++
 4 files changed, 31 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6013287f623..ff30985ead4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3774,6 +3774,11 @@ static inline bool isar_feature_aa64_pmu_8_4(const ARMISARegisters *id)
         FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
 }
 
+static inline bool isar_feature_aa64_rcpc_8_3(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) != 0;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 86cda127b78..d76b828a789 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -661,6 +661,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_sb, ARM_HWCAP_A64_SB);
     GET_FEATURE_ID(aa64_condm_4, ARM_HWCAP_A64_FLAGM);
     GET_FEATURE_ID(aa64_dcpop, ARM_HWCAP_A64_DCPOP);
+    GET_FEATURE_ID(aa64_rcpc_8_3, ARM_HWCAP_A64_LRCPC);
 
     return hwcaps;
 }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 8f2a43c938a..18c7b40f98c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -654,6 +654,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64ISAR1, SB, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, SPECRES, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 1);
+        t = FIELD_DP64(t, ID_AA64ISAR1, LRCPC, 1); /* ARMv8.3-RCPC */
         cpu->isar.id_aa64isar1 = t;
 
         t = cpu->isar.id_aa64pfr0;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 596bf4cf734..7a066fb7cb2 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3142,6 +3142,8 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
     int rs = extract32(insn, 16, 5);
     int rn = extract32(insn, 5, 5);
     int o3_opc = extract32(insn, 12, 4);
+    bool r = extract32(insn, 22, 1);
+    bool a = extract32(insn, 23, 1);
     TCGv_i64 tcg_rs, clean_addr;
     AtomicThreeOpFn *fn;
 
@@ -3177,6 +3179,13 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
     case 010: /* SWP */
         fn = tcg_gen_atomic_xchg_i64;
         break;
+    case 014: /* LDAPR, LDAPRH, LDAPRB */
+        if (!dc_isar_feature(aa64_rcpc_8_3, s) ||
+            rs != 31 || a != 1 || r != 0) {
+            unallocated_encoding(s);
+            return;
+        }
+        break;
     default:
         unallocated_encoding(s);
         return;
@@ -3186,6 +3195,21 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
         gen_check_sp_alignment(s);
     }
     clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+
+    if (o3_opc == 014) {
+        /*
+         * LDAPR* are a special case because they are a simple load, not a
+         * fetch-and-do-something op.
+         * The architectural consistency requirements here are weaker than
+         * full load-acquire (we only need "load-acquire processor consistent"),
+         * but we choose to implement them as full LDAQ.
+         */
+        do_gpr_ld(s, cpu_reg(s, rt), clean_addr, size, false, false,
+                  true, rt, disas_ldst_compute_iss_sf(size, false, 0), true);
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+        return;
+    }
+
     tcg_rs = read_cpu_reg(s, rs, true);
 
     if (o3_opc == 1) { /* LDCLR */
-- 
2.20.1


