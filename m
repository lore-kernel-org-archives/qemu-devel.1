Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0EFC2BA12
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:16:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C8A20737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lA285D1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C8A20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKRnM-0000Rc-Ii
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 15:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjX-0003M8-Mx
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjV-0002HW-IX
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:03 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42225)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jKRjV-0002Cn-9G
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:01 -0400
Received: by mail-wr1-x443.google.com with SMTP id h15so9786703wrx.9
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 12:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zezcqVbZAh673hmos+bKgDlwDb2CfDg/on9jJSHU3kk=;
 b=lA285D1Rg7ucY/Doq8MaiRAqRmiAK+itnW0AIVnEylfZBeaiigq+/DF8zs1RJp+Knf
 wwnAy0h8YjSi3hVoJNkkZeG7YL+JU3Up8cEPukEOKiG7gzXt3OpYkhtubG/mF83rQx0R
 RgHPIcrehW9jnUGtLgdwoA07RYoGN+XcJYXGzH0vp0WxGV7EHHBOJ4fIej7Tvqs24a4Y
 5EaDRSiGRGIA4NhVfaNUpaGBTwLHTqxlYzbM0RT/axbtzCR8CxwCIrDq2SfTLVI3W68z
 xmmVuofaaEHATkYqwVr2rZtFy/+lz3SsnH1jo9EP6HBURCxD7+zWdSVF/mA8HTYvAAI7
 ij1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zezcqVbZAh673hmos+bKgDlwDb2CfDg/on9jJSHU3kk=;
 b=GWNS3xz5WOh52x61+bbgoenf50arCnXZsyXREgigwgK+3HuM07Dc8D+e1aNNZPltwf
 Pz5qQRobS4/U1nbptXsiIOBMH4CxlWYfkXUyR2fUc9vynNJ4SV0gdS9NGVW1ctQEqzS4
 L6+a8FZiw6Wc9+C9ZphGdWfMIOHPNemqg3e2vJcFJ9Ra65BB/IV/C0u5xH8rY3XRDLoq
 r5f/ZAzxEOnaxiWdnQ3/F783Fa/OAW4kNkvjeq0tfTfBcpFGbi57ZA1KFgSrcEljMGNP
 yFPl+OZGIgcMU5S5DnHe1YO2r1sKaYRLQpQIBIAUErmHpdvNxdl9nDjxQ+fVpOeZvdot
 CUuA==
X-Gm-Message-State: AGi0PuZlbL50dKC5jbmTWiDDC/PJtSDm0+tckaIDc5rGPoCu6IChTOXK
 0bUdbxOI73pGzNT7FGp1p9Bpmg==
X-Google-Smtp-Source: APiQypKVL6bpkT0VTY6QAnvvXLU/9R8MSuhdpqgIRKLEaOZ4HBYprWPNEgQ9h+vrsp2Cs0YyWtaRQw==
X-Received: by 2002:adf:fd44:: with SMTP id h4mr10663153wrs.177.1585941119262; 
 Fri, 03 Apr 2020 12:11:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f62sm12170207wmf.44.2020.04.03.12.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 12:11:55 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1AB1D1FF91;
 Fri,  3 Apr 2020 20:11:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/12] target/xtensa: add FIXME for translation memory leak
Date: Fri,  3 Apr 2020 20:11:43 +0100
Message-Id: <20200403191150.863-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200403191150.863-1-alex.bennee@linaro.org>
References: <20200403191150.863-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dynamically allocating a new structure within the DisasContext can
potentially leak as we can longjmp out of the translation loop (see
test_phys_mem). The proper fix would be to use static allocation
within the DisasContext but as the Xtensa translator imports it's code
from elsewhere I leave that as an exercise for the maintainer.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 8aa972cafdf..37f65b1f030 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1174,6 +1174,11 @@ static void xtensa_tr_init_disas_context(DisasContextBase *dcbase,
     dc->callinc = ((tb_flags & XTENSA_TBFLAG_CALLINC_MASK) >>
                    XTENSA_TBFLAG_CALLINC_SHIFT);
 
+    /*
+     * FIXME: This will leak when a failed instruction load or similar
+     * event causes us to longjump out of the translation loop and
+     * hence not clean-up in xtensa_tr_tb_stop
+     */
     if (dc->config->isa) {
         dc->insnbuf = xtensa_insnbuf_alloc(dc->config->isa);
         dc->slotbuf = xtensa_insnbuf_alloc(dc->config->isa);
-- 
2.20.1


