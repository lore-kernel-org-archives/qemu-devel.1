Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C3AC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D66A2063A
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HE2pRBeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D66A2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKRst-0007OL-92
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 15:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjd-0003Yd-3j
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjb-0002XD-2f
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:08 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jKRja-0002VC-Rw
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:07 -0400
Received: by mail-wm1-x342.google.com with SMTP id t128so8281919wma.0
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 12:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DyeIxRwQ3r5TyVkIrZoIov4F8W7a9xfnJ4qmjPwmv54=;
 b=HE2pRBeHMSc4igIjt0XF95cKDtlhZawGnFUFuy+PmxcRSm6ybcvG6AndgkNiyUQLsQ
 pZTAd05urN571KW0zz+iPJDEc11dy2G7GRzBUc8W+Kd9rSg29IX6yKVIecL49VKH+t3V
 TPLSY2jOQeTxuxWQ0svd2j+62X7jTB+ivEGGBIFu8ItzWMqVqQ1bFOIz+3HJL8fpaTug
 4JtYCLJ6nPDBGUQ9EA5r7PJq3qoPyk2da71tNy0kmQ0v4Ei9gdTZQqaaHqBVBiMQ4APA
 CG6QvsnJ1ERR1XOEEzKO65bSWPPwCJGwTHABZmQrtTD9GUfKCFUcEyT1jZJs9lNVKsgG
 7oJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DyeIxRwQ3r5TyVkIrZoIov4F8W7a9xfnJ4qmjPwmv54=;
 b=CTgu84Zhs4AxIc+RwHJSRKNuXAikXfSSmY2Da141KwR4xGZWhG75wPFUWxEaBZ/LQp
 p6IfmXe6+CJEwCDlaZgux+W+Plc/GrFfl6TPSzzIDEfbJJavTIbe7CeonjzwBVbSsLJF
 qMo98xMpK/uYNfMefq6+8/uALbJiicvVW1VeGBWyFQtH5lwMN2MsV+YieIausCMppFUE
 mafzbp3XWZN+8XuZW2QmIn0mTXPBzfXLhCLw8cMdbrsmej5/p73rBrUL0WBg7hLzVyfQ
 4xo8MKUE8TNYKPpSbPba38UA+BmzXKbc0+JJG4DFNfTOBdn1J/c8P0piyYvD6bxrO0oN
 h88A==
X-Gm-Message-State: AGi0PubS9en2YmAr+dgO/lu1WphXgBMHyjfbHRxMOOcueIUCsuh4BFDl
 ePU1iMT8aZ8enIia+B7hkuYe6A==
X-Google-Smtp-Source: APiQypIvw1puQJJjnCsbKKByRZbDMqtpqRGxztr0Fz8+nT5pVnISdCFDraYGA0IRhHOw9Ax0ppM2OQ==
X-Received: by 2002:a1c:41d6:: with SMTP id o205mr9971548wma.122.1585941125880; 
 Fri, 03 Apr 2020 12:12:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 138sm12521183wmb.21.2020.04.03.12.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 12:11:59 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C200B1FF9B;
 Fri,  3 Apr 2020 20:11:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 12/12] configure: Add -Werror to PIE probe
Date: Fri,  3 Apr 2020 20:11:50 +0100
Message-Id: <20200403191150.863-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200403191150.863-1-alex.bennee@linaro.org>
References: <20200403191150.863-1-alex.bennee@linaro.org>
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Without -Werror, the probe may succeed, but then compilation fails
later when -Werror is added for other reasons.  Shows up on windows,
where the compiler complains about -fPIC.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200401214756.6559-1-richard.henderson@linaro.org>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 22870f38672..233c671aaa9 100755
--- a/configure
+++ b/configure
@@ -2119,7 +2119,7 @@ if compile_prog "-Werror -fno-pie" "-no-pie"; then
 fi
 
 if test "$static" = "yes"; then
-  if test "$pie" != "no" && compile_prog "-fPIE -DPIE" "-static-pie"; then
+  if test "$pie" != "no" && compile_prog "-Werror -fPIE -DPIE" "-static-pie"; then
     QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
     QEMU_LDFLAGS="-static-pie $QEMU_LDFLAGS"
     pie="yes"
@@ -2132,7 +2132,7 @@ if test "$static" = "yes"; then
 elif test "$pie" = "no"; then
   QEMU_CFLAGS="$CFLAGS_NOPIE $QEMU_CFLAGS"
   QEMU_LDFLAGS="$LDFLAGS_NOPIE $QEMU_LDFLAGS"
-elif compile_prog "-fPIE -DPIE" "-pie"; then
+elif compile_prog "-Werror -fPIE -DPIE" "-pie"; then
   QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
   QEMU_LDFLAGS="-pie $QEMU_LDFLAGS"
   pie="yes"
-- 
2.20.1


