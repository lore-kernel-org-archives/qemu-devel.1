Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31258C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:48:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D1622384
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SYl/uXBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D1622384
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZtrU-0000q4-KW
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 05:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kZtqV-0008Ms-Mg
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:47:23 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39288)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kZtqT-0000Nw-D5
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:47:23 -0500
Received: by mail-wm1-x343.google.com with SMTP id 205so4527793wma.4
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 02:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=c3NkgLLonq0LzBKzF34PapLARlN1DCYgZXlejCrKq6E=;
 b=SYl/uXBNzjWYz2MOnpX5Qi2zOHKatp7oSCl+guoZdXER0RWTsYZGlQgUA3+LL6WvV2
 AsHlGxrIQc9NREOcRGchzDqUJIC/zzBv39NkZKUXeWQozgNGKWKp0rLmf5B4OigT7sSl
 LqZ0LkrsJKVLMfAidpuVQ1CVmPaQ5/0cVpg3UxybZ1osq9GwbcYY625MKd9ZVJFbemGr
 svOAp3cSdTmo9CH9+RNy5dCd9JBs9M7xlh7Ou0n1OU+wftlpnv/KPqDVMGS1h3jMBVYf
 Yo0BAESxAPxwA1mCyziCiXmv89MFz0wuuJcgCQVXQI2w4jacn2WBb/ly/OgG2KKbq2WJ
 Praw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=c3NkgLLonq0LzBKzF34PapLARlN1DCYgZXlejCrKq6E=;
 b=AZ8HaTTaxowCmH5ouspB0xwNuGIyt2RHu1VZ1Q4DZMr9y3q38aXxI0nIBtcZpMiWW+
 RSpJDj4FjgEZJfkvvglRFB0P/WOngulockA62zuB/yI7NvkxSAouTQogFooEAZez+NR+
 aD44wdTyz5ZBWcLdiqESV63p+RqAYV8hZvnx34TSbq20CUO/gJUCJW20iFerDh02oelw
 GeSVHVcRPkZjU0pj24uke6osVhvWjSWlnVMnDScVgZZ6mIxAM/HAdd+P63lZy2TxQ0v2
 pk/aVF9e/D6SvtiTx9rdI3oEltU8kNs0pxuOjterL+3ncAnDdcXqP3mT00pmSc4wuWRS
 szeQ==
X-Gm-Message-State: AOAM533kI59Kdx9mEEu4x03Udsl3BZGZ/xVCgBec/hUSQhHfBhK+rKMe
 Si8+BjHrX93em2A9QkdR6ce1PQ==
X-Google-Smtp-Source: ABdhPJxE1nxZ/jgNFssuaLyiCp49G2340ZUmE0DO9GZ3GNPTvl6/wmK32aeV/vqiNNjofxw9AcNGlQ==
X-Received: by 2002:a1c:bbc4:: with SMTP id l187mr3039680wmf.133.1604400439151; 
 Tue, 03 Nov 2020 02:47:19 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v6sm10600099wrs.39.2020.11.03.02.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 02:47:17 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 28F471FF7E;
 Tue,  3 Nov 2020 10:47:17 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] docs: add some notes on the sbsa-ref machine
Date: Tue,  3 Nov 2020 10:47:10 +0000
Message-Id: <20201103104710.27150-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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
Cc: Graeme Gregory <graeme@nuviainc.com>,
 Hongbo Zhang <hongbo.zhang@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shashi Mallela <shashi.mallela@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Leif Lindholm <leif@nuviainc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should at least document what this machine is about.

Cc: Graeme Gregory <graeme@nuviainc.com>
Cc: Leif Lindholm <leif@nuviainc.com>
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: Shashi Mallela <shashi.mallela@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/arm/sbsa.rst   | 30 ++++++++++++++++++++++++++++++
 docs/system/target-arm.rst |  1 +
 2 files changed, 31 insertions(+)
 create mode 100644 docs/system/arm/sbsa.rst

diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
new file mode 100644
index 0000000000..a47c9360de
--- /dev/null
+++ b/docs/system/arm/sbsa.rst
@@ -0,0 +1,30 @@
+Arm Server Base System Architecture Reference board (``sbsa-ref``)
+==================================================================
+
+While the `virt` board is a generic board platform that doesn't match
+any real hardware the `sbsa-ref` board intends to look like real
+hardware. The `Server Base System Architecture
+<https://developer.arm.com/documentation/den0029/latest>` defines a
+minimum base line of hardware support and importantly how the firmware
+reports that to any operating system. It is a static system that
+reports a very minimal DT to the firmware for command line input to
+the firmware. As a result it must have a firmware specifically built
+to expect a certain hardware layout (as you would in a real machine).
+
+It is intended to be a machine for developing firmware and testing
+standards compliance with operating systems.
+
+Supported devices
+"""""""""""""""""
+
+The sbsa-ref board supports:
+
+  - A configurable number of Cortex-A57 cpus
+  - GIC version 3
+  - System bus AHCI controller.
+  - System bus EHCI controller.
+  - CDROM and hard disc on AHCI bus.
+  - E1000E ethernet card on PCIE bus.
+  - VGA display adaptor on PCIE bus.
+  - A generic SBSA watchdog device
+
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index fdcf25c237..9636f3fd00 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -79,6 +79,7 @@ undocumented; you can get a complete list by running
    arm/mps2
    arm/musca
    arm/realview
+   arm/sbsa-ref
    arm/versatile
    arm/vexpress
    arm/aspeed
-- 
2.20.1


