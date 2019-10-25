Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B1BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B0B21D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K9A1+p0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B0B21D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNthR-0002TM-Gf
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN2-000865-UN
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtMz-0003Cd-UE
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:47 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:35168)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtMu-00039s-3I
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:40 -0400
Received: by mail-wr1-x432.google.com with SMTP id l10so956585wrb.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=08b51CcPx/wlpoxLjc9OfnTHhyd7AMd9x8LJx1IeIRE=;
 b=K9A1+p0i9YS+hvxKJC4p1zE04JMb1tk6wQS00P44kiYyIu2unx2ZhDXMtjLlzwz49J
 DrhyHBB4QRea+eLoY0tMLj+0KhfYj/AMqgkIP9CTgk2BvHGogi1iDkag23HKB/iWhAl1
 Nw2OPpEbBg/Nlnbt+2YiUU4Fzv1LXW4wjQm1nbzH87b5Yy4U7M7kv71UrmF+VDCTOesj
 59cde4UZHVLzD7sSUNSW9R+h6wnxjZZRlWjBgBps4Fm9f2T0SPAEdrUh9lA79n3ffr1r
 rcK1H+hFFMDBF0ZqlF5TCM/ST3FEba37WyHjzGk4q2Nw7Y1ul6mk9OxFjFSUfbDL5IUz
 jPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=08b51CcPx/wlpoxLjc9OfnTHhyd7AMd9x8LJx1IeIRE=;
 b=Vx5UB9K3E6Gn+2mQaTFPUVRP7SyJ9P9ncJu7xTRNIlEnxgP9SDwigPPWvVyMX/hDXY
 LU3RAACOMEhOL1vkXtMx7Hy76AYw1p19dnl5OnHtAhEaj5olkV9VmBUuxM5UaoRZRUDF
 XiaNUKNyoRvd+zRs2mKlNePImi82gnh2vJzS0vc8dgJ/m8zjSunG/VfquvwDa8cbPyGe
 4+jOIFr8f/5K/U25W+22o3JRrBvvnhnpM1CcD4b4TIwaE+wVsfhWJM4Lii5uHVsyosWZ
 bCseGG5p/09MsHEW5EvAILwM5GvP5DmuKMQw+TKGbVnYL6PqHpDkqZX983kesp2YVfLA
 kYqA==
X-Gm-Message-State: APjAAAVjs8zt7Vvoe9w8yMlD6glq9G652vhNVnoqRk2WdM5ZEoH5TmWT
 HLTINyfitOhwwwoZp9Mi0Ke05g==
X-Google-Smtp-Source: APXvYqzZhEs7FEN+yksuZrr3E5uVJjL6xw9evmEOcH8+Q1tapHkDyfom0Z8zwa+JtfvvtHFNFZzdPQ==
X-Received: by 2002:a05:6000:350:: with SMTP id
 e16mr1398583wre.276.1571985997845; 
 Thu, 24 Oct 2019 23:46:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c144sm1201199wmd.1.2019.10.24.23.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:46:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 571831FFC9;
 Fri, 25 Oct 2019 07:37:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 49/73] target/xtensa: fetch code with translator_ld
Date: Fri, 25 Oct 2019 07:36:49 +0100
Message-Id: <20191025063713.23374-50-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index d20e60ce770..a99f5296e2f 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -859,7 +859,7 @@ static int arg_copy_compare(const void *a, const void *b)
 static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
 {
     xtensa_isa isa = dc->config->isa;
-    unsigned char b[MAX_INSN_LENGTH] = {cpu_ldub_code(env, dc->pc)};
+    unsigned char b[MAX_INSN_LENGTH] = {translator_ldub(env, dc->pc)};
     unsigned len = xtensa_op0_insn_len(dc, b[0]);
     xtensa_format fmt;
     int slot, slots;
@@ -883,7 +883,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
 
     dc->base.pc_next = dc->pc + len;
     for (i = 1; i < len; ++i) {
-        b[i] = cpu_ldub_code(env, dc->pc + i);
+        b[i] = translator_ldub(env, dc->pc + i);
     }
     xtensa_insnbuf_from_chars(isa, dc->insnbuf, b, len);
     fmt = xtensa_format_decode(isa, dc->insnbuf);
-- 
2.20.1


