Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D21EC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182B12468D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QqPbb73d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182B12468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50195 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ihf-0003qg-8X
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7if1-0007EJ-Ay
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7if0-0001ls-GC
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:47 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51403)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7if0-0001l0-AU
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:46 -0500
Received: by mail-wm1-x342.google.com with SMTP id t23so3862154wmi.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=UjASb9Z8QnXhRYOsvt2c7nwH5VonxCR4/zGig7D/A+U=;
 b=QqPbb73deHrp8+uZ70A8sET7xXtKptzfjYLjBJiPQTbDTOQPegr5IYo7ly4iHlsL8h
 m0Bc0HeJsa/G+exx0TzRs+k5/3Uje7hX/sAxPSKZy8ETWowi4bhk3vhhu2/lsBBch3PE
 r1YnBdWEtvoSHGPKmXNU50BCyZEhIBCLIhWxe1v6CkmP5vxOv38TKLOWKyi+iU5UJMnJ
 88NeIrLMeTb0W44YQq2nqov9v+0/Zu2B3bAApH/1GWuWMHt5/1/3FLvoJaEKFZ2W6NT1
 0XQFA8ImhdbDDgJem+PJczspD72/AXjgGVPYIdcdrnW838ObOOXIDUy9yNKzeW0JYT5i
 J+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UjASb9Z8QnXhRYOsvt2c7nwH5VonxCR4/zGig7D/A+U=;
 b=bSH21yjA06WB1CNj/JxsxEQWBaBhcKx0O+C4yr8GdwuFlczwVxfN+owmVPX6C8ZKH+
 Z0y/Y7HNtrI86Dvzo/2SUHVcPtzt0PbTuuKavyW1SAK8ABS/i2l6QvKMNk2aVPAcGJMK
 MlZBu8AzE77Mve5ME5p27nsv6O0O2Wry1TcHuoMqIeyDwK5jnNBV1AnpEgGQhUODhIEv
 6k5/Cabu3J+Pgqp9PYzLlC5jKqpXxMKpafXFV/9qXy7H1inpFU0uk+KwcsDioenPInMj
 yxzZJ/c8fdsBmaLKB8+hLXxRphZpiv8IRdPbBboS/gR5AP8ZZCg+FruOKKg43detktBh
 LI0A==
X-Gm-Message-State: APjAAAXuhA9FD+c8JWml5LQQhIxUumObQwQvlHc26rwA0kuRo+DLrl4p
 /Hb0LIw7oQRTUKpNXTY1hAzmsvDMRVcrJg==
X-Google-Smtp-Source: APXvYqw5hFlzEibrbvHPPmZ2nV6xg+4fKbOsWZQ5OnK743vNbuOnFqVMqHZ/e25cDrwkZGumrpu/kA==
X-Received: by 2002:a7b:cae9:: with SMTP id t9mr5509710wml.186.1582907925066; 
 Fri, 28 Feb 2020 08:38:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.38.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:38:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/33] target/arm: Set ID_MMFR4.HPDS for aarch64_max_initfn
Date: Fri, 28 Feb 2020 16:38:09 +0000
Message-Id: <20200228163840.23585-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

From: Richard Henderson <richard.henderson@linaro.org>

We had set this for aarch32-only in arm_max_initfn, but
failed to set the same bit for aarch64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200218190958.745-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 0929401a4dd..db695384ebc 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -704,6 +704,7 @@ static void aarch64_max_initfn(Object *obj)
         cpu->isar.id_mmfr3 = u;
 
         u = cpu->isar.id_mmfr4;
+        u = FIELD_DP32(u, ID_MMFR4, HPDS, 1); /* AA32HPD */
         u = FIELD_DP32(u, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
         cpu->isar.id_mmfr4 = u;
 
-- 
2.20.1


