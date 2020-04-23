Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF667C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84FF2076C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sR6/T+IP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84FF2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRfNY-0004Vv-NZ
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIk-0001Co-Ki
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIj-0005YZ-Mc
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:14 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:51749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRfIj-0005X3-6K
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:13 -0400
Received: by mail-wm1-x32d.google.com with SMTP id x4so7216021wmj.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 10:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CdlDA7BMPwodMgRCX0xuQP7nMRxxWJAZKYksxv5dmZ0=;
 b=sR6/T+IPT/LhQM1el7P5J867T+50zb6pxIuUciQSVFlhpVgyPUCUCFbpcETxarz+B8
 z3GvF0g4pDWRCeCQG0FYq80hnzTXqJ+lLNE929EptKAhcLnPXYncXxpJAwGLQTT+t4uf
 aev/lmE5wfql0uiUZQ4gXWpLh1Y3jbc0MNDFCuiHjrBNiPZ94GjEOQWcGI57cD2R4NsX
 2L+mPn0Xqa2u9LgrflfcoVDw2jrRyMbGqJHyIBp9rJ3LH8WqluAq+U08/gCjEkoPmmTf
 +98R1ojrJLDI5ue92sh4MNmaAyo4tgey0lq1FydJyu4gS6Rfv8CyMsbDOwnplcAKHM2M
 9XYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CdlDA7BMPwodMgRCX0xuQP7nMRxxWJAZKYksxv5dmZ0=;
 b=NBLTnx7prA2uhl977rN2cdm2wHVlZKSlR1odOf+mbktlu+ZGhNZ15tPewz9ADue+eK
 wTGMQqKvhCFtYGuhZUptCo7mqjgf+mmUS4nhkocLoa7d0MvATIODVOHcC0ATODC56K7A
 4AzcsEuoq9IEK7kFzRAYyINrnqdM6yMv6/hEg5PqWea+/j/GSfjbynS1a/wEFTMOZYwL
 2V7pV+A02bPuvRh0pHYy84DmNGX1GXWdX9+IptcsjhniFVBvDiJZwXM1AhKDp+WDttJ7
 kZXh+xUUB6QPwPRsU/4Jz4woM1vg3ci5091wgR2Cqs+w3wTdhabOmjpvQrBXspIMQzJa
 37cg==
X-Gm-Message-State: AGi0PuYP4rygsWjnwCf9pGWpDfnGrGbe1JfHstQsNW1uC8IurnfD8sJW
 kPhsxCveER8+L+D3c+ENRK1WUA==
X-Google-Smtp-Source: APiQypJb3NI4LnNsep8tS9338TP6fd1ev8e8QYa8VMqLtaWPlRzZ+m21e3MDqKNJiJnAQNTEHSWkBQ==
X-Received: by 2002:a05:600c:20c:: with SMTP id
 12mr5089738wmi.158.1587661571637; 
 Thu, 23 Apr 2020 10:06:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d7sm4399812wrn.78.2020.04.23.10.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 10:06:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 064F21FF96;
 Thu, 23 Apr 2020 18:05:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 08/14] tests/tcg: drop inferior.was_attached() test
Date: Thu, 23 Apr 2020 18:05:51 +0100
Message-Id: <20200423170557.31106-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423170557.31106-1-alex.bennee@linaro.org>
References: <20200423170557.31106-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test seems flaky and reports attachment even when we failed to
negotiate the architecture. However the fetching of the guest
architecture will fail tripping up the gdb AttributeError which will
trigger our early no error status exit from the test

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py | 3 ---
 tests/tcg/aarch64/gdbstub/test-sve.py       | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
index 387b2fc20a..972cf73c31 100644
--- a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
+++ b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
@@ -58,9 +58,6 @@ def run_test():
 #
 try:
     inferior = gdb.selected_inferior()
-    if inferior.was_attached == False:
-        print("SKIPPING (failed to attach)", file=sys.stderr)
-        exit(0)
     arch = inferior.architecture()
     report(arch.name() == "aarch64", "connected to aarch64")
 except (gdb.error, AttributeError):
diff --git a/tests/tcg/aarch64/gdbstub/test-sve.py b/tests/tcg/aarch64/gdbstub/test-sve.py
index 5995689625..b96bdbb99a 100644
--- a/tests/tcg/aarch64/gdbstub/test-sve.py
+++ b/tests/tcg/aarch64/gdbstub/test-sve.py
@@ -59,9 +59,6 @@ def run_test():
 #
 try:
     inferior = gdb.selected_inferior()
-    if inferior.was_attached == False:
-        print("SKIPPING (failed to attach)", file=sys.stderr)
-        exit(0)
     arch = inferior.architecture()
     report(arch.name() == "aarch64", "connected to aarch64")
 except (gdb.error, AttributeError):
-- 
2.20.1


