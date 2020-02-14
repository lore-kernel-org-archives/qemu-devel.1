Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C77AC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35466206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yurh1NTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35466206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fCY-0008Mj-F5
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 12:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7z-0006Bu-4v
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7w-00016S-VR
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:47 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45251)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2f7w-00013P-MI
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:44 -0500
Received: by mail-wr1-x441.google.com with SMTP id g3so11869408wrs.12
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 09:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QJEg/HbNShyyNFEksYvrdPfffEtZWxgEaTJmxp/tP2k=;
 b=Yurh1NTFNOE5oCZEwGcmyWRnqazdAgcsag4w1y57LNSt/LDy25EahlXaxlZn0W27Dq
 d0+Bz28ws698PcPLsjBrFmzaoN6jY1+nrvALBF1HiUVmOa4VhYviQ72uJY0fRoAwnZg9
 7OEoAfGlncXZP4Vzzu1fZjjDuQY4IMv7Jc7NTi+QUNRxprPCSl04+fdvV99GLSefMrI9
 z/AUVbHH9E/LcNDA93D8myG3Vncjb7fjuKPfNdc+OEf7R62mBjV1noCTVFnIDPB8D95H
 TpKjMNrI+2lRxWvgqHGf9oR1WWlOLgALRMksH0jUap+7R3rlAwxs6zYVUAnx1rLKObDz
 5yJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QJEg/HbNShyyNFEksYvrdPfffEtZWxgEaTJmxp/tP2k=;
 b=SWaAa+8ez/KZCJ5Py3QJtdGXNcAQqAccm62IB3da5miS8sDcdqFRfVDb7JoyL0GO/3
 DiwzQo2Blcp6A4Qay8ABBa2VO3jAnk0pS+WxwDPQ/amsTrXZftdMlxlOuL6A2TjpaKGs
 TMAUNA8MurIYN4WfWu0h2ZWuPwqm/9Ag3l0ggkJlap9NoKine48xm+SvaFkxj64PlEEJ
 r/eebbRV2ZW97qiXz6qiKg2Dlz8G+B4Q9KvtDm1Il9VhPihCkhTq9hyQP6AfmxVA/22A
 zcLfZg1w2lUG/NvlW8gxB5fXlaD39OKVvxEBwZz4DOWlTu6ODN/GRQkNMLY5vBxn+2Ne
 4uhg==
X-Gm-Message-State: APjAAAXEjoTXZ70gzmthBFVmZxWthTTq6cIMBGPge7k4YofiQjeZDsXu
 uBRR3DG7Jr7DRQoGae41zLecuA==
X-Google-Smtp-Source: APXvYqyrLjpUQdZgQLpydo3Cnc6g6jscV0sOLjWU58grOqEUIo/qZqPDo8ojdLRIxuwe5NgzeshUHw==
X-Received: by 2002:adf:9c8d:: with SMTP id d13mr5493858wre.392.1581702703524; 
 Fri, 14 Feb 2020 09:51:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v8sm8001857wrw.2.2020.02.14.09.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 09:51:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 18/21] target/arm: Test correct register in aa32_pan and
 aa32_ats1e1 checks
Date: Fri, 14 Feb 2020 17:51:13 +0000
Message-Id: <20200214175116.9164-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214175116.9164-1-peter.maydell@linaro.org>
References: <20200214175116.9164-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The isar_feature_aa32_pan and isar_feature_aa32_ats1e1 functions
are supposed to be testing fields in ID_MMFR3; but a cut-and-paste
error meant we were looking at MVFR0 instead.

Fix the functions to look at the right register; this requires
us to move at least id_mmfr3 to the ARMISARegisters struct; we
choose to move all the ID_MMFRn registers for consistency.

