Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF17C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 19:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8422073A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 19:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aIL/6iZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8422073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2gxd-0005GM-4I
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 14:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2gvJ-00031q-NZ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:46:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2gvI-0003ZG-PM
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:46:49 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:36060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2gvI-0003Xh-KS
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:46:48 -0500
Received: by mail-pj1-x1042.google.com with SMTP id gv17so4343986pjb.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 11:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q4tpwQmU/GY5DYP8gwmfjDF7+GhkCh2mU6sZu+wMVTo=;
 b=aIL/6iZqb8svQMq2gMc6FZYFZXQS5/dpAxvOvYgf4atmsGl/3Ij2Fwtk7/9qztMwdl
 t+Kg8k9fb2VgmrZ1JZ6/ggspKB5SNTcKjnofgfYwFdlQsKb+uPNogRIreD2uP7qoH0MO
 0r6wtm7x4oRP3yH864VPZMpa85TQ5rUaC2lNB4O3UwK8474h/qO7DANCZ/nvmI3XI91v
 gbrDyP17AEubmX13RYFyUk5JQzfYiDZfCMqf5zTAQ7HPOxa10rmWW6P1GYltyrSeMJch
 D55fzwsXz+BKe2+78fdX2bwPBSxqFKC4aOdFRAQCxeDt/32yAEYgaLrJMS5Rkfo1oQLk
 BXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q4tpwQmU/GY5DYP8gwmfjDF7+GhkCh2mU6sZu+wMVTo=;
 b=qtm/iNSAwZXfIJkO0wG0ftRa5vI6j57M9iSV6D07WyVUCosFTP2mUpPCcAkqsc4OVV
 fdDoeyc8TTfQRRuggG9f94q1vT/Z2MptSz3J78RutOrWXjeYEmCT8skqIXekQjBCl0Yy
 3uxEuzK167M8XRFU+gdTuSsO3y7oxeHUWFjrqDKmi07J5FlOxtMZba7CS+b9O1uML5y8
 23w0HX6PCMAnPBOo+A/01yaDzk6KjOiFYow8Xnla/MYvFviksRdLPw1PeGWRsNpHPO3s
 cFjXW3PS/r4Q3XhwUf9RU3ZaxW7VfR3aSTDqTupL49Y71BvPR10BER0oo1E6GJEhmFOI
 x4CQ==
X-Gm-Message-State: APjAAAU4EOTE1XAEkrPhfDgnz7hGE+dIkSCyvll447OJETD+apjjASfz
 EDBfnLe4/e+S8tPI2AvFrHo09FFLW0g=
X-Google-Smtp-Source: APXvYqyCZcEI60cIRiwxOAliRiNtCxmLZocPLQIEFINFek62jnPc4/HH0zEW0601ugu0f4Fz+2hTJQ==
X-Received: by 2002:a17:90a:a406:: with SMTP id
 y6mr5734073pjp.115.1581709606869; 
 Fri, 14 Feb 2020 11:46:46 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g13sm7558851pfo.169.2020.02.14.11.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 11:46:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] target/arm: Flush high bits of sve register after AdvSIMD
 EXT
Date: Fri, 14 Feb 2020 11:46:40 -0800
Message-Id: <20200214194643.23317-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214194643.23317-1-richard.henderson@linaro.org>
References: <20200214194643.23317-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Writes to AdvSIMD registers flush the bits above 128.

Buglink: https://bugs.launchpad.net/bugs/1863247
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7c26c3bfeb..620a429067 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -6895,6 +6895,7 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
     tcg_temp_free_i64(tcg_resl);
     write_vec_element(s, tcg_resh, rd, 1, MO_64);
     tcg_temp_free_i64(tcg_resh);
+    clear_vec_high(s, true, rd);
 }
 
 /* TBL/TBX
-- 
2.20.1


