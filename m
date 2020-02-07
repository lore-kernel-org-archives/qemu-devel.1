Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDB9C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB92720838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DH02ILyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB92720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05F5-0004d7-4q
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:08:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j058G-0000nN-Jd
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j058E-0003ni-A4
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:24 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35171)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j058E-0003gZ-3j
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:22 -0500
Received: by mail-wr1-x442.google.com with SMTP id w12so3087807wrt.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 07:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=geflNNg5itN8dXnNJ+nN1Foj8Td7+gJztf5WRFw/CZI=;
 b=DH02ILyn31hWZDIn7PbXVwUTONERvvLND5bXRV94M7JO4SmRqYA0gjtHKA7eCS/xvc
 52titBIzfHffSdrESWMFb6DrjvxZZzvzHf+0a/68KKicLArTWpDh+b31eDJSqBij72VW
 XiJZYh7qq3CuYVXxqbfOayOgPIF7IkhvoB1zyguZ4mgfyzYWOT743Vb9WKmS4EgI2bUB
 Pl3HR8GOr7rf1UGfk8wWj8F5OExi5Ylp6gWBLTisimWZEL1xxpky9OMeUljgOSfo2M1L
 n6ivpcAzndODuuBpkkf72+PPp5/8YvREoLb5qzgpOQYDkgKAHaZvMEjCnnMoOvc0u5aM
 xdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=geflNNg5itN8dXnNJ+nN1Foj8Td7+gJztf5WRFw/CZI=;
 b=HmL8C8kA+AsUN1TJTeZDcjj9pHOdd0bVkc8OBUSavw/sBFzgorkmacLMcQ3m5zUHs8
 FSgGL3JxJhEP+V1LyRLwY95fXUWfEhrGlOGcxHlwoBgGJaZd3oNAFF/6G+03EOpGK53E
 Zq+jEU+75nCz8R0p8ox96JiRsdtfxxK6sWsbVwU7t5+Xe8MBUuxXOUZsWEVWb/Oa58UX
 hBOZP1kjhikSGCgOzfLvSSqEaxI2wTaF7T8KCuL6HVng1pKXdHj2/r8x2prsHI26HJB5
 z5kVTcVyPwnrlhqqlhwdrMpANQ6t4AzuZuvZtIO9P+IQuqIr0NXxSsDa/J1HozRNzXpI
 YjHQ==
X-Gm-Message-State: APjAAAX7hy8ZcgjyqEUZ6BObMXxRvObcsGrMaLi3ykArwXTTE3kJbWm3
 suT/UgHDJW5cOyRyGhXxR3OA6A==
X-Google-Smtp-Source: APXvYqwwsz0TekjGr2ewp2Wg/EFFUEAULdrWGs0PrslPC7+pXQHsjyqXyGPIkSyUwMVKe6H2m9CPKw==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr5043627wrp.167.1581087680720; 
 Fri, 07 Feb 2020 07:01:20 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a26sm3688453wmm.18.2020.02.07.07.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 07:01:19 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1A7F21FF8F;
 Fri,  7 Feb 2020 15:01:19 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 2/5] plugins/core: add missing break in cb_to_tcg_flags
Date: Fri,  7 Feb 2020 15:01:15 +0000
Message-Id: <20200207150118.23007-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207150118.23007-1-alex.bennee@linaro.org>
References: <20200207150118.23007-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: robert.foley@linaro.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reported-by: Robert Henry <robhenry@microsoft.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20200105072940.32204-1-cota@braap.org>
---
 plugins/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/core.c b/plugins/core.c
index 9e1b9e7a915..ed863011baf 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -286,6 +286,7 @@ static inline uint32_t cb_to_tcg_flags(enum qemu_plugin_cb_flags flags)
     switch (flags) {
     case QEMU_PLUGIN_CB_RW_REGS:
         ret = 0;
+        break;
     case QEMU_PLUGIN_CB_R_REGS:
         ret = TCG_CALL_NO_WG;
         break;
-- 
2.20.1