Fixes: 3d6ad6bb466f
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      |  14 +++---
 hw/intc/armv7m_nvic.c |   8 ++--
 target/arm/cpu.c      | 104 +++++++++++++++++++++---------------------
 target/arm/cpu64.c    |  28 ++++++------
 target/arm/helper.c   |  12 ++---
 target/arm/kvm32.c    |  17 +++++++
 target/arm/kvm64.c    |  10 ++++
 7 files changed, 110 insertions(+), 83 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cfa9fd6c1b9..ba97fc75c1d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -867,6 +867,11 @@ struct ARMCPU {
         uint32_t id_isar4;
         uint32_t id_isar5;
         uint32_t id_isar6;
+        uint32_t id_mmfr0;
+        uint32_t id_mmfr1;
+        uint32_t id_mmfr2;
+        uint32_t id_mmfr3;
+        uint32_t id_mmfr4;
         uint32_t mvfr0;
         uint32_t mvfr1;
         uint32_t mvfr2;
@@ -892,11 +897,6 @@ struct ARMCPU {
     uint64_t pmceid0;
     uint64_t pmceid1;
     uint32_t id_afr0;
-    uint32_t id_mmfr0;
-    uint32_t id_mmfr1;
-    uint32_t id_mmfr2;
-    uint32_t id_mmfr3;
-    uint32_t id_mmfr4;
     uint64_t id_aa64afr0;
     uint64_t id_aa64afr1;
     uint32_t clidr;
@@ -3504,12 +3504,12 @@ static inline bool isar_feature_aa32_vminmaxnm(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa32_pan(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->mvfr0, ID_MMFR3, PAN) != 0;
+    return FIELD_EX32(id->id_mmfr3, ID_MMFR3, PAN) != 0;
 }
 
 static inline bool isar_feature_aa32_ats1e1(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->mvfr0, ID_MMFR3, PAN) >= 2;
+    return FIELD_EX32(id->id_mmfr3, ID_MMFR3, PAN) >= 2;
 }
 
 static inline bool isar_feature_aa32_pmu_8_1(const ARMISARegisters *id)
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 5a403fc9704..22a43e49847 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1231,13 +1231,13 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
     case 0xd4c: /* AFR0.  */
         return cpu->id_afr0;
     case 0xd50: /* MMFR0.  */
-        return cpu->id_mmfr0;
+        return cpu->isar.id_mmfr0;
     case 0xd54: /* MMFR1.  */
-        return cpu->id_mmfr1;
+        return cpu->isar.id_mmfr1;
     case 0xd58: /* MMFR2.  */
-        return cpu->id_mmfr2;
+        return cpu->isar.id_mmfr2;
     case 0xd5c: /* MMFR3.  */
-        return cpu->id_mmfr3;
+        return cpu->isar.id_mmfr3;
     case 0xd60: /* ISAR0.  */
         return cpu->isar.id_isar0;
     case 0xd64: /* ISAR1.  */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f58b4da4427..c46bb5a5c09 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1960,9 +1960,9 @@ static void arm1136_r2_initfn(Object *obj)
     cpu->id_pfr1 = 0x1;
     cpu->isar.id_dfr0 = 0x2;
     cpu->id_afr0 = 0x3;
-    cpu->id_mmfr0 = 0x01130003;
-    cpu->id_mmfr1 = 0x10030302;
-    cpu->id_mmfr2 = 0x01222110;
+    cpu->isar.id_mmfr0 = 0x01130003;
+    cpu->isar.id_mmfr1 = 0x10030302;
+    cpu->isar.id_mmfr2 = 0x01222110;
     cpu->isar.id_isar0 = 0x00140011;
     cpu->isar.id_isar1 = 0x12002111;
     cpu->isar.id_isar2 = 0x11231111;
@@ -1992,9 +1992,9 @@ static void arm1136_initfn(Object *obj)
     cpu->id_pfr1 = 0x1;
     cpu->isar.id_dfr0 = 0x2;
     cpu->id_afr0 = 0x3;
-    cpu->id_mmfr0 = 0x01130003;
-    cpu->id_mmfr1 = 0x10030302;
-    cpu->id_mmfr2 = 0x01222110;
+    cpu->isar.id_mmfr0 = 0x01130003;
+    cpu->isar.id_mmfr1 = 0x10030302;
+    cpu->isar.id_mmfr2 = 0x01222110;
     cpu->isar.id_isar0 = 0x00140011;
     cpu->isar.id_isar1 = 0x12002111;
     cpu->isar.id_isar2 = 0x11231111;
@@ -2025,9 +2025,9 @@ static void arm1176_initfn(Object *obj)
     cpu->id_pfr1 = 0x11;
     cpu->isar.id_dfr0 = 0x33;
     cpu->id_afr0 = 0;
-    cpu->id_mmfr0 = 0x01130003;
-    cpu->id_mmfr1 = 0x10030302;
-    cpu->id_mmfr2 = 0x01222100;
+    cpu->isar.id_mmfr0 = 0x01130003;
+    cpu->isar.id_mmfr1 = 0x10030302;
+    cpu->isar.id_mmfr2 = 0x01222100;
     cpu->isar.id_isar0 = 0x0140011;
     cpu->isar.id_isar1 = 0x12002111;
     cpu->isar.id_isar2 = 0x11231121;
@@ -2055,9 +2055,9 @@ static void arm11mpcore_initfn(Object *obj)
     cpu->id_pfr1 = 0x1;
     cpu->isar.id_dfr0 = 0;
     cpu->id_afr0 = 0x2;
-    cpu->id_mmfr0 = 0x01100103;
-    cpu->id_mmfr1 = 0x10020302;
-    cpu->id_mmfr2 = 0x01222000;
+    cpu->isar.id_mmfr0 = 0x01100103;
+    cpu->isar.id_mmfr1 = 0x10020302;
+    cpu->isar.id_mmfr2 = 0x01222000;
     cpu->isar.id_isar0 = 0x00100011;
     cpu->isar.id_isar1 = 0x12002111;
     cpu->isar.id_isar2 = 0x11221011;
@@ -2087,10 +2087,10 @@ static void cortex_m3_initfn(Object *obj)
     cpu->id_pfr1 = 0x00000200;
     cpu->isar.id_dfr0 = 0x00100000;
     cpu->id_afr0 = 0x00000000;
-    cpu->id_mmfr0 = 0x00000030;
-    cpu->id_mmfr1 = 0x00000000;
-    cpu->id_mmfr2 = 0x00000000;
-    cpu->id_mmfr3 = 0x00000000;
+    cpu->isar.id_mmfr0 = 0x00000030;
+    cpu->isar.id_mmfr1 = 0x00000000;
+    cpu->isar.id_mmfr2 = 0x00000000;
+    cpu->isar.id_mmfr3 = 0x00000000;
     cpu->isar.id_isar0 = 0x01141110;
     cpu->isar.id_isar1 = 0x02111000;
     cpu->isar.id_isar2 = 0x21112231;
@@ -2118,10 +2118,10 @@ static void cortex_m4_initfn(Object *obj)
     cpu->id_pfr1 = 0x00000200;
     cpu->isar.id_dfr0 = 0x00100000;
     cpu->id_afr0 = 0x00000000;
-    cpu->id_mmfr0 = 0x00000030;
-    cpu->id_mmfr1 = 0x00000000;
-    cpu->id_mmfr2 = 0x00000000;
-    cpu->id_mmfr3 = 0x00000000;
+    cpu->isar.id_mmfr0 = 0x00000030;
+    cpu->isar.id_mmfr1 = 0x00000000;
+    cpu->isar.id_mmfr2 = 0x00000000;
+    cpu->isar.id_mmfr3 = 0x00000000;
     cpu->isar.id_isar0 = 0x01141110;
     cpu->isar.id_isar1 = 0x02111000;
     cpu->isar.id_isar2 = 0x21112231;
@@ -2149,10 +2149,10 @@ static void cortex_m7_initfn(Object *obj)
     cpu->id_pfr1 = 0x00000200;
     cpu->isar.id_dfr0 = 0x00100000;
     cpu->id_afr0 = 0x00000000;
-    cpu->id_mmfr0 = 0x00100030;
-    cpu->id_mmfr1 = 0x00000000;
-    cpu->id_mmfr2 = 0x01000000;
-    cpu->id_mmfr3 = 0x00000000;
+    cpu->isar.id_mmfr0 = 0x00100030;
+    cpu->isar.id_mmfr1 = 0x00000000;
+    cpu->isar.id_mmfr2 = 0x01000000;
+    cpu->isar.id_mmfr3 = 0x00000000;
     cpu->isar.id_isar0 = 0x01101110;
     cpu->isar.id_isar1 = 0x02112000;
     cpu->isar.id_isar2 = 0x20232231;
@@ -2182,10 +2182,10 @@ static void cortex_m33_initfn(Object *obj)
     cpu->id_pfr1 = 0x00000210;
     cpu->isar.id_dfr0 = 0x00200000;
     cpu->id_afr0 = 0x00000000;
-    cpu->id_mmfr0 = 0x00101F40;
-    cpu->id_mmfr1 = 0x00000000;
-    cpu->id_mmfr2 = 0x01000000;
-    cpu->id_mmfr3 = 0x00000000;
+    cpu->isar.id_mmfr0 = 0x00101F40;
+    cpu->isar.id_mmfr1 = 0x00000000;
+    cpu->isar.id_mmfr2 = 0x01000000;
+    cpu->isar.id_mmfr3 = 0x00000000;
     cpu->isar.id_isar0 = 0x01101110;
     cpu->isar.id_isar1 = 0x02212000;
     cpu->isar.id_isar2 = 0x20232232;
@@ -2234,10 +2234,10 @@ static void cortex_r5_initfn(Object *obj)
     cpu->id_pfr1 = 0x001;
     cpu->isar.id_dfr0 = 0x010400;
     cpu->id_afr0 = 0x0;
-    cpu->id_mmfr0 = 0x0210030;
-    cpu->id_mmfr1 = 0x00000000;
-    cpu->id_mmfr2 = 0x01200000;
-    cpu->id_mmfr3 = 0x0211;
+    cpu->isar.id_mmfr0 = 0x0210030;
+    cpu->isar.id_mmfr1 = 0x00000000;
+    cpu->isar.id_mmfr2 = 0x01200000;
+    cpu->isar.id_mmfr3 = 0x0211;
     cpu->isar.id_isar0 = 0x02101111;
     cpu->isar.id_isar1 = 0x13112111;
     cpu->isar.id_isar2 = 0x21232141;
@@ -2289,10 +2289,10 @@ static void cortex_a8_initfn(Object *obj)
     cpu->id_pfr1 = 0x11;
     cpu->isar.id_dfr0 = 0x400;
     cpu->id_afr0 = 0;
-    cpu->id_mmfr0 = 0x31100003;
-    cpu->id_mmfr1 = 0x20000000;
-    cpu->id_mmfr2 = 0x01202000;
-    cpu->id_mmfr3 = 0x11;
+    cpu->isar.id_mmfr0 = 0x31100003;
+    cpu->isar.id_mmfr1 = 0x20000000;
+    cpu->isar.id_mmfr2 = 0x01202000;
+    cpu->isar.id_mmfr3 = 0x11;
     cpu->isar.id_isar0 = 0x00101111;
     cpu->isar.id_isar1 = 0x12112111;
     cpu->isar.id_isar2 = 0x21232031;
@@ -2362,10 +2362,10 @@ static void cortex_a9_initfn(Object *obj)
     cpu->id_pfr1 = 0x11;
     cpu->isar.id_dfr0 = 0x000;
     cpu->id_afr0 = 0;
-    cpu->id_mmfr0 = 0x00100103;
-    cpu->id_mmfr1 = 0x20000000;
-    cpu->id_mmfr2 = 0x01230000;
-    cpu->id_mmfr3 = 0x00002111;
+    cpu->isar.id_mmfr0 = 0x00100103;
+    cpu->isar.id_mmfr1 = 0x20000000;
+    cpu->isar.id_mmfr2 = 0x01230000;
+    cpu->isar.id_mmfr3 = 0x00002111;
     cpu->isar.id_isar0 = 0x00101111;
     cpu->isar.id_isar1 = 0x13112111;
     cpu->isar.id_isar2 = 0x21232041;
@@ -2427,10 +2427,10 @@ static void cortex_a7_initfn(Object *obj)
     cpu->id_pfr1 = 0x00011011;
     cpu->isar.id_dfr0 = 0x02010555;
     cpu->id_afr0 = 0x00000000;
-    cpu->id_mmfr0 = 0x10101105;
-    cpu->id_mmfr1 = 0x40000000;
-    cpu->id_mmfr2 = 0x01240000;
-    cpu->id_mmfr3 = 0x02102211;
+    cpu->isar.id_mmfr0 = 0x10101105;
+    cpu->isar.id_mmfr1 = 0x40000000;
+    cpu->isar.id_mmfr2 = 0x01240000;
+    cpu->isar.id_mmfr3 = 0x02102211;
     /* a7_mpcore_r0p5_trm, page 4-4 gives 0x01101110; but
      * table 4-41 gives 0x02101110, which includes the arm div insns.
      */
@@ -2473,10 +2473,10 @@ static void cortex_a15_initfn(Object *obj)
     cpu->id_pfr1 = 0x00011011;
     cpu->isar.id_dfr0 = 0x02010555;
     cpu->id_afr0 = 0x00000000;
-    cpu->id_mmfr0 = 0x10201105;
-    cpu->id_mmfr1 = 0x20000000;
-    cpu->id_mmfr2 = 0x01240000;
-    cpu->id_mmfr3 = 0x02102211;
+    cpu->isar.id_mmfr0 = 0x10201105;
+    cpu->isar.id_mmfr1 = 0x20000000;
+    cpu->isar.id_mmfr2 = 0x01240000;
+    cpu->isar.id_mmfr3 = 0x02102211;
     cpu->isar.id_isar0 = 0x02101110;
     cpu->isar.id_isar1 = 0x13112111;
     cpu->isar.id_isar2 = 0x21232041;
@@ -2712,13 +2712,13 @@ static void arm_max_initfn(Object *obj)
             t = FIELD_DP32(t, MVFR2, FPMISC, 4);   /* FP MaxNum */
             cpu->isar.mvfr2 = t;
 
-            t = cpu->id_mmfr3;
+            t = cpu->isar.id_mmfr3;
             t = FIELD_DP32(t, ID_MMFR3, PAN, 2); /* ATS1E1 */
-            cpu->id_mmfr3 = t;
+            cpu->isar.id_mmfr3 = t;
 
-            t = cpu->id_mmfr4;
+            t = cpu->isar.id_mmfr4;
             t = FIELD_DP32(t, ID_MMFR4, HPDS, 1); /* AA32HPD */
-            cpu->id_mmfr4 = t;
+            cpu->isar.id_mmfr4 = t;
         }
 #endif
     }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c9452894035..8430d432943 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -123,10 +123,10 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->id_pfr1 = 0x00011011;
     cpu->isar.id_dfr0 = 0x03010066;
     cpu->id_afr0 = 0x00000000;
