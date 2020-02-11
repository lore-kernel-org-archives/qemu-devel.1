Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6E6C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B26A20848
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3vs9c7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B26A20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1TSw-0008Nz-Je
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 06:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j1TRe-0006et-FR
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j1TRd-00069F-8o
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:11:10 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j1TRb-00067Q-Vt
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:11:09 -0500
Received: by mail-wm1-x344.google.com with SMTP id s10so2952855wmh.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 03:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xiuLr2bgSRxDP5CJng9ok5G0lC9iDI/XVskdjRAUAgg=;
 b=E3vs9c7fahija2XGr6++VsgiMj4LD/gkIHv5taOUKomglv4MW4BQ+Uo1ECmBQRxEo/
 FWPpyvWvJfSbvtdjIGuIklOdtH6/FP8Dlqu+b8Gw2kaQWoir/t1fcU1wJlKdWGFTLIKc
 vgn0CBtHr1LIYj1kheghs7RqN/9YwCa1+IoVwR2YouBHiu3oA3C3D1dbHiH9e0BJ8BEo
 Ge22uF11K4iVco6l92ie3niulGP3sRDinXrywjBOouOZcZaGJCsxtj2Xr90t2P2LspuU
 jEqqjj5xi2gP2afCMUxzvEskUtk0b5esnve4/sqhNYVA3B3ABrP5g8REhWVnV/Qfl2Gx
 DCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xiuLr2bgSRxDP5CJng9ok5G0lC9iDI/XVskdjRAUAgg=;
 b=FxAymaocNYeh04VWTfFzPSBZrx4iIf6DA9MHbtoo2cWP03crpEBpFfs37YIYIN4jOc
 XCVji/Hu/iaIUNjtAyPQUrNiSb6gvhuQeap4QsJqUxMKY/xVv+IAf+VgrwVzBuG8pvzj
 /nDSfuSc7KwIvVdx32uMZlJWSS7h8oDhGekkVB73lU/BHJolzEf+6tJ8CbaD/rbfidZS
 q4txpOE7GRpfwuvI3rSmmXKU4QLQ9vc+6jnhagNtpoVXSdLH4Juncj+mAKhhpskzA0E7
 uAaWj7NuH2bs3EfTEY0W4yoRYq5ilTbR/0KgBFXp8HaJKi9N5k1ou06xhHWNAvUfEWUg
 Lj5Q==
X-Gm-Message-State: APjAAAWsFv1CPjOezZQvYv+26yaxUaWwWeYyOAwZeg5QLltA4XWPbckp
 S6xaZ0PbxrRd0MD+sH6MwxpG1w==
X-Google-Smtp-Source: APXvYqxT/W4VfZUj5i+HHD9phypXXawQKkXVCadtTmUpLqSETMfwDiPNK/FTS5HyC8GmxwcHt+YcnA==
X-Received: by 2002:a1c:a78b:: with SMTP id q133mr4995353wme.28.1581419465790; 
 Tue, 11 Feb 2020 03:11:05 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q3sm3198949wmj.38.2020.02.11.03.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 03:11:04 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9E4EF1FF87;
 Tue, 11 Feb 2020 11:11:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tracing: only allow -trace to override -D if set
Date: Tue, 11 Feb 2020 11:10:54 +0000
Message-Id: <20200211111054.27538-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Otherwise any -D settings the user may have made get ignored.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 trace/control.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/trace/control.c b/trace/control.c
index 6c775e68eba..2ffe0008184 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -226,10 +226,15 @@ void trace_init_file(const char *file)
 #ifdef CONFIG_TRACE_SIMPLE
     st_set_trace_file(file);
 #elif defined CONFIG_TRACE_LOG
-    /* If both the simple and the log backends are enabled, "--trace file"
-     * only applies to the simple backend; use "-D" for the log backend.
+    /*
+     * If both the simple and the log backends are enabled, "--trace file"
+     * only applies to the simple backend; use "-D" for the log
+     * backend. However we should only override -D if we actually have
+     * something to override it with.
      */
-    qemu_set_log_filename(file, &error_fatal);
+    if (file) {
+        qemu_set_log_filename(file, &error_fatal);
+    }
 #else
     if (file) {
         fprintf(stderr, "error: --trace file=...: "
-- 
2.20.1


