Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8C7C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659EF206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DwQ7cjEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659EF206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi7qH-00075p-Ka
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 21:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60156)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4em-0001Ue-5V
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4ek-0005MP-Cf
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:20:16 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:37001)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi4ei-0005Hf-JU
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:20:13 -0400
Received: by mail-wm1-f53.google.com with SMTP id f17so1129183wme.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 15:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=yx5elbyAko/ok2mgqRgnOYZgmbIkaCHz6sv2gkqMUnQ=;
 b=DwQ7cjEvuwHzPLz1S92z+87NLUwZx1ditwsqjHRgP6HcTU0dP1YdTc0t2ECKQyE2i+
 auFdO4j8TEtHAvBdBGk8qldaxCNsX15/2fPCzRL3rAn5aPWFhTp4RzPEpWu06266ArMs
 9LJFq1h1pxZ6+NE/Tm/apm32iS5tWg1OqEYllUp7iW4QDFrV8CsGf6+h/nWUXIVaVlvz
 cP0Zt8wsKvHM4ZBUoqZJ0SjXMxHtfplAuvmHc2BJKKPaWeeQee6j7IqJUonSphX6ETXg
 PjoTnHRq9iwa2/11SyeRmmYfLEEJF1BL43YTs7tNkvNLIBeX4UzqbDm2ebpdB4CVdQzO
 Rmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yx5elbyAko/ok2mgqRgnOYZgmbIkaCHz6sv2gkqMUnQ=;
 b=CTSwKdaZOhJV5u7x+aEZ46ijCt5Ub7f+ZSUmKQ2bOK43hq2FbGb/IUTrtBdZm5ahrn
 +EbOAhgbrx9YiFihfMLOeM7g2CNvAUFhCSdow+iwdTXXszvHSLP4BiRGiMHQIUhL52An
 KpUnJBaUCJlEYyCfnrNQ9dr/YzUVeTY4Uou0Rw1V0mgbWIQ6IUW0G2L7I1IehT1/kE2P
 cXLcPoVUq5LngJEwdcBbviPXLD4DrIYhvsIZ3V+rXVsgfu3it7Ly5keq9wnCtwEsqm3a
 LSi/ZW9ceuGidPEScPoFKY+gVC6TszH9XtAuvzgy5EbM331L/JcytjMVGAJGR6wAx/w+
 MKHg==
X-Gm-Message-State: APjAAAVNRwyhpMvVGA06N91WpVzyoKSTcdNDMfzazv40PrpyXjrIokU7
 Ag2EuFi1S8pufhxl7hcRl9Lf5SGMFZkrtg==
X-Google-Smtp-Source: APXvYqww1E6PINnRZDFmi0gd2QADyGUzZ3omjPmQUnKNtWvws9nNE+UXHnrxl8pibeDGqmlrfAqkEQ==
X-Received: by 2002:a1c:1a06:: with SMTP id a6mr130999wma.128.1561999233407;
 Mon, 01 Jul 2019 09:40:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:40 +0100
Message-Id: <20190701163943.22313-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.53
Subject: [Qemu-devel] [PULL 43/46] target/arm/vfp_helper: Restrict the
 SoftFloat use to TCG
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This code is specific to the SoftFloat floating-point
implementation, which is only used by TCG.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190701132516.26392-18-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp_helper.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 838f7d25fd1..46041e32949 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -18,17 +18,20 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/log.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "fpu/softfloat.h"
 #include "internals.h"
-
+#ifdef CONFIG_TCG
+#include "qemu/log.h"
+#include "fpu/softfloat.h"
+#endif
 
 /* VFP support.  We follow the convention used for VFP instructions:
    Single precision routines have a "s" suffix, double precision a
    "d" suffix.  */
 
+#ifdef CONFIG_TCG
+
 /* Convert host exception flags to vfp form.  */
 static inline int vfp_exceptbits_from_host(int host_bits)
 {
@@ -145,6 +148,19 @@ static void vfp_set_fpscr_to_host(CPUARMState *env, uint32_t val)
     set_float_exception_flags(0, &env->vfp.standard_fp_status);
 }
 
+#else
+
+static uint32_t vfp_get_fpscr_from_host(CPUARMState *env)
+{
+    return 0;
+}
+
+static void vfp_set_fpscr_to_host(CPUARMState *env, uint32_t val)
+{
+}
+
+#endif
+
 uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
 {
     uint32_t i, fpscr;
@@ -210,6 +226,8 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val)
     HELPER(vfp_set_fpscr)(env, val);
 }
 
+#ifdef CONFIG_TCG
+
 #define VFP_HELPER(name, p) HELPER(glue(glue(vfp_,name),p))
 
 #define VFP_BINOP(name) \
@@ -1303,3 +1321,5 @@ float64 HELPER(frint64_d)(float64 f, void *fpst)
 {
     return frint_d(f, fpst, 64);
 }
+
+#endif
-- 
2.20.1