-    cpu->id_mmfr0 = 0x10101105;
-    cpu->id_mmfr1 = 0x40000000;
-    cpu->id_mmfr2 = 0x01260000;
-    cpu->id_mmfr3 = 0x02102211;
+    cpu->isar.id_mmfr0 = 0x10101105;
+    cpu->isar.id_mmfr1 = 0x40000000;
+    cpu->isar.id_mmfr2 = 0x01260000;
+    cpu->isar.id_mmfr3 = 0x02102211;
     cpu->isar.id_isar0 = 0x02101110;
     cpu->isar.id_isar1 = 0x13112111;
     cpu->isar.id_isar2 = 0x21232042;
@@ -177,10 +177,10 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->id_pfr1 = 0x00011011;
     cpu->isar.id_dfr0 = 0x03010066;
     cpu->id_afr0 = 0x00000000;
-    cpu->id_mmfr0 = 0x10101105;
-    cpu->id_mmfr1 = 0x40000000;
-    cpu->id_mmfr2 = 0x01260000;
-    cpu->id_mmfr3 = 0x02102211;
+    cpu->isar.id_mmfr0 = 0x10101105;
+    cpu->isar.id_mmfr1 = 0x40000000;
+    cpu->isar.id_mmfr2 = 0x01260000;
+    cpu->isar.id_mmfr3 = 0x02102211;
     cpu->isar.id_isar0 = 0x02101110;
     cpu->isar.id_isar1 = 0x13112111;
     cpu->isar.id_isar2 = 0x21232042;
