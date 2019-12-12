Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8C2C04E30
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 998282173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="StUfQfWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998282173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifFjX-0006AK-9x
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFes-0000rD-4Y
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFen-00040s-5T
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:57 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFem-0003y9-Pa
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:52 -0500
Received: by mail-pf1-x443.google.com with SMTP id 4so26804pfz.9
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z1jFy93uFg71kyk+6R/bFVW2zASLoWb071ZQYRrnUSs=;
 b=StUfQfWwXDTEPgbVa7bDj69E9+ZdaLTlaO9Ftu8fj03nTEUiXHJSLXgNw+Qr1BYaWW
 0veFfMaLjOxrg/Woo/gj+nZqdojImRJQ9V6WpM+oCP5Cy3gqcsem8kG3+euXI2f2VYA7
 hsBkYBzMr2ps/UVi+pvxhsbgtWFzFfqAehpEGkQOfigDq56iWxDmvHI5axXI/9y4lqkE
 GGU4Ecz74vuv4ruEec0KoUKhRJTdCwZ29w6mprzFCWaSSVMlP3hr03IfG4Qzakz9eXrd
 aX/zXymXh45HU6A28y86jsx/PNuBIMCRGwBDTyM7TjA+HBEeLbLuhuaiCFSUB3oGTtJb
 MS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z1jFy93uFg71kyk+6R/bFVW2zASLoWb071ZQYRrnUSs=;
 b=V9kbc58CJr+nnbME5na/J8UtiB70Kv2qv6nkRon5aXfMvnXRRqu7fWmY89ubOg11zE
 eIRZPS/RIBppTrVSQHfCofgI2QjdiuU7r2x5p4j1slpfRGXDtktV39ZYZQMza2rSkvv4
 vUlaY/CGGJ4xcM/UiLzNeC8aNcQeEOLzrGub52+8EC0HHPavoaKR33mIzOejyIZlxq3S
 gtnFZVesuCSO1TMtBmx/tr36UobGAmfh5s+uAw6tCYWKz2+iO3ZVXuGMBt9ib/ZCZzgn
 UsYMRk5oiBLhQQ41ObvzBe+5a9ObhXqAI0ccj31nDIDuUKLBYLJ+qyeiKL0nIuMYhdn3
 BoiA==
X-Gm-Message-State: APjAAAWeQoZZKP4QDQ/xJNwHz4V61MDk4PjVaruhax8k8DlGCAKypmRu
 VI1rLxbmKmduXFDN7IdbdX6oW6FZJ10=
X-Google-Smtp-Source: APXvYqyA3eoZgKadubirkarZq4YTaHJ7KToPLLbHwHFHLc89Tx+qddHk4Aqi3AVoVQ1DrTc6Df3pmw==
X-Received: by 2002:aa7:9103:: with SMTP id 3mr7584230pfh.95.1576123251277;
 Wed, 11 Dec 2019 20:00:51 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:00:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/28] target/i386: Use cpu_*_mmuidx_ra instead of templates
Date: Wed, 11 Dec 2019 20:00:19 -0800
Message-Id: <20191212040039.26546-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212040039.26546-1-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not use exec/cpu_ldst_{,useronly_}template.h directly,
but instead use the functional interface.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/seg_helper.c | 75 ++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 25 deletions(-)

diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 87a627f9dc..b348569c30 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -37,37 +37,62 @@
 # define LOG_PCALL_STATE(cpu) do { } while (0)
 #endif
 
-#ifdef CONFIG_USER_ONLY
-#define MEMSUFFIX _kernel
-#define DATA_SIZE 1
-#include "exec/cpu_ldst_useronly_template.h"
+static inline uint32_t cpu_ldub_kernel_ra(CPUX86State *env, abi_ptr ptr,
+                                          uintptr_t ra)
+{
+    return cpu_ldub_mmuidx_ra(env, ptr, cpu_mmu_index_kernel(env), ra);
+}
 
