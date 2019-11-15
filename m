Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A0BC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 13:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A6C2073C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 13:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wSNtJbnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A6C2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVbV2-0002QM-7D
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 08:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iVbSp-00012g-GW
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:16:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iVbSo-0005zo-Cz
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:16:39 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33228)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iVbSo-0005zK-5s
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:16:38 -0500
Received: by mail-wr1-x442.google.com with SMTP id w9so10980264wrr.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 05:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=WmaVPbNi6CliSLCCEE8VXm/BApKdLtRR80zrwM4EczY=;
 b=wSNtJbnP5y+kdFHZzlg/YZahh4/GRPg+ya9Kctr3GR2UISNCjBXKW2wRUJfluu/n7Q
 K1EvNFwHdqZKk0tRzx2b4BYULzKlhr41gV9MBZadbzkLMeq7qSnVMV1EIQJtp8rnfake
 FCNd15R0bO6gk87Vb9IvW1lvpzPND6HO5DA5wveNUTevvnd+xY6w6qVKh9GJvCZKFiTh
 j7p8dQG2QHB0HXRTvgtUK2PaXVWcz7mSWeQ177O+P5RgA0gvMJieDMppRp8Z29HjTokV
 2HPDTqg13HkaRjyjee9d7aQSay3D477+A34USrpN013OXVVQLApHUMXGp5KNq+zOTHYE
 rDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=WmaVPbNi6CliSLCCEE8VXm/BApKdLtRR80zrwM4EczY=;
 b=TNp5T5yPAb+3RjDJ++DKnDINLrlmn+hKTSk4rtNXpW2vKzhdkQy3WiBES/LRMP8NyP
 I0AUECY3I5ieUbB6FLjpeX+GPpQpsN1FhnB6UQZuwaU7sGeEeS+4MCUaaqOD+YPO7IAx
 WdQI1v61ZPLkSY5dDBhaJPxZhToIQ8l19gL8IoEgUISJJI5JhB60NJ279U5w8e7akOpX
 aS7K3Q4IWIHuAx0nmXQdIt9mCNerUNP3IQTbaK1RrD51Zwm8uCZDbHv7KWRzExs0crG1
 nnNE6XxGlPS9hOLcVXjh6v/RCpZx6BAO7WbSpeujQSs+FembEgG84M95Ea7f8OleBE3z
 dT2A==
X-Gm-Message-State: APjAAAWNUKEx+0qqDfgbVK7Y9EX6euUPXtUPhmqs1Sl6ZWoLh3uhH91M
 VKKve6IsPxfXu8SGF2Ray+Co4V7ElIHAbg==
X-Google-Smtp-Source: APXvYqyrDdka+VzKbuxxjsIBMJSfhm2XyMLFDuXciHTXdMwNHaj6Uj98qvwycSM6H3Oqx+nLk2R3AA==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr14707291wru.159.1573823796432; 
 Fri, 15 Nov 2019 05:16:36 -0800 (PST)
Received: from localhost.localdomain
 (56.red-213-99-189.dynamicip.rima-tde.net. [213.99.189.56])
 by smtp.gmail.com with ESMTPSA id u26sm10012284wmj.9.2019.11.15.05.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 05:16:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Clean up arm_cpu_vq_map_next_smaller asserts
Date: Fri, 15 Nov 2019 14:16:23 +0100
Message-Id: <20191115131623.322-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.maydell@linaro.org, drjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity reports, in sve_zcr_get_valid_len,

"Subtract operation overflows on operands
arm_cpu_vq_map_next_smaller(cpu, start_vq + 1U) and 1U"

First, fix the aarch32 stub version to not return 0, but to
simply assert unreachable.  Because that nonsense return value
does exactly what Coverity reports.

Second, 1 is the minimum value that can be returned from the
aarch64 version of arm_cpu_vq_map_next_smaller, but that is
non-obvious from the set of asserts in the function.  Begin by
asserting that 2 is the minimum input, and finish by asserting
that we did in fact find a set bit in the bitmap.  Bit 0 is
always set, so we must be able to find that.

Reported-by: Coverity (CID 1407217)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h   |  4 +++-
 target/arm/cpu64.c | 11 +++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e1a66a2d1c..d89e727d7b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -190,7 +190,9 @@ uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq);
 # define ARM_MAX_VQ    1
 static inline void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp) { }
 static inline uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq)
-{ return 0; }
+{
+    g_assert_not_reached();
+}
 #endif
 
 typedef struct ARMVectorReg {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 68baf0482f..83ff8c8713 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -466,11 +466,18 @@ uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq)
      * We allow vq == ARM_MAX_VQ + 1 to be input because the caller may want
      * to find the maximum vq enabled, which may be ARM_MAX_VQ, but this
      * function always returns the next smaller than the input.
+     *
+     * Similarly, vq == 2 is the minimum input because 1 is the minimum
+     * output that makes sense.
      */
-    assert(vq && vq <= ARM_MAX_VQ + 1);
+    assert(vq >= 2 && vq <= ARM_MAX_VQ + 1);
 
     bitnum = find_last_bit(cpu->sve_vq_map, vq - 1);
-    return bitnum == vq - 1 ? 0 : bitnum + 1;
+
+    /* We always have vq == 1 present in sve_vq_map.  */
+    assert(bitnum < vq - 1);
+
+    return bitnum + 1;
 }
 
 static void cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *name,
-- 
2.17.1


