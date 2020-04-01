Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3895C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622E820772
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RMProAHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622E820772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJZzi-000655-ET
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 05:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jJZyk-0004Gz-JR
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jJZyj-0002Bf-JP
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:10 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jJZyj-0002B3-Dn
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:09 -0400
Received: by mail-wm1-x341.google.com with SMTP id z7so3171019wmk.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 02:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h75bfILekusPXGlQBXuZSQUYvT0dH6xycgkUfP0rfEE=;
 b=RMProAHXOWc8vNSSVJOn0d1/V812X8r5sXDCj0Z/r/Tih7krd/eYR1UsEhM26pSWTB
 Dnzle2Op5YTAv+uplilIGicw/ebRfyGJewXZsSc/wR3L1iK57UPf/Sb51B7jAAqG+fyJ
 4TeMfV6P3Oe6TkFezn+lcQyEYjzekG3Dm9y2B8K+FXeWGN7pTj5tCcIIb5KpQtxF/S/c
 QnBXgkq0/Wazl6j4dzTmsmqBltZBeEHS8oydZuQx2yNUos9hlBfIDwU4TZKyRtOD39UN
 9S1VNTfdnQ87tdQVBX4V7CiwdHtdfIrak3t5cBzRuFFxW83D0GwDPQHSt57shRSuOaLa
 DM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h75bfILekusPXGlQBXuZSQUYvT0dH6xycgkUfP0rfEE=;
 b=WxsjTnDhu9A4eKOSoMzbRaJAGqZ4oCsBgAFDYsmrn/DeCpOvrDXM4tbrhogvborNxV
 70E+xOMkt2EZh6wFzCMOcByZ8f3BTz36Xbf/WntRhvrJ9s+iCwkIeUR3NJngtlbR4oHi
 Qk2knCUvjkvyNSQr1FL893rKK5PnT0QDSSapcR96+CdoiR0r+5P+c0jln+BHwvtbwR8d
 HXQSsXdztns9QT5a/RNKMFksf0fGJzE0u8Ml1Co812fHNqWQWbj/qWZKtn8lLXPEZiOU
 yWehD1eQJ861OKmENJ4Nv29fM3xQzOZA3NvS3IBYJm3oOVAPOpFdwtRKaR7+qFegOCss
 gnGg==
X-Gm-Message-State: AGi0PubJLxW9OWwPbZxQzP19f1Cb/7aNGzBawO3KYZSvUlsjX+PUJKrn
 jmNXT3U4FmM15A+ONiOPNa0XQQ==
X-Google-Smtp-Source: APiQypK9xv5BTWrp1VkpsZLejm1tKrhwj7MuUam69Y79t8z4Bp/CE39d3/rkI0HgDaFWd80NDtSeSA==
X-Received: by 2002:a7b:c404:: with SMTP id k4mr3265439wmi.37.1585734488421;
 Wed, 01 Apr 2020 02:48:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z129sm1974080wmb.7.2020.04.01.02.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 02:48:03 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C84071FF91;
 Wed,  1 Apr 2020 10:48:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/10] target/xtensa: add FIXME for translation memory leak
Date: Wed,  1 Apr 2020 10:47:54 +0100
Message-Id: <20200401094759.5835-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200401094759.5835-1-alex.bennee@linaro.org>
References: <20200401094759.5835-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
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


