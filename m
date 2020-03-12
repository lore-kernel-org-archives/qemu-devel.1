Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854DEC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:00:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5173D205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XIfuiFZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5173D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCU0C-00025L-EP
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 16:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjf-0006o7-C0
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTje-0002PR-B7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:15 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTje-0002OJ-5u
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:14 -0400
Received: by mail-pl1-x644.google.com with SMTP id t14so3062757plr.8
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oOGWU6CgcAFRrNmaOEFHGDGiBotip/Vn0ZaQb6OYup4=;
 b=XIfuiFZ9PHJ4tysbW3FlEDZ2Xh95aeYAhuZENQ24XBKqj5QSbeCqRThREz4xNNPfwC
 OuOQshhKfD9w/ihwmca91rKdZlJjtLjr0u2watMO5q+nidjEBkDAk1zUixjab788ukYy
 FcBrJorCllZ3hCEmNFFT8DAkQRpY4LcjMuBN+Fm/zmR9mS6MUOJ6hkrUzDrNnkHL54Fo
 r9+nO8k8s2bXrhBbNEUNkGrVVNADYYvKx5j91C92Js7B5He7JBjAvHQxq3gV3NcS3VQK
 Wtu49cww+eY2627Um5nD2oe0uuCE6oKN0uvs0Amoln26FxYYEsRwAxHUDFqH685KGsHX
 l0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oOGWU6CgcAFRrNmaOEFHGDGiBotip/Vn0ZaQb6OYup4=;
 b=n3GXOWmr5Neemwfm5h7MG5uzJgiV7IM1g7KRRZAefTFCZ7Ho6uL0OiLJ3GPfewdzJ6
 r4TJQaqcW7HK9u3/8/qRAh2sGZpZlaEvK1rnqIymj4F/q9IFO5NBUpx1Z5kvCzJwozZd
 +MB+ADEABM1J19zRARfnDUTsxIyqmPudATmAKoI4UI2K6ln7Qfy1bkN3gcQvYlVykx2L
 t83hmasXPfhwngHZerNggbN1uxffYz6P7F3GoL2bFHQRgIOSz0rtuTMDJowg/gR709a2
 aJrpsjBm68nF5ppBFeuMxR3S+kS7QPnH6MC6WlvIDwLXqDVp8+loXT/zY+UrDqr2Ihr8
 4eDw==
X-Gm-Message-State: ANhLgQ0fiOlXC8Yd/iOcpmUOMsKbhLZ1p9+iZQgjah1boTQOtFzOuQ5b
 1oLE7+t/fMy8lmqdPnAkqCbIBbsaTKI=
X-Google-Smtp-Source: ADFU+vuWHgkNs53qyBi4Yd0+s7L0YajE/N4Of0z3hs9u8THPwvTpIwFhVoFz5odzND5UvS5USYGYWg==
X-Received: by 2002:a17:902:9886:: with SMTP id
 s6mr9716875plp.100.1584042191976; 
 Thu, 12 Mar 2020 12:43:11 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:43:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 38/42] target/arm: Set PSTATE.TCO on exception entry
Date: Thu, 12 Mar 2020 12:42:15 -0700
Message-Id: <20200312194219.24406-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

D1.10 specifies that exception handlers begin with tag checks overridden.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Only set if MTE feature present.
---
 target/arm/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 44e7c0d19b..b38dc74733 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9664,6 +9664,9 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
             break;
         }
     }
+    if (cpu_isar_feature(aa64_mte, cpu)) {
+        new_mode |= PSTATE_TCO;
+    }
 
     pstate_write(env, PSTATE_DAIF | new_mode);
     env->aarch64 = 1;
-- 
2.20.1


