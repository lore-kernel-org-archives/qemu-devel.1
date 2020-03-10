Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431FCC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B97E20675
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uPQzn8nD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B97E20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBez5-0003Zc-8i
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 09:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jBexq-0002ex-9L
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jBexo-00038o-Ry
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:30:30 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jBexo-00036d-K4
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:30:28 -0400
Received: by mail-wm1-x342.google.com with SMTP id g62so1358311wme.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 06:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bo2tBndkpkzB6/29hZp0+G3KOqfBm7NxtWzBJP62dzw=;
 b=uPQzn8nDbz9zWbOgo0e//fzWTe413Ljvje4JJSFOOqJQ3Ow5vq29cuAsMMarfd6pG5
 8gf2HKKVtWp/gmhuNFd8ErMg2YzjmmWgC3YUZeLfBNdYXOwAvZp61IqNki2QhBg7BbR9
 VAw47aBh+6r2Wd0Lm4YZ9q9RhnyWb+LlYlnR/7S5LVe/UIXSzzFmRcagjViFf302Cnk6
 ce93rctHsTozmbNFFnNdso1lHkgP+8Suap7i6mkFPsVzWq7vy9M2XhqJO0mTrVzjHjO8
 tvpRO2QgpenFlogCvLYiBKV7dWSwwq4/sokQaD0OnRKGsKYvfKUr20jM6A1LXYpvSrl5
 uhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bo2tBndkpkzB6/29hZp0+G3KOqfBm7NxtWzBJP62dzw=;
 b=PjlB8SgqLMw3D7HusRKIOjJNjh+EnEROOGFHgTMmTzhgUAquKugydh42u+8qUa9Mem
 WFlYNORbs1ioCRiGsO6oi6g/ELenwTO5iM01ihzik5cHAJMs6Z4/yl/ZBNED+rM0eN+u
 s4LVy8rrPTBpgQazNpzt1anSGBuDR8N+U1vyLNNp8pCUG6TlTI/WXZhXBYGKXLpn6+C1
 RVjvHsie6SSCbQUVy5vzrina4Z2+pfXG9U/91edJjWAfuNorS8rAkiRMRJgpkjTO6m+w
 jP8exYJaRE2m7OzamMwSvZYsgipjWGjkL4INVkwzRslOzh79UewBiVnuXie89ia/O3ZP
 z0tw==
X-Gm-Message-State: ANhLgQ3lpW+9Rx5d/99uQDlnHZp4+ZwFS25edtR/j8j0ONwIZGk90OV+
 6ZcAD6HXo9aNuy7uEiQiGNu/nA==
X-Google-Smtp-Source: ADFU+vv0j6is6BB58FmxqxXWJxw+06h32Y8LDKFkQ8+YH5nhKVvsMdir9NML49LQOSkcvjacYGjXIw==
X-Received: by 2002:a05:600c:2213:: with SMTP id
 z19mr2101181wml.141.1583847027348; 
 Tue, 10 Mar 2020 06:30:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y69sm4254503wmd.46.2020.03.10.06.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 06:30:26 -0700 (PDT)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C0ECD1FF7E;
 Tue, 10 Mar 2020 13:30:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] docs/system: add a little more detail to ARM machines
Date: Tue, 10 Mar 2020 13:30:20 +0000
Message-Id: <20200310133020.27196-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Taking from the wiki page mention:

  - both 32 and 64 bit architectures
  - the roll of A/M profile chips
  - warn about kernel portability
  - gently suggest -M virt
  - add headlines for groups of boards

This is still incomplete but hopefully is a less of a straight dive
into a dry list of peripherals.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/target-arm.rst | 47 +++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index d2a3b44ce88..28aaef011d6 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -3,8 +3,35 @@
 ARM System emulator
 -------------------
 
-Use the executable ``qemu-system-arm`` to simulate a ARM machine. The
-ARM Integrator/CP board is emulated with the following devices:
+Use the executable ``qemu-system-arm`` to simulate a 32 bit ARM
+machine. The ``qemu-system-aarch64`` executable is used to simulate
+the 64 bit ARM AArch64 architecture. AArch64 CPUs can often include an
+AArch32 execution unit and execute a mix of 64 and 32 bit code.
+
+The emulator supports both "A-profile" and "M-profile" CPUs. The
+A-profile CPUs have a full MMU and can run things like the Linux while
+the M-profile CPUs are typically used in embedded micro-controller
+boards.
+
+Because ARM systems differ so much and in fundamental ways, typically
+operating system or firmware images intended to run on one machine
+will not run at all on any other.
+
+If you don't care about running on a particular piece of hardware the
+``-M virt`` board provides a PCI based virtio board which can be
+configured with a range of RAM sizes, CPU types and virtio based
+peripherals. It is generally the target you want to use if general
+purpose operating systems.
+
+Otherwise a range of other machine types are available. Passing ``-M
+help`` to the command line will list them all. They include the
+following:
+
+ARM Integrator/CP
+~~~~~~~~~~~~~~~~~
+
+This is a development board intended for prototyping and developing
+ARM-based devices.
 
 -  ARM926E, ARM1026E, ARM946E, ARM1136 or Cortex-A8 CPU
 
@@ -18,7 +45,11 @@ ARM Integrator/CP board is emulated with the following devices:
 
 -  PL181 MultiMedia Card Interface with SD card.
 
-The ARM Versatile baseboard is emulated with the following devices:
+ARM Versatile/Versatile Express
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Another family of development boards. The more recent Versatile
+Express boards are designed for modern Cortex processors.
 
 -  ARM926E, ARM1136 or Cortex-A8 CPU
 
@@ -45,6 +76,9 @@ The ARM Versatile baseboard is emulated with the following devices:
 
 -  PL181 MultiMedia Card Interface with SD card.
 
+ARM RealView
+~~~~~~~~~~~~
+
 Several variants of the ARM RealView baseboard are emulated, including
 the EB, PB-A8 and PBX-A9. Due to interactions with the bootloader, only
 certain Linux kernel configurations work out of the box on these boards.
@@ -77,6 +111,9 @@ The following devices are emulated:
 
 -  PL181 MultiMedia Card Interface with SD card.
 
+Various PDA machines
+~~~~~~~~~~~~~~~~~~~~
+
 The XScale-based clamshell PDA models (\"Spitz\", \"Akita\", \"Borzoi\"
 and \"Terrier\") emulation includes the following peripherals:
 
@@ -156,6 +193,10 @@ Nokia N800 and N810 internet tablets (known also as RX-34 and RX-44 /
 -  Nokia RETU and TAHVO multi-purpose chips with an RTC, connected
    through CBUS
 
+
+M-profile boards
+~~~~~~~~~~~~~~~~
+
 The Luminary Micro Stellaris LM3S811EVB emulation includes the following
 devices:
 
-- 
2.20.1


