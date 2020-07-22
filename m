Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11DCC433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CCEF20656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KhwPHa9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCEF20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy8Gu-0000Om-Jr
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 02:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8Fb-00071b-VH
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:11 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8Fa-0006uM-Gx
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:11 -0400
Received: by mail-wm1-x344.google.com with SMTP id a6so3659828wmm.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 23:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FXawODYQMPXkW63coV0jaCgGZ0mloHIJB4WSMUcLFTA=;
 b=KhwPHa9yjKnauoBpSsKJLnF0es/YzqGalAAoPgWCdfqgzK+Z93KpaN8CIXTgKoipid
 joLQcjIoNVGCZAaLep382LfuDFqvk13i8td7aDE8YF1OGfYg+EX+UmGQ9twfOYvlDnFH
 RojoGhlXU9xml5AJ+zQLhOUFdhdDMpKrTW+Yms8BZNw7n6xZhNFrfpUNmH6PP5iFnuQK
 qLMytkcii8r/tWQOD/mrYb8p0FE1v5D39SwWrz57qKu95QjOKJLNQx1DXzO7hdDWu6xG
 v1jxO5dJWWZCuf0Ql91r9t3tEB42Y/kGtlfiAMFnekTCPaOisGs/cqRZ4BJuP6oB5OPH
 N9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FXawODYQMPXkW63coV0jaCgGZ0mloHIJB4WSMUcLFTA=;
 b=GqVx1a6e1Bma1v9Xw0r3T73MKMsJgd6E2YEn41TCy5YBl8Dw8EoJohp4zLu68hqXoO
 Yr+WPB1Gswi/WZFJnUMDz6OL+Q1um0eeaPZinYmg/qdZPIPa36r8Mf3MvW7bIFWpg2Kj
 DPZq4Nb7oAUh2TRIyYv2F/J+PJNgZ/GqC2l4akhX2l1a/uQx3xK7aTim297kjJKoxsaw
 LERw5F0E6kpiVYswSULcs84qgh7HFlCmIqc1oDPZZbiXrtce77E/gp/M3CDEHhwHmmN2
 cWC2n0L48PVbPs16NXQaZBMdMqMGI/kkc9UCV4UvuLfoGMU8ltbpsYVee0UeXiUkT4KE
 nSWA==
X-Gm-Message-State: AOAM532kDyKhSEB0KNY0DdDuil+xRSOEgQicdIpSUZTWAykjxnePU8P7
 KtaBZJc8VG7M0VYegWo5LB6Uog==
X-Google-Smtp-Source: ABdhPJyacCCk/0B3/A+JLg/+8wPu53mnLJAoDOrwOpzG2r9MaK2Ij3/qRcsl8dNtna8kEzO+u/jVvA==
X-Received: by 2002:a1c:f616:: with SMTP id w22mr6837124wmc.44.1595399349155; 
 Tue, 21 Jul 2020 23:29:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 60sm15886664wrs.20.2020.07.21.23.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 23:29:03 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3E4761FF8F;
 Wed, 22 Jul 2020 07:29:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 03/12] semihosting: don't send the trailing '\0'
Date: Wed, 22 Jul 2020 07:28:53 +0100
Message-Id: <20200722062902.24509-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200722062902.24509-1-alex.bennee@linaro.org>
References: <20200722062902.24509-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: KONRAD Frederic <frederic.konrad@adacore.com>

Don't send the trailing 0 from the string.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <1592215252-26742-2-git-send-email-frederic.konrad@adacore.com>
Message-Id: <20200717105139.25293-4-alex.bennee@linaro.org>
---
 hw/semihosting/console.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
index 22e7827824a..9b4fee92602 100644
--- a/hw/semihosting/console.c
+++ b/hw/semihosting/console.c
@@ -52,7 +52,9 @@ static GString *copy_user_string(CPUArchState *env, target_ulong addr)
 
     do {
         if (cpu_memory_rw_debug(cpu, addr++, &c, 1, 0) == 0) {
-            s = g_string_append_c(s, c);
+            if (c) {
+                s = g_string_append_c(s, c);
+            }
         } else {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: passed inaccessible address " TARGET_FMT_lx,
-- 
2.20.1


