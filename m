Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AA2C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448E62073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JPCbO69M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448E62073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58L4-000401-D4
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582W-0007Yr-PO
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582V-00036y-PW
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:20 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:40380)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582V-00036M-Jf
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:19 -0500
Received: by mail-wm1-x335.google.com with SMTP id t14so1774601wmi.5
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9YDEWfTgYbtJnejtZ5TxG4cpNRlX/38cACEqimzClc0=;
 b=JPCbO69M6gUgiN5X1o1Oo7L7typeOWAVGP8vCfx9+qlIUg3BYwkwBjyp82X+4oBrjd
 cSJSnV9L3jRUTJiQ5buVN5stpTAzyvFrQFRQLpv8BtwPGDmznpxoLHc5lT1nb6tMWN1y
 KYPMaLkjpLTRb9hFTgPWnHnMFMJXzDlbWuJ7dH+FqzHmUO5iheQwo4RvrcqJlT0fCKVa
 WpxQJoUrlgWZi8DrY5j7jgjvHJ2LuMyZn4Ok4oIS8lEgzljZR9NBzrKReHzzkPy6jMQJ
 koFqXo70T2zDCEexf5LeeDGJ5Pg7RwzOyzSCqNqxUK/9hIFffdbE4+Vxh4bLA4eYADUr
 SKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9YDEWfTgYbtJnejtZ5TxG4cpNRlX/38cACEqimzClc0=;
 b=VrTjBJ7dbwS7hg59E/pltJ4G79Znu47W5hK3LtVGZ33y2trrvh6N16SYFNJELakLav
 UzH+5LEPWK8MZvXhRXtGtUHw3d3h4duvSsD3Tjq1TkM2h+eao/XPxN53LtDjlxgtqEfa
 Sgyv79ZdhJTpIT33R9w9Ll2J3Ofh0VzQKJaM0/ahMXo4nopsCVmKKX16lUhrbAMF3GrA
 PijbY2nu72XQvEOlR/ty2iWHdAqahmfdfda4q52AI7gtVxyZBGFPtg4j94aWfIqyN0Fg
 b2zpc3FCIHi44S8SBJOnd5fMILBefBFoyv+zcXSs5Ybv022FGpx13RHtXD1dVYJEQDoa
 v7Ug==
X-Gm-Message-State: APjAAAUKdNZS47c2d5xrOgbpfCBOHlQdplS1rsfwwg4eJfL7MY1oYiMv
 O028v9ZWy5yN9r3qxrpRqOzQvJkZ1dKqsw==
X-Google-Smtp-Source: APXvYqwr9PLOlTfS00vDi5LDQRaDlePGn/g3SWRWlS2ql60Cqf0AyGykLFMlQkUY5MpVY3g0yD6xHw==
X-Received: by 2002:a1c:f003:: with SMTP id a3mr3871204wmb.41.1582290498041;
 Fri, 21 Feb 2020 05:08:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/52] target/arm: Correct definition of PMCRDP
Date: Fri, 21 Feb 2020 13:07:17 +0000
Message-Id: <20200221130740.7583-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PMCR_EL0.DP bit is bit 5, which is 0x20, not 0x10.  0x10 is 'X'.
Correct our #define of PMCRDP and add the missing PMCRX.

We do have the correct behaviour for handling the DP bit being
set, so this fixes a guest-visible bug.

Fixes: 033614c47de
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200214175116.9164-17-peter.maydell@linaro.org
---
 target/arm/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 72c9c7e694a..e868b08cc18 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1017,7 +1017,8 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
 #define PMCRN_MASK  0xf800
 #define PMCRN_SHIFT 11
 #define PMCRLC  0x40
-#define PMCRDP  0x10
+#define PMCRDP  0x20
+#define PMCRX   0x10
 #define PMCRD   0x8
 #define PMCRC   0x4
 #define PMCRP   0x2
-- 
2.20.1


