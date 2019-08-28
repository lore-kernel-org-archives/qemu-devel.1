Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770D9C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C07214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ajhz8MJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C07214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i31Ok-0004BN-Bg
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 13:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i31CJ-0007oF-1c
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i31CH-00013b-QF
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:26 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i31CD-0000tM-VB
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:23 -0400
Received: by mail-wm1-x344.google.com with SMTP id p13so811955wmh.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 09:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rVdkSzu7T7YfYwM2o/2/4ishC2eiSSFgkpF8Efr9l+Y=;
 b=Ajhz8MJeMhcs+hycgsyyQxLquHNoG0UiYZlogabY7dFPNezTIO13LlAyOumozOMSsM
 kkpniY3O6nie1ScKOp5W2Nl7JDKtlTyptboSAl3ZBeGQl5gsllIfIy7Uv68jO0zYTA1M
 bz2gbwYOMlJRn6coycdU1J9QeYqKmT+Lb62ehGWlAx5aXgr4hOyFlA5bkpSYAAyr5NNX
 h8u8jD+lr986kn3+wyAMLPSCzkU3kaamnqqwnm9MP44jf/Er7bJaIViSadw7/siDGwnz
 GJN9wKrswc88H8wjNXfJmHi/UFLtEtMGfPh9jroNH79Oryjdbao1q7vnVc4Mow7j5L41
 tc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rVdkSzu7T7YfYwM2o/2/4ishC2eiSSFgkpF8Efr9l+Y=;
 b=INZBS+L2IX/kN8iHKPQzTqut6V4MXk6M0C0SVnZJkjmWLM5/D2aD3ITtW8w5A8YHiM
 Nu/7i42vdWBhaY9vL3/ENqL0MG26YXboV6pUEHqZX6jD93TvjndzYMFrSKCbpCoGocYv
 PNl1C58wItIZLw9nvjjTeJLayfk/bjLB0McBPojRES2lSydcgHQBI/iwTzW96JYEq/nh
 1bTNYqCIP/mWD6w8V22xVoQmQjnj3aoB2Ps0TqcQC9xrWgeCiyGoOVCXHxikB/kfAF0q
 rrZHMFAxbqW/gK2S2f4TlOcrMRndFIPFkA0OdkMVL1GL4OKJ81I9mEDwhl12JYXkGrI8
 9Tqg==
X-Gm-Message-State: APjAAAWNr5CrdNcWGLaTRFTGVPjwm9v6nNR+Nh667+pGA/TOR1tRnYR3
 XgZAAlu1qH5kUOafmWlcD6L9Dg==
X-Google-Smtp-Source: APXvYqzr/nrxTbXgv4UuSLilxI5awpijeKLS0bxl4JadvJ9xlETkYRgwp9GQzIGmcI8jj+sOJ+u0ZA==
X-Received: by 2002:a1c:ca0c:: with SMTP id a12mr5860465wmg.71.1567011193875; 
 Wed, 28 Aug 2019 09:53:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f10sm1962046wrw.16.2019.08.28.09.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 09:53:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 254D81FF99;
 Wed, 28 Aug 2019 17:53:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 17:53:07 +0100
Message-Id: <20190828165307.18321-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828165307.18321-1-alex.bennee@linaro.org>
References: <20190828165307.18321-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH  v1 9/9] include/exec/cpu-defs.h: fix typo
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 189709b6deb..be946ba1ce5 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -231,7 +231,7 @@ typedef struct CPUTLB { } CPUTLB;
 #endif  /* !CONFIG_USER_ONLY && CONFIG_TCG */
 
 /*
- * This structure must be placed in ArchCPU immedately
+ * This structure must be placed in ArchCPU immediately
  * before CPUArchState, as a field named "neg".
  */
 typedef struct CPUNegativeOffsetState {
-- 
2.20.1


