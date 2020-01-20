Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2639BC33CB8
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A5222314
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gzddz73z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A5222314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYkB-0001yp-Ig
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 10:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itYiV-0000ET-6B
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:11:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itYiR-0008Km-PJ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:11:50 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40420)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itYiR-0008KS-JE
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:11:47 -0500
Received: by mail-wm1-x343.google.com with SMTP id t14so15048903wmi.5
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 07:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QOlYVQbhK3uxfa0fBYUIEX4IDujmYIqF+cSXeERZjfU=;
 b=gzddz73zO6fGsc/ZWn+pX3n5TwUHqyQoErZijB3Qf36+gNsTUWaRT8yTzQwBLI1hFX
 a44LHcRz/GhcGlSZyiRDjMuJXWgKKzmst9m5lPNpwJahgz0uX1Ul7rftfsIzebjTZ5l7
 hRUy3XfMQDRSL6QZcbO71NwYFikaUtRrI0fPrIiXCNDbUbyQQjdBFiCv8Hn8IuyvItLc
 lwYuXk/BQsGL+0N4P/GBX1Z2FjwFtr8DIc0FP/z+v3y1MuhHq3gshP3qvBASEOKAdxtR
 a3U6DmXZ5H8W8GYI+w4lKzVLazrD9z++k2bI1Bq10gb1pj+y+pnZ2SD2Om8P3/Ef3Nmm
 rt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QOlYVQbhK3uxfa0fBYUIEX4IDujmYIqF+cSXeERZjfU=;
 b=Q67SJBcp/nkFENXHQkmoNaD9CYSE8xm+bvDAIOQqqiCOsx4yf410dNCPyuQyVDzJwG
 sNHyHFp0gRTagaGjAYAXWOzGH8+Ns69djjCOro5XtOCbR/9jGk+V8/6jcRt5AYmYk2Hv
 E9S/ssdwNnlYiKPWpaJW26lj2/2lSIz5MljRqHYBNEhNLy4gGuPW4Zs+Ezay5b1+kXpJ
 wKpDASEv07ctGhnx/pcSc5H35KSwmCPkbItxPGf0ov+LyFwPB03Uk9+mMkjmOIjOnfpF
 36F/CuuKa83zttkfzbrnh4+d2OfxRU8/ZTWewLtREnE+3Any4XkADjYKGibfdYQ8i9d0
 lJqg==
X-Gm-Message-State: APjAAAUJXSvYKip2vtWA34NXsy+N8zXUT+yiJjYvp3lOzzMZR1F12+BS
 mtQLiYv5zxfMM+IPJlmaJbdIay4E93JazA==
X-Google-Smtp-Source: APXvYqzKXRQxfiJpw0NWeCNAk0o0HA7zpZtjx00Y3U1ZadzeXPKVW9GE3/FG1BcI6BpjsS0cvOQmvw==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr18611726wmi.45.1579533106313; 
 Mon, 20 Jan 2020 07:11:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f17sm817919wmc.8.2020.01.20.07.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 07:11:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] docs/devel/tracing.txt: Recommend only
 trace_event_get_state_backends()
Date: Mon, 20 Jan 2020 15:11:40 +0000
Message-Id: <20200120151142.18954-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200120151142.18954-1-peter.maydell@linaro.org>
References: <20200120151142.18954-1-peter.maydell@linaro.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of recommending checking the TRACE_FOO_ENABLED macro to
skip expensive computations needed only for tracing, recommend
only using trace_event_get_state_backends(). This works for both
compile-time and run-time disabling of events, and has no extra
performance impact if the event is compile-time disabled.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/tracing.txt | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
index 8c0376fefa4..cb5f685de9f 100644
--- a/docs/devel/tracing.txt
+++ b/docs/devel/tracing.txt
@@ -342,8 +342,10 @@ edit the "trace-events-all" file).
 
 In addition, there might be cases where relatively complex computations must be
 performed to generate values that are only used as arguments for a trace
-function. In these cases you can use the macro 'TRACE_${EVENT_NAME}_ENABLED' to
-guard such computations and avoid its compilation when the event is disabled:
+function. In these cases you can use 'trace_event_get_state_backends()' to
+guard such computations, so they are skipped if the event has been either
+compile-time disabled or run-time disabled. If the event is compile-time
+disabled, this check will have no performance impact.
 
     #include "trace.h"  /* needed for trace event prototype */
     
@@ -356,7 +358,7 @@ guard such computations and avoid its compilation when the event is disabled:
             align = getpagesize();
         }
         ptr = qemu_memalign(align, size);
-        if (TRACE_QEMU_VMALLOC_ENABLED) { /* preprocessor macro */
+        if (trace_event_get_state_backends(TRACE_QEMU_VMALLOC)) {
             void *complex;
             /* some complex computations to produce the 'complex' value */
             trace_qemu_vmalloc(size, ptr, complex);
@@ -364,10 +366,6 @@ guard such computations and avoid its compilation when the event is disabled:
         return ptr;
     }
 
-You can check both if the event has been disabled and is dynamically enabled at
-the same time using the 'trace_event_get_state_backends' routine (see header
-"trace/control.h" for more information).
-
 === "tcg" ===
 
 Guest code generated by TCG can be traced by defining an event with the "tcg"
-- 
2.20.1


