Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27073C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E484920848
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="es1Odej8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E484920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2a1-0003Ze-Km
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:04:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2JF-000597-0o
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2JD-0003vW-Qt
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:04 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:53597)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2JD-0003uI-L8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:03 -0500
Received: by mail-pj1-x1031.google.com with SMTP id n96so464410pjc.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TWAsBzCoriAb7ux23wFGxM2iykLABej28qb4JsXtnPw=;
 b=es1Odej8Obq31DnMppCRcmBbsH3VFXrFT4yBboUbcmVtm4P4jOsV2lGcazE9TOxREg
 NLoyaDakddaOtP+2uQNMqjzkIifPN+uaLxzMYXR0MzEC636zvIpOkADVRa4XF4FvqiZy
 wRIAXglhQW8lSiUAoT+PBfufNK/NAUz5eLYVfN7x1/yoCnKkVOYxj40Eisjhit1+KBIn
 d9//ImK2t4KrLWPs1WVOH+A2A8i2UZdUfTPLnf70/4AGQocNR6umW8NXnbB/l7DmMdFH
 53riYClWcWEEngBRbSpSDfkZlbur/4rj/I3zBVkZzQAEMPQKn7OMFJaF+RpTZDcrFjHt
 raaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TWAsBzCoriAb7ux23wFGxM2iykLABej28qb4JsXtnPw=;
 b=l2QLCCyNvlLWhSftFvUUXS1gv7Dh5Z3zTbcSMBMe9x6VFZPO7+WLKQ0y37RMt4YHAk
 ciStV33Iwv4xZCGt+UNkTo5S9zhy+/gDzCP25AWq9s0YnGrR502oW2kSm6rcEUmJLV6P
 lgVdYdyGYvJyERWQpsOgw64B9p1J/JG1U08FDtnR6dBi+XTDFNTR78fEv5Q+rFcx6Ps6
 zVH448Du759ER02Z0m+Uu+xvuL+CgjdZrvhY5VSMbj5KhsVzoKs7SrsDWciKotzYLunn
 Rmvq/AgAfllrFKiUwLTqzXoKhJy+vpEkqZpTS+qLh/7oWjTdt+nWGUwNALjybDqaQtDU
 6CJw==
X-Gm-Message-State: APjAAAW9XtepfzAFD8KEcyWBhwMWG1GnLFPFcmcJ2nRy/EABIprbNa6F
 uCxX0+BMgtXpWO83/BYXveHu63XrW4RlkQ==
X-Google-Smtp-Source: APXvYqwXGBVuhCRsYPfNb73TvOPL8Y2/3ZDCaJ57+UcawIUUGl91S4frs01TYR9WbM2SMipjPWfWSA==
X-Received: by 2002:a17:90a:d807:: with SMTP id
 a7mr2185325pjv.15.1578455222365; 
 Tue, 07 Jan 2020 19:47:02 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:47:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/41] target/xtensa: Remove MMU_MODE{0,1,2,3}_SUFFIX
Date: Wed,  8 Jan 2020 14:45:12 +1100
Message-Id: <20200108034523.17349-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1031
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
 peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/cpu.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 75e65df597..493f4fc80c 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -689,10 +689,6 @@ static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
 }
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _ring0
-#define MMU_MODE1_SUFFIX _ring1
-#define MMU_MODE2_SUFFIX _ring2
-#define MMU_MODE3_SUFFIX _ring3
 #define MMU_USER_IDX 3
 
 static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
-- 
2.20.1


