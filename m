Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30333C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED137206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xyKzTnUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED137206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh3qG-0001v5-4J
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 00:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3na-0004G4-JM
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:42 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:52419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nZ-0000jW-SK
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:42 -0400
Received: by mail-pj1-x1041.google.com with SMTP id k2so2054723pjs.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 21:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nqqofQziFBqWdXP+8khcoigsyFvMbdt2vH117/pVwFo=;
 b=xyKzTnUoermMpUwPDDOvda0xWv7DakzouPKnECbhodlQTTmqQHY3y5wDHVpNUkudKc
 5nZMV4J5d3QeKHmtH/WKEU8h8mGbFhgS+qjoJx7OmYNf1/ZSHSavCutMk74RS2TDX1IU
 IlXPdq1uDZlj9vKIDz/fW+nFGTrbkqf/cBZv0rkNYXliiE7aT/Nk2gSIBzi2UA+Lxu6q
 mYHxAn5sKl/AuOASnN5mNnjdi5BPyY9USNVxBH51SPKnDiSvQDGCP9Z5URJQsp46kbHh
 g+Er9rkYF9X1iR0svgXb0JeAR9ONRR1ZVL3padv8JVnV4D8e2NPSn1azB4JzoCgR7ffa
 hcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nqqofQziFBqWdXP+8khcoigsyFvMbdt2vH117/pVwFo=;
 b=mGQomlIZX227NHPiPoAoV/x8nrnCaIEUepyTeUVnwE4qkofurAu0mq0pz7zAKwF+CV
 qvX9jpsILILaWmFpbD+o2vOY/6JDMtlfOBYEzPpMloC859VGpYDFiY7dgMrAgJqUjMLH
 /km6mngLuQuyDKofnIM1wOKG9xTki3iGq1xIBT7yH8/f/zirNY7qaGC/HJfI9We2M7xO
 DcfGt8lGUzT7914kyoeo2i78bMq4FWLpK0WYV9fotoCfLuq94rA62UYQ/09p4lha7oNr
 NaKMvfi8HUyLq9kRGBTAIYyZJ0wy/lmi56FO8oQnrhv1dGYiuqMjWx61F6aVBZ0IfJcd
 px0A==
X-Gm-Message-State: AOAM530JOdSusFpEvyr2/WhCzT8nDYKwF3ZGcESBCGtWINLGeTHaTEQi
 82B8ZLY32KRL4Vq/hPVIKUm/MEkjRFk=
X-Google-Smtp-Source: ABdhPJwFDYVvMiy2eMcza5GBkDYBUYtsdGeV7Tpyo2G42Ak0L7S6k/H0dVViCIBtrZtaCtF69ZB2fQ==
X-Received: by 2002:a17:90a:17ed:: with SMTP id
 q100mr740057pja.80.1591330660238; 
 Thu, 04 Jun 2020 21:17:40 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h15sm5440902pgl.12.2020.06.04.21.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 21:17:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/17] linux-user: Tidy VERIFY_READ/VERIFY_WRITE
Date: Thu,  4 Jun 2020 21:17:20 -0700
Message-Id: <20200605041733.415188-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605041733.415188-1-richard.henderson@linaro.org>
References: <20200605041733.415188-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These constants are only ever used with access_ok, and friends.
Rather than translating them to PAGE_* bits, let them equal
the PAGE_* bits to begin.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 2bf35e66ac..a8dde8c609 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -464,8 +464,8 @@ extern unsigned long guest_stack_size;
 
 /* user access */
 
-#define VERIFY_READ 0
-#define VERIFY_WRITE 1 /* implies read access */
+#define VERIFY_READ  PAGE_READ
+#define VERIFY_WRITE (PAGE_READ | PAGE_WRITE)
 
 static inline bool access_ok(int type, abi_ulong addr, abi_ulong size)
 {
@@ -477,9 +477,7 @@ static inline bool access_ok(int type, abi_ulong addr, abi_ulong size)
          !guest_addr_valid(addr + size - 1))) {
         return false;
     }
-    return page_check_range((target_ulong)addr, size,
-                            (type == VERIFY_READ) ? PAGE_READ :
-                            (PAGE_READ | PAGE_WRITE)) == 0;
+    return page_check_range((target_ulong)addr, size, type) == 0;
 }
 
 /* NOTE __get_user and __put_user use host pointers and don't check access.
-- 
2.25.1


