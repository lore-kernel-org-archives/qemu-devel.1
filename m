Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55122C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 04:42:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20985206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 04:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="YtEUxre5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20985206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVTRU-0007A8-3e
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 23:42:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iVTQH-0005zs-Fn
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 23:41:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iVTQG-00084a-IV
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 23:41:29 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:46276)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iVTQG-00084F-DZ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 23:41:28 -0500
Received: by mail-pg1-x52a.google.com with SMTP id r18so5169661pgu.13
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 20:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=OzEoao2IwUVlnSm2tLOqOqfLN0Byl7NdWouaeEHTbz8=;
 b=YtEUxre54I2H3ekSyai7tTjcbmebsXNZrIAv+n6Z3tleuJouK7s3pMaa18Tx6TJZVH
 rqdhOqe3K99p6PiVOhgytj216zVFNK2he3GRT+vX/3LrwmHxr61aFITSopLi03DAKNey
 3ldy0KgcFEhrfDWsUJ08rrAyuRCEs8T/iRwg++S83G1C82b6jtugn85iQMk/W0AlN6Sd
 KC1MXpmKGuygrBMGSMMCEj3im9V7DppOZMpiiu6WV/Ntuff/3sIrPyd3yX67rDPkaDdg
 UposlhaZmCjixPmQmpCNLHaUVmMbs7ED7jDGfGWotx8PyNKufwZAQG+wdZ64auwf98iM
 JPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=OzEoao2IwUVlnSm2tLOqOqfLN0Byl7NdWouaeEHTbz8=;
 b=pQogDPAwMZ9RKQz12GbF2mKF90Ju5QwAKs6bt2QeTkKa+Gqg68M/LSbxR7KWuI5IdF
 q9ARmXWIgRbWg/4OoRvri3IdRsxOvcbHtpK7JgErnQXl0H43hAOXOS+a42O9PqVw64pa
 0Gd5fOqN5U3SAWeUori338J6rNpRbMhVezO/Cz3IKwNw9gEJA8c7R8Ua0swYooH4nf/K
 7mWbyQhLrhTRHtfN+U2AiltgaRyFJqelrJPOEUUPTmZAfYbN9cTP+MxAZk5veO3MXogm
 c2D6AN1MVUTe/IAQK8YRSs+1FKCKaORreCxw8ABHmoxcXpWlFfozPtOUyxtdPgdZ8a+s
 kzdw==
X-Gm-Message-State: APjAAAVqfmhIQnPv93nNcq9cT4fxbTD1rDe7ORDbE4yT9jhQVmVpVtef
 U224kH+f7b/A+Rqmq5i46ymQxw==
X-Google-Smtp-Source: APXvYqw6RvrDK8qlNn1ESpbD2e3Tj8Arj2xjs0SF6ZWTlrhDJ7sIYvp2BMGrnup4RX8Y1y09H8TSsg==
X-Received: by 2002:a17:90a:a00d:: with SMTP id
 q13mr16931431pjp.106.1573792887135; 
 Thu, 14 Nov 2019 20:41:27 -0800 (PST)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
 by smtp.gmail.com with ESMTPSA id a12sm9419246pfk.188.2019.11.14.20.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2019 20:41:26 -0800 (PST)
Subject: [PULL 1/4] remove unnecessary ifdef TARGET_RISCV64
Date: Thu, 14 Nov 2019 20:41:01 -0800
Message-Id: <20191115044104.4197-2-palmer@dabbelt.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115044104.4197-1-palmer@dabbelt.com>
References: <20191115044104.4197-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52a
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
Cc: Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, "hiroyuki.obinata" <hiroyuki.obinata@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "hiroyuki.obinata" <hiroyuki.obinata@gmail.com>

Signed-off-by: Hiroyuki Obinata <hiroyuki.obinata@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index b26533d4fd78..ab6a891dc381 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -64,12 +64,10 @@ static const int tcg_memop_lookup[8] = {
     [0] = MO_SB,
     [1] = MO_TESW,
     [2] = MO_TESL,
+    [3] = MO_TEQ,
     [4] = MO_UB,
     [5] = MO_TEUW,
-#ifdef TARGET_RISCV64
-    [3] = MO_TEQ,
     [6] = MO_TEUL,
-#endif
 };
 #endif
 
-- 
2.21.0