@@ -230,10 +230,10 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->id_pfr1 = 0x00011011;
     cpu->isar.id_dfr0 = 0x03010066;
     cpu->id_afr0 = 0x00000000;
-    cpu->id_mmfr0 = 0x10201105;
-    cpu->id_mmfr1 = 0x40000000;
-    cpu->id_mmfr2 = 0x01260000;
-    cpu->id_mmfr3 = 0x02102211;
+    cpu->isar.id_mmfr0 = 0x10201105;
+    cpu->isar.id_mmfr1 = 0x40000000;
+    cpu->isar.id_mmfr2 = 0x01260000;
+    cpu->isar.id_mmfr3 = 0x02102211;
     cpu->isar.id_isar0 = 0x02101110;
     cpu->isar.id_isar1 = 0x13112111;
     cpu->isar.id_isar2 = 0x21232042;
@@ -699,9 +699,9 @@ static void aarch64_max_initfn(Object *obj)
         u = FIELD_DP32(u, ID_ISAR6, SPECRES, 1);
         cpu->isar.id_isar6 = u;
 
-        u = cpu->id_mmfr3;
+        u = cpu->isar.id_mmfr3;
         u = FIELD_DP32(u, ID_MMFR3, PAN, 2); /* ATS1E1 */
-        cpu->id_mmfr3 = u;
+        cpu->isar.id_mmfr3 = u;
 
         u = cpu->isar.id_aa64dfr0;
         u = FIELD_DP64(u, ID_AA64DFR0, PMUVER, 5); /* v8.4-PMU */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 468e4e89848..492741a2b0b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6910,22 +6910,22 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->id_mmfr0 },
