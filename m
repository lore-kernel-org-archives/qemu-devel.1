Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95599C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DCF720848
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DEyZSVjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCF720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2XK-0008U8-Pl
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Iz-0004pT-3I
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Ix-0003e3-KT
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:48 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:38762)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2Ix-0003dK-FC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:47 -0500
Received: by mail-pl1-x629.google.com with SMTP id f20so546023plj.5
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=epQ8gnLIG21U33fUc1Ykb+d66gYp2VTQnVaLDtLK2uk=;
 b=DEyZSVjPHA3AvT08H88qb7qYX3igVzEEr5n51CqxYH6+F/XopkVeYdbDzRpTeBqjWP
 OJfP9hI6Jk+d+wI/vCoJgbvUUNc9Mcn/bX1jqLdqFpL2fKdMph0Lg4WGwE8yPYAsHoRN
 CFk/O7+xeY9Y3tNxfiwSXWa68l3hknVPWVrUeiuIAhALYLWPLNKyZ53jOgeWG8/MMXt7
 vRM36IcKaPWflVv4Bg+712rvTHBew7D9VKJo7QRZ9n+OJ7x4SzeBDHUIJ0u0nhk9HI6U
 VDgetQZHlNNBV3RBDuwYtE4J71Y3K5OoSOuCcm7GrgIqSgdRQ2UhQhuW4ceYyPBFVvkB
 yWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=epQ8gnLIG21U33fUc1Ykb+d66gYp2VTQnVaLDtLK2uk=;
 b=Ewc48sjIVmZU0wepmXFSt4BF0frFZL1UkR+1rC0xySzLYyGhHs8oFTDQHrjPhoOesm
 V4Yb0/9fAx84EdUMqi9s4E8hqkRrqH3B5+25TKvMb+XfR0Rqu/vvNUCEC9Gkg6gEEVAT
 Kz0TooptbpapdminumoUhF2R03cpwn7iSIJZRrEjy48TqZeLSxMHPBQZ6Jx/yHQobz6I
 33x5eyBc2mjVzAV7lk2pD3rLkceOuhFXrP2M3kQuUBQOrRPL7BZfDf/xmvDRGxnblsq4
 LHBGgNL9BkFWHVTaexR5oxckLn86WKJuh5ATCsR4LqFwZKTCCFbReyuMwq29OCr7EoAT
 K8Ag==
X-Gm-Message-State: APjAAAXGfIwPbM23UoZaUZ6dzSQ/dww1WH7kurBzkVb+2g5YEFNVuoYP
 DCDokK5JKqxPTUwyxaZL+g7/kjpLnuzj8w==
X-Google-Smtp-Source: APXvYqx5Ko0voebBLKQoP+ogfhIRBNZg240AKm3KV9f7v1xoURtUebVPTcsF9MtnoWPgnd/77K49Dw==
X-Received: by 2002:a17:902:7484:: with SMTP id
 h4mr3109306pll.206.1578455206205; 
 Tue, 07 Jan 2020 19:46:46 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:46:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/41] target/cris: Remove MMU_MODE{0,1}_SUFFIX
Date: Wed,  8 Jan 2020 14:45:07 +1100
Message-Id: <20200108034523.17349-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::629
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
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/cris/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index aba0a66474..bc43bc23a1 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -252,8 +252,6 @@ enum {
 #define cpu_signal_handler cpu_cris_signal_handler
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _kernel
-#define MMU_MODE1_SUFFIX _user
 #define MMU_USER_IDX 1
 static inline int cpu_mmu_index (CPUCRISState *env, bool ifetch)
 {
-- 
2.20.1


