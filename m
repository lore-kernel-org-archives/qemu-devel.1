Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD427C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 23:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A25622053B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 23:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zsizWUve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25622053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isEI3-0005mK-MC
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 18:11:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isEFb-0002lf-1g
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 18:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isEFa-00086c-19
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 18:08:30 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isEFZ-00082W-Rm
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 18:08:29 -0500
Received: by mail-pl1-x644.google.com with SMTP id c23so9018679plz.4
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 15:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NVbq1Jag2Ekov4ET8qNdfiaIvA8EZAKN4xv0TeisvTw=;
 b=zsizWUveFCD+JR7XI8QiMaGtfBljiK39Fy4uai3KKQ5ijeft74PT/v0THXRAA+ow+W
 75MlADDz3qG5mc5VMeziRgrsGXCkX/NFo74Ra+xBUWUkDkBeEcs32pfzAikXabRDpuD5
 DII0IMMHQ7Q1fZzF/SMmgD4+TSuGH9NE20g+vEN4lixsfs4gOS2fan87XylRPK90eeyR
 MLtuUt5sZbYcXWFzH3XWJfC31hHJoCGYRAURIEEw7fscpllTvAVy8RclV76Dmw7VIjLr
 44Y5Rot6hrGnjEWg1S5x1m2NGXYoj6RSizvEKyfXCsRcZ+GcLfzpxzQb6GcO/S5AtalS
 9n0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NVbq1Jag2Ekov4ET8qNdfiaIvA8EZAKN4xv0TeisvTw=;
 b=gDtokNNKTwDvTGAVCPZXr6QhWwlqiDH8ncdF+4sVdr6qShp8Y45AwSr9eJ+rIL8p9L
 djoibDwWxSFceARHLUoCpWrGJjSFuE3SX2mU3MDZy6BP/UUKs6y/y3CPjNe20jv7pztP
 ninsRS3YFRk8oNdJMwujiW9dLQCs0GbZLtcfsQumwgI3CACg7+kaQ1vziDc2MEcegD6O
 xefByvUY/NDrleKlPXGpfmHXm1X4TkofMht0cZjCCvZ1ugMzLCLuyT08/TQBfVeynVkv
 XOiHHeRASEwo6pBIxY5Gq6m+1+7Cj4CpZwgdXjdx2RNgpf4CDUowbu5kQLvOgdSdZTht
 0vwQ==
X-Gm-Message-State: APjAAAXzHPUb3aMYMMbbYzxRtEnceVWFRsbPYYE8CBuYA+yLasXrbYc4
 U1PmTMvvmarhR0fHw3iuyFVuxv9XqeU=
X-Google-Smtp-Source: APXvYqzs5na07qLW5vghc3yt+NlTJJxnxj3J6IP4MxGdEP+NtR2U5HRPDU0A0da9Z27/35M4b7Gnug==
X-Received: by 2002:a17:90b:2289:: with SMTP id
 kx9mr2058984pjb.94.1579216101221; 
 Thu, 16 Jan 2020 15:08:21 -0800 (PST)
Received: from cloudburst.ASUS (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id s7sm5111578pjk.22.2020.01.16.15.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 15:08:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] tests/tcg/aarch64: Fix compilation parameters for pauth-%
Date: Thu, 16 Jan 2020 13:08:07 -1000
Message-Id: <20200116230809.19078-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116230809.19078-1-richard.henderson@linaro.org>
References: <20200116230809.19078-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: peter.maydell@linaro.org, vincent.dehors@smile.fr, alex.bennee@linaro.org,
 adrien.grassein@smile.fr
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hiding the required architecture within asm() is not correct.
Add it to the cflags of the (cross-) compiler.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/pauth-1.c       | 2 --
 tests/tcg/aarch64/pauth-2.c       | 2 --
 tests/tcg/aarch64/Makefile.target | 1 +
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/tests/tcg/aarch64/pauth-1.c b/tests/tcg/aarch64/pauth-1.c
index a3c1443cd0..ea0984ea82 100644
--- a/tests/tcg/aarch64/pauth-1.c
+++ b/tests/tcg/aarch64/pauth-1.c
@@ -2,8 +2,6 @@
 #include <sys/prctl.h>
 #include <stdio.h>
 
-asm(".arch armv8.4-a");
-
 #ifndef PR_PAC_RESET_KEYS
 #define PR_PAC_RESET_KEYS  54
 #define PR_PAC_APDAKEY     (1 << 2)
diff --git a/tests/tcg/aarch64/pauth-2.c b/tests/tcg/aarch64/pauth-2.c
index 2fe030ba3d..9bba0beb63 100644
--- a/tests/tcg/aarch64/pauth-2.c
+++ b/tests/tcg/aarch64/pauth-2.c
@@ -1,8 +1,6 @@
 #include <stdint.h>
 #include <assert.h>
 
-asm(".arch armv8.4-a");
-
 void do_test(uint64_t value)
 {
     uint64_t salt1, salt2;
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index df3fe8032c..374c8d6830 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -20,6 +20,7 @@ run-fcvt: fcvt
 # Pauth Tests
 AARCH64_TESTS += pauth-1 pauth-2
 run-pauth-%: QEMU_OPTS += -cpu max
+pauth-%: CFLAGS += -march=armv8.3-a
 
 # Semihosting smoke test for linux-user
 AARCH64_TESTS += semihosting
-- 
2.20.1


