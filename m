Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF3BECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 19:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3AF22089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 19:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYDYv4z5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AF22089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLB4o-0006ln-Gr
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 15:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLArs-0001C4-N7
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLArq-0000sX-Vx
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:24 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38366)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLArq-0000s7-PM
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:22 -0400
Received: by mail-pf1-x441.google.com with SMTP id h195so2215787pfe.5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 11:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IBA+abtZ26hlRDDlZ8eTB3Pn4yNYwZChmFB+u2JQGOM=;
 b=DYDYv4z5rYOHKgP6fl/oD3gy6IBcwlCqU6Lzlv3YGFO/8SgQx3joZpGJThFmfmg0zW
 OkKJlj2e1FzwP+0oSvb4zOC9V3kEUMaQ85rUx/HNCgjsaQ/Y6yDYxzDF4rBhb8lvgsuJ
 DHR3tIaDWRfRCeUNirUziKF7BcSO5GsHFOenZeZYdByCKSvRZs7yjlsVcmkRRwRrOelP
 kWv2KfQj81uoYjaABTZd59k7DvZ0FwXRCTflLI7grg0vr3Xng4IFSv6BpgRkinPpT3KT
 k3YhgAN1i6OdqKwNrkiX3ONQbaJnXfaxJGUe2DY0K9wggeKOx85bGRZfHRmazbhYY0Fl
 tGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IBA+abtZ26hlRDDlZ8eTB3Pn4yNYwZChmFB+u2JQGOM=;
 b=O/Imc6nBgL0Q0fL0LDF8RS2hZ6EuI+m9erXi9/ILflrNIsXdXsbIdL7S6BbMUfbK3S
 jXw5THa8Dpxx/DLXD17OaiuXkUD+AxXbU4NFIhU3EQIPkJH7N++GaRybHzK7cX9cTq4W
 sBhMfInCphTC/Fj8uEjbZNL/K6MyWWuq0ZITAa7XcfZJWi4oPubUi8CIKMriIFrout5p
 h5OGbw2iiS/ojOVr3DVKjHusakO0PD+tntqjglcosksMf+3c0D3TlVM4NdZRuE9se6Ul
 JFoT1whu7MSfRMiynhPstrIPNCO4QENFwHatX5w09+cUJTrAhAn8AubOFNwtY9NC4Hye
 3eOw==
X-Gm-Message-State: APjAAAW1AhdlE6y6lrFvCrjT0WkZbz05GUw7r7Aiz77ka/J+OEuaVTuS
 T+evUbe17RVTWgmAD6RzhSkUjxrz4b0=
X-Google-Smtp-Source: APXvYqyVwWYfM2o9N7W3q5VNlxHpSt3mWSSauKW8wsSRDebW/2xSrQFLSUmQkFbnkoQMa5JBUn+gGw==
X-Received: by 2002:a63:cf4d:: with SMTP id b13mr5600676pgj.396.1571338281342; 
 Thu, 17 Oct 2019 11:51:21 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s97sm5009256pjc.4.2019.10.17.11.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 11:51:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 07/20] target/arm: Split out rebuild_hflags_a32
Date: Thu, 17 Oct 2019 11:50:57 -0700
Message-Id: <20191017185110.539-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017185110.539-1-richard.henderson@linaro.org>
References: <20191017185110.539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently a trivial wrapper for rebuild_hflags_common_32.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 296a4b2232..d1cd54cc93 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11106,6 +11106,12 @@ static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
+static uint32_t rebuild_hflags_a32(CPUARMState *env, int fp_el,
+                                   ARMMMUIdx mmu_idx)
+{
+    return rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+}
+
 static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
@@ -11218,7 +11224,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                 flags = FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
             }
         } else {
-            flags = rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+            flags = rebuild_hflags_a32(env, fp_el, mmu_idx);
         }
 
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
-- 
2.17.1


