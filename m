Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA60C2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C832D2168B
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gq0m7DMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C832D2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLGy-0006Ny-Hl
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFV-0004aA-Gf
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:11:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFU-00054D-AG
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:11:57 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLFU-0004zM-3x
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:11:56 -0500
Received: by mail-pl1-x641.google.com with SMTP id g6so10250840plp.6
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e7IjWrGdGmZg7JkMhbQbAWZ0eqaluquJ5qRv97GXAjk=;
 b=Gq0m7DMhV1+i6cHjAH8+98rCcXg82qdLs1Efe9y5gEPhuvOAvqIK0F1mGY1s+WASPz
 0QOBKJqJdGTtQOOdHO5jrNAA1wSRsu5U9qyhw/9enJJA7BXJNpqhhyB0imEWXezu0g6h
 jxuLOxIq09Ytkvr5zR3La18xcCRhvrMLGI/3NAUC6XJkdPLJNp0mz+z60YoTvs87tqPv
 7ROUIvPNGazjE8w9wyFQWzWLoj6eiRtIF0FJtS4eklun50PzFUKgG3vZ8+xT/FLXFuBZ
 bbGT0KG6pykAOgEMe6r3AoORpw+UtB2VH+GV/dZwXDSyIAmINPBoPe/mIsfAfeNhA80i
 Bh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e7IjWrGdGmZg7JkMhbQbAWZ0eqaluquJ5qRv97GXAjk=;
 b=iD3w+dihza5rwP0mgoHT9QK5PU8QWVBYLhHV2Bkc+FQhjHKwaN/ujmCZ0kG7o6kRgz
 ttnC5pET6E8eUOadZlSRXlV3s9aUDw+JNh6A2EaZNZXEf0m6QisOwoFwU7QOazp8JB+Y
 hyhbZh7I7GBl+g22pC3AnWQttlYRdYwBaUGJmUr/QRmUsJ6jRkU16YhsltKOdGJJXwnN
 P+DDdEtSjlPHsBEEwK4o3thF+x+PUN8qh2Pl26IYdi2EKdIl2Ainy4HjuqLdl1xIJHc1
 S+J945P+RwnCX0zTFYZcvFqENhNeaT2Q/+Ikzbs9cWtaDHDyxUCu8tJr1RWWKwRvxyWp
 +psw==
X-Gm-Message-State: APjAAAXixli9pm4t5N8t/T2gPkEZYFZsg+b/ZFkxdYXg0A5CG0UMZGH9
 /W8/0ovrWI2nXUVuI3rBLCNWNWW9FiE=
X-Google-Smtp-Source: APXvYqyM7lwOL1ljfukycW4hjb6vJzz+KUoIiD6cRpCbwi9t2/mcx7OeoAdjMQ2YoAjp/emGUaJD7A==
X-Received: by 2002:a17:90a:191a:: with SMTP id
 26mr35282365pjg.111.1577574714835; 
 Sat, 28 Dec 2019 15:11:54 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:11:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/29] linux-user: Include tcg.h in syscall.c
Date: Sun, 29 Dec 2019 10:11:02 +1100
Message-Id: <20191228231124.18307-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Code movement in an upcoming patch will show that this file
was implicitly depending on tcg.h being included indirectly.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 171c0caef3..34825f15bf 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -115,6 +115,7 @@
 #include "user/syscall-trace.h"
 #include "qapi/error.h"
 #include "fd-trans.h"
+#include "tcg.h"
 
 #ifndef CLONE_IO
 #define CLONE_IO                0x80000000      /* Clone io context */
-- 
2.20.1


