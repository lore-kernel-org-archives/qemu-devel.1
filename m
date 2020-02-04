Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B21C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A12A217F4
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HReE0Ogg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A12A217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz38r-00043z-Qf
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 13:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37q-0002Hb-2t
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37p-0003A9-06
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:41 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:34843)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iz37o-00033h-Oy
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:40 -0500
Received: by mail-wm1-x331.google.com with SMTP id b17so4996150wmb.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 10:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NU0qWo97bX9PJ7TTtxC/vjgYMNLPxAXiNxqJmP7WyBc=;
 b=HReE0Oggfzpy2Qw8z+vyUPeocm9rcsbN9/MgDj+xeAzgMkJI4CXaobrDanTzJR68Tg
 0FCtG1VfT27BQYTuuoJON2XdW2o8O1dLStOLKkmMtaPIsEWBKRrUQjjVSj32coMfx8rU
 v5aH7BJeq2ZIBFLyG76AY1ftOX+TE3FtUrfYR528nz5bV5A+bL3uXdtM7/klqtdzrFJ1
 2CnfDyLxbH5cOMM679MvmvV7pcK31h6aia708igcT4oEdpsg4MhBlo+SMbSr+T8+TCZN
 aaXUP/fq3zFD2kwSUf2TSOOZlRsnzBjZug0abT+z6hb0P+gO+5kNjGzlZyYRTSF3H8QP
 NvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NU0qWo97bX9PJ7TTtxC/vjgYMNLPxAXiNxqJmP7WyBc=;
 b=YL6TFhZtbTtKmr0oaWZG5S9ztfL87BaZ11QKOHMfbuDtJKBjSpZ7BEs6QpVyWz2YLX
 +4UOSp5YnVK/gioAJIQx7nGJcfcgTnKU94WYbWB3gI3dUuSo+/IHFS8H0v4Zjz5fKRw3
 HmQcDRR1hAU8/rGdrixUehuszgVnlODOJDXfcG+9UHCDP0dEvQs/oiWxT+IAuxdMYOlE
 vSebFb+P+wC9xjsF4s6UDophBitGJe6P50X3WngohNdgKumBsc9CWUJlzV1IpC0bvP5x
 NhqSUYPF1aG4yMXof9Cwpo5IS784lRceaReZX4fDWdW+0G1e7QsSfAPvHpfnqLGAqM8Q
 V++A==
X-Gm-Message-State: APjAAAWUozM04jMHcHiNui6AQiVBT9h21gPAcxTDWqEr5uCOFVw9iNXd
 fD+9GQwX9EfWOraYSZBvSiA6/Q==
X-Google-Smtp-Source: APXvYqx6smpuJ2XUWfT7LAT6UO3jxd1DjMBiZVmR48dXoPg4ggednmEK7w6XwphekqLH6yW+h67P2Q==
X-Received: by 2002:a1c:6408:: with SMTP id y8mr378043wmb.130.1580841639675;
 Tue, 04 Feb 2020 10:40:39 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e1sm9885995wrt.84.2020.02.04.10.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 10:40:37 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0C61A1FF96;
 Tue,  4 Feb 2020 18:40:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 07/16] .travis.yml: build documents under bionic
Date: Tue,  4 Feb 2020 18:40:19 +0000
Message-Id: <20200204184028.13708-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200204184028.13708-1-alex.bennee@linaro.org>
References: <20200204184028.13708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It looks like the xenial tooling doesn't like something in our setup.
We should probably be moving to bionic for everything soon
anyway (libssh aside).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200203090932.19147-10-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 3128eff7e01..f245765cfed 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -165,7 +165,8 @@ matrix:
 
 
     # Check we can build docs and tools (out of tree)
-    - name: "tools and docs"
+    - name: "tools and docs (bionic)"
+      dist: bionic
       env:
         - BUILD_DIR="out-of-tree/build/dir" SRC_DIR="../../.."
         - BASE_CONFIG="--enable-tools --enable-docs"
-- 
2.20.1


