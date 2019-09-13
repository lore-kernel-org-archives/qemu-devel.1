Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BFBC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B127320640
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zY51cO7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B127320640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8nyJ-0000F4-Pj
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8npp-0007fe-7n
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8npo-0000vj-7F
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:09 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:54976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8npo-0000vI-1H
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:08 -0400
Received: by mail-wm1-x336.google.com with SMTP id p7so3292513wmp.4
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 08:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=OB9XFxOwyf056lQ1S4kvmXdc02MTc76JEazor4S9ukk=;
 b=zY51cO7J4HZLQZRJStKvOJp41WDXWRHihGr2Rart7WVOzvltSpeMapPTiICueTQtKb
 V0ykT8t27zJz0wWUmrHQgKLQ3reTb1sXCZd0xkxembZFpsgWB+b8SUdn/wt6aV7BpJeb
 6TCKFW3mLIB5skGR3Br6/1ljqLCAgvBmYtzu/ske4sAqsPWWgEYmHw2VmbW5xLGGwNtN
 iDVGBN4oLHZFKIWjYySx9xeivVUPlDXzHb+jyHv20mVz9Vo5DankwbEcFBNwwOARWjtn
 HXjPcoQOCQFaJQPG5ot6nzAlNI7yVdBb3dYpBz69MW1tijd9O0ERhvua9cmE9/O8hHC/
 vY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OB9XFxOwyf056lQ1S4kvmXdc02MTc76JEazor4S9ukk=;
 b=DAe3If2BHogPXTHedhjxHjLmkk/7Un9Sf4mi4wBRV+vdceIMGfFCK4ETZP6ZAFdsKM
 VvOjfHltjD9doapR+9icm+ICqBbNbX2/xt8rVUQaFtSzY/oL+gd0/U8obovD0YYXSWd2
 eHUX5ahGD86z4fGpnpbXNiWRsTgZ9KHdyNO7l8nELZfAlpd5pQOVhwEjymU44PjqQz0j
 7zQfcbFOZCabVTucmY+e8SlSHauPZgNANara4a/pddWAjurcuofudb6Ksw8lAU1yG+xQ
 OcgEu7OrwY7t60eMopyftc66M0R/y3HwrHopEaJc3rtVvXhb6j/dDbWJakeK9j3ijqIH
 EFKw==
X-Gm-Message-State: APjAAAXD33kAPdOGTBk8S0JJLqAyw3YgsbtSr8LBSM9gaJspLYvrKpVU
 1yjF3UUIhwW69xdgvQJVfvcpVwoE5MWsfw==
X-Google-Smtp-Source: APXvYqxJmFeywQGKK2YhmuqpZhAHkNvyMwTFZ46RZsik2Xc6Rz7amstYzrBjyqW1Nx40ulrBYZtasw==
X-Received: by 2002:a1c:ed04:: with SMTP id l4mr4166506wmh.81.1568389806862;
 Fri, 13 Sep 2019 08:50:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c132sm3562207wme.27.2019.09.13.08.50.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 08:50:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 16:49:51 +0100
Message-Id: <20190913154952.27724-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913154952.27724-1-peter.maydell@linaro.org>
References: <20190913154952.27724-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: [Qemu-devel] [PULL 11/12] atomic_template: fix indentation in
 GEN_ATOMIC_HELPER
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

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/tcg/atomic_template.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index df9c8388178..287433d809b 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -149,7 +149,7 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
 
 #define GEN_ATOMIC_HELPER(X)                                        \
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
-                 ABI_TYPE val EXTRA_ARGS)                           \
+                        ABI_TYPE val EXTRA_ARGS)                    \
 {                                                                   \
     ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
-- 
2.20.1


