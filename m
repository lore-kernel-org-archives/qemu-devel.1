Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5962BC33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26DA5222C4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L6rp5JeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DA5222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irNs4-0008KD-Ie
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irNpT-0004zb-QQ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irNpS-0007Nl-ED
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:03 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36917)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irNpS-0007MC-7p
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:02 -0500
Received: by mail-wm1-x344.google.com with SMTP id f129so14148376wmf.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 07:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3umaeyZGHx38fKYCe2E4NwESx7BhJFAQKAKH5fWHUFE=;
 b=L6rp5JeHaHqlnOc0DFbB5B8hrC9ItnQzDvtijqazK7vSj5Nh8oiMEiLui4SV7hrwjt
 jEc4tMzlVkqjGrWWVnteEokkuJ9VeNOxCjjsKBnQSlZirWgbFvELVJHJrmK8Lcxw6JHe
 GlyWw1k4XKx+ELdbtQjVS6GIyPmDTN7BnLgR9DEZRC/D96iE5a8eDKdnsYejWLjGhCBu
 5J8QwNpJyfbUbVGHl2X4NE0JBddqJrMdk4+rFuzkvTKNsk+JIBFFgF4NpyOfTE8Vsu3F
 F+W7yHr2+AAwaQw4MBWdmwv51FW8AQfteqGE1zS5j7ZSG2GQ+AX4UkiA91E8gIisZqQu
 aO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3umaeyZGHx38fKYCe2E4NwESx7BhJFAQKAKH5fWHUFE=;
 b=FPpJugz7ESTDo0X5gNcUBn1QyQsBpD2QhajQbUctNugH11ODZF0ZM7SqWSIWKUSWJL
 +qj+fnYMpn6aDc9b3F0C88WrtcnS+RJUs0L3xezDQ8AMoBFHwQjZX7nfDjQcQDywyF2K
 J5jmkyTxbNNZZdPgf6sBCurNge6bk90ihUus7Ux0h+7pwT61n1xQiKUNYCdX0+wswAGn
 wrPuqqkyB6bebGGHbpZvjy8Ju6eH9tM2zxBgDX8lNXGq6CX1bNjofWkxpAAp/QKFMAsB
 S1rvZmKnySLojQ95CsK6ZLGWBghArhjnuJshxJQBx0/kd21XjUxE2vnAEAnq2pQq6wvb
 p+/g==
X-Gm-Message-State: APjAAAUrQefD8bhs3/QJ3omDprYgrMAc2tlk3beJikNmqqubRz3TbsiF
 yzfFxabYkFl2Uu2OpSvWGWKybg==
X-Google-Smtp-Source: APXvYqw8OyjzySR2cvCD+XSKgbesS5nZDahgJbvoqPbg0u3TQMyI/Q/nxDBWf+wFFGKp4aHF8SGCPA==
X-Received: by 2002:a05:600c:20f:: with SMTP id
 15mr27870690wmi.128.1579014601282; 
 Tue, 14 Jan 2020 07:10:01 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q3sm18155025wmj.38.2020.01.14.07.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 07:09:57 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 89F751FF93;
 Tue, 14 Jan 2020 15:09:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 06/22] target/arm: use gdb_get_reg helpers
Date: Tue, 14 Jan 2020 15:09:37 +0000
Message-Id: <20200114150953.27659-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114150953.27659-1-alex.bennee@linaro.org>
References: <20200114150953.27659-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
index 19a57a17da..b417b33cd3 100644
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


