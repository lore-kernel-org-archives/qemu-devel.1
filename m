Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD706C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9169620679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ASD5c37H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9169620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDud9-0001lZ-NI
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRX-0000un-Rk
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRW-00012S-4y
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:23 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtRV-0000up-II
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:21 -0400
Received: by mail-wr1-x441.google.com with SMTP id s5so22318941wrg.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=52E0x1HbvIq1AGgecckQBDYD7WRAAr/qdglgq3wleWk=;
 b=ASD5c37Hp/yOpT2AMQ8G8x7ETDDTSgCgW9W9dcT7bYZSdBHHDLBEic0bcLYorgB0tM
 jGT31fT9VMqBfTFQ4kk/6mXERJc5swGAsqFZVnniyCJP7AyLbzqQ4fWItCaSfG9s1HQk
 8yg50aD5Ui5UPR7GsxkdJ4CYhcgoLy/foE4Gs/OltB8dzzXz7JJj5TQOQYkjgFaZA9z5
 k9wIq3AT9G0hfo6zd4WmSHFP+vKa8J8AsubpgFD/Gvgmbx8IPvAPIhSBAR90wnEfvCVr
 rEmzDK3lD+EqYbW00BfGx3VVED5KqWv1mn2FMpfmmTl+wgW6pXPD4qxMBl3y0gGPFg/i
 K7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=52E0x1HbvIq1AGgecckQBDYD7WRAAr/qdglgq3wleWk=;
 b=SgGvoFmd0qSmyd3GIotBn+MmLF4pJBWHETLAU0XN3MhCuETQ5dEMJynI3SY/kR70Ll
 7ZPH2Hj8XYb6FOJo0/p6B4C2pT+VT1/U/qhOD9fl2caUHzSgGOIyuB4h5vfveZkLeR6r
 QdHCpMw0kupktL+QtIItbLav/Hg9tGevgAjJyTPpc2gV/kqpHYQe0jer4/iJ4ILtJdou
 apa08JLvn3M//XFYTcGhbocVqNuMKJUEZkIcxO0uNPSVJqUXHA+LonK0aGak3pck97Df
 tv35JknAhAFahIZdgyQlakWqtE60ICehi3CpkBv54xsSVzz1Pva6cM28XFtukkySYLsh
 KCrQ==
X-Gm-Message-State: ANhLgQ19/L9aG5i8A/1/q5AxRhLUpCXkSA0wIk4mGMRryVTslOB18iFw
 qjzF1G9l9abyrEkBfPhDOk/dug==
X-Google-Smtp-Source: ADFU+vsXYlOPAvvYhX10BRcGGDmhSdyN/NQH01aDX1wJvplH3Pjvrl5RuGZg9SXwsNkaTr7JjjXQXw==
X-Received: by 2002:adf:f688:: with SMTP id v8mr405847wrp.344.1584379337878;
 Mon, 16 Mar 2020 10:22:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l64sm463140wmf.30.2020.03.16.10.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:22:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 265BA1FF9A;
 Mon, 16 Mar 2020 17:21:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 11/28] target/arm: use gdb_get_reg helpers
Date: Mon, 16 Mar 2020 17:21:38 +0000
Message-Id: <20200316172155.971-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316172155.971-1-alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is cleaner than poking memory directly and will make later
clean-ups easier.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - make sure we pass hi/lo correctly as quads are stored in LE order
---
 target/arm/helper.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b61ee73d18a..69104fb351d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -106,21 +106,17 @@ static int aarch64_fpu_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
 {
     switch (reg) {
     case 0 ... 31:
-        /* 128 bit FP register */
-        {
-            uint64_t *q = aa64_vfp_qreg(env, reg);
-            stq_le_p(buf, q[0]);
-            stq_le_p(buf + 8, q[1]);
-            return 16;
-        }
+    {
+        /* 128 bit FP register - quads are in LE order */
+        uint64_t *q = aa64_vfp_qreg(env, reg);
+        return gdb_get_reg128(buf, q[1], q[0]);
+    }
     case 32:
         /* FPSR */
-        stl_p(buf, vfp_get_fpsr(env));
-        return 4;
+        return gdb_get_reg32(buf, vfp_get_fpsr(env));
     case 33:
         /* FPCR */
-        stl_p(buf, vfp_get_fpcr(env));
-        return 4;
+        return gdb_get_reg32(buf,vfp_get_fpcr(env));
     default:
         return 0;
     }
-- 
2.20.1