+              .resetvalue = cpu->isar.id_mmfr0 },
             { .name = "ID_MMFR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->id_mmfr1 },
+              .resetvalue = cpu->isar.id_mmfr1 },
             { .name = "ID_MMFR2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->id_mmfr2 },
+              .resetvalue = cpu->isar.id_mmfr2 },
             { .name = "ID_MMFR3", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->id_mmfr3 },
+              .resetvalue = cpu->isar.id_mmfr3 },
             { .name = "ID_ISAR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -6960,7 +6960,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->id_mmfr4 },
+              .resetvalue = cpu->isar.id_mmfr4 },
             { .name = "ID_ISAR6", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -7409,7 +7409,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, vmsa_pmsa_cp_reginfo);
         define_arm_cp_regs(cpu, vmsa_cp_reginfo);
         /* TTCBR2 is introduced with ARMv8.2-A32HPD.  */
-        if (FIELD_EX32(cpu->id_mmfr4, ID_MMFR4, HPDS) != 0) {
+        if (FIELD_EX32(cpu->isar.id_mmfr4, ID_MMFR4, HPDS) != 0) {
             define_one_arm_cp_reg(cpu, &ttbcr2_reginfo);
         }
     }
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index bca02553b25..7981ae3bc4e 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -111,6 +111,23 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      * Fortunately there is not yet anything in there that affects migration.
      */
 
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr0,
+                          ARM_CP15_REG32(0, 0, 1, 4));
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr1,
+                          ARM_CP15_REG32(0, 0, 1, 5));
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr2,
+                          ARM_CP15_REG32(0, 0, 1, 6));
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr3,
+                          ARM_CP15_REG32(0, 0, 1, 7));
+    if (read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr4,
+                       ARM_CP15_REG32(0, 0, 2, 6))) {
+        /*
+         * Older kernels don't support reading ID_MMFR4 (a new in v8
+         * register); assume it's zero.
+         */
+        ahcf->isar.id_mmfr4 = 0;
+    }
+
     /*
      * There is no way to read DBGDIDR, because currently 32-bit KVM
      * doesn't implement debug at all. Leave it at zero.
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 527532f2b37..5e29b3bb456 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -565,6 +565,14 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
          */
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_dfr0,
                               ARM64_SYS_REG(3, 0, 0, 1, 2));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr0,
+                              ARM64_SYS_REG(3, 0, 0, 1, 4));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr1,
+                              ARM64_SYS_REG(3, 0, 0, 1, 5));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr2,
+                              ARM64_SYS_REG(3, 0, 0, 1, 6));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr3,
+                              ARM64_SYS_REG(3, 0, 0, 1, 7));
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar0,
                               ARM64_SYS_REG(3, 0, 0, 2, 0));
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar1,
@@ -577,6 +585,8 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                               ARM64_SYS_REG(3, 0, 0, 2, 4));
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar5,
                               ARM64_SYS_REG(3, 0, 0, 2, 5));
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr4,
+                              ARM64_SYS_REG(3, 0, 0, 2, 6));
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar6,
                               ARM64_SYS_REG(3, 0, 0, 2, 7));
 
-- 
2.20.1


