Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C953FC433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1B7207D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="adByaDUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1B7207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD93t-0002vw-Uo
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 12:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD91g-0007Eq-QQ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:20:52 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD91f-0006ro-12
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:20:52 -0400
Received: by mail-wr1-x441.google.com with SMTP id j2so2213870wrx.7
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 09:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ReY/1n/ie6ZAtVbti6DfhgYHV+yHFNXl8nsuTTpy/mc=;
 b=adByaDUyDtVOLywiiEFsODHpvSzhmtxF/2bDQZvjuketfYh1Parrf2p5hD9yQhuKhc
 D7nB6hY/p79E2xjWp4ODtLjkUYj1JqFym2C9CMybDiajF+azQW8mEcQtHiXz3iTjbJXz
 sHZJ2EN4H/q6HLzk10hjtMBbXJ7I/NeFZS1OY9qmamLmJcHGlx4UR/RylRYJ05Hl/NtE
 rjkrLNfqVeO54i6f/PZGl384YVamv49N8EqQDJ5uUkwGDeCmjPg+qQGuCHB6U1qBjJC3
 AAIUAY2/cIyaMkF+hhuAB5KTNSEcKFIXOqL378oXhSutiY1yDDQcSVQ2tgHvvmwboknc
 qA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ReY/1n/ie6ZAtVbti6DfhgYHV+yHFNXl8nsuTTpy/mc=;
 b=iubsskEJl8j5TvxMNGRXsT0WPG0i7IMSboHcMkSqN0+TaU3f0oF0JelshKHpewxulK
 M+VBp7MNSTtKmXlNF/SYSRhoqspD353KuHBjIa+dnnSx3+leA0fXXjJ4LIKlXv02ZNHn
 US3Ntrn1vM1eV0Xfmg/5e/dFEIcB7Lj35Geu0MTRYfsBNzwcP6fIq9YCNwwzb4WDLn0W
 NHTHJqxo8SqZIqaRMyqikrksudjo8tWdui3UesAp+QgtGJ2bzDdnjP1sAOY8B/7LI+v+
 Ph15KUbrMeZIm4u6Wx397v50KRH+QoqpzE5p1NzRAw7j4h+Bg2h5wAfWrd6U/j9MytVP
 B0lQ==
X-Gm-Message-State: AOAM5317X+KJcw0yHY+nmV+mb5RlM0mIudI4j4P7QWwgtxlLe0XcljbB
 N2xctNngQ2F3EFAP9AeWlWF6Pw==
X-Google-Smtp-Source: ABdhPJwCfOsaFzrv2Knov8p1mVUoCOrr+bNEO7w9W8cQJRhcfIy3KsCHAb2Do03bR02MhSaAGRJWIQ==
X-Received: by 2002:adf:fec7:: with SMTP id q7mr2673792wrs.293.1598977249555; 
 Tue, 01 Sep 2020 09:20:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c10sm3145097wrn.24.2020.09.01.09.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 09:20:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] arm.risu: Correct VLDR/VSTR U=0 patterns
Date: Tue,  1 Sep 2020 17:20:45 +0100
Message-Id: <20200901162046.32670-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901162046.32670-1-peter.maydell@linaro.org>
References: <20200901162046.32670-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Correct the VLDR and VSTR patterns, which claimed to be setting U=0
but in fact left it identical to the U=1 pattern due to a
cut-and-paste error.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Somehow the pre-generated test binaries I have from Alex have
U=0 insns in them -- I suspect this got fixed locally but never
made it upstream ?
---
 arm.risu | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arm.risu b/arm.risu
index f8b6deb..43a72ae 100644
--- a/arm.risu
+++ b/arm.risu
@@ -757,7 +757,7 @@ VLDM A1c cond:4 110 p u d 1 1 rn:4 vd:4 101 x imm:8 !constraints { $p == $u; }
 VSTR A1a cond:4 1101 1 d 00 rn:4 vd:4 101 x imm:8 \
  !memory { reg_plus_imm($rn, $imm * 4); }
 # both A1 and A2 encodings, U = 0
-VSTR A1b cond:4 1101 1 d 00 rn:4 vd:4 101 x imm:8 \
+VSTR A1b cond:4 1101 0 d 00 rn:4 vd:4 101 x imm:8 \
  !memory { reg_minus_imm($rn, $imm * 4); }
 
 # VLDR
@@ -765,7 +765,7 @@ VSTR A1b cond:4 1101 1 d 00 rn:4 vd:4 101 x imm:8 \
 VLDR A1a cond:4 1101 1 d 01 rn:4 vd:4 101 x imm:8 \
  !memory { reg_plus_imm($rn, $imm * 4); }
 # both A1 and A2 encodings, U = 0
-VLDR A1b cond:4 1101 1 d 01 rn:4 vd:4 101 x imm:8 \
+VLDR A1b cond:4 1101 0 d 01 rn:4 vd:4 101 x imm:8 \
  !memory { reg_minus_imm($rn, $imm * 4); }
 
 ########### Extension register transfer ###################
-- 
2.20.1


