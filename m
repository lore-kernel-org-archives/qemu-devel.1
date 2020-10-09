Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AD8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B67A2225F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6VK+5YE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B67A2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvpD-0000gw-4S
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvR9-00033N-H7
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:40:08 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:53322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvR7-0006Ga-GX
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:40:07 -0400
Received: by mail-wm1-x336.google.com with SMTP id f21so10430911wml.3
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BN5pU+5tBBzX4KE1P4q+qJbBN4nkulfbKpNhgOuiWjw=;
 b=T6VK+5YEXCZGIGpRbfnVVtUWhZKH9D3VjyaclgWTb5272TyTvVtWyRSiKjTeDQFdKQ
 Ejtt1+M/MZ4o2BACuO+kXCgDz/Vx71hOo7i3ic45HCQN5b1flu81jmO0JYSw1jvvsayT
 J67fyCn6doAGkg37Glf5XHnLI8OofY6KSLygP22GZvQk2ScixmJlNN/AbDmp0NK6euXK
 ztTTYLAwLqJqkrose91K79KQpXQnrLkg4GoygvdpvtsMxLzqkeJRo+yE+Vod/XA2FP8+
 U2yn30NLEhTLceEheoeyWttsCjZQXexqE1Iz9RwaqV22nj3CekIbG2+JFFMzW9gGJvfF
 rw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BN5pU+5tBBzX4KE1P4q+qJbBN4nkulfbKpNhgOuiWjw=;
 b=Hmz+MagSVN1QwryEK2+QYlQ3+iC+iahG3k5SKIZ+Z8hN5aQXwcgpRo3HiCeiSpQ6aW
 yqgiYBm4hxRzYf0G0E/A4epOhhTWRamKD39l0hS4mxtYOinBGanzSBOgjUJ/LnOII3GC
 G8GEjZV0UDJYLPXPTE6ysfkyjbULxVtOT9I/wZtAmacwViRACyrRiYLWYUyZzvLWZH/y
 9CZH5Lr0BHXYVUW8QCBL5m3szQKUHIll7Uaj0YTFe2OHs+ehp8WWX3iANicolUhBSaW1
 LDX0eQaHbaF2EzXpGI7iak3seaOEcNC4IsTCUA2YSw1KgEetXmKmqnuL6lmIpnOBaUcY
 oPVw==
X-Gm-Message-State: AOAM531pxpB1TTFSLaWhw1gPbRfB+svPulaaOOBW2/zdaJ/9DY+Uhd7L
 F9r1LdD4JFJRwx1on2LXrTl8Wg==
X-Google-Smtp-Source: ABdhPJwOs6Jx9PdoJKirQ3V6sw3gSE+z5Nm6fy8vvDT5Rb/xti4oQEOSuC98BiF5fFQeJSQo2ckHEQ==
X-Received: by 2002:a1c:2bc2:: with SMTP id r185mr7075111wmr.53.1602261603505; 
 Fri, 09 Oct 2020 09:40:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y7sm12711954wmg.40.2020.10.09.09.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:40:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 917571FFA5;
 Fri,  9 Oct 2020 17:31:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 17/22] contrib/gitdm: Add Yandex to the domain map
Date: Fri,  9 Oct 2020 17:31:42 +0100
Message-Id: <20201009163147.28512-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
References: <20201009163147.28512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Roman Kagan <rvkagan@yandex-team.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Roman Kagan <rvkagan@yandex-team.ru>
Message-Id: <20201006160653.2391972-12-f4bug@amsat.org>
Message-Id: <20201007160038.26953-18-alex.bennee@linaro.org>

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 1572070cf4..0074da618f 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -33,3 +33,4 @@ virtuozzo.com   Virtuozzo
 wdc.com         Western Digital
 xilinx.com      Xilinx
 yadro.com       YADRO
+yandex-team.ru  Yandex
-- 
2.20.1


