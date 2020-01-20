Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9B9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 879C82070C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gmFWvdMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879C82070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYk8-0001vW-L8
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 10:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itYiV-0000EY-AL
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:11:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itYiU-0008M1-04
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:11:51 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itYiT-0008Lg-Qf
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:11:49 -0500
Received: by mail-wm1-x341.google.com with SMTP id u2so15064606wmc.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 07:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kyP6q/PhV5q+RaHRDmSj+IKiauIeyDHvRutDmqUe9TM=;
 b=gmFWvdMVHZdDdkLnWlhAd6LBFtHjJ/H4BfnvWeviQe6SELJfIDInXNrzWP/zhQD0jl
 Dyqvt6vrFSSSj7aE8MLfZnScGF3lFqpWLuUO1lJ6U/KN0zVpepR3tc2bILRUfpNdH1h2
 o31ZZap1E19pHzPFLgaPVIZZn33LytsE+WjOFTCgBqppJj67/4qgwYfC9UIwxNjAKLI+
 EYefjjYyqsSILgC5TTl88DkGY78Cz1hiIdEAA5ZGL91CmSqfN4b0NpEvqSfs8GMuVjxE
 YHlO0VHkHCTYq2lpgcdPaVsKZu0T6cNug9V3OzLLlKF9KFiTt5CkIl6y971a/gY4FeSC
 jNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kyP6q/PhV5q+RaHRDmSj+IKiauIeyDHvRutDmqUe9TM=;
 b=mksCwcXMVZQPyAOe1uR69+9AkDSRLRLITQw+GRFIsmszYO/67Qg8YPGjiCzElZtpke
 Eoci9Pk+bHeaiA/TTb14+sJEnUAHOmCWHxm4zNv/c+CDYvj7094aTpBdp4eINzUCGArN
 4yLaCVrOi2eOotT2V0J04egEPuOEiMeakeihYjyGs0wwNZcU2yA5Ux+ban98ORr3vFCV
 C3ncuPzUxUANb9k1a4i4hADCFMxtpm3cA5brxWbe/FymqLf+3smgH0QJ7ldOOBpBTQ2B
 ZjbkBAlVNJfD9erKQREKbpk6zJUPY4+CKSXACN+nbl6l1zqPGjovULiokLaVUAP0pduA
 +tCQ==
X-Gm-Message-State: APjAAAX5+ccuLLP9Bf2t2XS4N3dbEU23cykOuL+vIzdA8maUfsCJmhhH
 AkMCsQvYjmqkme/WFyExVk1SvoxXrkJiQw==
X-Google-Smtp-Source: APXvYqyc80UUcu6KJhT1DViU45TyXQ/wVJ4FpXqlR8NsLjJUxtTzatzrz9EFpMW0aj+uH5c9IhYHCg==
X-Received: by 2002:a05:600c:21ce:: with SMTP id
 x14mr19142404wmj.120.1579533108520; 
 Mon, 20 Jan 2020 07:11:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f17sm817919wmc.8.2020.01.20.07.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 07:11:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] hw/display/qxl.c: Use trace_event_get_state_backends()
Date: Mon, 20 Jan 2020 15:11:42 +0000
Message-Id: <20200120151142.18954-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200120151142.18954-1-peter.maydell@linaro.org>
References: <20200120151142.18954-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

The preferred way to test whether a trace event is enabled is to
use trace_event_get_state_backends(), because this will give the
correct answer (allowing expensive computations to be skipped)
whether the trace event is compile-time or run-time disabled.
Convert the old-style direct use of TRACE_FOO_ENABLED.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/qxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 6d43b7433cf..80a4dcc40e4 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1764,7 +1764,7 @@ async_common:
         qxl_set_mode(d, val, 0);
         break;
     case QXL_IO_LOG:
-        if (TRACE_QXL_IO_LOG_ENABLED || d->guestdebug) {
+        if (trace_event_get_state_backends(TRACE_QXL_IO_LOG) || d->guestdebug) {
             /* We cannot trust the guest to NUL terminate d->ram->log_buf */
             char *log_buf = g_strndup((const char *)d->ram->log_buf,
                                       sizeof(d->ram->log_buf));
-- 
2.20.1


