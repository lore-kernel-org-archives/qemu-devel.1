Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0133EC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF04206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eiblINp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF04206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifFyE-0000kJ-VA
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFf9-00015B-SX
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFf8-0004UN-IN
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:15 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34018)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFf8-0004SH-BV
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:14 -0500
Received: by mail-pl1-x641.google.com with SMTP id x17so11569pln.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LUeojZYde3/VPw2CxoZItM1wJDRbu9EUvabmt44460c=;
 b=eiblINp2VMI3MQxaYSnI2FBOhKZFOnvn+VkzoxYpz/Nl4SlibWU3HBih2G6tNva4Vf
 wRC2BkJXqBCPOKMRgWC1AU+MevuT9+cgTDHdzYHR5bM4YhwUnwlCxLeLD+JH4Rvj6BSd
 cCJV2NbVOBkdpCFQt+TvPNdTb02JmP2d4XhToaBfjsJeiaBiMChwFQ18dx/etimCPs1B
 dwnDuGrnthmSAn61PpUuV9xb4rqUOn0BG/MqXezipE1GkBic7+7gzVcWX/LI+1cf2/9I
 qykamI4WQmVbMdMMRXsGjOPdX0gYyfpkurhtelbL0x3I5Gna23Peusrur1+6xG3i4DXY
 pZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LUeojZYde3/VPw2CxoZItM1wJDRbu9EUvabmt44460c=;
 b=CUWXKQXV75DBpg0eTSgBddlZ4adagNfuIUtftoPcwu44RuBcWMiFtHl8fHwX/kUh4J
 STafwuJQ8praJWJ9XkEW4B7ZOe7gTFhzKCOj5ygp1LdcNfQAnAZd4m0FdsX4t9x1ak58
 uhPvt1G5EOZedc7bGPQmUiurgLIAac3JvQZ3s5e+KgPTqU8oCRsQlfHJgUUAeCme/cWq
 8OWjpPPGO6JP6rmyoay0dj2RRNMkjWvTac0lu/ELklSklvsZcrbGvBQHyMMbb85AHney
 AKZ5pQwn54JnPbjH8O4HWz+TwRxu1AtUtyaMVEJBa4ULQnDAdE+anqsbc12w4HfweDwV
 +yFg==
X-Gm-Message-State: APjAAAUHizsT2TzPITBx8UdsIEiGU185/mAQzW+YfFJ7PedMyUuHMflT
 k0zKRKS2gvvL82ckR7HF/BfZVG0kayg=
X-Google-Smtp-Source: APXvYqyCITezLurnr52VrmWBIDqt6GRIzS1WHSZ0sA87c0nqV1ATXrsMOjg2zFTLYacOnWqPt7oDpw==
X-Received: by 2002:a17:902:8608:: with SMTP id
 f8mr7383736plo.106.1576123273028; 
 Wed, 11 Dec 2019 20:01:13 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:01:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/28] target/s390x: Use cpu_*_mmuidx_ra instead of
 MMU_MODE*_SUFFIX
Date: Wed, 11 Dec 2019 20:00:36 -0800
Message-Id: <20191212040039.26546-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212040039.26546-1-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The generated functions aside from *_real are unused.
The *_real functions have a couple of users in mem_helper.c;
use *_mmuidx_ra instead, with MMU_REAL_IDX.

Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.h        | 5 -----
 target/s390x/mem_helper.c | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 17460ed7b3..2670728e8a 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -36,11 +36,6 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 2
 
-#define MMU_MODE0_SUFFIX _primary
-#define MMU_MODE1_SUFFIX _secondary
-#define MMU_MODE2_SUFFIX _home
-#define MMU_MODE3_SUFFIX _real
-
 #define MMU_USER_IDX 0
 
 #define S390_MAX_CPUS 248
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 57ce17c252..d379be8418 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -43,6 +43,11 @@
 #define HELPER_LOG(x...)
 #endif
 
+#define cpu_ldl_real_ra(e, p, r)    cpu_ldl_mmuidx_ra(e, p, MMU_REAL_IDX, r)
+#define cpu_ldq_real_ra(e, p, r)    cpu_ldq_mmuidx_ra(e, p, MMU_REAL_IDX, r)
+#define cpu_stl_real_ra(e, p, v, r) cpu_stl_mmuidx_ra(e, p, v, MMU_REAL_IDX, r)
+#define cpu_stq_real_ra(e, p, v, r) cpu_stq_mmuidx_ra(e, p, v, MMU_REAL_IDX, r)
+
 static inline bool psw_key_valid(CPUS390XState *env, uint8_t psw_key)
 {
     uint16_t pkm = env->cregs[3] >> 16;
-- 
2.20.1


