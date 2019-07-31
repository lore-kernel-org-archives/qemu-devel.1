Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EB6C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4EC7206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BaNLFgp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4EC7206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrT4-00057J-4w
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45113)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPj-0004q6-JH
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPi-0000JN-GA
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:19 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:40461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrPi-0000IK-6I
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:18 -0400
Received: by mail-wr1-x42f.google.com with SMTP id r1so70345177wrl.7
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=71PC3LPMQ7lE0ThGx+IfFN7xPEpt1fYEADeiWTvDA7s=;
 b=BaNLFgp7IprdtgYQFWlB5XUJfCGlbnrvhF+Lt59pn3U1OulSdQWgXVf82/rA+QxpHA
 Gn0SVfG/ZMJpRmKGFPTwt1Ibn3dDWic9+/mMDoTOHFFOMcXqeiTUxj8Z7jrWavA6x5ze
 sTrERoku5cHJT7mD1HZ3siLXW8x+UM9ecP7vzw91YIYfcFUxdgsvP9ayslWQ7UQLIUPG
 oaSGi0/wP+cg82pChb2y3d7lusuyQf7OCMhmQvpDeyiyVELqLnVlhPxAPXAH6uxIryih
 fsXYXc9Di4d5DCgK1sXkDyckdgSIjTg+B757OcUGk/qLdVGHqEhSJ1s2Wbibb0hlqA2b
 QacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=71PC3LPMQ7lE0ThGx+IfFN7xPEpt1fYEADeiWTvDA7s=;
 b=nTKpGz9/rqiiCqEOeU+ou76oD5+PVJ+xKuY+bkQduOidCs63CjVvq/qva3lCmUQLyF
 zEHnvVa0iXNReoY/lBL4XMz5uZi5Xh58NRUMOWoZUN0cd28SBnQVEn4TEKmx+i1SRhqo
 0lzPc3Gk+tw1oNHp2qeNe56p0UvAd+IeP0PCBxFVrLEUfEAWwlobt1Z4ZGwADSfXMiuj
 iz5vrHdgUaR9OeM1LXQTNRjejld9d1aRvx/Apa3Tvz8RUzELDF7oUoqi+kichjL6ecEW
 564WMg3AdRFwk4s8Y2pUwDVW59GSP/rOLRk4Or2W6tGN2gUBpX15nIg54nfJtrQc2sHM
 DLDA==
X-Gm-Message-State: APjAAAXPYRwz/v08eMpcSAFM5ZsUfliaSPFaOnLgFUdnBOvWxBPNUezN
 tOiuEW9godoVfh2JWnMyW9+Q3w==
X-Google-Smtp-Source: APXvYqxFsQyX63Ufqiz1zfohjUE+QsF9GVojU6XEdiiukcts54H+0JBa93uy0/4Oii4/kLydLZa9lg==
X-Received: by 2002:a05:6000:187:: with SMTP id
 p7mr12000274wrx.189.1564590317023; 
 Wed, 31 Jul 2019 09:25:17 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id h133sm74457531wme.28.2019.07.31.09.25.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:25:15 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 461F71FF93;
 Wed, 31 Jul 2019 17:07:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:07:17 +0100
Message-Id: <20190731160719.11396-53-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: [Qemu-devel] [PATCH v4 52/54] accel/stubs: reduce headers from
 tcg-stub
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
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, bobby.prani@gmail.com,
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
 accel/stubs/tcg-stub.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 76ae461749e..431ec7d7e6c 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -11,10 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
-#include "tcg/tcg.h"
-#include "exec/cpu-common.h"
 #include "exec/exec-all.h"
 
 void tb_flush(CPUState *cpu)
-- 
2.20.1


