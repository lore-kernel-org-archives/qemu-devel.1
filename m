Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751BAC3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4377020870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlMLB2+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4377020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Qws-0008Sy-F7
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 05:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Qqw-00072v-Bq
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Qqv-0000u0-Cd
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:10 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:39768)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j9Qqu-0000pq-KA
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:08 -0500
Received: by mail-wr1-x430.google.com with SMTP id y17so1599931wrn.6
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 02:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=proYjuk/ghIUbAZUhjDs+u7cCfDIGKo4bJEFHg7+0GY=;
 b=UlMLB2+958dDHppmMIFuSMDcdYE8CJxzZipz6BbZnLsA13OXNJ0MHux6ChF9m+h4n+
 suJ66b5kcZLPF5ANIbwE/YtTw6OqSpuStoIFc6X3laXSNWiJEJpzQH1tTFt8XVyl517y
 8HGHttOWygrINcNclxWe+060kkmge5MTNmNxJutXfst4RdlZ2gBtyJNFiE7AWbHjot2s
 Vh9TtrUxkkvDrtMnF04LFxuVY5vdY5SknEP0nZCOgBH1Pz7u7FKj6E18sWKdDlGtlhpz
 Zizn0UU9J7wwTCSALP45egdL47KWFzPscxqI+CUPegPIGXGPRweeVLNs/4wI3wxIjv23
 Znfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=proYjuk/ghIUbAZUhjDs+u7cCfDIGKo4bJEFHg7+0GY=;
 b=NGA1lVyfUtO6a50X7qsWs6TWgVVPWk5GXa7etFFhia7pklvwQQSK77RwzM0jVL429D
 x99gcjwSmhf+XbkiktNkUO+6c4TjoNBfxKK8ChV06X+TS64UIgis0/8qIrlXnU0YiJf+
 ppHOi/wf0sTdAlebP+nBTm8Utq73padjUpu2od3WyGXBpcZpMQC5rCqFZcrXnwXg4X/J
 g/Zn9up7bEem7VhfuubqrHKwR/X6WQ/xVR4qXSHo2advbu0oOHeCKMh0VhbYdzGrcLU2
 f0KogXxhwLxgQZ6Ys9V1wIXWtBnNSWYpD23SbUBAsYCSvEKvuseWfpnvf7wzkhpdIJOR
 ZB8g==
X-Gm-Message-State: ANhLgQ0BYHWWIlGnOFVzAls4I1z+y8fZjDewOmaZ4DaYhhgao/R6jeYb
 O0an5SlLX5AeTGOSSnnNsOiEQA==
X-Google-Smtp-Source: ADFU+vsS+FYAmLcuOfKxSKCAtTuV4PLut+/Bd/GXh/OHftkr6X+Rh5ww5m9hHvwkecP5mYdlVrgRMw==
X-Received: by 2002:adf:dccb:: with SMTP id x11mr3278956wrm.214.1583316127568; 
 Wed, 04 Mar 2020 02:02:07 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m3sm18662244wrx.9.2020.03.04.02.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 02:02:00 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AD8EE1FF99;
 Wed,  4 Mar 2020 10:01:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 9/9] travis.yml: install python3 numpy and opencv libraries
Date: Wed,  4 Mar 2020 10:01:54 +0000
Message-Id: <20200304100154.14822-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304100154.14822-1-alex.bennee@linaro.org>
References: <20200304100154.14822-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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

These are used for the acceptance framebuffer tests to count Tux. As
we need slightly newer python3 for opencv we bump up to bionic.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Message-Id: <20200303150622.20133-10-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 70a24bf2fc8..b92798ac3b9 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -313,6 +313,7 @@ jobs:
 
     # Acceptance (Functional) tests
     - name: "GCC check-acceptance"
+      dist: bionic
       env:
         - CONFIG="--target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
         - TEST_CMD="make check-acceptance"
@@ -323,7 +324,9 @@ jobs:
           packages:
             - python3-pil
             - python3-pip
-            - python3.5-venv
+            - python3-numpy
+            - python3-opencv
+            - python3-venv
             - rpm2cpio
             - tesseract-ocr
             - tesseract-ocr-eng
-- 
2.20.1


