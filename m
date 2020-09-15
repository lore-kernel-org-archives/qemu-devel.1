Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBE5C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5EE120738
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pTOcitnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5EE120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIBOJ-0005NX-TK
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIBEz-0000bL-V1
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:43:25 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:37243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIBEx-00047S-K0
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:43:25 -0400
Received: by mail-wm1-x32b.google.com with SMTP id a9so3541932wmm.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 06:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5BOmhReUgRYepT/uJV8CPnyEkDw8fwL11jEVPcCrHmY=;
 b=pTOcitncvy53xOhCf4QRpkprIZWZlBMsw5/lWlUuQ1IeblFN0QB8CoJ5QsRahMWJL4
 ZknFy1oCNxuUfrJvPC2X9aYyyP5hViDFgyNvpivvyC3jzn1uXt2nhPepcZB80dRsCB+S
 kP+9ps/D5HvaFWrkj3pEQWgTX+4LYG/JBRrIgSIi+p5JG/BH1xozHhXf/epqSqLJAbyJ
 S72ZJHHn+HJXhlLpJGrguCDUhQmlGv6u8XrxRt/aqH/el79P/pzm4MCwn2kxBjcdyvPF
 XHv6k4MTsIjqCl4Z1pn4D/TIhSTt3aBxD/nJj3WcM+WrC0MsEBpGVEY+po2YJSJZKqWi
 bNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5BOmhReUgRYepT/uJV8CPnyEkDw8fwL11jEVPcCrHmY=;
 b=hCznmD/hjaYSpgwyRzfWrA31vfnuPab+gQYvjJARCXLGwssKUXrobsPCTCZ61OnTq7
 VI3/g85T6N5zqaj3ETZsJ+X47erlm50tRn4ArPUXalldUJ6sR7CqxH5XwGdT8pT+12N3
 BsrAHAkSPJwkOwkfb/9lDQLJYsKGi2q4efvXQfTGbQHrtE0Phg1qR849Lxm91RfSh1D3
 WN23FzVM0T/aAFBHPf4hAysFST+56diPUoScCB6HNP+0hCddg7Bge5Iq6XO/nFIG/1Cj
 iM0viUqFR+DPbhfwMfV/knzL0StXiamxB+ADwJJzDw/PXLdpLS9xjpHxurZ88beu3CCw
 jBCw==
X-Gm-Message-State: AOAM53199URJd7fOtDhLqc/v/R2/m7mRMvovlDFq1FjdYrRJVRsW163d
 3PLjXhlWW3TuyN28OnP0osrIUQ==
X-Google-Smtp-Source: ABdhPJxIy1CAsn4LmSa2iR3chOTeVwu/yWaNQjCYPg9QBDIDnDk83ddOr4ViEAweq43+6v96phoTaw==
X-Received: by 2002:a05:600c:283:: with SMTP id
 3mr5018151wmk.110.1600177402087; 
 Tue, 15 Sep 2020 06:43:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z127sm9706917wmc.2.2020.09.15.06.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 06:43:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 57F0D1FF8C;
 Tue, 15 Sep 2020 14:43:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 2/8] iotests: Drop readlink -f
Date: Tue, 15 Sep 2020 14:43:11 +0100
Message-Id: <20200915134317.11110-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200915134317.11110-1-alex.bennee@linaro.org>
References: <20200915134317.11110-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

On macOS, (out of the box) readlink does not have -f.  We do not really
need readlink here, though, it was just a replacement for realpath
(which is not available on our BSD test systems), which we needed to
make the $(dirname) into an absolute path.

Instead of using either, just use "cd; pwd" like is done for
$source_iotests.

       ("iotests: Allow running from different directory")

Fixes: b1cbc33a3971b6bb005d5ac3569feae35a71de0f
Reported-by: Claudio Fontana <cfontana@suse.de>
Reported-by: Thomas Huth <thuth@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200914145606.94620-1-mreitz@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qemu-iotests/check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index e14a1f354dd9..678b6e49103a 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -44,7 +44,7 @@ then
         _init_error "failed to obtain source tree name from check symlink"
     fi
     source_iotests=$(cd "$source_iotests"; pwd) || _init_error "failed to enter source tree"
-    build_iotests=$(readlink -f $(dirname "$0"))
+    build_iotests=$(cd "$(dirname "$0")"; pwd)
 else
     # called from the source tree
     source_iotests=$PWD
-- 
2.20.1


