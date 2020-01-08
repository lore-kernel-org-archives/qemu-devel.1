Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56044C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:01:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F70D20673
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0hf9oMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F70D20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2Wi-0007qC-Py
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:01:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2J8-00052H-Iq
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2J7-0003oz-JD
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:58 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:33715)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2J7-0003oD-Do
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:57 -0500
Received: by mail-pl1-x636.google.com with SMTP id ay11so524584plb.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J0NbyLl5+EmsVs3kA4BMAH1WI7D6bmJtQQCfcSxRCUE=;
 b=W0hf9oMSh32fM/AC4MH+xzti4XfCbDGjqc5jrF+j9ot+ligOAd3wdnWQuPdjCfx8aQ
 FpNmcrY1IWBr6fJnSn5gjMHdSjzg2NLYeaQvrTg66frlqyVF3X9worc4KRPzqsrAwiJ9
 I+sNKoK3qS7pU38xJGmBeTk/wWvnQ+l7x5R4pGUMHJMtKqWl3QnUncYTjxV1/kC7OEVH
 TB7e/VoeJQOcImtFfP8TVb0v++ncj2cJglhPsui2/WmwTfVOMXPeDwi+W1tPXamC/qCG
 Asi7evl2+JGvzvvZD6njGYMPPrrMxnk6Z0xYvQRp65ROperluDNYzHiW72koiv3nBdgf
 fwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J0NbyLl5+EmsVs3kA4BMAH1WI7D6bmJtQQCfcSxRCUE=;
 b=VCudZdVdNO85NPjF8VlHWUCPJ5A1kQ9erRRmnSU8KytddFkJ2AipifeOraF+0W3b4V
 63ZSA6ZzJY5BlBspsqDuO/B3xRw+k55eMmCtfzqrbUfwE2TldqWPYFIwryXQShpm1+ar
 KQdT5anlrbvSslfIOYlVg3fKk0OIkat7Y3KdA78lvxjzW2rBCnWORqJubjUOR5jES4SA
 1j9k6qAZ1h/7diL+4XbhnTqrL8CBcfm/MBjK3YpSTqDJfjYf3PCZiTRcEM67U4rmXkdZ
 jh82P3YFo7Wx6lnWoOJSWKoC5i/6bHGAzk/zDhIAPymLOaurYIN9awWYagLCFBOdNz1Z
 QtwA==
X-Gm-Message-State: APjAAAVdHXC4brFQ/1RSVixjLSnEYR9lzWMPPd4ZHc8ao421t9JEMgqm
 hWg7ZkoXBdL8jRiX+pr1piBenZgrFrpntg==
X-Google-Smtp-Source: APXvYqzVvkIyu+gQ+1dLxxzSL51yFzHAhNbLIcnrbJXBKyHePUTmOv9z0mInZF0vzwXdoFpnZ7jMvQ==
X-Received: by 2002:a17:90a:928a:: with SMTP id
 n10mr2220760pjo.58.1578455216206; 
 Tue, 07 Jan 2020 19:46:56 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:46:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/41] target/sh4: Remove MMU_MODE{0,1}_SUFFIX
Date: Wed,  8 Jan 2020 14:45:10 +1100
Message-Id: <20200108034523.17349-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::636
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
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index ecaa7a18a9..452a596e67 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -254,8 +254,6 @@ void cpu_load_tlb(CPUSH4State * env);
 #define cpu_list sh4_cpu_list
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _kernel
-#define MMU_MODE1_SUFFIX _user
 #define MMU_USER_IDX 1
 static inline int cpu_mmu_index (CPUSH4State *env, bool ifetch)
 {
-- 
2.20.1


