Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94943C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 06:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 600082146E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 06:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BxZybswZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600082146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzEsP-0006XU-45
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 02:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzErH-00056m-Dt
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 02:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzErG-0000l6-D7
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 02:40:07 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35168)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzErG-0000kj-7A
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 02:40:06 -0400
Received: by mail-wr1-x443.google.com with SMTP id k2so5419293wrq.2
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2019 23:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FYIOkeCFDs+BgfZApqGQTYKi9ofiCzdQQpabShx+clA=;
 b=BxZybswZd7mlu+zDCl5EE89cpB9LSXMOaG1bQ9ORBc/RUuO4kufMVcGrJq1K5jYFnz
 XAGVT6NFoIp1yASZaG5MGtdTK2bKh0BbogAC2vkDnX7xuRHosUOJ0NIypSm5stslzAK/
 A5UsOJl1JeTiStn9qdHGVzwV3wcDYt+CfpxbKc4UPV45IPExGZ4auhe8Sc32UnCkDEkX
 wo3tNxrTFI4b4HoBW4WqCjI55n+EmJhAcS5+8Tg04JCsu/CnG3a9/W1jyhy51vbgV/ru
 7rTqTybEHzi1T/cMMfY+xnsq4ed+J2u6mNDtBcMUbKyvAXlf4+P4Exe2PZYbCCY6CmBg
 JgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FYIOkeCFDs+BgfZApqGQTYKi9ofiCzdQQpabShx+clA=;
 b=Ul/cNb5OL2FFR2IfHczTlVhWZ9CdJ5kPjwbJ1ELNfibTfCVG9Ue0H1UEYQQfpRRhOS
 nMUS9Q8zUPb63+tmXd3nixBTFqPBtKhur8I34S96SY9qFGpvYdUs/RhNTGuLLGludaE5
 lRxlEsDGmJLOyWZ0BZOGjusFjKlHyWPSlYvJe988QkuKtW1oyrSaqwQJ2gpQeEEUklW+
 8NI1A87v6Madfl7GJIuaVv+7SEs2THSAZvaMhZ0gyVyyY5W3vX4kGsEWclZ9NSDPB/PR
 5Y+9zrdIWk+0v/rLp4qBjT6N25OkU65TndrkUogpnWvgDTc297+V4TxGG0ocQ/5Hibi7
 qeug==
X-Gm-Message-State: APjAAAUXms8aobn2/CuLkFlwXlCUuEvWT/PtUuKMODNXOtOkV4a+JHr/
 q0fchHpYDwkXDMzFcb/iP8scUOwyHck=
X-Google-Smtp-Source: APXvYqxG2/BKSQ3Pk1ejeN17VdBGxOmBAu7vSxecXXc5q9Sb6UnTkcZX+qMShCGMlv+VtNzWQ1h8NA==
X-Received: by 2002:adf:f705:: with SMTP id r5mr19188340wrp.342.1566110405026; 
 Sat, 17 Aug 2019 23:40:05 -0700 (PDT)
Received: from cloudburst.Home ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id r5sm9015435wmh.35.2019.08.17.23.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Aug 2019 23:40:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 18 Aug 2019 07:39:59 +0100
Message-Id: <20190818063959.14533-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818063959.14533-1-richard.henderson@linaro.org>
References: <20190818063959.14533-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v2 3/3] target/riscv: Remove redundant
 declaration pragmas
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are now generated by decodetree itself.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/translate.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 8d6ab73258..adeddb85f6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -708,26 +708,9 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
 #include "insn_trans/trans_rvd.inc.c"
 #include "insn_trans/trans_privileged.inc.c"
 
-/*
- * Auto-generated decoder.
- * Note that the 16-bit decoder reuses some of the trans_* functions
- * initially declared by the 32-bit decoder, which results in duplicate
- * declaration warnings.  Suppress them.
- */
-#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
-# pragma GCC diagnostic push
-# pragma GCC diagnostic ignored "-Wredundant-decls"
-# ifdef __clang__
-#  pragma GCC diagnostic ignored "-Wtypedef-redefinition"
-# endif
-#endif
-
+/* Include the auto-generated decoder for 16 bit insn */
 #include "decode_insn16.inc.c"
 
-#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
-# pragma GCC diagnostic pop
-#endif
-
 static void decode_opc(DisasContext *ctx)
 {
     /* check for compressed insn */
-- 
2.17.1


