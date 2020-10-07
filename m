Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6825C4727F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26CAD216C4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ncxf6K7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CAD216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCDc-0003EN-4D
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBsC-0005F7-Bt
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:01:00 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBry-0000t5-Qx
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:00:56 -0400
Received: by mail-wm1-x342.google.com with SMTP id v12so2978685wmh.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eBK05jRS+TMzL9aJmI57xketxlAuAw5ejWzAFKW8NCY=;
 b=ncxf6K7om3QeNVuMEdgZoQoVZEO2Sbc/8TDfmOQi8tS2IDKj32dguXwznaFE65jeTX
 DZb+vWQTMMyYTXyi/KPOUnfqfudNxpVnf86O0zE8QgThVnNUmh8B7H2kKKcIzQGDrvwS
 XaJVj6HHFATTZNzb7sI3gZ5l0UQ9fqtxYnIQx5CP+zThVqovhMuqxHX51f5vUNL9NIEb
 3f9VcOCvXO0/8i0RUX6SjRvJSmdwzFnFDhCcWGV8qvRU3QoF+ZMd6J+IWy2FOY8RQEyu
 cvHE1yuUz0me1UKuYWWy+xT/dwO0z5bq2Cj+PGez4iQ1j1Gw89n5VO7mJy2dhGl8Na/e
 bXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eBK05jRS+TMzL9aJmI57xketxlAuAw5ejWzAFKW8NCY=;
 b=rw4+fKlJAxrWVZa2K+PqTxXzSTFwuKAHyjRnk2Hl9RntLwtlySfLqqR2QKtwn3il8B
 EFNM6YmzlyFu/v/N4Fmdv5PdKdb7umpz57k5kuch9PR0+M57l2L7slpnJtEdgpQ1sLdI
 yGnURyOa2TShMO8CvlQjnoAO+2Cjl8oUgOGjmSQBWhhruXcybjVoRFyxkAdI0WE+NG89
 h4QSYhWsu74v+w2dW21qwT+EC0jvpRPeeZ2hL0iPpPZvfuhY/Bq4HFJ4SKswoqmTIzop
 yw4t3BOoMTD2Kx9HYsi5Wf5gVsCZbBF7e2o4IwkiqLX/B4vZxQD1mgx34iThcv/58znc
 MYHw==
X-Gm-Message-State: AOAM530BXcaR8D1G9uUrITxIAHexhjbgwTre15w+FQ2SPNCRqikHDgu7
 sfyVE7nBE3nvJfv03dN8BV7B3mUl/f+xbg==
X-Google-Smtp-Source: ABdhPJxzvXH7y+AgpGImwY7Ohv4TD0W879I4raZROUMyXL+Tlt8ndV+/2vyPo7eTR0OUW8KewvN/2A==
X-Received: by 2002:a1c:ac88:: with SMTP id v130mr3969213wme.43.1602086443846; 
 Wed, 07 Oct 2020 09:00:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q13sm3496758wra.93.2020.10.07.09.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:00:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6414E1FF8F;
 Wed,  7 Oct 2020 17:00:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 03/22] hw/ide: restore replay support of IDE
Date: Wed,  7 Oct 2020 17:00:19 +0100
Message-Id: <20201007160038.26953-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007160038.26953-1-alex.bennee@linaro.org>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "open list:IDE" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A recent change to weak reset handling broke replay due to the use of
aio_bh_schedule_oneshot instead of the replay aware
replay_bh_schedule_oneshot_event.

Fixes: 55adb3c456 ("ide: cancel pending callbacks on SRST")
Suggested-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/ide/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 0e32abd779..693b352d5e 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2289,8 +2289,8 @@ void ide_ctrl_write(void *opaque, uint32_t addr, uint32_t val)
             s = &bus->ifs[i];
             s->status |= BUSY_STAT;
         }
-        aio_bh_schedule_oneshot(qemu_get_aio_context(),
-                                ide_bus_perform_srst, bus);
+        replay_bh_schedule_oneshot_event(qemu_get_aio_context(),
+                                         ide_bus_perform_srst, bus);
     }
 
     bus->cmd = val;
-- 
2.20.1


