Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85FCC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6092078E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t1aDoHg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6092078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnN5-0000nM-GT
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDnIw-0002dT-Af
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:21:22 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDnIt-0007a1-Td
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:21:21 -0400
Received: by mail-wm1-x342.google.com with SMTP id e17so2494405wme.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mJNKp9y1F6rLirIyiQ2tKjhVz1svga6dJmHJIZK3pwc=;
 b=t1aDoHg3niacDPuDcWpr7qRaEPmYyH/SKmum2XKpJ/TVFZW7TZiEOphvFg7PiN0gni
 l8OfPZWnmnwCYb0jMIjLl8ouGm5y2QHldXvsPQkgHVdDyIYWVNlEyq0fInDIAJcvfErO
 B4HRS08UC3NvxxwRYuFiIt5bafDPrjoZrPfbwOZVmFP8/m0GGc2ptQdAjpon2cm6Jy3L
 4/vWW+muyQh+FeK0iJTuEgFjvKw28DwEn/Iy662h+6jYWqRUh0jOwIw3TCOD1u0Zlwmh
 zTSUwtnZzOu2kCezKdsNqmPWcYBT1QHXU65ArJNtlZYU/BTPbGWTWI/EuIyxwi13BiAo
 m8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mJNKp9y1F6rLirIyiQ2tKjhVz1svga6dJmHJIZK3pwc=;
 b=Lr631Tjekk4OPM/XWh+RA43INRebIKef7YkxNE9rmk9uJvNGFZ7BzMpjmN4lXt/WWT
 G9BohilfYyX/zgP5nZ4ZEOslK/wfWyLpXuJqFcLgXafPuFECAHUc7ac0VcGcj2sgRmnY
 f5sPkJ5GzkHy5ulv5xW7xbHCzB6mzkLz7zBUO6DPLf4Y97Yvtw6z7XpR6gG6+U1mtY2L
 rzJdrFVo27F0H/dHIWrb0KO3wgQyy0fq9UknGQf5EjdER393NToWmmY7ijHo9qP2PeCw
 ChSWiGrd+gESMK4kRwGlcmUfS3vTWu158eGNs0N0sA1djiprIY7EnVjwgaMAWzBoQQzm
 iBcQ==
X-Gm-Message-State: AOAM530u409+jTg/BP2Tk7/TvGkpTL5Rwfl9ZDjoajbknFHWytueCOyL
 aII0wLqmpjlw6+EcDMHlwQhSqw==
X-Google-Smtp-Source: ABdhPJw+NjrxzImcq6EfdBJH7dMlSgesVzMeNN8YA4ILC+PkNomH6Is4CNDu1fcAb4ikywDbJ5hgOg==
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr156661wmc.151.1599132078701;
 Thu, 03 Sep 2020 04:21:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z203sm4057517wmc.31.2020.09.03.04.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 04:21:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 88E721FF96;
 Thu,  3 Sep 2020 12:21:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 8/8] migration: use pstrcpy to copy run state
Date: Thu,  3 Sep 2020 12:21:07 +0100
Message-Id: <20200903112107.27367-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903112107.27367-1-alex.bennee@linaro.org>
References: <20200903112107.27367-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>, richard.henderson@linaro.org,
 f4bug@amsat.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 cota@braap.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The gcov build triggered:

  ../../migration/global_state.c:47:5: error: ‘strncpy’ specified
      bound 100 equals destination size [-Werror=stringop-truncation]
      strncpy((char *)global_state.runstate

As we shouldn't be using strncpy anyway lets use the suggested
pstrcpy.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 migration/global_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/global_state.c b/migration/global_state.c
index 25311479a4b..5fbe6d1ff07 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -44,8 +44,8 @@ void global_state_store_running(void)
 {
     const char *state = RunState_str(RUN_STATE_RUNNING);
     assert(strlen(state) < sizeof(global_state.runstate));
-    strncpy((char *)global_state.runstate,
-           state, sizeof(global_state.runstate));
+    pstrcpy((char *)global_state.runstate, sizeof(global_state.runstate),
+            state);
 }
 
 bool global_state_received(void)
-- 
2.20.1


