Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085E3C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C76EA206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wF5gXv6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76EA206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7c9v-0006FB-Hr
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqs-0000jf-Py
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqr-0000ae-OL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:18 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:40177)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bqr-0000aN-IM
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:17 -0400
Received: by mail-wr1-x436.google.com with SMTP id w13so18408648wru.7
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yN9jXo5+S+0huz8wikfbtwNsu0SkQHF6SIknbKMmpiE=;
 b=wF5gXv6xZGwPnCYvv7mP2ljDORFRMgcH1z7Lj1YZF9YYq14j/D6lJxbF5HPPurXD5L
 zYAlK0BRhxFzJ3FwXX06aaLiEgxzIMoNlUhx7tUqAowth7sX3oAk6/OvaUo7qTpZ+aER
 7jWVVcB/5edeZ7hR8toXMfwUP2PX/UEBg6A+rAJspf9J2DGIUTVThXsH8FdaDO0Rtnws
 HrqQ8sCynJtSfP2NTigW+qk4Ag+QBLuMp8Y7grNZVVDp7lSO7vtsrSnyNdUL9dqVyszX
 DlhJR4TDO1BPFlrNV+8de72P+fGRhjGUGODDuISo4S6y8dTOBz2vcxkgm6lvylKwjXAp
 BExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yN9jXo5+S+0huz8wikfbtwNsu0SkQHF6SIknbKMmpiE=;
 b=kcmz+yupIELGT2l88gHFsYolKLysh6NNwL4QySwYp7G/FnKVSSVtD/tIz6KWVz9jVS
 KLTbya23QUZCOfIZzrJLIDb4Htkt5mplQyD6rnwDByBdSh+nMyno96clWlud97vbSt8e
 aLtEzuwed7PMSRuL3YlqrcZhuxwd/A/79wP6jlKr6vNMNbSyWRkgm5iP33XkFKGQH9dc
 Ulp3NPW4Tt5Fr1wVOX9f7qwY+1w33R5sHrI3AyjFa7m7k4xj6SXFqo3cYNqozIK/sXd3
 KZCnoH8slmxSle/RmtfAPlFT3KPw9Fldgh0yHUfntRD6ldvuwYtlYNlvkHKtYjEQc1pC
 0DxA==
X-Gm-Message-State: APjAAAUi5/6NAykzb2kSXiLu9dH8+IBE74X9EskLqTmKjEHpJq39Y4er
 uKVutyY5dY/mwudOIc4F5bkakg==
X-Google-Smtp-Source: APXvYqxCqDnZUTNzN8G8ne7BJsGUEwzbYH8NnfT9QOBFLW2j7Zl6zsSiEXyGOKdQzScZrj6etM5kXw==
X-Received: by 2002:a05:6000:142:: with SMTP id
 r2mr1130862wrx.212.1568105416514; 
 Tue, 10 Sep 2019 01:50:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l1sm19638291wrb.1.2019.09.10.01.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:50:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 132531FFB1;
 Tue, 10 Sep 2019 09:43:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:31 +0100
Message-Id: <20190910084349.28817-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: [Qemu-devel] [PULL 27/45] tests/docker: add debian9-mxe to
 DEBIAN_PARTIAL_IMAGES
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

Another image that can't be used directly to build QEMU.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index c57b74903e6..27a1cc0d833 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -6,7 +6,8 @@ DOCKER_SUFFIX := .docker
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
 DOCKER_DEPRECATED_IMAGES := debian
 # we don't run tests on intermediate images (used as base by another image)
-DOCKER_PARTIAL_IMAGES := debian debian8 debian9 debian10 debian8-mxe debian-ports debian-sid debian-bootstrap
+DOCKER_PARTIAL_IMAGES := debian debian8 debian9 debian10 debian-sid
+DEBIAN_PARTIAL_IMAGES += debian8-mxe debian-9-mxe debian-ports debian-bootstrap
 DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
-- 
2.20.1


