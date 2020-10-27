Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2700C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F0B822281
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ct7+2tBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0B822281
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLnJ-00006I-Tl
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXLle-0006mG-MK
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:59:50 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:39440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXLld-0000Qd-07
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:59:50 -0400
Received: by mail-wr1-x42f.google.com with SMTP id y12so1151878wrp.6
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pFYczLPUBSOWDoLgSQqU1D7iJ2Ux4Pk/W6bbBdNtUg4=;
 b=Ct7+2tBsgww9pDeT6nxCVMSbr128ISULjfNKKzxUk610GQdV7X7/sBX7mNRrbcyBWP
 OFxgEmcmS5MiDc3GjYk7HoBc2556IS3UYeRu6iBpHvaV1VPSHigrHkYj5WEbQ/yljFia
 dKJzt3Ks/yZZkXN04in3VMzHpZXkbyQwtPRC4VuvgjU2wBcSWijjRHbVyy6p95TYWx7j
 lkWGtCN1ezqylEHwJCWtrcb0jPNvDm8EasgwGqqY55DESvc44U//kAioao/xdE4pxuB3
 wYfm12GA2ODURgBOVPurv0nnlidNBoDV2/d8+oV8GSZQC8HAU03dx3Pwbj7BBXteuJin
 Xq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pFYczLPUBSOWDoLgSQqU1D7iJ2Ux4Pk/W6bbBdNtUg4=;
 b=DEzdqH8uufnKdwU2s1zCEL9jsX9+DYNG/KASjvm6ldu5Oq/vt6tdoH126GXGoxgQru
 K/4Vt53PltbFJi6f049V2XIhGpz7ITo17waOuWnXC/uGjDuF2HU+eVDxAjIZEcXPbb14
 4Kxbr1hETstUHNI0A02AeMJCDb3BBK7kw6hVG+NWH0mkN4QpbrePzgjwXpSzoccBtwyo
 hMfFuLFv8PexEFDKNb1hz1DQiCK4V1Pc8BLFxYpiB2b62gRTIP9lyzpJab3ghN8KdLrS
 3JKSTyL8NEv3i/j2ui7AqIRZNPyZ8kkEH3jn7u/OVPgT1fvzpkN7748xewB2NYlYkIlH
 uFWg==
X-Gm-Message-State: AOAM531YpD8BMznE60BSL7VdFYuWDyF3+cqSOtJtZ2O9Yl27fUrTwgd5
 V7ZVpaW0BiJfhK72VfMrcAbVt04mUqxnlQ==
X-Google-Smtp-Source: ABdhPJxsvH8adRARaW2rUJDpqL5rTOOQPdh2huG8s+Q2IBnCneiVl6jzr6Ca63sNH/OspTfPGu7bzw==
X-Received: by 2002:adf:e444:: with SMTP id t4mr1981223wrm.58.1603792787571;
 Tue, 27 Oct 2020 02:59:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i14sm1312564wml.24.2020.10.27.02.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 02:59:43 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3A0A31FF91;
 Tue, 27 Oct 2020 09:59:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 5/8] scripts: fix error from checkpatch.pl when no commits are
 found
Date: Tue, 27 Oct 2020 09:59:35 +0000
Message-Id: <20201027095938.28673-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027095938.28673-1-alex.bennee@linaro.org>
References: <20201027095938.28673-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

The error message was supposed to mention the input revision list start
point, not the branch flag.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20201019143537.283094-3-berrange@redhat.com>
Message-Id: <20201021163136.27324-6-alex.bennee@linaro.org>

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 6ed34970f9..88c858f67c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -392,7 +392,7 @@ if ($chk_branch) {
 
 	close $HASH;
 
-	die "$P: no revisions returned for revlist '$chk_branch'\n"
+	die "$P: no revisions returned for revlist '$ARGV[0]'\n"
 	    unless @patches;
 
 	my $i = 1;
-- 
2.20.1


