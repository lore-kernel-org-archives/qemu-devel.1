Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C861C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D0E2073D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TgtBNqGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D0E2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j998b-0003x6-9R
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 10:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j997r-00035z-0a
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j997q-0001ih-3x
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:26 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:46771)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j997p-0001iZ-TL
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:26 -0500
Received: by mail-wr1-x42e.google.com with SMTP id j7so4692911wrp.13
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 07:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L2sHHUzShlYr/EmtNOXj/kdHEDLGbc34wsNmyk67wtI=;
 b=TgtBNqGbIExMpsBz3F9dOIbtXTSqCezJbjAij0wSCAMR21tQwXbAYaHK0Jit1nAChl
 FTl/EKLGvOKYsz+aKeK5TQ4N9j1rhmzUJHrZD1mynerT+Re4uXSo/Bx0ekABXcrC7Zmz
 EK9Ox8DIbyDzXo0NZdnEAzdWJM6sgBQFNI28kE+bsthKBmSMpkGeNfsE61UQg+kJ1w2l
 wsR9IbzsKhT9ZHExOQyZKM1KA7RUMsQmDb8+Fuv74ibnG/fM6xyCYxZzUs2bjJZd+jCY
 nswlMwC0brC55D7ZzNzAq87On7Pv02H6IKHf2C5Ago9xh+BTfKw0ok0e9ZGclvWlwVBd
 6YZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L2sHHUzShlYr/EmtNOXj/kdHEDLGbc34wsNmyk67wtI=;
 b=UGUhCdSz2+SlDlokOiroWAmXT7j3g5Zjb4RcwLdD0AvAoXV75ox1qwLcrTgMj/pwUT
 dWgpuMrKqj6dYkXIO2x5TIBZsCOpqo3TkZ1fYjX12CODkYh106chgDR8VwzOMLlviNQw
 4rlehv0I2MR7KJXZmUPShJvhNhWhM1o2AdyapdyynjrMFG02JqX8XeEvDHmW0oxMGNMn
 NizTsqpl9i3qbB20RtxjAxyefqKdpv5CwA0CaEh83UE1tKU6KxP6IAkn7vDqvOBl16SJ
 02qzyUF9RLxX/jjU8fAzIcFpvOZvWkKf2RnqGLOAsw2Ny0PXBRmJpEvchQtNr+tqhFvP
 QuPQ==
X-Gm-Message-State: ANhLgQ1+MivruHF5lnlCcLA4/qI/07SPHKDbrIK2/qeMO7HAiBVIlz6Y
 TP6tPApZztFdHAe8z8GHrYX6Ow==
X-Google-Smtp-Source: ADFU+vunUXwitjXPW9cTG88lGEmJvE8mSVr2ircRXVUu6cREJWr2LnzIw9W0LKpBYx7kv69OMHgFLw==
X-Received: by 2002:adf:ded2:: with SMTP id i18mr5847588wrn.173.1583247984514; 
 Tue, 03 Mar 2020 07:06:24 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f207sm5381887wme.9.2020.03.03.07.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 07:06:23 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 98C291FF8C;
 Tue,  3 Mar 2020 15:06:22 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 1/9] tests/vm: use $(PYTHON) consistently
Date: Tue,  3 Mar 2020 15:06:14 +0000
Message-Id: <20200303150622.20133-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303150622.20133-1-alex.bennee@linaro.org>
References: <20200303150622.20133-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: Fam Zheng <fam@euphon.net>, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

Change Makefile.include to use $(PYTHON) so for vm-boot-ssh to be
consistent with other cases like vm-build.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219163537.22098-2-robert.foley@linaro.org>
---
 tests/vm/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 9e7c46a4735..778e5067554 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -80,7 +80,7 @@ vm-boot-serial-%: $(IMAGES_DIR)/%.img
 
 vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 	$(call quiet-command, \
-		$(SRC_PATH)/tests/vm/$* \
+		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
 		--image "$<" \
 		--interactive \
-- 
2.20.1


