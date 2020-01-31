Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05F8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC12214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbEcqWJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC12214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixZ8G-0002M2-LY
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ixYJl-0008Pe-J0
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:34:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ixYJk-0001Cm-8c
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:34:49 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39164)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ixYJj-0000wl-Ec
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:34:47 -0500
Received: by mail-wm1-x342.google.com with SMTP id c84so9134943wme.4
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 07:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=U6rBLA/U9vPD0iwiYokLmvgSrsiQLZatZk4Rve05YVs=;
 b=WbEcqWJ2gYLrhdL4WI08wliy1wuAuauA9BwN9C45FJCc8nbooxRimuJIxiDGmcUjw0
 EKl/9pEvYpgb8dScvDO/NtLI7WI/qadKz5i1sqEruIB/ZJ2mK8XzICwQUTp+uY0GFxFC
 fmWw1vxrLrW7QEPEZ1bYX1H3xnWLlaIhIFR549UqFpXNFC/Y75Znmh2FIxtBi3LdOWgx
 Q0dhqQ36nCgVQ050Iq8xzvueuVpZhOQgzbn/DIVNGMicVbht6ym8mG37d+lWraB4BwVJ
 DSKQ7O+Evp18/m6Bz0mf0AVv8sZL9ld95TKdVXBcP+3vfwIdfz0omANpdHlOjyPDzwbm
 O8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=U6rBLA/U9vPD0iwiYokLmvgSrsiQLZatZk4Rve05YVs=;
 b=o9iUuxcFY25UhmX+N7P9uBKHVA1psmG0KsC7XMISNQpHZFIV+ra0fDHmpp1gmUIIy/
 rCHC/sf8djCy1QMJjK8Ktl8oXaMirs5dGaG6RaZVjzzOx/eQ9LCsGuKAitEvZUifn12A
 AGgxhUJ/2XFwlhr0pQS/h7Nic2cZjEXCJGB9+4UydZ1eClFgYhYHL4hNJDv/cLmcWxyK
 7QpBRwweCd9V5iMwld90WEQ4I44GFvCPUC8ohMcM6yRnmScIMhb+wRnKBAPO1+TEG4uH
 kqxBz7BUu7WKSAnXcNue20MR/N/JhgHL9yZk1r3aVpu3A3boZ0fjgUGG9y/S9ZxSJV97
 vWVQ==
X-Gm-Message-State: APjAAAXvjVInreGXJx2wFhNzCHaYhNB107Wy0tvnA8AR+ZygRWo5CAgx
 9Aq1PZaoMnoE3MZypXkMoB8Ngw==
X-Google-Smtp-Source: APXvYqxNVzk0wwtJCOs0UG8hUY5oiVJ3368Xg9p30bNzSB/iL4JfVpF++3NaGSwAZK5Xn3ZGUADrng==
X-Received: by 2002:a1c:9e89:: with SMTP id
 h131mr12677641wme.161.1580484884918; 
 Fri, 31 Jan 2020 07:34:44 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w19sm10714852wmc.22.2020.01.31.07.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2020 07:34:43 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0987A1FF87;
 Fri, 31 Jan 2020 15:34:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH] target/arm: fix TCG leak for fcvt half->double
Date: Fri, 31 Jan 2020 15:34:39 +0000
Message-Id: <20200131153439.26027-1-alex.bennee@linaro.org>
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When support for the AHP flag was added we inexplicably only freed the
new temps in one of the two legs. Move those tcg_temp_free to the same
level as the allocation to fix that leak.

Fixes: 486624fcd3eac
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/translate-a64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 96a5be2b372..766a03335bf 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5778,8 +5778,6 @@ static void handle_fp_fcvt(DisasContext *s, int opcode,
             TCGv_i32 tcg_rd = tcg_temp_new_i32();
             gen_helper_vfp_fcvt_f16_to_f32(tcg_rd, tcg_rn, tcg_fpst, tcg_ahp);
             write_fp_sreg(s, rd, tcg_rd);
-            tcg_temp_free_ptr(tcg_fpst);
-            tcg_temp_free_i32(tcg_ahp);
             tcg_temp_free_i32(tcg_rd);
         } else {
             /* Half to double */
@@ -5789,6 +5787,8 @@ static void handle_fp_fcvt(DisasContext *s, int opcode,
             tcg_temp_free_i64(tcg_rd);
         }
         tcg_temp_free_i32(tcg_rn);
+        tcg_temp_free_ptr(tcg_fpst);
+        tcg_temp_free_i32(tcg_ahp);
         break;
     }
     default:
-- 
2.20.1


