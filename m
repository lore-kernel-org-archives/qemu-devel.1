Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6064ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B6420673
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TlF03HDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B6420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyOi-0005aB-HP
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvW-0007as-JJ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvV-0006L0-GU
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:10 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJxvV-0006Jg-A6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:09 -0400
Received: by mail-wr1-x441.google.com with SMTP id v8so19151684wrt.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AQnBIoxWJcGF7VxKdA+3Fs3YaFpJDSvvaPPi8ZLzb54=;
 b=TlF03HDFOj2n6QqbryaZSM7qOLJY8m/vg6xIzE2uNwk0xaUG/i78iswMP8JLNXSIWz
 b6QyK/OtmBGTFDM7UppTa0KBsnf+S9kJSus5cufQyI2Q0lmow/3ZgskgBTb1Y4rg4bQx
 sv+u4FL8gxfw1/Z6N8WwDy8hT8bms0W0RgX9EX50W/0DX10+stiRFYeIBhFHUPwoSLSM
 XkLuUIOW5lkE98XoUkal37Kt3Bs6IQNS0q2pQBnSqT4OdFvjcspFnlFKCTw2g+T1H5Sx
 MiOh5C16C0Y76BNDt15gNM+K6JwkX/MviBNLl5jf+JmodFXtpkMqknbvbgRTR5oMuOVa
 4FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AQnBIoxWJcGF7VxKdA+3Fs3YaFpJDSvvaPPi8ZLzb54=;
 b=p5if6eiRJYbZDxUqf9OXrUlYQb31eleF+FInZd3skEUt5e05/QbYevTm6EjsqrGeE7
 SQ2L0HsglfCyR1/crcJ1/Aa4Zh6Nf1oNbZ0ytsy8l2GKq0AEWkgr/pmwMZoECGhbesgW
 vH75J0MP4abRxow1xhAK4G0Lli4vML6uUcSLIkvKrIcaPw/kj8ww2XZp6C4pchDF4jv7
 nFVnDCinPQXOCw+7zcjBwYUM+K1KdNbwRNLE7MQi9mhfOCVSMXVScX3MWNf0zY6NYWfX
 LG7b0gs9XsMvaoZG//OTuJDEWP7uYnmgYuMPD6VQiZ153R41HqEpyOBMc5Ubspf+tBSW
 1Twg==
X-Gm-Message-State: APjAAAWnu7m2tMfeC5FGHfsf5lcPaDoTlS3rXBda6wufiCmxIeT6QEkv
 P1ixEkuMcpPLesD3c0Lc1v7gsw==
X-Google-Smtp-Source: APXvYqxOsZKOwaPSVCLT6/pegkRPArMpDg1w0ZRkrrptT8bcxCeClq4jipPgmHB9kX6W8ND40qBNiw==
X-Received: by 2002:a5d:5228:: with SMTP id i8mr19531464wra.191.1571050208199; 
 Mon, 14 Oct 2019 03:50:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s1sm25625137wrg.80.2019.10.14.03.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:50:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E66B41FFD4;
 Mon, 14 Oct 2019 11:49:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 49/55] accel/stubs: reduce headers from tcg-stub
Date: Mon, 14 Oct 2019 11:49:42 +0100
Message-Id: <20191014104948.4291-50-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need much for these. However I do wonder why these aren't
just null inlines in exec-all.h

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/stubs/tcg-stub.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index e2d23edafe..677191a69c 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -11,7 +11,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "tcg/tcg.h"
 #include "exec/exec-all.h"
-- 
2.20.1


