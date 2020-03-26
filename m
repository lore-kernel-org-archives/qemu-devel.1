Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892CDC2D0E9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588E120722
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sSmTb2Er"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588E120722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYdA-0000yw-IB
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLP-0000Ot-N4
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLO-0002EH-LY
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:11 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:44637)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYLO-0002E5-HM
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:10 -0400
Received: by mail-qk1-x743.google.com with SMTP id j4so8132357qkc.11
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FcchR0Kiy3cS07PsythDlOBOqbmqT9MEDX8/TYIcoYY=;
 b=sSmTb2ErLMx7WBXRsV87/uGwvDHjPofX/UGkCp7tU20luPN02liTEjeT+g+eAF95LG
 q7ML2QnFzszAla3K4lxyZ6f592wFoV8cl/JCgvxUMlQK9ZZhuil9GWjioAz1JZlcHmFx
 /eMncs0GGzssq/fucixb31+XFBMEmrP1kpt4G0DYfp/QWkJXMJZm56waaGD9M16yAIqj
 fQyAW/uofUUkSp7wXlvRVu4jn4kpgGekoq72XwmfcPnPK8jC/ANGKI+OF6LAEw2geWOI
 YTXvADlsjepXwPPlrrYMJ75JvZ5/sEHDLRuZxQr4LPFWKnFd7MPEXN27vQHvMfZHOZ8W
 y6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FcchR0Kiy3cS07PsythDlOBOqbmqT9MEDX8/TYIcoYY=;
 b=g5ubQHQD3YNvxpvymcAaT8UVLT8+N7PX2Zma5JIbKU4OSZrAIKyplFxTW7YVRbP5OI
 7ng2XPE6JrfDaRVLI6hWaMtK50MJ7g0Xr1OzGJHiHAxuborxWO6zwf+2Z0XMR7Og+pSy
 rJ1bproiknWWCOoR0qJd2rYIv3uSvGakfEHS065rbdN2mWp2q4AtOK5vPuQrHPJjM95U
 /rYtZNPBBPTTQrdnEAUaA8LPw3pLEefpeHuiwKAanR+P4NMv5VTX/bLI9g9HYHJTs0v+
 hPZ1oHMmJkFshaP880xCgecWQc9XImkkpQV8cKGcvd7uJ8LWlz0zQEG5DZFMiGMOwGc5
 1wqg==
X-Gm-Message-State: ANhLgQ1tC4KBMIEyokBgyP/ZgIb5c8dCAYIv6kd3DGJ2fpGG95FAOzNj
 Z7WPLMf8C2hvPCyfaCS4Lb09OiwpUOcG9Q==
X-Google-Smtp-Source: ADFU+vusqx9t8gE5wnpBDnk2e4DGJSXEDqZDsUWWjUiQ7fR0kIN+rLDEa+VeIU2PplMGkT7Y1Qe9IQ==
X-Received: by 2002:a37:482:: with SMTP id 124mr9764000qke.306.1585251549776; 
 Thu, 26 Mar 2020 12:39:09 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:39:09 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 69/74] xtensa: convert to cpu_has_work_with_iothread_lock
Date: Thu, 26 Mar 2020 15:31:51 -0400
Message-Id: <20200326193156.4322-70-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 Max Filippov <jcmvbkbc@gmail.com>, "Emilio G. Cota" <cota@braap.org>,
 peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Soon we will call cpu_has_work without the BQL.

Cc: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/xtensa/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index fda4a73722..0f96483563 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -47,6 +47,8 @@ static bool xtensa_cpu_has_work(CPUState *cs)
 #ifndef CONFIG_USER_ONLY
     XtensaCPU *cpu = XTENSA_CPU(cs);
 
+    g_assert(qemu_mutex_iothread_locked());
+
     return !cpu->env.runstall && cpu->env.pending_irq_level;
 #else
     return true;
@@ -187,7 +189,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
     device_class_set_parent_reset(dc, xtensa_cpu_reset, &xcc->parent_reset);
 
     cc->class_by_name = xtensa_cpu_class_by_name;
-    cc->has_work = xtensa_cpu_has_work;
+    cc->has_work_with_iothread_lock = xtensa_cpu_has_work;
     cc->do_interrupt = xtensa_cpu_do_interrupt;
     cc->cpu_exec_interrupt = xtensa_cpu_exec_interrupt;
     cc->dump_state = xtensa_cpu_dump_state;
-- 
2.17.1


