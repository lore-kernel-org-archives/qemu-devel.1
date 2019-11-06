Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B80AC47E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68B72077C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aOjCzRcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68B72077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJay-0005k8-Kg
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZA-0003m4-7j
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZ8-0007F0-GE
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:35 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40357)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iSJZ8-0007DG-A1
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:34 -0500
Received: by mail-wm1-x341.google.com with SMTP id f3so2896204wmc.5
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c9UPRPKHJUNhzqq+bqS8IJr3Nntx8YxeU90N3YYxIP4=;
 b=aOjCzRcbQWDShqOS/dQd5Ioj1a5B13l3MPPMSqKMK0wjR4r9wMcjosBdIL1V2Zc+xO
 3d3dT0TylBhZOsoQgFJQVcXPyDYK1uEbH5qH0KuQgDpnBz7yrr/LjuNxRLNVfEvzIY3X
 N0MChXKCcQjpFH9u/LDFpAhvvYz74mPOQZ1bFbtJc2zjsysCx9fGE2Of2MWIU5uG8tTi
 B3iQXLgKLCPJykI3DpEYIs6mtNmjOXFtrujF9DQjWJZTwgyZs8PKDyPtjuPOKzGf7kdK
 t0mlTY7ZvM1EKvElw432Ae6a24xg7sxZPAAzCSKkiZPWcTGIHAsfoP8woyI7wLipP380
 qEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c9UPRPKHJUNhzqq+bqS8IJr3Nntx8YxeU90N3YYxIP4=;
 b=fBiNXdXrsbMZrIia7Gko1ON+KAEqw7vBQxuwkC2BcJ2G/xdFjDu1l1Pzih7aH4vYoL
 crQkvxYXP/QvuNbsFFIgbpH9OyZLNMr8pNBJjLqQJYnXPVXI3jBFQL7ztc/wmGeE0bY7
 px6ghBnjDlMbv35vJ6WI1N3oWNAxlR3phl7vP5WvVOtfOo7cmnDVxgIfGrFefOyxOHNe
 V7BAz+q6EMh6rONecjFvKclzEe9EyrOBHC/KsZCFIoNhtKtpWDSrN9aIjzEfVhBC3rfN
 r2AkCDa2/8NKWgD9bOKXOEogPSsa85B8dIyDWtaUtpvSRLwONNfgAAqmH4IyPXArIc3L
 AJMQ==
X-Gm-Message-State: APjAAAUVsI829kqHX3eooZObEZlHzjsk1KXzzCr66s31yJmgTVy/TMR2
 UsudiI5p+Pvuq0AzhoGZZ1aYmKsfxTFjNQ==
X-Google-Smtp-Source: APXvYqxRk/wyk3Wt+WACNu+cGcubPFW8W0uYPVPysB2V9aA5VDNu4zjVhvE8ylv3IS8thO8YqbXiXw==
X-Received: by 2002:a05:600c:28c:: with SMTP id
 12mr1989359wmk.25.1573040012975; 
 Wed, 06 Nov 2019 03:33:32 -0800 (PST)
Received: from localhost.localdomain
 (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
 by smtp.gmail.com with ESMTPSA id q124sm1776907wme.13.2019.11.06.03.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 03:33:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/12] tests/tcg/multiarch/linux-test: Fix error check for
 shmat
Date: Wed,  6 Nov 2019 12:33:08 +0100
Message-Id: <20191106113318.10226-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106113318.10226-1-richard.henderson@linaro.org>
References: <20191106113318.10226-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The error indicator for this syscall is -1, not 0.

Fixes: e374bfa35bfb ("shm tests - disabled clone test")
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191025113921.9412-3-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/tcg/multiarch/linux-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
index fa4243fc04..673d7c8a1c 100644
--- a/tests/tcg/multiarch/linux-test.c
+++ b/tests/tcg/multiarch/linux-test.c
@@ -503,8 +503,9 @@ static void test_shm(void)
 
     shmid = chk_error(shmget(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | 0777));
     ptr = shmat(shmid, NULL, 0);
-    if (!ptr)
+    if (ptr == (void *)-1) {
         error("shmat");
+    }
 
     memset(ptr, 0, SHM_SIZE);
 
-- 
2.17.1


