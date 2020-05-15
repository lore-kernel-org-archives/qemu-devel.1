Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFABC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 513602076A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="icIXrHxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513602076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbkG-0002Xc-HC
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZbfe-0003m3-Pf
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:50:42 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:40678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZbfd-0002NS-Fh
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:50:42 -0400
Received: by mail-wm1-x32b.google.com with SMTP id u16so2967940wmc.5
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 07:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kKMoxXAM7m/jF9QY7qqcaTZMK0m+l3vXAyXZXTtWXsI=;
 b=icIXrHxronYe/OpJ1UDOT+R3rBTwR7CYroDGueLRQMp7wTN+XJDVsYRG5vLRUQ9X1t
 wB3QK3ZjFN3ONBHMruFWpGXyEPQoT8gnWTPDujzTu4+Rb/zA3E6aq5/pWrPHfXdhZEZC
 2tc58yNDJhCL+WeSGE2zs51uyLjboFADHHsh4ddO6R2ZPzD1+q1TbR/aYU/1MKQDCFAA
 HpnJB5kg4L0/JNPbBeyFIsznkBuONdAKC92XeLe/YYZSbFtiUaF7ZZMbmptZRNS43vCc
 B9LglIOqiNSutl1wHRIK4wF9L+5bMP/WuRVmdACAF2vzM4jHjFFuX7QXTByBmVkTUVqa
 bnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kKMoxXAM7m/jF9QY7qqcaTZMK0m+l3vXAyXZXTtWXsI=;
 b=c9D+V5YFTuUaDqeaLoGI5pcupQ/V9XFkozkTgI9CZmmdWBB29Cf/utJHeXY5w46gd/
 LIP325LfPuCYK7xQlgYjX61o1LB2moKbWXVNkbE1gBKuvrQkdChgU6GcB2C8Fyy/9A/Y
 KnPtCTxJpVMw4zxY36WfZGFqMjbGSPvVc6VcsZuJoBVs4tK2rtHGNHkHgbhcDji+Es39
 Vbdzzl+jSI46a0FDPwib0hp8ssLF79txSjdVYlDTRxRivOsKN1WcFDayBH49Pnsw6MMv
 9qK/rUrMEKabbwPagtQp0r0458iGlRIXtYhlESO7Wec5wRwmkDhklbOsrBu6N+TIvzX8
 cwPg==
X-Gm-Message-State: AOAM532P6YptU4UvGryWiGusIQ//vDtmUTcFOkB+GbeqaU1idZifatPP
 CmDKgX+jmnC7+PV83O8wxVrvZQ==
X-Google-Smtp-Source: ABdhPJwI9p3OqA9tRSlOJUGFZeFNgc7BAfdY8AAvNU7owbqsVgQH0MUWFP9oFAk5O+Iccu6vyWbwCA==
X-Received: by 2002:a7b:c2a9:: with SMTP id c9mr4409414wmk.8.1589554239941;
 Fri, 15 May 2020 07:50:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h74sm4122337wrh.76.2020.05.15.07.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 07:50:38 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 47DBB1FF9B;
 Fri, 15 May 2020 15:44:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 12/13] qemu/qemu-plugin: Make qemu_plugin_hwaddr_is_io()
 hwaddr argument const
Date: Fri, 15 May 2020 15:44:04 +0100
Message-Id: <20200515144405.20580-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515144405.20580-1-alex.bennee@linaro.org>
References: <20200515144405.20580-1-alex.bennee@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Rename qemu_plugin_hwaddr_is_io() address argument 'haddr'
similarly to qemu_plugin_hwaddr_device_offset(), and make
it const.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200510171119.20827-4-f4bug@amsat.org>
Message-Id: <20200513173200.11830-4-alex.bennee@linaro.org>

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 5502e112c81..89ed579f559 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -331,7 +331,7 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
  * to return information about it. For non-IO accesses the device
  * offset will be into the appropriate block of RAM.
  */
-bool qemu_plugin_hwaddr_is_io(struct qemu_plugin_hwaddr *hwaddr);
+bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr);
 uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr);
 
 typedef void
diff --git a/plugins/api.c b/plugins/api.c
index 53c8a735823..bbdc5a4eb46 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -275,10 +275,10 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
 }
 #endif
 
-bool qemu_plugin_hwaddr_is_io(struct qemu_plugin_hwaddr *hwaddr)
+bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr)
 {
 #ifdef CONFIG_SOFTMMU
-    return hwaddr->is_io;
+    return haddr->is_io;
 #else
     return false;
 #endif
-- 
2.20.1


