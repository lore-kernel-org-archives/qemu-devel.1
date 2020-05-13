Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A18C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13682053B
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xVZ8C1P0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13682053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvHb-0000pm-B0
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvEo-0004hy-QB
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:32:11 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvEn-0007lh-8O
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:32:09 -0400
Received: by mail-wm1-x342.google.com with SMTP id y24so29512110wma.4
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 10:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C5L2tP3m/XtQpZw+uVEZIBSr0SqohhleNs5AmfODQjU=;
 b=xVZ8C1P02bKndHIFx//8VuCIb57kKh01f8OFVUXfSvQOqxpRRTkhKTPOTAljRT2NSk
 Tm5y6FX+Ab/wOYBuJ5HhbFHISZ2wWE8rtBzkrRnWQnyz6/qAd+igPHo70CnKEM2O6mUB
 hpG+mkSsNcBQA0+I+zYHYhkMFLpfhFMy8KAHiERnYkRs1VhVzi26mig6m2f/KVGiTjSQ
 mQC+WWwnTgkEiNQfGePzk4pmNnQzyyhM+er+hKfdRopIFk+FB00wloY4LKwbz2JgmI4k
 7MyIUBGs9M55R3AAAHRmDtVhuXTFtLYazvwtsRpeIZhxvxVLV/VyBCE5CT+/+Nw3tiI0
 SuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C5L2tP3m/XtQpZw+uVEZIBSr0SqohhleNs5AmfODQjU=;
 b=LOWY4TbW9H8kQewoTYiIYLF4+75EApadIZgrNHSyMC1fOnxd+ni+sO1ZJ6sDEb2jYI
 QPA5hAC9fr/XC4OkxNj1rzIe5jw8dlXqkuIZHl13d0kPj32Ke83ZvMo+1TgVyBgpUI0B
 TVY4dFoYc7ZzbZ1CbE84zvKamzgXrFv2Dz6kyPNtJ2dsn7xcPeKijrVp4CONM8P5HpuA
 3TyJq9hCOZnBaHilEEG31+4IeIWmPRxPQyamlW+y6govVw1yEYsugp5BNdN9dOOhMeqN
 ZlF8XlwGq7t9XntNm9jrulMhMe7gS3yRMGV77UoLnGBStnOickczPyv4kYyErmelZC3R
 /Xlg==
X-Gm-Message-State: AGi0PuY3FyJTtAw5GJ2Cf5Dd4De/9mxDoiSsoyZh1fhsRfaKl5YHXePj
 Pxn1xyijGlhWJLvTUzj98zzL8/9ZEJM=
X-Google-Smtp-Source: APiQypKPwWZTI0td0ToQfqXGHWF7B6hO3oy63ykDfbabCXbKIGlfiVqwGaCm8NUi7/9RFF2VBo7AjQ==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr33930439wmk.18.1589391127899; 
 Wed, 13 May 2020 10:32:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i6sm193679wrw.97.2020.05.13.10.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 10:32:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2BCD51FF8F;
 Wed, 13 May 2020 18:32:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/8] qemu/qemu-plugin: Make qemu_plugin_hwaddr_is_io()
 hwaddr argument const
Date: Wed, 13 May 2020 18:31:55 +0100
Message-Id: <20200513173200.11830-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513173200.11830-1-alex.bennee@linaro.org>
References: <20200513173200.11830-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Rename qemu_plugin_hwaddr_is_io() address argument 'haddr'
similarly to qemu_plugin_hwaddr_device_offset(), and make
it const.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200510171119.20827-4-f4bug@amsat.org>
---
 include/qemu/qemu-plugin.h | 2 +-
 plugins/api.c              | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

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


