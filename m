Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EC9CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:48:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430402053B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N/t+f1kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430402053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMY2i-0003Ys-3x
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMXye-0007vR-AZ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMXyd-0000lN-74
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:44:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38184)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMXyd-0000l0-1R
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:44:03 -0400
Received: by mail-wm1-x343.google.com with SMTP id 3so12873879wmi.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 06:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NNjgD+GMiDONMUPjFkwhkEedG5MwQW3b1aiW+hJXhJM=;
 b=N/t+f1kxwHRhc3Ul+j00FsXHLTaQ8Op0R/eO+UlTIUYNP2BOqepg29BeALVA6eTtZm
 +drJXtNSwBGQGBg0dIDsaD+1wNwSDXqk5bqrAI+k2LQ6mFksMlbEcBs/SidsPYYtEDcg
 UbfFEz6ehGctKvOKh36RzyOomKTq0MYaMqjEpHekYSStu/VjYSA5W7qhvOu7UfODiJ3q
 dRmO1YUbL2jh2GGn8qc3+roNw0eVHV1UmNdP9we2uP4PBX95cNZo1pliwON0BQDycCDS
 YQfKV30nf+vhafow+B4oK7SjukN8Ql5xK4LkBszNPd+kTLZPRF6f2Dar0ERdRlhNmlgu
 +ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NNjgD+GMiDONMUPjFkwhkEedG5MwQW3b1aiW+hJXhJM=;
 b=k1dfh1hHsyrIo1UJXWVoV2lSWHxMeDXjtYonqtZBZ51xOhLuQQuMqKRNPwSCeCgefq
 KXQKtVMGTYgJVPGCsRGOys8nHw7E5U1NWvcIhr0apJAzUqpPXjLavpze8G8y/VvjTSEX
 9qaCbEPbk1tWS0BoJCuwQfo2RPAP1FdIBAnsWkasX1QWGYxhwH+YXxDCGEPJDfybl8bH
 VINd1y1c2ha3xAjVGYpq5DB4AiweeJ1jx8vzU9AgiIGKKFkp28qF632HZL5q0PpVG/Fv
 N/SJiehKjWUYjSh96WYdO8lCZZKEPg9xcVUyBq1h1dpoI4PPv3i5B4zbxyu2v/jIuG9T
 jDkg==
X-Gm-Message-State: APjAAAUiUUKb08QRy70c13OPqvMrFORTGsmK1u7dpCHpn47al7eLUrF4
 jslAo/Mo39lQ93V+nRprOqsh3dh7Tqk=
X-Google-Smtp-Source: APXvYqxGyTnCS52dxqs4VzTzYLDqIXGCAq+liZ9wFZhp1LniQxoGEnhDJxgG03P/DWYLmRHqXCB3dw==
X-Received: by 2002:a05:600c:214:: with SMTP id
 20mr19890800wmi.45.1571665441708; 
 Mon, 21 Oct 2019 06:44:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q196sm10443689wme.23.2019.10.21.06.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2019 06:44:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] hw/timer/slavio_timer: Remove useless check for NULL
 t->timer
Date: Mon, 21 Oct 2019 14:43:55 +0100
Message-Id: <20191021134357.14266-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191021134357.14266-1-peter.maydell@linaro.org>
References: <20191021134357.14266-1-peter.maydell@linaro.org>
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the slavio timer devcie, the ptimer TimerContext::timer is
always created by slavio_timer_init(), so there's no need to
check it for NULL; remove the single unneeded NULL check.

This will be useful to avoid compiler/Coverity errors when
a subsequent change adds a use of t->timer before the location
we currently do the NULL check.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/slavio_timer.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 692d213897d..890dd53f8d8 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -227,13 +227,11 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
             // set limit, reset counter
             qemu_irq_lower(t->irq);
             t->limit = val & TIMER_MAX_COUNT32;
-            if (t->timer) {
-                if (t->limit == 0) { /* free-run */
-                    ptimer_set_limit(t->timer,
-                                     LIMIT_TO_PERIODS(TIMER_MAX_COUNT32), 1);
-                } else {
-                    ptimer_set_limit(t->timer, LIMIT_TO_PERIODS(t->limit), 1);
-                }
+            if (t->limit == 0) { /* free-run */
+                ptimer_set_limit(t->timer,
+                                 LIMIT_TO_PERIODS(TIMER_MAX_COUNT32), 1);
+            } else {
+                ptimer_set_limit(t->timer, LIMIT_TO_PERIODS(t->limit), 1);
             }
         }
         break;
-- 
2.20.1


