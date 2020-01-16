Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD58C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 21:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 074E420661
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 21:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfnIR0pc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074E420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isCOD-0006pk-QV
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 16:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isCKi-0002Wn-3c
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 16:05:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isCKg-0007UU-Vi
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 16:05:39 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46056)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isCKg-0007TF-Pf
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 16:05:38 -0500
Received: by mail-pf1-x444.google.com with SMTP id 2so10815747pfg.12
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 13:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ncyinpMmDKy28yziRLqa0f0i557ZSdsPadwgIMhtoD8=;
 b=TfnIR0pc2BgqyNOTZwgucsEvmC8Nsp8gd0WKM+wpmyS0srNV0sYfQz2m5NcJs1BIUj
 BHtelKdHOuT1os3b0LvX+hyVGYQU/XWA2Y5UACwCuUzUL5SJPWIZSkurf5rYunLZYF0A
 E91BjEZzXzpqjMretOLEaA1o5f6Az6SwzyZeQfcjSnSK10hu3RLnPurdnpJZganDGm0H
 cryrqdkejbpIZpRjD8TkD6m7xEdmrWpnEyZTN/JJ54Jn71dUl70i9maus1VgqPexmHVQ
 1VPYEfR0GiARH6JVwt4tBDLsbF8cawTMQOyOpFMJtPQbs8gGC3aVtxrD0HEopVV/oUYx
 G0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ncyinpMmDKy28yziRLqa0f0i557ZSdsPadwgIMhtoD8=;
 b=NSK2ATHcoICGEFic+Iza0aAs2OyMtyp+KauTb3Ys1wJV07vf75R9Sn2XRsoB2Vf1xY
 mivNJFBhiRwwKroImeqgMzKrlbBqCtfnrqPj1/E5L+tNZfv1NQ3obRXiUlC6EmmatPEC
 HecL+qNy80uggwE5b3dNd6TA9d7vJk8M6D4qMYY6dTJoYZrvXFJhovaiSyUwuTELtyfG
 Ea8JBWeikNKSehAlnTvBUwdBM4WtnZSBbAYkxWZ6CBasa1VTZWjAhawgJis1S4jD7uTT
 dY1nOYwjfittTSzJ1rFOHI1PZkC6NxJvfR+JUEbk/Nlkm1t11fOQazqMm90tiiHSf0WU
 3cCw==
X-Gm-Message-State: APjAAAVmuBIE5DC0A29X+whmL/cglGIzIjRefDg+yilwa4D1XrcTa020
 b5K+ubOP3BKH5wlKF8uBcsjrTCDLC/s=
X-Google-Smtp-Source: APXvYqyUa9RISP966WWhk58TQ6bQjz0g5tCkw6Iwo7TzJLK1w6ii0jbuP9n6wFzwopiW4t674b45mg==
X-Received: by 2002:a63:358a:: with SMTP id
 c132mr42324420pga.286.1579208737494; 
 Thu, 16 Jan 2020 13:05:37 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id k21sm25494907pgt.22.2020.01.16.13.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 13:05:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] vl: Remove useless test in configure_accelerators
Date: Thu, 16 Jan 2020 11:05:27 -1000
Message-Id: <20200116210528.31953-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116210528.31953-1-richard.henderson@linaro.org>
References: <20200116210528.31953-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, aleksandar.m.mail@gmail.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The result of g_strsplit is never NULL.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 3e2b77a4e8..8ae8a5d241 100644
--- a/vl.c
+++ b/vl.c
@@ -2781,7 +2781,7 @@ static void configure_accelerators(const char *progname)
 
         accel_list = g_strsplit(accel, ":", 0);
 
-        for (tmp = accel_list; tmp && *tmp; tmp++) {
+        for (tmp = accel_list; *tmp; tmp++) {
             /*
              * Filter invalid accelerators here, to prevent obscenities
              * such as "-machine accel=tcg,,thread=single".
-- 
2.20.1


