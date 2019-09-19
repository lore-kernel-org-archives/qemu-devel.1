Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F177EC4CEC4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C59D3214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flY1OZLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59D3214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0T8-0006dU-P1
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iB07I-0008UJ-F4
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAzwo-0004PF-87
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:10:27 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:38247)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAzwo-0004Or-1j
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:10:26 -0400
Received: by mail-wr1-x436.google.com with SMTP id l11so3925682wrx.5
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z2dldeaupASu5CT4Xr8MeQ1Fb6vAVzmxZ2ssb087XM4=;
 b=flY1OZLUOYqKxEa5F5h3EwQk632jt4CfRcHiwaEdBncTq1oBmZqAmNjRTfL7tMYtsH
 H78aIN15Hp0CR7u7lL5MTMZP1/oq17S4Ic6XtlVZHf9vuDdmqDkNL7k27o2MjoSxq0Zz
 kFsSXIte8vZzhd7fC4/icetmHLrZM53X2q2mpgjXzpi8qHdO/SGSVvQI6IEjKncJCvTc
 ISzemltpAeseseC2gI8+10z++Gdc1bHYmZ22nLuIi50dfgI8oPNFZHPbblL8YGLQiUt0
 H87tudPvLeonpFWl5DWfGHDDDTGjsdU00g88hr71N3uAmGICtsjwxTAmBRdqTdrsWOlS
 M+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z2dldeaupASu5CT4Xr8MeQ1Fb6vAVzmxZ2ssb087XM4=;
 b=LgfUn22bNyYFb302r6kPHmHwj8BpB0WOAZYC9Z7VmYM2KIMG7NI5J+OtMIBElq3umo
 Wjm7CKlhDwTlePzAtlvQ1AvdHpwhJA2+UYVskzvhtx9dd8U69xRPJLtKzDQYtVo4RE0p
 N8l35YwIZdicPE23f/Vqzs84Fyf9SYhiQSamurSNU0v/hr00tBZS+KGaYT8ex3AuZTq9
 QcsTQcxSKIQbjARYrG3OuClfya1hbXFSRizpoUUOs/qscE/7Tsq/YfoIsbXMN2McPFRT
 CzMj1DNAEyBJxiJdU5/KkyD2nGIkKIDwCtP7mKvtOheD6F+WjQVNhSv393N8Z2v/SX0p
 jHKg==
X-Gm-Message-State: APjAAAWnv78M2nc2Cqh2IQvEnwLQK3zgGYoa4yAZU04/LF7w8VBAP3V0
 hh1IlpLnrzVKzQaHfWNwKe/uQg==
X-Google-Smtp-Source: APXvYqyDfSUSSoqXcxanHr6SMV8bUpn0emBQw1/COJOFDl97rYD5znXI0/yq7sSHUF/W0ubqnU68nw==
X-Received: by 2002:adf:ecc6:: with SMTP id s6mr7947628wro.333.1568913024865; 
 Thu, 19 Sep 2019 10:10:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o11sm5410712wmc.7.2019.09.19.10.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 10:10:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 00ED41FF9D;
 Thu, 19 Sep 2019 18:10:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 13/16] .shippable.yml: Build WHPX enabled binaries
Date: Thu, 19 Sep 2019 18:10:12 +0100
Message-Id: <20190919171015.12681-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190919171015.12681-1-alex.bennee@linaro.org>
References: <20190919171015.12681-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
 peter.maydell@linaro.org, Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190919105932.19412-3-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .shippable.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.shippable.yml b/.shippable.yml
index bbc6f88510f..01b33bd034e 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -25,6 +25,8 @@ env:
       TARGET_LIST=mips64el-softmmu,mips64el-linux-user
     - IMAGE=debian-ppc64el-cross
       TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
+    - IMAGE=fedora-win10sdk-cross
+      TARGET_LIST=x86_64-softmmu,i386-softmmu
 build:
   pre_ci:
     # usually host ARCH is set by configure
-- 
2.20.1


