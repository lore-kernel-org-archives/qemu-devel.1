Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D12C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21A4206EC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LuPL37ZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21A4206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiHFy-0007QQ-Ho
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:19:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiH1a-0004k6-G9
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiH1Z-0007nz-2H
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:04:54 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiH1Y-0007k4-Hg
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:04:52 -0500
Received: by mail-wm1-x342.google.com with SMTP id d73so8695432wmd.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 04:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yP04C6ThOAXjLefYFBP1Rp4bmt2cBEv6NwVmKqtKkDw=;
 b=LuPL37ZAkEEmEi+yqJ9WADzmqnLZrz+RJ1ojuwkeqTFWjZWglfHrlUo+yK37mRjyZ0
 uHIir3/Jqn78UzcjUndn5Dw4i4rDuovNnUx/XgHE6FGoCZEqX3Arh6JLtcbTr5tmFQG5
 SKAj2i6eGnLxfltMBbkJF4Vnboz5XMFC5EyBKkorUm016VRyd2n5d1Z+Kx9HSGZjoJId
 WolhnPylDDM/imY+lIo2y/AAJKdfo+TwTDgKBEFZy4rEFNEpXDwRjmq+zrnaZSMMvag0
 lP14JfWmS/CWyFwt0nZwkPI9vPzT81ub4r78E2S7+TR0TIkqU4gK+JzJlf65b2kZXCE6
 Qsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yP04C6ThOAXjLefYFBP1Rp4bmt2cBEv6NwVmKqtKkDw=;
 b=hR+iXuwuK/gQQe5lleWcy+Vcfp+NbSNk6fE93K7MJquOOdgVCzPyIWEAayw/zgNqqY
 DkWAPO2uC78V/+PxEu75IS/XAzx1Q/SbRQsN+2pZ6OKF2Su0b89HIm4Qi1w7VsqVUE2t
 rYrtydCHDj01LJ0Anlgp38dp59OCvhIAijsTAUqYzhlxX2bMKwsJWBoposZSMkOw221k
 vsIIalmZuHvOFcBF/DhnbLvqZMnQGfNGiH5TGdMoqatfKIM5yeQ5NjpL7RVxwt2SHMDi
 7e+pq3iKdHbRmDSeK9D8CNAeYpFRxraNJ8lvZo21Dk+vIR41y6wCs2zldwF5OIW6RRNh
 0LhQ==
X-Gm-Message-State: APjAAAXzI6afax/JQvPq0YFmRf5ffBJXrp7wdLJQ6nvj86k34cWb7YHN
 oT2qpXc3qNpTwW2sBeDGKo3VNpLakjk=
X-Google-Smtp-Source: APXvYqyvumcnFZnL/JzZ9GcYtuAspnT5f62Y+tBwsLNxOJYXcjvMrNznje1K7Sso/vTenmXWRmlVrA==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr15629231wmg.147.1576843491069; 
 Fri, 20 Dec 2019 04:04:51 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m7sm9462105wrr.40.2019.12.20.04.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 04:04:46 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6B5541FF93;
 Fri, 20 Dec 2019 12:04:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v4 06/21] target/arm: use gdb_get_reg helpers
Date: Fri, 20 Dec 2019 12:04:23 +0000
Message-Id: <20191220120438.16114-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220120438.16114-1-alex.bennee@linaro.org>
References: <20191220120438.16114-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
index 5074b5f69ca..6f3b6ca7d3f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -105,21 +105,17 @@ static int aarch64_fpu_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
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


