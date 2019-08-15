Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891BDC32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535C920644
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax3FMlcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535C920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5OO-0002SA-3J
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DK-00061S-JC
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DJ-0008JA-F3
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:06 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:34784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DJ-0008Ir-Av
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:05 -0400
Received: by mail-yb1-xb44.google.com with SMTP id q5so410892ybp.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cyegfqQ66vBczNAfRKb53VrlCHN8G52UPrZRGksak8s=;
 b=Ax3FMlcQ3g0lEpaB+kMd1sXkssslXecIEK/Oe99/4mQT77YFSXD7GVRRIIFWheSgfX
 Pw/A08TGyRJybPRWGQzx1KbUohOeRZlbA134gJFLa5+s81KNltYgBIgaH5vaH459aykm
 MpiFaCNXoqlKSAEaAufif7sdsGJAIXiSpRG+IhJx2w4fIBqPrnQ1DFwbyMEue3f7GtDq
 PxyywUgzHo5C7s24U5Hulj1Q/gThyIIWz221OtMkq9sK8gBCx9w1+e3pse+VYLhh/j5C
 u6LqTtaLfbytgbzf+8d92WtmnyQEE5Gpyfl4hwVxaAkT3bEXo2Wz1FwgO3R2y9Jdg+sh
 qG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cyegfqQ66vBczNAfRKb53VrlCHN8G52UPrZRGksak8s=;
 b=p8zhQnom/PbHcqiQrXMzzgjxAW4PE/KeC546C2JApf3E7eaBRwAgip+BnsmlTWnAQ2
 EeJoopqxzkusdPlR7Jwb7g9+fk+ay2bI8clV6jS4+9fYsBxmTMBYsnwKIgrUy5su2U7c
 YobSQZGjKUJiXfI5cgS5TPzm2UKQ4b9Ux9QHJFXke12jJprFb4MyUSLYD8wKRQdeVZC7
 zgo8Nrk93Cno2ZwV2AC25BgdzAa3jQ8sXtgSVGY8TlL/d9oPE0n6e5uWQ0GqMnaCN1li
 81fNiYdaOi/FE1wM06VACPFEHRGqtDy50VVwKwuhcLO/hDtCGQ/a/Pqnj0BjtPVDBm8f
 QcuQ==
X-Gm-Message-State: APjAAAXsuMdgnznzg0g6q2dFRyCcBitkYhoIEZVlzAtdeWPw6cTcm1la
 JaOfhTuZiRNfAcj9UB++2YaUzSy5
X-Google-Smtp-Source: APXvYqxdcei3XxSvO+ysY7mDmf+cycYP+OEY0v6vvLfK/C9RDhHYbwGYWDB+56lj149TXvrFQN0x1Q==
X-Received: by 2002:a25:8285:: with SMTP id r5mr1886591ybk.268.1565835004638; 
 Wed, 14 Aug 2019 19:10:04 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:03 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:08:53 -0400
Message-Id: <20190815020928.9679-12-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RFC PATCH v3 11/46] target/i386: introduce gen_(ld,
 st)d_env_A0
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similar in spirit to the already present gen_(ld,st)(q,o)_env_A0, it
will prove useful in later commits for smaller-sized vector loads.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index c5ec309fe2..258351fce3 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2652,6 +2652,18 @@ static void gen_jmp(DisasContext *s, target_ulong eip)
     gen_jmp_tb(s, eip, 0);
 }
 
+static inline void gen_ldd_env_A0(DisasContext *s, int offset)
+{
+    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0, s->mem_index, MO_LEUL);
+    tcg_gen_st_i32(s->tmp2_i32, cpu_env, offset);
+}
+
+static inline void gen_std_env_A0(DisasContext *s, int offset)
+{
+    tcg_gen_ld_i32(s->tmp2_i32, cpu_env, offset);
+    tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0, s->mem_index, MO_LEUL);
+}
+
 static inline void gen_ldq_env_A0(DisasContext *s, int offset)
 {
     tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0, s->mem_index, MO_LEQ);
-- 
2.20.1


