Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F105C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A2520735
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iYSLRaPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A2520735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS090-0007z5-5a
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqM-00072B-63
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:37 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqK-0007KB-CR
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:33 -0400
Received: by mail-wm1-x343.google.com with SMTP id a72so6921543wme.5
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+rL5y+LPIlyoU3TM7H1gns6WWZrHXRx5K1wFTm/QiuM=;
 b=iYSLRaPqYYm55PYEe2u/gTksh2DYtlQokYWvM4HiWEY591jCkZjXlvE9Mz6wVNvzdj
 V7qOhCBqCi/pArufM/CE7v2jlImzg0wx76ZOQacNHpTAnJ0IBnhz9uC7sYU/GGebLldo
 e0U3FfKg4ytb0CxgMN/hzId/Y41ZdOCl9g3kUV9OKgtUmDBP1KjXuTgGcKHSf6YljeyT
 vU8p6NTtoHbUpBYKl8ighOGm7ygULVeUPcdqyFhRbEEFUxCcd4CFOFJbWbeIyB4V7xUJ
 f7Qh1svo9X+M8jEY+XB7ucnTrVmhfEgEWP2RLVUexTHUU0UnDAQEriJptvFGpt+GRcI4
 D5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+rL5y+LPIlyoU3TM7H1gns6WWZrHXRx5K1wFTm/QiuM=;
 b=EnzDU+BQjP3PrHRviV8T9Lswwd4bLMN50IOBRF3TPhuURD4AlsCj3o6QYk8ezdZM8+
 bOkajBrZC1RFW9WirpkHtnVbIjmKaGEMZ0YkVeMbtSi1hhdRtMVLRdcayrH8JgFgjjCB
 Cgx1S4UXBDuFwqZmZGohoIFckKedRDWIj/A+8TxAHEOUmii3eCGKZzz6MNtF9xNKhuis
 +BV4xO1+JKeS1wbWzJa3zlF8aCZyoHesEEJUO87BFI+I/REr1SkCAywuD9A++UnWGHwD
 bd3FKrL/L3Aqm8SFyUzJQz0EZtH2YjOc/MOevBi9+G783izpj3YvvFPs9TGh2IO7FXyU
 RZOA==
X-Gm-Message-State: AOAM533X67DQ7i7QDRgF4ezMhWPipjJSV2YCyH3lgowvWlYWOXIp0on6
 jlE98UmLfvpd+mdhDDFWC+S4aCa5o++MzwVF
X-Google-Smtp-Source: ABdhPJwF+yWue4chDZSyrgNYqc2uiQYCfPFKmGc7jxqKUcC/k2E33P6KIKyDGKsAKe0EaL4fAyqfTQ==
X-Received: by 2002:a1c:6457:: with SMTP id y84mr11141811wmb.36.1602516871079; 
 Mon, 12 Oct 2020 08:34:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm19675284wrq.73.2020.10.12.08.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:34:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/timer/armv7m_systick: assert that board code set
 system_clock_scale
Date: Mon, 12 Oct 2020 16:33:41 +0100
Message-Id: <20201012153408.9747-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153408.9747-1-peter.maydell@linaro.org>
References: <20201012153408.9747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is the responsibility of board code for an armv7m system to set
system_clock_scale appropriately for the CPU speed of the core.
If it forgets to do this, then QEMU will hang if the guest tries
to use the systick timer in the "tick at the CPU clock frequency" mode.

We forgot that in a couple of our boards (see commits ce4f70e81ed23c93f,
e7e5a9595ab1136). Add an assertion in the systick reset method so
we don't let any new boards in with the same bug.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
In the longer term we should make this a clocktree input and
plumb it through the armv7m container and so on, but for the
moment this assert() improves the current situation.
---
 hw/timer/armv7m_systick.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
index 74c58bcf245..a8cec7eb56b 100644
--- a/hw/timer/armv7m_systick.c
+++ b/hw/timer/armv7m_systick.c
@@ -202,6 +202,14 @@ static void systick_reset(DeviceState *dev)
 {
     SysTickState *s = SYSTICK(dev);
 
+    /*
+     * Forgetting to set system_clock_scale is always a board code
+     * bug. We can't check this earlier because for some boards
+     * (like stellaris) it is not yet configured at the point where
+     * the systick device is realized.
+     */
+    assert(system_clock_scale != 0);
+
     s->control = 0;
     s->reload = 0;
     s->tick = 0;
-- 
2.20.1


