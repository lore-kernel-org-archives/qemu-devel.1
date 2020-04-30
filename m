Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CDCC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A272054F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c0ZD8xZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A272054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUEVZ-0003wi-7V
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUERD-0006Ew-EV
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUERB-0003A7-4P
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:55646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUERA-00038k-GG
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id e26so3173719wmk.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CdlDA7BMPwodMgRCX0xuQP7nMRxxWJAZKYksxv5dmZ0=;
 b=c0ZD8xZPVJXIbdPhdjP7tGfgN/G0Njx+lxCbCWAUwkaYitwRBEuIfC2Vu+7acYZgrK
 E+m7HHEDENt7iHTIr+eP/T8J+f5VBM0l1du8gxfmUK1ETA+nflmXpF8nK4LsmuNHnrLY
 JHkmMEmN75fGsAnzfi0ReXZLs4jCaRss1qYWvOOkyHgdDqavZe5bI+qtbBSFrsBFM37f
 gClgH2BHME4cqJkyVW/Q9738JEeX3CZ3PxVwym2xHoXx5uOXzai9yE3CVLUooJqtBuGx
 en96fLiu3JcSk5qpquojxGkCz3+iPF+vrz279DV76yKMAykLM3e/S4LiQesDe7fCGdFF
 7jgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CdlDA7BMPwodMgRCX0xuQP7nMRxxWJAZKYksxv5dmZ0=;
 b=eR0f9cyHR0qQq9JQyFVY5OFIUWbBwzVp8+mK5C8NrNKNEA44hDMHr7TJxPEgpaBeWl
 sVDQtj2Mxj0LUIcDLP8PvlSmBq4knItGEgmkKZkjOOaSDZPS7aG+00f5u+NrK+kdLceG
 miK9V2K9JFrZud1xpytIJbgtolYXfj34/pf9i1E7BAneX0nwlXFdVdYxse8TgJUH6GSA
 6ydc4Pu2Mhtg1fX80n7YhewUMnjrNnXi1v+Lfji5zJkwcWN/aZY8UCL7dYo9Lf6D88U9
 PhPks0diu5H3o1aZnKUdAa+8WKZzV1vHhkPf74s+sLUkJYIPF/mfgRHQ378JKj8F4dak
 228w==
X-Gm-Message-State: AGi0PubMDf9XGGfo22IvEHWzd6acr8ZKaqKJPpTWnmj9CQcCWCtYvECK
 h+U14VJ5D3B8xHVX3Vd6Cyw0hNvvdFk=
X-Google-Smtp-Source: APiQypI7MaSZfHR50xdmKecIoqjfpJ8P58pS7zduAy9ZoGf+t2rVJ2nC2i5Z3MtzBmGlAo3ncMsDQg==
X-Received: by 2002:a1c:e187:: with SMTP id y129mr4827715wmg.133.1588273291007; 
 Thu, 30 Apr 2020 12:01:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r20sm687752wmh.26.2020.04.30.12.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 12:01:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 01A9B1FF90;
 Thu, 30 Apr 2020 20:01:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 4/9] tests/tcg: drop inferior.was_attached() test
Date: Thu, 30 Apr 2020 20:01:17 +0100
Message-Id: <20200430190122.4592-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430190122.4592-1-alex.bennee@linaro.org>
References: <20200430190122.4592-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::330
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