-#define DATA_SIZE 2
-#include "exec/cpu_ldst_useronly_template.h"
+static inline uint32_t cpu_lduw_kernel_ra(CPUX86State *env, abi_ptr ptr,
+                                          uintptr_t ra)
+{
+    return cpu_lduw_mmuidx_ra(env, ptr, cpu_mmu_index_kernel(env), ra);
+}
 
-#define DATA_SIZE 4
-#include "exec/cpu_ldst_useronly_template.h"
+static inline uint32_t cpu_ldl_kernel_ra(CPUX86State *env, abi_ptr ptr,
+                                         uintptr_t ra)
+{
+    return cpu_ldl_mmuidx_ra(env, ptr, cpu_mmu_index_kernel(env), ra);
+}
 
-#define DATA_SIZE 8
-#include "exec/cpu_ldst_useronly_template.h"
-#undef MEMSUFFIX
-#else
-#define CPU_MMU_INDEX (cpu_mmu_index_kernel(env))
-#define MEMSUFFIX _kernel
-#define DATA_SIZE 1
-#include "exec/cpu_ldst_template.h"
+static inline uint64_t cpu_ldq_kernel_ra(CPUX86State *env, abi_ptr ptr,
+                                         uintptr_t ra)
+{
+    return cpu_ldq_mmuidx_ra(env, ptr, cpu_mmu_index_kernel(env), ra);
+}
 
-#define DATA_SIZE 2
-#include "exec/cpu_ldst_template.h"
+static inline void cpu_stb_kernel_ra(CPUX86State *env, target_ulong ptr,
+                                     uint32_t val, uintptr_t ra)
+{
+    cpu_stb_mmuidx_ra(env, ptr, val, cpu_mmu_index_kernel(env), ra);
+}
 
-#define DATA_SIZE 4
-#include "exec/cpu_ldst_template.h"
+static inline void cpu_stw_kernel_ra(CPUX86State *env, target_ulong ptr,
+                                     uint32_t val, uintptr_t ra)
+{
+    cpu_stw_mmuidx_ra(env, ptr, val, cpu_mmu_index_kernel(env), ra);
+}
 
-#define DATA_SIZE 8
-#include "exec/cpu_ldst_template.h"
-#undef CPU_MMU_INDEX
-#undef MEMSUFFIX
-#endif
+static inline void cpu_stl_kernel_ra(CPUX86State *env, target_ulong ptr,
+                                     uint32_t val, uintptr_t ra)
+{
+    cpu_stl_mmuidx_ra(env, ptr, val, cpu_mmu_index_kernel(env), ra);
+}
+
+static inline void cpu_stq_kernel_ra(CPUX86State *env, target_ulong ptr,
+                                     uint64_t val, uintptr_t ra)
+{
+    cpu_stq_mmuidx_ra(env, ptr, val, cpu_mmu_index_kernel(env), ra);
+}
+
+#define cpu_ldub_kernel(e, p)    cpu_ldub_kernel_ra(e, p, 0)
+#define cpu_lduw_kernel(e, p)    cpu_lduw_kernel_ra(e, p, 0)
+#define cpu_ldl_kernel(e, p)     cpu_ldl_kernel_ra(e, p, 0)
+#define cpu_ldq_kernel(e, p)     cpu_ldq_kernel_ra(e, p, 0)
+#define cpu_stb_kernel(e, p, v)  cpu_stb_kernel_ra(e, p, v, 0)
+#define cpu_stw_kernel(e, p, v)  cpu_stw_kernel_ra(e, p, v, 0)
+#define cpu_stl_kernel(e, p, v)  cpu_stl_kernel_ra(e, p, v, 0)
+#define cpu_stq_kernel(e, p, v)  cpu_stq_kernel_ra(e, p, v, 0)
 
 /* return non zero if error */
 static inline int load_segment_ra(CPUX86State *env, uint32_t *e1_ptr,
-- 
2.20.1


