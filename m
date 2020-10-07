Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E715DC47095
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C66206BE
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RbEwx0wp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C66206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCNP-0005DA-CC
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQC0l-0004FV-Dy
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:09:51 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46407)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQC0i-0003C9-0S
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:09:51 -0400
Received: by mail-wr1-x441.google.com with SMTP id n6so2554130wrm.13
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/pFB/VAsIjYSTZIScMCznIhiLzuDJIOTEgBnk08g4x4=;
 b=RbEwx0wp+p0DCDytz4X7v1B8m0c2wDPf8oiQVdZ0Vy5ysWZrLpDt+p+bQz6QSBdcmZ
 5ryNDYRIzptSzaSLXAnE5C4JJ37+5vwLkxNphHcsEDTRyZ0VPkTEd3V45rZ30owTcNpE
 cKYQw7JN2ZCfL9VutYea3fmuKohoV50JkRNeEHMjBhwX+iGat5sLLnBQpmainXCvKNtb
 3wVpyGJpE6ISRCNE7eTJk7QnQ/qlyoO2rTbM0FcLMwGVb6zlmsIAJp/NYu/UfSjCksy1
 48R0RSyZF/68Jjzc5NXo8o4eKSvra5DdIpNBckz8MEg1pznlT6XA9uc0L9Wpk5AzfQf7
 LAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/pFB/VAsIjYSTZIScMCznIhiLzuDJIOTEgBnk08g4x4=;
 b=LOPzA1OoCfOyz9Bm/TS0AP149w49YVOwgk97qd4Wtarvy39S5OcXJ4hKrUTS3B+8MC
 H8uHL6bxF41s0rdf0htOXEmCPeQHsHoLHNz67cCcAcfcOKKqTRn9tLburUHyPipCK+9K
 PLZbVSq2A1jxrzgQI7mq5J5spvcj/o1zj+pODLNcZiRD1kbV5kEMwKI/cBE9ZYZ/126U
 Qry2Unq0Uv9udIK+H1HKwD6sMBAwlz+9yUbXNDYglRyrXJCj7EJQi+rZOZkWydK7JvmY
 sB+GETLLz6siAil9QCm7FAYEdpAy3i9d3CAdE3jbUJxu7xL4+PauH5djiEOU8P+NSjcM
 N6kQ==
X-Gm-Message-State: AOAM531RmvjlB254FWbLttpoWf9FNpuD65vx9wkjkk8joEHh7CXU4Ou/
 wLwR/zCKAwdG+3bwmAate87fN6RfRdvsEg==
X-Google-Smtp-Source: ABdhPJxPGQVw5fo3y51XsSpOvaxcdFz6YeG19d/OdnqLgpQN63Lpv+nVS+ZvD9Lk+J9XSm95Qbq4kw==
X-Received: by 2002:a5d:4388:: with SMTP id i8mr4320679wrq.365.1602086986541; 
 Wed, 07 Oct 2020 09:09:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c132sm3338077wmf.25.2020.10.07.09.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:09:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DAA371FFA9;
 Wed,  7 Oct 2020 17:00:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 19/22] plugins: Fixes a issue when dlsym failed,
 the handle not closed
Date: Wed,  7 Oct 2020 17:00:35 +0100
Message-Id: <20201007160038.26953-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007160038.26953-1-alex.bennee@linaro.org>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20201001163429.1348-2-luoyonggang@gmail.com>
---
 plugins/loader.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/loader.c b/plugins/loader.c
index 685d334e1a..8ac5dbc20f 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -235,6 +235,7 @@ static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info_t *info)
     return rc;
 
  err_symbol:
+    g_module_close(ctx->handle);
  err_dlopen:
     qemu_vfree(ctx);
     return 1;
-- 
2.20.1


