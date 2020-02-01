Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A37C33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D5A205F4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9OSSMFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D5A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixyfx-00049r-4L
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:43:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySZ-0007U5-Kh
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySY-0006ma-Kz
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:39 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40135)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySY-0006mA-FW
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:38 -0500
Received: by mail-pg1-x541.google.com with SMTP id k25so5472920pgt.7
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tAUO3moP+hTFL+z2g2ynj8dsoHjP3s61tE4VX5hK15k=;
 b=C9OSSMFWGEv+aSsj5+cE4JNQhFKHzcssnQ/vjZaaUbfiAB1piErFrqV3EcV5o/guo8
 ZL/OHi3yrmI/JNJpBJW7CJ07YTdc53l5VB9UkX1z/U/9YrbzAVes1cM1LsNz+CsCrJkK
 D4EqKILG3vw7qcr3qGTWHPFGvOUXnxh6uj95Kr9Q1m3m1sGIEKC/ptQOcSjTKNjPa/v2
 rNuGxtveICmckOBn+Dmc8R3hYeiwJIDQlwUExwwWis6UPdfB2vTL1u/paUgs4HnxH0Go
 pAe2lLFjorWVspBvJtEQNXLkozJWvThsZFSU5GXBW8mZ3hA69tP92p6B6XM8+jWP2YWk
 aN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tAUO3moP+hTFL+z2g2ynj8dsoHjP3s61tE4VX5hK15k=;
 b=GJsXS5BJ+N5aX8ytrpmFeX+UEcQJiAVcLpHfo7GJPwfQD0Hqa8JXnUEnDfRYQ/j2K/
 qZj7hmmJ/8D8DWrRmZNhhQZjPwSk0EArbuvRNX4h8qSUcBj5oHmIjuhjb0KnjnsafjmU
 2qeNPtxUiHI1bMUMgakIw4BanJkH0VtJqtX8a42ANTG5K76zlhfoEiFcS2fWE6YhhxDh
 0iYO4wt/9DVvcTeJKRDlPfw+z4LMikg+WgBqHQNf8q0YJFzAcR8jppXFmnYzgi6KQH3z
 GZj2WHF9FGeWHeYt//Cu4yMpMawmO0dI+4+WzRuxSzUr7aLzEIg4MDBnJdK2FYcyitzd
 e7Ow==
X-Gm-Message-State: APjAAAU3a29mWzFRM9F4qCf3+mCkx12fJupomJzLx3d9n1/oHii43NNv
 pNledJorG1YRdhoh4kgsiyVNDOiPMrA=
X-Google-Smtp-Source: APXvYqx7ryVCoWAJgjobtZq06vJ1SA2MCiomoFahBU7Bcs/Jz8zeS4M7qm6rSDVqDbIryRX6ZSAGfg==
X-Received: by 2002:a63:5c10:: with SMTP id q16mr17172124pgb.35.1580585377263; 
 Sat, 01 Feb 2020 11:29:37 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 16/41] target/arm: Expand TBFLAG_ANY.MMUIDX to 4 bits
Date: Sat,  1 Feb 2020 11:28:51 -0800
Message-Id: <20200201192916.31796-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are about to expand the number of mmuidx to 10, and so need 4 bits.
For the benefit of reading the number out of -d exec, align it to the
penultimate nibble.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index fce6a426c8..aa9728cff6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3214,7 +3214,7 @@ typedef ARMCPU ArchCPU;
  * We put flags which are shared between 32 and 64 bit mode at the top
  * of the word, and flags which apply to only one mode at the bottom.
  *
- *  31          21    18    14          9              0
+ *  31          20    18    14          9              0
  * +--------------+-----+-----+----------+--------------+
  * |              |     |   TBFLAG_A32   |              |
  * |              |     +-----+----------+  TBFLAG_AM32 |
@@ -3222,19 +3222,19 @@ typedef ARMCPU ArchCPU;
  * |              |           +-------------------------|
  * |              |           |       TBFLAG_A64        |
  * +--------------+-----------+-------------------------+
- *  31          21          14                         0
+ *  31          20          14                         0
  *
  * Unless otherwise noted, these bits are cached in env->hflags.
  */
 FIELD(TBFLAG_ANY, AARCH64_STATE, 31, 1)
-FIELD(TBFLAG_ANY, MMUIDX, 28, 3)
-FIELD(TBFLAG_ANY, SS_ACTIVE, 27, 1)
-FIELD(TBFLAG_ANY, PSTATE_SS, 26, 1)     /* Not cached. */
+FIELD(TBFLAG_ANY, SS_ACTIVE, 30, 1)
+FIELD(TBFLAG_ANY, PSTATE_SS, 29, 1)     /* Not cached. */
+FIELD(TBFLAG_ANY, BE_DATA, 28, 1)
+FIELD(TBFLAG_ANY, MMUIDX, 24, 4)
 /* Target EL if we take a floating-point-disabled exception */
-FIELD(TBFLAG_ANY, FPEXC_EL, 24, 2)
-FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
+FIELD(TBFLAG_ANY, FPEXC_EL, 22, 2)
 /* For A-profile only, target EL for debug exceptions.  */
-FIELD(TBFLAG_ANY, DEBUG_TARGET_EL, 21, 2)
+FIELD(TBFLAG_ANY, DEBUG_TARGET_EL, 20, 2)
 
 /*
  * Bit usage when in AArch32 state, both A- and M-profile.
-- 
2.20.1


