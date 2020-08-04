Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A20C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 00:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A6C22B42
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 00:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ha8gFfo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A6C22B42
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2kq6-0003LP-Hb
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 20:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3x6soXwMKCsAviimuumrk.iuswks0-jk1krtutmt0.uxm@flex--pcc.bounces.google.com>)
 id 1k2kp9-0002lx-8r
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 20:28:59 -0400
Received: from mail-qv1-xf4a.google.com ([2607:f8b0:4864:20::f4a]:49895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3x6soXwMKCsAviimuumrk.iuswks0-jk1krtutmt0.uxm@flex--pcc.bounces.google.com>)
 id 1k2kp7-0006p1-QB
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 20:28:58 -0400
Received: by mail-qv1-xf4a.google.com with SMTP id l18so8954732qvq.16
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 17:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=xqQGOC1I8/LJEKXsAn6LIqZnaJheV9poec5ecJcapYc=;
 b=ha8gFfo1JR3XksH6aVZxPAg/K4TUcq5E2q98umkm4HTyTvmaNwBHNuHD/dlY2eeVw6
 jiJ6mnBS/X0sjPekaBOmAdOT85mYJ//nrXDPR7gdRZgYfC0mu+sI+mGSPjH0HhgaX/5H
 OIRMr5qb/Ar3G0cD1Vowuxa89u6MzzZ2kbdDVPiBdDA0ccbCCV9IL9PtgUDyMFiDd5b/
 uGwgq0WvJs9JmdOl6jN0F4ifZqRme/aTTC8qxEJI/h5AucxOTGH31axXzYhc2ZvWhj1R
 K8BGcu5hupPJmnJLyU/Xrg7LjsjSI6TOXbYIp9eaqGbDn+Q7m7QSzAWnmBL3qppHUXEa
 7xWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=xqQGOC1I8/LJEKXsAn6LIqZnaJheV9poec5ecJcapYc=;
 b=GmtqBJSQ5uoFKn48+Bcz1jwx7+uO2T13Ji9OQU/kEL/84ohUOiGHhIGDDZfqrvEa4t
 7DmO5tb6XlUryfX8gJXayEsKMt8EjCM0OgENCTTymzZZillcoeZ9H1rdvAiAlLXViGCL
 kg0fP4g17j66wwUow3FDoLakPlw3/YBrBOyVC485kzbvJAzSAzdLvwkkwi/BTbfU3PXA
 Uao/x3fdDqM3RpYc+4j/G95+z862LKkBePDDbCEp4Ep8tBEmpMsyCldsHZjdUmIV6l24
 78GHE7hVC1rVuwLmQjkL5OOkfW2DhMbylTyCK/Nl2susdFkfT/+Y61eNUKLSnNd3tX4z
 eM8Q==
X-Gm-Message-State: AOAM532pIDIjYk0LLv37OauC5jbwPYY69oKDbbJAGLSytDNOzNd4PfkR
 Tg3qu7cn9VGUSiiCj1GRYoXyLlk=
X-Google-Smtp-Source: ABdhPJy7hnvMnTR990+xA0oC4VY89d/MPuufPc9gZnDKilxDBx3gQncWG22EbRFdxRmy5gRVWxY3eDk=
X-Received: by 2002:a0c:b2d6:: with SMTP id d22mr19104308qvf.209.1596500935249; 
 Mon, 03 Aug 2020 17:28:55 -0700 (PDT)
Date: Mon,  3 Aug 2020 17:28:49 -0700
Message-Id: <20200804002849.30268-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2] target/arm: Fix decode of LDRA[AB] instructions
From: Peter Collingbourne <pcc@google.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Cc: Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f4a;
 envelope-from=3x6soXwMKCsAviimuumrk.iuswks0-jk1krtutmt0.uxm@flex--pcc.bounces.google.com;
 helo=mail-qv1-xf4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These instructions use zero as the discriminator, not SP.

Signed-off-by: Peter Collingbourne <pcc@google.com>
---
v2:
- fixed commit message

 target/arm/translate-a64.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8c0764957c..c996ca1393 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3429,9 +3429,11 @@ static void disas_ldst_pac(DisasContext *s, uint32_t insn,
 
     if (s->pauth_active) {
         if (use_key_a) {
-            gen_helper_autda(dirty_addr, cpu_env, dirty_addr, cpu_X[31]);
+            gen_helper_autda(dirty_addr, cpu_env, dirty_addr,
+                             new_tmp_a64_zero(s));
         } else {
-            gen_helper_autdb(dirty_addr, cpu_env, dirty_addr, cpu_X[31]);
+            gen_helper_autdb(dirty_addr, cpu_env, dirty_addr,
+                             new_tmp_a64_zero(s));
         }
     }
 
-- 
2.28.0.163.g6104cc2f0b6-goog


