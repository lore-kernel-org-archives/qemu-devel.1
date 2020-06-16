Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0498C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908B320DD4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ogf2Kzz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908B320DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlB71-0005Qc-Ot
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 08:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlB5q-0003hw-MI
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:53:34 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:38374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlB5o-00005g-Bn
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:53:34 -0400
Received: by mail-wm1-x32a.google.com with SMTP id f185so2938567wmf.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+NpXtT7RiBsbFomL5lDB9mC735VtH4XYz1tP+UOZeEo=;
 b=Ogf2Kzz2ENtZakGpVXq9A6GzWuoCyEALK8Kw9iXxyAVFz7Zsapk7OvdtUYJ1wq0z1k
 QemkMybZQhDdpaxhGuS7Weqp4uhFOQxjBFXHgIRz6CVc4ElC0P35FZSb2f/QQE6QINbm
 BXVuV6fDb7qPqUNFXrjyt568OV0sAO9Md4Uz9QQ9I/rtCdF1DAfVuMCX/mvr2QygPkdM
 aiyT0IpUC0pZ/DZBj+sjGCO5HcEG75u5QNvAyxFFXM4a/wkh7nJGUlTNwMMCCPDRXmQl
 hk3iNUqfha5Si8OA8DiEkykbeiuIJJEkBg6udalSmga/CSjCvkGma2ETz64LAD9uxRGM
 5/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+NpXtT7RiBsbFomL5lDB9mC735VtH4XYz1tP+UOZeEo=;
 b=CvD81f0LQJ3aEsQaL4cPMrdYlkp43oeCMN4JHD27mLayUbISjTQ9WnmKAhmJklhuPP
 ls9+xY2GbzPVEQn9ek+4gRuUmaWtZnkAEpJmhwqsXL2ro90YEfGtKuDV0+B5Yo+mLYLo
 d0Lju0FpLNO4ie3esjCRpSn1R14x7EC1vFs79Ydu1KCDtz5AeohNZJx3RhjzUKZISea9
 5xvSAJajhCcYLQzGLGIeQE0C/rvZXmnp2tnZvzKSsOmMINfCitHMg/wN4r9279F1CzTR
 5k9vubImvJ4CUdZ1VzfGiu1AXR9SlxKENuL8P3UFYnAxMUWJN5SjM0T9612X1EX/SZvM
 Tcig==
X-Gm-Message-State: AOAM532B785zamy3Ye3hpNPhHLFfBGPrcn7WwotHJph/jGHJ6oRskkd/
 d8R8MwH0dJft91TPwXQIoCb/AvgaGwc=
X-Google-Smtp-Source: ABdhPJzr9ETjdgNozI58Repv7yTDhFKWgq2oQ5f4xnwHIMtMe87QcBajjQgYuqcASZgjTVeMdcliCw==
X-Received: by 2002:a7b:cf06:: with SMTP id l6mr3071539wmg.63.1592312010929;
 Tue, 16 Jun 2020 05:53:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n7sm29697418wrx.82.2020.06.16.05.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 05:53:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D534E1FF92;
 Tue, 16 Jun 2020 13:53:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 06/21] thread: add qemu_spin_destroy
Date: Tue, 16 Jun 2020 13:53:09 +0100
Message-Id: <20200616125324.19045-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616125324.19045-1-alex.bennee@linaro.org>
References: <20200616125324.19045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

It will be used for TSAN annotations.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200609200738.445-4-robert.foley@linaro.org>
Message-Id: <20200612190237.30436-7-alex.bennee@linaro.org>

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 06c058fb58b..9479facdcc5 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -215,6 +215,9 @@ static inline void qemu_spin_init(QemuSpin *spin)
     __sync_lock_release(&spin->value);
 }
 
+static inline void qemu_spin_destroy(QemuSpin *spin)
+{ }
+
 static inline void qemu_spin_lock(QemuSpin *spin)
 {
     while (unlikely(__sync_lock_test_and_set(&spin->value, true))) {
-- 
2.20.1


