Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A9FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9744F21929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNMhZ45J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9744F21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtdd-0000sG-WF
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN2-000864-UM
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtMz-0003Ci-UY
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:51313)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtMu-0003A4-4J
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:40 -0400
Received: by mail-wm1-x334.google.com with SMTP id q70so790819wme.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d77se2AWHQTDPWAjRF6o7tLkcsKtKX6IpL5FuyPE0Bw=;
 b=pNMhZ45JBOvME59FiyNdglxMN/f9D8Do0wWVkbQIRwk5VNcrXvPBM/jZwGD9SfzL1q
 mAf4e5Eio+quxIUZYCFNvCsdew4uO0u01TWodA0NQs9vOELS7lgC1887gYmoLZsvI8om
 GrrRePeBaSy58RazAhCfiWTA2w/D8bRJYy0OtVg/2EQAz16VpbyO69IKwy90VknEH+Gb
 s0dYMXNYrtlvIzmFyaWeXbg6Sl55ASe2aXXzvh46zWjyNuz0hDgpnlAzDHtvcNAO+0RC
 uvZR8H5DtRoKZduEeuGPsU3Y7+61GdP2aOh3dyeGMBjvKABDE0F//lozLJ2GOSMlZgBV
 EyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d77se2AWHQTDPWAjRF6o7tLkcsKtKX6IpL5FuyPE0Bw=;
 b=NbX2+U0QXFGR0AJYzmhnsvKvGPTNF/8bsVNgkC0Fy6nSOn/EwcuR/sVRO+qjyAocHJ
 368yl9Y0mXPJFb3/N6am6uhqAn0uZRoOMa7B7LNICShpb+9NARWr/XwyLTbkNms5CUuj
 33+o3LHMhRe/309qEsBej6TzQwgSkoCcaP2HtweSzlrAApXzWFtnrRFUyFyv2lqUxXYa
 oR5EI+XOJ49ffT2EyBaeW7tEncMwlttcDYsXqyxy3MMa2jfBCwTo4NWmh2VS/tccOSjV
 7hyXCzNi3Q17z9itzsGsNFzw3suxKYXn6RrIOtbmXNwUVx1LySpnddQESGKWPXthveu5
 0Cjw==
X-Gm-Message-State: APjAAAVnzO1QvkcnnC4NnMVffSLNrMhD49gRs1GMRMEnli5EbsPiZpoM
 wVVj7kkGLuPqu+9kbKTGMvuKZA==
X-Google-Smtp-Source: APXvYqxfzfFW5WBvEvFGQQ+R3mqA4gnaulTkP3CenuRqjVfsc2S2Q9Tvh+SDQh8eSzeS3QvonpsadA==
X-Received: by 2002:a05:600c:2487:: with SMTP id
 7mr1855217wms.164.1571985998432; 
 Thu, 24 Oct 2019 23:46:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n187sm1570516wmb.47.2019.10.24.23.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:46:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 574441FFB4;
 Fri, 25 Oct 2019 07:37:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 28/73] tcg: add tcg_gen_st_ptr
Date: Fri, 25 Oct 2019 07:36:28 +0100
Message-Id: <20191025063713.23374-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
 "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Will gain a user soon.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index e9cf172762e..7c778f96f3b 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -1249,6 +1249,11 @@ static inline void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
     glue(tcg_gen_ld_,PTR)((NAT)r, a, o);
 }
 
+static inline void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
+{
+    glue(tcg_gen_st_, PTR)((NAT)r, a, o);
+}
+
 static inline void tcg_gen_discard_ptr(TCGv_ptr a)
 {
     glue(tcg_gen_discard_,PTR)((NAT)a);
-- 
2.20.1


