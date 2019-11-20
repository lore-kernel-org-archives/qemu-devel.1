Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13469C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D688C2230F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D6Xw/GXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D688C2230F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNhr-00087e-Sa
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iXNgY-00070C-Lb
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iXNgX-0006yD-KB
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:10 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:43872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iXNgX-0006wn-Dr
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:09 -0500
Received: by mail-wr1-x430.google.com with SMTP id n1so27555780wra.10
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 02:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6jNVg48ILdOHUBfDag+r3nY2uNv57Ins0s145E0Rdjc=;
 b=D6Xw/GXAJr99E6Z5h4w/PzEwPAptn6kZBU1eDhiEI31WLiaRsmosYV6atZG96SImNK
 PrPRDdRf+jmBomWeShD47a6fL3Aihr+9HzoKMko9GMhgayRas80okuFuj3erx5hydWGM
 WfgTBTb6RMaexAkygLW+d4OfMIP+k3DvW5pDaW8PqRF4YVe5xJPWWhwMYqtdifwZdmVw
 lQOEuZ75wIDAuziLtwVDlqBLe68mQvkGheFy1mcCRm/y2zEiLJccBOB6KpHX2XrgHNVi
 z54n9bIm0nfILhWjdJgxael5MOWxfyGmlGUi9+zJTbV6pFPcTCKgHKt6idRTsRqFfysw
 gvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6jNVg48ILdOHUBfDag+r3nY2uNv57Ins0s145E0Rdjc=;
 b=pV4GxM0q8CqiQICD5E2uzX9oCos/hVKOt21UbakhHUcrfqDAqeJ9gmQedKpKEiIyMR
 8xZhGSihjxA16qHFQKXW4HNbone2CGf4YxMBK8F9vBO0t/cWrbILz/9ZGAOaHD/cYF9J
 RdrJlGvslLBJjJqU7/Tsuhpf12fwXESP2s40FSe8BUFTfMIIqFOJVib/JQMCOzfuOtyP
 5bp8cjmf6HYFbwyDihG4AvkuiM331LBEVbANAueDbWUSN43yM2RpmOqhtesqaM6SRTNR
 7J6aAkd0XwkILeWJGA9PtijxwKqR7U5u1wW/l4B6ZRUv7wOBg+1LK+Ntv/q8O6cYNLEk
 z52A==
X-Gm-Message-State: APjAAAXbMnnIi6ZcZT1Xvw/1MjuYEPIADE+yW7nwlp5QXFnyalPt+nFW
 /M4HBlVPhSU3Vl+xHuKBSXYdjA==
X-Google-Smtp-Source: APXvYqzm6i1qzhOmeIh0wrFUkLQMLTJ2u2VVmaSrOxS7vBsy//KuPi7BP0nvcbtIyIFSYAiaYPnmAw==
X-Received: by 2002:adf:e8cf:: with SMTP id k15mr2565912wrn.256.1574247488296; 
 Wed, 20 Nov 2019 02:58:08 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p25sm6162574wma.20.2019.11.20.02.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 02:58:07 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 972771FF91;
 Wed, 20 Nov 2019 10:58:01 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 4/5] .travis.yml: drop 32 bit systems from MAIN_SOFTMMU_TARGETS
Date: Wed, 20 Nov 2019 10:58:00 +0000
Message-Id: <20191120105801.2735-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191120105801.2735-1-alex.bennee@linaro.org>
References: <20191120105801.2735-1-alex.bennee@linaro.org>
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
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The older clangs are still struggling to build and run everything
withing the 50 minute timeout so lets lighten the load a bit more. We
still have coverage for GCC and hopefully no obscure 32 bit guest only
breakages slip through the cracks.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index b9a026c8eeb..c09b6a00143 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -79,7 +79,7 @@ env:
     - BASE_CONFIG="--disable-docs --disable-tools"
     - TEST_CMD="make check V=1"
     # This is broadly a list of "mainline" softmmu targets which have support across the major distros
-    - MAIN_SOFTMMU_TARGETS="aarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
+    - MAIN_SOFTMMU_TARGETS="aarch64-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
     - CCACHE_SLOPPINESS="include_file_ctime,include_file_mtime"
     - CCACHE_MAXSIZE=1G
 
-- 
2.20.1


