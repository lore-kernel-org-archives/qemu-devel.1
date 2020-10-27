Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36D3C56201
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F302C21D24
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eNu+1ZUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F302C21D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLqK-0003Oo-Py
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXLli-0006tS-00
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:59:54 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:33594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXLlg-0000Ra-6t
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:59:53 -0400
Received: by mail-wr1-x42a.google.com with SMTP id b8so1194074wrn.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 02:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6RhO4cdwQCgpwQ0W5UH+iqbHXTkkBBBZq5r2GBAXBI4=;
 b=eNu+1ZUDW7KK31w7OGjrpCAJulmG/4nOnjtfA2SJE/8ZY22qxBlV/l4icyfzkz1G0w
 j+xFsROdEcuechc+gGzi9Pn7yljLn/s546mg34tfqwiia2pihGEIr8HEGsEt9UUIQ+Xx
 MBCWYIxCXseM93NMI8QfXllMmDwzaAG0Q5zWLL9wpBCq8l5xqx9TcC5rnvZm7vdz3K4h
 2JpksBEIBcLfhcBcKNdDeusNCe+ThjunFo19m1aM5fRQEMjY52nAHPRX+8rgRiE0QpqB
 MNOdKCw/kTB/Fv0ps+dKBo8X9vG30WCbp68G5BPdR478T0puxbTzLZHpG9Mk3RDEO6Rx
 6l3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6RhO4cdwQCgpwQ0W5UH+iqbHXTkkBBBZq5r2GBAXBI4=;
 b=KbgaDqDcq+ixsMcGE8LjyEoXoSDobsH08u1u9daht+UAo2mbuRlPmAo/wED3f1dOP0
 3CxXoQ/xcUFSZxn4udXknMl6VL4ufI0+bxHlFWAFlUw7/D5CGxrm5DKdJ40iljAUFUak
 al3G1Kolrf2RL7kOQD2ydCh64IFluckso2oJUi5st7bpLwfjzg2Blgwj5eyPmmTN4jFw
 XCVaGh/Qm6O2G+tQ9UIU4+WcGH1R8jHEWefXevcOcSGadIBzZ+Zl6U4BI+bOEThTjNQh
 pmNkfwv6RNC/eDAF4hUdJqp4K4gxvfWaJcVNXUEZCDhMHS8WZ8vEvS8K+Nbv8xdjgmhu
 1NuA==
X-Gm-Message-State: AOAM5327NpSrii9IXrqWjqCH9TxfKTgnTQAzy/rGFNHItcEsL8hbKnnh
 8ghhzU0yj9pwH5hD/WENt57Z/A==
X-Google-Smtp-Source: ABdhPJxbPqI2rJquE4iqYyJkUhQTxEKSMF7Dx0AwF251D9zHSac0xbJN6M3eD4rdtkhNqcVGBc9vvg==
X-Received: by 2002:adf:9150:: with SMTP id j74mr1973074wrj.57.1603792790552; 
 Tue, 27 Oct 2020 02:59:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 30sm1392304wrr.35.2020.10.27.02.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 02:59:43 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 669C31FF93;
 Tue, 27 Oct 2020 09:59:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 7/8] gitlab-ci: Clone from GitLab itself
Date: Tue, 27 Oct 2020 09:59:37 +0000
Message-Id: <20201027095938.28673-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027095938.28673-1-alex.bennee@linaro.org>
References: <20201027095938.28673-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Let GitLab runners use GitLab repository directly.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20201022123302.2884788-1-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5d6773efd2..3b15ae5c30 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -24,6 +24,7 @@ include:
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
   before_script:
     - JOBS=$(expr $(nproc) + 1)
+    - sed -i s,git.qemu.org/git,gitlab.com/qemu-project, .gitmodules
   script:
     - mkdir build
     - cd build
-- 
2.20.1


