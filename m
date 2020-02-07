Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B8FC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B07D620720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FR2esMpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07D620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04n0-0002Ff-T8
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hf-0008Gt-Lg
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04he-0002Rs-FY
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:55 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:38574)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04he-0002Qd-96
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:54 -0500
Received: by mail-wm1-x336.google.com with SMTP id a9so3017418wmj.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=m9az9Yd6ZI7VspoBTA6WPj7qhcoz5+8SEqEa5r5dyV8=;
 b=FR2esMpX9FGcR2a9PYqBGjVaNiJCkiFruHSBF9jFBCF1pjuE9JpW1eIUtlQgiJqKKw
 CNv4/Ho5Cb11zpPbRKbx+yOHMqqskTVLJx3JniYE9tR9HlB1zwdr1hnvgcf97/Ig3MfA
 /GvKo57NAzWzv8i6LdUp8Q7mkKD3KUAzQOOpN16UwivHNlRtUyCGi70NCGfSK4MN/a4+
 3Tua2/6q0Zz6d/RvEKMAlMImoeNGEMgapLcP9WbEClJupWhhelwtfA0gagN1Hj2/p9Bq
 dYfSekBiZ3ECP0l4NKY9yfhtYMwtpFos6guVQLZdBZNhunKkV1jNeaTY+o7o4ksIaGHk
 /RLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m9az9Yd6ZI7VspoBTA6WPj7qhcoz5+8SEqEa5r5dyV8=;
 b=toDSzbLkN5SMspnsAiIg5HE6xetUgd1o6ZiOPFyvUDJhV1niuFRR5XqE+htlSSkXn7
 pFZrH89veMdT8AcA9Mq1af5IJWz05bCUvbbASv6nLK5GfvRBT7BkMgZ03m290h6XpOBF
 GAoisLFCB4be+KbnHoMi18IPgu1STD684VdDkszX+c/vUyARq+D2pYhYjKQaT1W5jNHF
 L9ev5yJIDj4j4iPJO9xY2O3Utlz+Pk+4uzWjj4egxxujMaJssrWc2TdsespXlL08jLDU
 Tsj1wgeN3W3mF5fiyZ+UwQlEn3l2uVayMqMFjjct/+D1rOvVzPj1nPFcQ1L28yUJd/jE
 u0zg==
X-Gm-Message-State: APjAAAXjaZJOyOtECpVVQBG0DcP8LTBdDn/icPVWb9gNaEKbQHw/GYxt
 sDYQTmoaMZZTBdaUfmYtHkrD6L+me+M=
X-Google-Smtp-Source: APXvYqwSGvUcYl7iVmOqTEjO/0vFcqV9Nd1AQukZYgqJUbftvwisc4H3a+5osfU7vvWYsE/tST4UVQ==
X-Received: by 2002:a7b:c249:: with SMTP id b9mr4701603wmj.74.1581086032949;
 Fri, 07 Feb 2020 06:33:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.33.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:33:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/48] target/arm: Split out vae1_tlbmask
Date: Fri,  7 Feb 2020 14:33:02 +0000
Message-Id: <20200207143343.30322-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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

From: Richard Henderson <richard.henderson@linaro.org>

No functional change, but unify code sequences.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index dbfdf2324b4..8b3bb51dee2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3940,42 +3940,36 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
  * Page D4-1736 (DDI0487A.b)
  */
 
+static int vae1_tlbmask(CPUARMState *env)
+{
+    if (arm_is_secure_below_el3(env)) {
+        return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
+    } else {
+        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+    }
+}
+
 static void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                       uint64_t value)
 {
     CPUState *cs = env_cpu(env);
-    bool sec = arm_is_secure_below_el3(env);
+    int mask = vae1_tlbmask(env);
 
-    if (sec) {
-        tlb_flush_by_mmuidx_all_cpus_synced(cs,
-                                            ARMMMUIdxBit_S1SE1 |
-                                            ARMMMUIdxBit_S1SE0);
-    } else {
-        tlb_flush_by_mmuidx_all_cpus_synced(cs,
-                                            ARMMMUIdxBit_S12NSE1 |
-                                            ARMMMUIdxBit_S12NSE0);
-    }
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
 }
 
 static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
     CPUState *cs = env_cpu(env);
+    int mask = vae1_tlbmask(env);
 
     if (tlb_force_broadcast(env)) {
         tlbi_aa64_vmalle1is_write(env, NULL, value);
         return;
     }
 
-    if (arm_is_secure_below_el3(env)) {
-        tlb_flush_by_mmuidx(cs,
-                            ARMMMUIdxBit_S1SE1 |
-                            ARMMMUIdxBit_S1SE0);
-    } else {
-        tlb_flush_by_mmuidx(cs,
-                            ARMMMUIdxBit_S12NSE1 |
-                            ARMMMUIdxBit_S12NSE0);
-    }
+    tlb_flush_by_mmuidx(cs, mask);
 }
 
 static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.20.1


