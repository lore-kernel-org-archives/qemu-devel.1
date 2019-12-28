Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1904AC2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3BDA2168B
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q0KV8V8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BDA2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLMw-0004t6-Fe
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFt-0005Ea-Qi
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFs-0007Jn-NT
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:21 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46561)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLFs-0007Fz-He
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:20 -0500
Received: by mail-pf1-x443.google.com with SMTP id n9so8658348pff.13
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JNBmm1sV0HQlIuj50EfP42qQQdAOa/hMzuJfrSMg+C0=;
 b=Q0KV8V8GTe3jO+5NY9YacbGc1L5vM9HTs4TL+GzeF4vIJvT1ImevWNJWdjfkVzfEU1
 BM+Y5Ohq63A2hH+2L+4jN3ekDFAk3R6MM/JHcUhoXp/Z9qb+f79+Qg5cQsNaM/4V6PXK
 2ibKEtgs5BlecBC97veUkCCtzMK15IfqTM5F7tIV+Mgcbfe3puXYDWClYWW8QsTMnKTY
 XvZjo73cKQEB22bdZ47hPLpqU066vbOZsNk7Xf2ni5lqqhRItBlZ2/cRDKxVmURw+lN5
 IHu1pt6asXNqr4yLJIaAnaYyukr10Edd4T69m6Y5O0XBWejC7rlk5dZztKYKTru6pHM0
 E37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JNBmm1sV0HQlIuj50EfP42qQQdAOa/hMzuJfrSMg+C0=;
 b=i76irJ3mMkZLu5/f/icyDbbxe/NUPYOLmlAL9GiQcjHzT1tWCbmf4EGacToFMla+tz
 WXg/AUIvCOteKTqTb7YqgFGuelnSEqvATkCN9oMfQ7SKscIlcdBlV+j/fAHTBAs8Jbge
 +wTuwUWv2aBf9CEBqPWMQ2J5KaOtz1t6majk/XzLXZ4/EASaeQucJgneVKvisLUX6jQh
 mzMPWO5qz/L0NVH2+KSN8kym64k7sU472S4T32UJssoSzp+QCSzxGC3PmI/246q4QxTY
 G2ptlROnRK/rIgo6ybO/yFZEsT5doDUTwInwklRnMQl46ctXy6mQusHaVW4+lnua7cqq
 DSeQ==
X-Gm-Message-State: APjAAAUFskg3Bq1pcERCJiHzOUa8v/ws/WHHs+XalikvJGB4Yvm43wh+
 8ea9v+fsowcCTzUUtJd4rA0/RKxay9g=
X-Google-Smtp-Source: APXvYqxDc62B9kLDxiCPgQrEtgJLV0lJilOX8wPPQ5RBXaNWBBWAXprE2ICSAEJw8Wj3JplQ6s6hag==
X-Received: by 2002:a63:4e0e:: with SMTP id c14mr62645838pgb.237.1577574739337; 
 Sat, 28 Dec 2019 15:12:19 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:12:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/29] target/nios2: Remove MMU_MODE{0,1}_SUFFIX
Date: Sun, 29 Dec 2019 10:11:11 +1100
Message-Id: <20191228231124.18307-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Chris Wulff <crwulff@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/nios2/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 361b06ffeb..78f633f970 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -217,8 +217,6 @@ void do_nios2_semihosting(CPUNios2State *env);
 #define CPU_SAVE_VERSION 1
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _kernel
-#define MMU_MODE1_SUFFIX _user
 #define MMU_SUPERVISOR_IDX  0
 #define MMU_USER_IDX        1
 
-- 
2.20.1


