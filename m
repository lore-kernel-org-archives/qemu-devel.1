Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBD2C352AB
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100FA207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mf0cSmBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100FA207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYjb-00060s-1c
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcZ-0007xG-7p
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcW-0006Tk-1o
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:53208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYcV-0006SD-P9
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:03 -0400
Received: by mail-wm1-x32b.google.com with SMTP id r19so3897862wmh.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/wEnd1FmzxpoUwd38Uee28CXsvCfelQe2lzLzw60kzg=;
 b=Mf0cSmBItdDBBWcyoD9Trh9M0IC3Cc/hPPA2wE25Iwa4bqXqR34dFtQnANXA9PLHSR
 vSRfMUF0ZL9qnWDIdnyA51t+SEoyJpNiCJJRsnN9Baibq3v/XCTKgmpymQCoXLu8o4KG
 8Sx1aSM0MceowTMB/kcLtOXDZfd2GyaOK2t5k+ZOho8Y29eVlMLkrzUlm+K7DNvbGQ8N
 +WIVeymSbU3YY4cRX5QxzMe+owmcrfRUUQtsvfpeoprRt1jZKhGkRUJ41rwmLe0wUi/K
 8q+mLynxSAg2PwWKT9t1pKjXBIt3bfjIyyTZMjEVOczHC/Ld4nKm9ODe74NZXjJrIBq8
 n0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/wEnd1FmzxpoUwd38Uee28CXsvCfelQe2lzLzw60kzg=;
 b=NVGwrtbVoNxF3ITZyjsFbq24pBZ/fr9D6cRyRprri1aH/mD3N7bQYv7JQYdtdKT2Av
 baLRmz4rRb79AJ1b1cypEv0q97M46lbM0ONkPFbykq9ZHj8TGz/XiD+/PCfrhH7Ga8h+
 5dUjculFgZR+67tPkYKRSPwe8kPOADMu5q5axu41r0SqGmjHne0nvAT6WWBX2s0nQJC8
 EmA75u/G/wg9Edr4uGoAWVmTKqONfwUSRLzrzDClx7e+ROmQefpeGLwkW5vE1BFm+PTN
 F7qN3C2qMBHuMqPS7BdsUrZs3DxMv3dfugWhuTKFhWMUJKyfXvl56MmnQwAwJtDbjAkL
 Ts1g==
X-Gm-Message-State: APjAAAUsYsr7wQgidI04KZxwR9kO57hBxeqgPe7gOF6b++bPgqxY0NHQ
 27QgbwykNPioESVhOpKn0+lwgw==
X-Google-Smtp-Source: APXvYqx3G3HiKa+Dm2zVGeLZKIZtG7I1or4uNzQIw+LNzUX6LrEJyBlxfN+KI9HwT4TPBSf5MgXGaw==
X-Received: by 2002:a1c:720b:: with SMTP id n11mr3921628wmc.23.1569522962529; 
 Thu, 26 Sep 2019 11:36:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x129sm5241866wmg.8.2019.09.26.11.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:35:57 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 11E991FF9A;
 Thu, 26 Sep 2019 19:35:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 10/28] tests/docker: fix DOCKER_PARTIAL_IMAGES
Date: Thu, 26 Sep 2019 19:35:35 +0100
Message-Id: <20190926183553.13895-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Finger trouble in a previous clean-up inadvertently set
DEBIAN_PARTIAL_IMAGES instead of DOCKER_PARTIAL_IMAGES. Also fix the
typo to debian-9-mxe.

Fixes: 44d5a8bf5d2
Signed-off-by: John Snow <jsnow@redhat.com>
[AJB: merged fix from Message-Id: <20190917185537.25417-1-jsnow@redhat.com>]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 50a400b573..3fc7a863e5 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -7,7 +7,7 @@ DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
 DOCKER_DEPRECATED_IMAGES := debian
 # we don't run tests on intermediate images (used as base by another image)
 DOCKER_PARTIAL_IMAGES := debian debian8 debian9 debian10 debian-sid
-DEBIAN_PARTIAL_IMAGES += debian8-mxe debian-9-mxe debian-ports debian-bootstrap
+DOCKER_PARTIAL_IMAGES += debian8-mxe debian9-mxe debian-ports debian-bootstrap
 DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
-- 
2.20.1


