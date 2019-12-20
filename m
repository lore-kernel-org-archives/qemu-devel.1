Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58470C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248A2206CB
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xc0qI9gd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248A2206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJLZ-0005Vu-T7
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJF1-0004mW-TL
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJF0-00072P-GT
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:55 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54099)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iiJF0-0006yA-3p
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:54 -0500
Received: by mail-wm1-x343.google.com with SMTP id m24so9123783wmc.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 06:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1Vvsojp+zl6N16RSn1fF9GlZuFxqm0kem6/eRYXK5FA=;
 b=Xc0qI9gdlGukiYwgAhUlI+C+XgvtVMRW1Z8z9Ry4Bj91oUV8bhxw+r4ZT9jJ5ylqDb
 kPWthdk45dVEtNpjjWEfneuihy9SYy/UNmbwVKmhWE9L14hjBkHcZ+fqcWOjTZFih4Jx
 WZyAHcGJXwUVOJnGJP+0M3LwZmvzwvYvW951yoe3Wsn+6l9gtrQIahvqsZwXA+7Z+mxM
 9RSXeO0EPjR14rV72bros9vLHbRJVIpP4XEXVWxfThGwfza33gSv7RBUz7x7yK4jkp1W
 8ChmaPFY3oWkiWPwc49un7oZiKjVl6+N+aQG2pMmw70zOgIyPbMSn04PEkCmPCEaJmWC
 cePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1Vvsojp+zl6N16RSn1fF9GlZuFxqm0kem6/eRYXK5FA=;
 b=FqePVdC1HjiRA9otYiDgTZs+3HjYvA59OhwYGWn9aHemMUq7H+3RrS/vlM3ctEOREn
 bUGZg531EHeH1bfxOj3+F0yzuw4GQVH7LU1goSsO6V7JQvC/U6CI7W7kLk8Cw7U9/rlM
 6zLKSfDLn/zeVt84gsnQFVyIPLvoSBOzpobMyLWEJ7lyLyNFKRPpEuEhRTF9cg7ux4A9
 s7l+AP4uI0XHj29DA+49fUrpRQ2t05ziZrhP5R/2ns7NZqoqv+bdSayL+f+ecQ/5U5tN
 GxM3C2TqLbS7nQCpkC3+ssp5wGmFujmYuHdHmckDMfaqxEaD7Rw2jQIbJzvLZOH9k8FZ
 /QfQ==
X-Gm-Message-State: APjAAAXtxVUaIpQiGAqtswyyL/dGim3ck8YBdRA4TIdlHGTCxcg/iVbv
 N/J/+rBFSFfHTuo9+aH7e7UR7f3W8I/kpg==
X-Google-Smtp-Source: APXvYqwVeeJJtIpXx5FzGHQTSiCAn7F7wr8ULFlxA6A9yr6Zh1t+ynWx1Whb5Je+JBRI/meRZv5ACw==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr17934164wmi.101.1576852012582; 
 Fri, 20 Dec 2019 06:26:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t5sm9741814wrr.35.2019.12.20.06.26.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 06:26:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/12] ast2600: Configure CNTFRQ at 1125MHz
Date: Fri, 20 Dec 2019 14:26:36 +0000
Message-Id: <20191220142644.31076-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142644.31076-1-peter.maydell@linaro.org>
References: <20191220142644.31076-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

From: Andrew Jeffery <andrew@aj.id.au>

This matches the configuration set by u-boot on the AST2600.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 080ca1267a09381c43cf3c50d434fb6c186f2b6e.1576215453.git-series.andrew@aj.id.au
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed_ast2600.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index be88005dab8..89e4b009504 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -250,6 +250,9 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         object_property_set_int(OBJECT(&s->cpu[i]), aspeed_calc_affinity(i),
                                 "mp-affinity", &error_abort);
 
+        object_property_set_int(OBJECT(&s->cpu[i]), 1125000000, "cntfrq",
+                                &error_abort);
+
         /*
          * TODO: the secondary CPUs are started and a boot helper
          * is needed when using -kernel
-- 
2.20.1


