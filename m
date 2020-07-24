Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73DCC433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769B92070B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="of2nc2ak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769B92070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyrTw-0005ld-Ns
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 02:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSG-00040Q-M4
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:16 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSE-0000FK-UV
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:16 -0400
Received: by mail-wm1-x341.google.com with SMTP id f139so7229631wmf.5
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 23:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XVrIJpB2y9Ni5lFZGxJn8qTVzv2l9retbWFqQwZwYzA=;
 b=of2nc2ak7G3R/14eKYDrekzPb0Le2mZyrw4iQ3dOsj+37n4JVMpf11bPTrvpKYl33F
 pvLwYEJQPvMRmNNzdyXIM7++GW4iQz3x4qhc/+nwaamGfEqBaJFRzMCXrZzeABsOY/a3
 PgWRDHXrVSFrl1qWxUwk0P6UZxC9FLfSWYfX2vJlwh7bgXF8tzSQQprJTMDTY1ZeIdrp
 0x6149B7vFtYGWd/9sjRCxlPCTJd8DgUvq4Bu1B3oRQnXendRWVKKnqwxNuIOyu4Pp9o
 pC0jREXLgIMoaxczrG55YIy4ILSF6D/lzBLRDXZJ8drdyv/PGbPxytba/Zx3q29+dlxe
 vQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XVrIJpB2y9Ni5lFZGxJn8qTVzv2l9retbWFqQwZwYzA=;
 b=HM5FIGHyEY5hNSdzY2/rIxFS+Wk4l41phwJaW6A3HvUGZvJI68SFBzG0L3oRdgeqFu
 p4AIHCphlMmGlygQdNqdw9jc7L3EEoXLvBWZWO2/qu5OgJJ/GTG2PXyH75RQr3o0k1gT
 xobllPphzVaAPvDR1W408CGMX1rJGg0FqYK3H39g3togi7ZuPlNDsTXcZVBrsDwu976r
 fdvZ49kIj8+6Awwu3pLMB/90blT4jDsOZ5LyoDzm3XilJ7/GOXQ/UOdxmBy419yRLsmp
 3T4ysVLp1gCBpWIIgcf7iahfPitOJWI3HHUHgjxGWSQlHpesvu/43jgnJdLJohOGtEga
 svSg==
X-Gm-Message-State: AOAM530cVBJfkWjxAffcg8nMxegVkZdPC56h1nNbi/MUlwt6U5oCLtZS
 h5ydCLibDQLrEda/sXfMhQRZhQ==
X-Google-Smtp-Source: ABdhPJydQazuMVVTtSOZoF5XQl2o5nHpjOowT8D01JQ2/MnzLKk2xQFUN4BqFf4jbxVDcJZVVHKSyg==
X-Received: by 2002:a1c:2c0b:: with SMTP id s11mr5782235wms.48.1595573113421; 
 Thu, 23 Jul 2020 23:45:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v29sm151317wrv.51.2020.07.23.23.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 23:45:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 612551FF8C;
 Fri, 24 Jul 2020 07:45:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/16] semihosting: defer connect_chardevs a little more to
 use serialx
Date: Fri, 24 Jul 2020 07:44:55 +0100
Message-Id: <20200724064509.331-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724064509.331-1-alex.bennee@linaro.org>
References: <20200724064509.331-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
 KONRAD Frederic <frederic.konrad@adacore.com>, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: KONRAD Frederic <frederic.konrad@adacore.com>

With that we can just use -semihosting-config chardev=serial0.

[AJB: tweak commit message]

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <1592215252-26742-1-git-send-email-frederic.konrad@adacore.com>
Message-Id: <20200717105139.25293-3-alex.bennee@linaro.org>
Message-Id: <20200722062902.24509-3-alex.bennee@linaro.org>
---
 softmmu/vl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 34162415579..295459adc95 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4127,8 +4127,6 @@ void qemu_init(int argc, char **argv, char **envp)
 
     qemu_opts_foreach(qemu_find_opts("chardev"),
                       chardev_init_func, NULL, &error_fatal);
-    /* now chardevs have been created we may have semihosting to connect */
-    qemu_semihosting_connect_chardevs();
 
 #ifdef CONFIG_VIRTFS
     qemu_opts_foreach(qemu_find_opts("fsdev"),
@@ -4277,6 +4275,9 @@ void qemu_init(int argc, char **argv, char **envp)
     if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
         exit(1);
 
+    /* now chardevs have been created we may have semihosting to connect */
+    qemu_semihosting_connect_chardevs();
+
     /* If no default VGA is requested, the default is "none".  */
     if (default_vga) {
         vga_model = get_default_vga_model(machine_class);
-- 
2.20.1


