Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9996EC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04820206E3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cNMioLAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04820206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJPs-0000qF-0l
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 07:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJMv-0006nb-IN
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:00 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:43686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJMo-0007bd-ND
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:36:54 -0400
Received: by mail-wr1-x42a.google.com with SMTP id k15so1437569wrn.10
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 04:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dapbAby+p+IB97tixpUV9qcke8guPCQp0Q97X2paJKo=;
 b=cNMioLAmqS0sE4QwG7m5Zykam0aEw+OAy/8SEUBm08fCjUCaOFi8CNZGt0KqY0tVQz
 PKbop8DuzpByiCDMV9qVDNViMzYo/1C2tBTUJDESD7IoT8AeAFNlDkkbGUK3wwZHgRnv
 VwTbyGfN4rFE+6nuRO9XrADSTWuXbzdNHnVkXfQdoWVp5d3DB9JixZmDp7cPNlC7qU7X
 DyPtdIZ3JZcQojCqQqHwP7B/D/zreiHxvaxsAQsrMb4WokWgElegRYkBKmshMmM7ZqzC
 551QGcynN3LgmfhjtB2WStb7ckyhz1ejNiVAJkqoINZzZMwTtABjfR8vFlNS/Gpn0N2k
 uwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dapbAby+p+IB97tixpUV9qcke8guPCQp0Q97X2paJKo=;
 b=qAA22JvrgzQh3GJVm/HcidyBjh3kI+iDv0ZkUXXzE7VmB8JpqjQ4nRRNFblNnLXDSL
 kD6xbnA4+CLcc+3NNst7vuYjDRRT8ppcgjjdJxx3dEYQrHWeRz2QAaWADdLLbYi3BQpf
 7M9TgEvp+RUDPECzDTZMFPxQYqQ4Z7IuturD5AV63J1rnjlFSczYoOjOYOI0kPastNC1
 25+1sndwmDnJY+NAVHlc/aGCd7eBkoiEk5dmAfhGWc/viP4i/Qx+7G8BNlqnaT8xkueO
 cyXpf09TSQNQGjtJ4azr1HbplcdFEimkA2tnYei3VZWJIMjfXgVTxzbmf9LGBjxTtJco
 543g==
X-Gm-Message-State: AOAM532WxF1dkI5iwrV0VG/d0kA9QvXwI5utaomu1aGnAZDRWJXaB5ei
 urpotT+U/4pRXuOy2G7kiBXLQg==
X-Google-Smtp-Source: ABdhPJzlG5Hanjkan2nIbrKMLf0U3fYzelH1OQCvLSAqjp2vi9ebTjtwl//lGJya1cYHb8IIJ3euEw==
X-Received: by 2002:adf:ed12:: with SMTP id a18mr2712195wro.178.1601638609197; 
 Fri, 02 Oct 2020 04:36:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w5sm1537648wmg.42.2020.10.02.04.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 04:36:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 065B01FF87;
 Fri,  2 Oct 2020 12:36:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 01/14] migration: Silence compiler warning in
 global_state_store_running()
Date: Fri,  2 Oct 2020 12:36:32 +0100
Message-Id: <20201002113645.17693-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201002113645.17693-1-alex.bennee@linaro.org>
References: <20201002113645.17693-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

GCC 9.3.0 on Ubuntu complains:

In file included from /usr/include/string.h:495,
                 from /home/travis/build/huth/qemu/include/qemu/osdep.h:87,
                 from ../migration/global_state.c:13:
In function ‘strncpy’,
    inlined from ‘global_state_store_running’ at ../migration/global_state.c:47:5:
/usr/include/x86_64-linux-gnu/bits/string_fortified.h:106:10: error:
 ‘__builtin_strncpy’ specified bound 100 equals destination size [-Werror=stringop-truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

... but we apparently really want to do a strncpy here - the size is already
checked with the assert() statement right in front of it. To silence the
warning, simply replace it with our strpadcpy() function.

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com> (two years ago)
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200918103430.297167-4-thuth@redhat.com>
Message-Id: <20200925154027.12672-5-alex.bennee@linaro.org>

diff --git a/migration/global_state.c b/migration/global_state.c
index 25311479a4..a33947ca32 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -44,8 +44,8 @@ void global_state_store_running(void)
 {
     const char *state = RunState_str(RUN_STATE_RUNNING);
     assert(strlen(state) < sizeof(global_state.runstate));
-    strncpy((char *)global_state.runstate,
-           state, sizeof(global_state.runstate));
+    strpadcpy((char *)global_state.runstate, sizeof(global_state.runstate),
+              state, '\0');
 }
 
 bool global_state_received(void)
-- 
2.20.1


