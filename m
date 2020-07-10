Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0768CC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C699B20578
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MNFmj9LY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C699B20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jttAR-0005hm-1s
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqfx-0006IL-OJ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:54:41 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:40175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqfw-00073H-7Q
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:54:41 -0400
Received: by mail-pj1-x1041.google.com with SMTP id t15so2447241pjq.5
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QSJ1bGauDFTOgyu9hOGxlnkT/w4hfR8pkrBU4Rw5V5g=;
 b=MNFmj9LYhfENTei0tAkr9eoOjFeKaQ2uS+MKjcbgt+HEP61OjaA10TZwj5wij8kgx9
 obxSNgGHqB18IiluS++rIGs8eFW7m79wEbzWWhc000e6TX+j9SCUgB9TGjtVQKWqm5XQ
 14bTjTEy5MuysIiSDi5hTmgUvdXCLaimC0DL4doey1zacZKEDq9qT3OqCaT5K06aIzjR
 EolZKxl44uDmfcJm8gzzLwZ5cm08q63rWYz5deGWNs8oEBEQzq/VgptDFjBKe/kuCdfk
 16PRYsE2103KaSbRFYNUnRRXKc0wLzSMU+8DzFChBJM2W/NsGl5fWVPv/sXkE0MGTdYw
 qBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QSJ1bGauDFTOgyu9hOGxlnkT/w4hfR8pkrBU4Rw5V5g=;
 b=fj54pgK8WtnhfQy/tCeA/JBZTGDVbaBBdI+9fGUvSG1QrFQUmyUblkxwfCkHwqp+GE
 1xTLdlMSFzsDiN67/mE5U9fHuHkM6VrD1R28Aj5OB1SgssnbOaR6fDgjG856MfvuKll+
 Lq0cGNGbCnLqfFKJcmKsoBLNzUexZAN3u4P8ViLNkaNhv7oKsV7IWluCAd9wik8TY7Lh
 Jc0SFTiP0RpWV/F3wn2sOu0Ifl4E+SSnR2F9Ga4Q6JvJOXsJtqHy49208wg+cu5B84H1
 2TU64LnrKtnJVz5ndkfCAZQYwHUVaVdT//lUh/V4/lLAVmiwkEtV0prRXVN/f7j8H447
 mYag==
X-Gm-Message-State: AOAM531GgiU7CGI5OZpw6b0xdTEjTZ1f5ZZyGzE1XM6JCultphMVboLy
 H7ePQMEUtViBQNCMR3+WsbmsuK1lrn6zYw==
X-Google-Smtp-Source: ABdhPJyMhlKUgfAHDhIFHX/sE8o+NSa4YSGZucN1EP+qSN0RO7SwWaN0RoZy2rh+ip1LI/M43kkAGA==
X-Received: by 2002:a17:90a:3d0e:: with SMTP id
 h14mr4746206pjc.184.1594378478931; 
 Fri, 10 Jul 2020 03:54:38 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:54:38 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 61/65] fpu: fix float16 nan check
Date: Fri, 10 Jul 2020 18:49:15 +0800
Message-Id: <20200710104920.13550-62-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:18 -0400
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Chih-Min Chao <chihmin.chao@sifive.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chih-Min Chao <chihmin.chao@sifive.com>

      16     15       10         0
       |sign  |  exp  | mantissa |
  qNaN   x      11111   1x_xxxx_xxxx

  The mask should check  exp + msb of mantissa

Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 fpu/softfloat-specialize.inc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fpu/softfloat-specialize.inc.c b/fpu/softfloat-specialize.inc.c
index 44f5b661f8..fe7a5e79e4 100644
--- a/fpu/softfloat-specialize.inc.c
+++ b/fpu/softfloat-specialize.inc.c
@@ -254,7 +254,7 @@ bool float16_is_quiet_nan(float16 a_, float_status *status)
     if (snan_bit_is_one(status)) {
         return (((a >> 9) & 0x3F) == 0x3E) && (a & 0x1FF);
     } else {
-        return ((a & ~0x8000) >= 0x7C80);
+        return ((a & ~0x8000) >= 0x7E00);
     }
 #endif
 }
@@ -271,7 +271,7 @@ bool float16_is_signaling_nan(float16 a_, float_status *status)
 #else
     uint16_t a = float16_val(a_);
     if (snan_bit_is_one(status)) {
-        return ((a & ~0x8000) >= 0x7C80);
+        return ((a & ~0x8000) >= 0x7E00);
     } else {
         return (((a >> 9) & 0x3F) == 0x3E) && (a & 0x1FF);
     }
-- 
2.17.1


