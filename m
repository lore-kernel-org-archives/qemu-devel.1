Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBA2CA9EBC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D64C21929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yo4BbSSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D64C21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNth6-00021S-7w
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN6-00087Z-OE
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN3-0003FS-NH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:52 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:51308)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtN1-0003BY-3c
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:47 -0400
Received: by mail-wm1-x32e.google.com with SMTP id q70so791004wme.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QA5G0ge3KbQ5Y8JeR92unhUZGUgp9+560bkXJZMuTD0=;
 b=Yo4BbSSXTK1PTS4yl4y+dRwdUrZPXgJgxer4b+zLf+3PFiQCDUMvrWBAyIEYJXTlu2
 Yn97U9G3aXlOnZOmmW2rDQKtAM43qXJI3bMyTp7FqsAF4tVy6Op5qYk1ERZLzZ+cqBLP
 uHTdf6AugNRX9cqvFHj8kbvkS9+D5y0G2Fe5PFgVOYmFlM3k16aBY2Rq0uKSl3rtw9vi
 UUuy9bXgaashurFVGjLoNLYbUzMp25BEb/KlPMgcJdDNv4ErwM3UwZb3MJpAeduS4ocS
 pLc66O6XLwVD9NWjEf0sEe2o3Yz0vz87jGE8feiqzvur6KF/fP0hGvM8T6rt17OeM/tv
 6SSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QA5G0ge3KbQ5Y8JeR92unhUZGUgp9+560bkXJZMuTD0=;
 b=CMaae4myoq9ibI4DbP/2tPo64EKw9l8d7lmbRDXDQPuO1YFYQhtsRkGGRh80lvB56m
 GLKThIr0e+1ZG1xMZjeV2rgwaw+jjp2oCdeWW6rgQdr0Ei4Cx7n32zCeVZlB344I+/On
 +rpnOReocP1A0YyUAZZQv2bCFAX+t+TwMXNWhbH9gKV+UPGE/hvGzWzSm7O0bx/IAuTo
 me3Q4pxamzhAKcadv/1xY6NyN3H26LyoqROIbKlPzaXZn2DZLROKC9ZMgxoMuzsbTWmV
 wwfOq6vOlAIjXdBC2Nvnyw1fNrgSORspl788ao45Ilmh/oXduXZ7qtbMoqJw8Bpy7I+v
 decQ==
X-Gm-Message-State: APjAAAXhv9CjhoroFEAGwQ/cpaW2jmaH6K3oX2j9l+2hXp1Y7TA9v8zQ
 F9fUQdY/gdGbu+N+WYvW+NwHag==
X-Google-Smtp-Source: APXvYqxfVrzW/xLDbuHwdj7JgJ9ulBosNVcjI00dcho5oCUqxTi7gylsKXkgvDexpSIQgesQyutgcA==
X-Received: by 2002:a1c:3dc4:: with SMTP id k187mr1802621wma.167.1571986002300; 
 Thu, 24 Oct 2019 23:46:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c8sm1074923wml.44.2019.10.24.23.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:46:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 62FE71FFD2;
 Fri, 25 Oct 2019 07:37:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 60/73] tests/tcg/Makefile.target: fix path to config-host.mak
Date: Fri, 25 Oct 2019 07:37:00 +0100
Message-Id: <20191025063713.23374-61-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since moving where the tests are run the path to config-host.mak has
been wrong. This doesn't affect much but things like the time fallback
for CONFIG_DEBUG_TCG and will also get in the way of checking for
PLUGINS support.

Fixes: fc76c56d3f4
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 5a9a6faba4e..84abbd24f34 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -30,7 +30,7 @@
 #
 
 all:
--include ../../config-host.mak
+-include ../../../config-host.mak
 -include ../config-$(TARGET).mak
 
 # for including , in command strings
-- 
2.20.1


