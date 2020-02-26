Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43093C4BA1E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A0224650
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S6PCTofg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A0224650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j71C8-0004jg-7s
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 13:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j718h-0007Gy-ED
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:10:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j718g-00068Y-FG
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:10:31 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37061)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j718g-00067j-9M
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:10:30 -0500
Received: by mail-wr1-x442.google.com with SMTP id l5so4305157wrx.4
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 10:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mGdhokziaFlD24j2e180ug759eZelaxuW6pu6HeYdT8=;
 b=S6PCTofgeYtP2Wsm4aYo/W9iKZZgEEkaoEfhMSkuk3t1Gw1gr4k6Ei0rXViBm7YXON
 k9MUApcURl81lTk0y1GvkekR2TQE8wka0qKAdw/rKYg96Hou3ySxw57m1QJMBbW/UYiw
 Yg9teIYwwZHdAo8cKaMy990lCu5CSR9f4+6xxk7E/YhcPnfi8z5SO+hhbgpIGNuD+dji
 V4AHxWNrEWkaMR5Aij9+ZPs4jjuWRketPCY1enCZ4u5ZkfkZw4Zy8HdNd412kXlNg+6c
 TBSZj0eo5h8i9LPuWlxK2g2HAJ7thZc9oY+v9dwOtqxxw/gJkY6bS65f6l5OSwcuSMD/
 CSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mGdhokziaFlD24j2e180ug759eZelaxuW6pu6HeYdT8=;
 b=aZUefVf4gNd1AHE2vepf93jCyrlhhlm9GJ3Ll+rPQEUdwgm1AE/9yUN+Ow55wKCcbB
 s87yMsvjb9julad906z+rK99vPfTLMsEG1Ygr/NdJx+3YmU5Gms9o9HjxfpGEoW7KSMy
 wTFILWzkDGXcoOkZ2nl2vyaZbG4/tCDdxkeDAu0qQl9MQSt643B1mVuCAfNNebrjRmRb
 wU0TR9br33d22IZDOJBXPjBDwLKegbJ14/dn7k7zfKaZQU8m75153YQzEJBTh6LA2I4J
 ucnc6088BhpPMMfbOunysPib9iPSCJLQASUoTzFweRvuCH5l5KZpOwVvMumuALdYOUiP
 5JKQ==
X-Gm-Message-State: APjAAAUhCFy/3U3+HDTxZaEuoU0aZzBul5FrWuNpprYkKJVlaSe91P1s
 aXcJmDv4AspZGnPz9D6YZ/hhjQ==
X-Google-Smtp-Source: APXvYqxGDjFnY6b5blMr7GM/ru+U+9CiqyaFPCP0PoqNCXpX+OmvjNLgdq3NDV7f/mRHl9YpzpqytA==
X-Received: by 2002:a5d:440f:: with SMTP id z15mr6669505wrq.420.1582740629273; 
 Wed, 26 Feb 2020 10:10:29 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n5sm4223973wrq.40.2020.02.26.10.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 10:10:25 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 326FD1FF91;
 Wed, 26 Feb 2020 18:10:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/4] accel/tcg: increase default code gen buffer size for
 64 bit
Date: Wed, 26 Feb 2020 18:10:20 +0000
Message-Id: <20200226181020.19592-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226181020.19592-1-alex.bennee@linaro.org>
References: <20200226181020.19592-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While 32mb is certainly usable a full system boot ends up flushing the
codegen buffer nearly 100 times. Increase the default on 64 bit hosts
to take advantage of all that spare memory. After this change I can
boot my tests system without any TB flushes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/translate-all.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 4ce5d1b3931..f7baa512059 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -929,7 +929,11 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
 # define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 #endif
 
+#if TCG_TARGET_REG_BITS == 32
 #define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)
+#else
+#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (2 * GiB)
+#endif
 
 #define DEFAULT_CODE_GEN_BUFFER_SIZE \
   (DEFAULT_CODE_GEN_BUFFER_SIZE_1 < MAX_CODE_GEN_BUFFER_SIZE \
-- 
2.20.1


