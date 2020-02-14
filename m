Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C07C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 19:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C39AF2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 19:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZJpr2yNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39AF2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2gyk-0007aV-V3
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 14:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2gvL-00034S-Gn
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2gvK-0003eC-Ir
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:46:51 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40086)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2gvK-0003c0-Dg
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:46:50 -0500
Received: by mail-pg1-x542.google.com with SMTP id z7so5450564pgk.7
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 11:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HlkIYk7mnAAf7AbZuXJxcfBvUpBjMWEzz4Glx4QDkeU=;
 b=ZJpr2yNc4bFP0OQSn9wxp9sciMybWSOPY3ZBxGD/wZw9U32RjStcE0eH70GeKj/CQD
 15gorhT6j8dFvMw12/T/LDxNV7BNbrX01ZbFo6xulNyW6iWvP6QHA6arflTMpR3Cwzpc
 M5CED+VyzP4Yg7ubx+0QOg6skJqFSIOF1QmCzvvHx6rizFma9a1LXjF26dNEcPnIh8he
 KfsOh4lgNrWXE/1vQkwaY9Pys1atlmwxZNPIqr37pZmGZP3y1UaDudf9YMP5ELPYYUvm
 eacJT8axDZAzba6m+V/WStVmtiNGs+/+mghDQXefLaLweK0Ck7mDXACxMXSanfCVhgRO
 Qazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HlkIYk7mnAAf7AbZuXJxcfBvUpBjMWEzz4Glx4QDkeU=;
 b=pqx5GgaaEPG/Qrc9tk+WsTyPawMnRiXPYbPTqkHQ0ThBAP58jR7MwX5eyHqt3gkGme
 JfMF3A+ZOLP7D60vbC22IpiJJC3Y+65s9Jti47vrzTD/AFA0NsabsFUPyEIrTeKFGNz+
 efXFv6MS7v0kruyd8CoIZEOi/DiLOckYUIFruf0J+6Cs0WpBNX2MGtV4JcYSH4neySsO
 0jau9X7enng9CSFSefivNi2UVedLRObhw6aTksRe1uB2mhS7Lx3S/UkELbmUrMGfQI3R
 HN+/T099xAWjU7pQlDS8+kER5lje0mwtUXFUXoe/b2le/4Z010+2IJoqT0ix4wM5M/6m
 xDDA==
X-Gm-Message-State: APjAAAVEseAqyUJl3m7Ze4vhknyDx4nUtjr2KCPEhY9GlYTttTcfLY3L
 tg4OTnaKiF0DVFnTRqMW9JFpy2QecEM=
X-Google-Smtp-Source: APXvYqx51fEyzMIeFlHSW3wszAvuE/evubtnMJqdpkcnlDApcjTKGKOPjcHgj5e2be6cKY2Cl50wmw==
X-Received: by 2002:a63:d18:: with SMTP id c24mr5238576pgl.218.1581709609094; 
 Fri, 14 Feb 2020 11:46:49 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g13sm7558851pfo.169.2020.02.14.11.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 11:46:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] target/arm: Flush high bits of sve register after AdvSIMD
 ZIP/UZP/TRN
Date: Fri, 14 Feb 2020 11:46:42 -0800
Message-Id: <20200214194643.23317-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214194643.23317-1-richard.henderson@linaro.org>
References: <20200214194643.23317-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 096a854aed..b83d09dbcd 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -7054,6 +7054,7 @@ static void disas_simd_zip_trn(DisasContext *s, uint32_t insn)
     tcg_temp_free_i64(tcg_resl);
     write_vec_element(s, tcg_resh, rd, 1, MO_64);
     tcg_temp_free_i64(tcg_resh);
+    clear_vec_high(s, true, rd);
 }
 
 /*
-- 
2.20.1


