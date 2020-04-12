Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D1AC2D0EC
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 21:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD9A206E5
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 21:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QtD+q+NS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD9A206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNjuW-0003iD-4y
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 17:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jNjt1-0002Aj-Ri
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 17:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jNjt0-0005ZW-Fe
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 17:11:27 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:40922)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jNjt0-0005ZF-A8
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 17:11:26 -0400
Received: by mail-pl1-x62d.google.com with SMTP id h11so2719714plk.7
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2020 14:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qi+n7ODv/l3RsbJtLXhoMScg4tR6tjfge3kZ2WpJBR0=;
 b=QtD+q+NSLft6F/7RZSal6tF/ONRc6QRtNJYd/NbzfUorkUqgC2rsjMMTfndKBCvygR
 mCRDs374Dkvj9ofPNRchyb4SXWOejN473DSZKyLGoomD3DI+7kGdq9N1/BVgA8CiknLU
 rLbIfZqyna1egB46iw/3zrRSbRnvoj9pb/K0SUIgROMP5l32rSQE6oeMEn99YNiMF7Ct
 2zY+i9wk6TG0RHvbdDKuYPH7ALdDDq0a26KoCh2CsF6rj0R2pThg+2RAS1fxxW88QkZI
 RHqCtlRkQ0oGKX7q0oEWycqHY/8VsfY+5NFauHlpW/3AVow7JRHriQGABnUEIGl9oslD
 GOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qi+n7ODv/l3RsbJtLXhoMScg4tR6tjfge3kZ2WpJBR0=;
 b=ETgqtMNfBxhonWQCHYDjN8mrM5Vu1Eo2X+YNCpXYFXFpAvdIiJh8RtTt2XcZRrw/7U
 L1U0OQPKCdyMVhV7yzEYnoHsz16DtfnEG5OaG7n6iTKc5OEl9Bv7HcicRQgBpRK43wQ/
 VAzkQ3LgzkTIcC1QsMmFpR9wy2N3e3QuCMdnqrc1P3kmjqbYEGocWrzyvW9c7yVU8+DP
 3xkpw4DWyTxffBnkmf4jVmjhn/j7C+gNGKJ1lp0xcRDCGY72QQIhh3bGXuxte8NoUBxG
 FR53y7tZoqIEEvSZV45sA2LHa5Gvw/VQhtjM3vPmN76QaYQwCodYcrPhgncfRWlemBon
 pq0g==
X-Gm-Message-State: AGi0PuZNTe9317nflhUC6qTDLf1ZG/fnaKNlcjAeOCe/UJ6yjtZMUKAI
 y3aZHLf5J7l05HtFvqwtgIEuz78oHtA=
X-Google-Smtp-Source: APiQypK/xUM8U1wpv0GDZTseSOCG1MIGgXGybkHstEjQsBRy2BSRPTj51QbD4NZIdt0nxru2BuYUPQ==
X-Received: by 2002:a17:90a:1f07:: with SMTP id
 u7mr18835394pja.24.1586725884883; 
 Sun, 12 Apr 2020 14:11:24 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id jx1sm4916804pjb.5.2020.04.12.14.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 14:11:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 1/1] tcg/mips: mips sync* encode error
Date: Sun, 12 Apr 2020 14:11:21 -0700
Message-Id: <20200412211121.13579-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200412211121.13579-1-richard.henderson@linaro.org>
References: <20200412211121.13579-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62d
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
Cc: peter.maydell@linaro.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 lixinyu <precinct@mail.ustc.edu.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: lixinyu <precinct@mail.ustc.edu.cn>

OPC_SYNC_WMB, OPC_SYNC_MB, OPC_SYNC_ACQUIRE, OPC_SYNC_RELEASE and
OPC_SYNC_RMB have wrong encode. According to the mips manual,
their encode should be 'OPC_SYNC | 0x?? << 6' rather than
'OPC_SYNC | 0x?? << 5'. Wrong encode can lead illegal instruction
errors. These instructions often appear with multi-threaded
simulation.

Fixes: 6f0b99104a3 ("tcg/mips: Add support for fence")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: lixinyu <precinct@mail.ustc.edu.cn>
Message-Id: <20200411124612.12560-1-precinct@mail.ustc.edu.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.inc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 1da663ce84..4d32ebc1df 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -404,11 +404,11 @@ typedef enum {
 
     /* MIPS r6 introduced names for weaker variants of SYNC.  These are
        backward compatible to previous architecture revisions.  */
-    OPC_SYNC_WMB     = OPC_SYNC | 0x04 << 5,
-    OPC_SYNC_MB      = OPC_SYNC | 0x10 << 5,
-    OPC_SYNC_ACQUIRE = OPC_SYNC | 0x11 << 5,
-    OPC_SYNC_RELEASE = OPC_SYNC | 0x12 << 5,
-    OPC_SYNC_RMB     = OPC_SYNC | 0x13 << 5,
+    OPC_SYNC_WMB     = OPC_SYNC | 0x04 << 6,
+    OPC_SYNC_MB      = OPC_SYNC | 0x10 << 6,
+    OPC_SYNC_ACQUIRE = OPC_SYNC | 0x11 << 6,
+    OPC_SYNC_RELEASE = OPC_SYNC | 0x12 << 6,
+    OPC_SYNC_RMB     = OPC_SYNC | 0x13 << 6,
 
     /* Aliases for convenience.  */
     ALIAS_PADD     = sizeof(void *) == 4 ? OPC_ADDU : OPC_DADDU,
-- 
2.20.1


