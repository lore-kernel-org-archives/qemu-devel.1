Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80258C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD672072D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4PtLl7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD672072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9BiO-00039a-Ft
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 12:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9Bg3-0007Uo-OD
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:49:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9Bg2-0006JH-OT
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:49:55 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38355)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9Bg2-0006Ii-Im
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:49:54 -0500
Received: by mail-wm1-x343.google.com with SMTP id u9so3792890wml.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 09:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BW8r3OV+Pyq8lB5xngUwKNwFXrFswSLDbGpWItcOSxQ=;
 b=Q4PtLl7+HZQYu7VMFn3dxi920sKXxwV2P7w6itTsq8iyzTwEfwZfG4aIul8mqwqMed
 R8qJV4HoFvWmm/tYYMEzQhEuHpxHqWzQH+AEi3VL7R76f6Cc6MRFmfJnLcMwwoWamjZU
 lMsEvUE/rqBF5jYRITmWZzSEIONBa8D7tb2hDeGbQ9IJtV+4yNwkU7fKUxsu9jBxDi4c
 mNMCSQ/L/VWbFnXbQF9zT39dg0NwNUrgvUeikTTXXgmiqctHiDZdmNOa3O4lz2tbgbKt
 EA3nCznqn6DHBOtb+/l5DgXlzYoU8Su925O6k8JoLV/+NnNoc0DPbzG5dzxAmwh2kHPh
 EtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BW8r3OV+Pyq8lB5xngUwKNwFXrFswSLDbGpWItcOSxQ=;
 b=dqdvXdIAuTCJtgeOuxfcyVzlWuaNlxf/TS4UxdFcO2ZOPNkeQkD2zsHZbujidJMnoi
 4wC+eYUCgXxjw/4uRW+JeZs6UI9gQMRAUs8/XWTgUPU2c/tErKEzJmMk67S7eJh3LbJN
 kggSxqpGSgfWauyZn2c0FO8Aiag+ONimZhzpEpfNP1gTjzhyC3CjEeVh647M36vtNlsr
 t0odhjuylZfd9Bq8MzFWpdMnDupb2W+LNwck65sX2982PhqfIFDo5hsCzHF6ldeC2ZWf
 8rBpfQqFw0n4xNKI2p9oiP3xgYBsMM7MSYakwccNDXMcEnbaS6dZx3bXONiNOd464Rax
 Wp/g==
X-Gm-Message-State: ANhLgQ1dXlOIAelWEM6XB4VJCPrkRYPJzmToUanbaz1t7fwtM+Dtd17A
 il9G7YHO6lIj27zkxp6850orcA==
X-Google-Smtp-Source: ADFU+vuaNG8fEhdim2g43Smqv+UUcQeCbXLEMRS0YyCS/z/eXCcszpfwWrWKZS8aP+E3ZvZ5YqUkxQ==
X-Received: by 2002:a1c:4b0d:: with SMTP id y13mr5450958wma.4.1583257793657;
 Tue, 03 Mar 2020 09:49:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d63sm4867576wmd.44.2020.03.03.09.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 09:49:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/4] hw/intc/armv7m_nvic: Rebuild hflags on reset
Date: Tue,  3 Mar 2020 17:49:47 +0000
Message-Id: <20200303174950.3298-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303174950.3298-1-peter.maydell@linaro.org>
References: <20200303174950.3298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some of an M-profile CPU's cached hflags state depends on state that's
in our NVIC object. We already do an hflags rebuild when the NVIC
registers are written, but we also need to do this on NVIC reset,
because there's no guarantee that this will happen before the
CPU reset.

This fixes an assertion due to mismatched hflags which happens if
the CPU is reset from inside a HardFault handler.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index a62587eb3f0..1ad35e55292 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2593,6 +2593,12 @@ static void armv7m_nvic_reset(DeviceState *dev)
             s->itns[i] = true;
         }
     }
+
+    /*
+     * We updated state that affects the CPU's MMUidx and thus its hflags;
+     * and we can't guarantee that we run before the CPU reset function.
+     */
+    arm_rebuild_hflags(&s->cpu->env);
 }
 
 static void nvic_systick_trigger(void *opaque, int n, int level)
-- 
2.20.1


