Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F625C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F18208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DeU2pisL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F18208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47878 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZBqK-0007kR-FB
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45043)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB53-0008Fj-Ar
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB4y-0005oZ-5L
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:37 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:55429)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZB4w-0005jC-69
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:31 -0400
Received: by mail-wm1-x329.google.com with SMTP id a15so1265163wmj.5
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RWdjGRz2IFIKsx2DAAA/Umb0YtSGfkHMorsWs9va5Qs=;
 b=DeU2pisLAHpKCQTrWMuQukqIVvwYUA7fg1PfI5Nq2L1WDAZUf4w29Lv1uyySkFjoId
 H1uhokx5DM7zbJC9WU3CPnmJ2cGhrlrHYFyHBF652Wem4XkRcFSNPtVB55DRheDoV7sR
 u33ARvo8CsPyhgedtCVO22zmNQLkF0oHJmZ2Z8HSn7nU3y4mPmDpLWt5095Fwgts6iuX
 eWAYChQSLu8N4+1I4KRY3TPDK7UiFW5VFNu2Jzl9M7LQz+f//z67r6peCI5EgMeR7pn2
 I1DimVMPGXhiY3MCmG/masM6sdFz6KKtUuN/KdP0kNXPaFI6LRBLncCpSRoVONbCJhEz
 67Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RWdjGRz2IFIKsx2DAAA/Umb0YtSGfkHMorsWs9va5Qs=;
 b=qlIvIDkkaCY8QfV6ye+VesfVsp3e2c3VI3UVUTPn9MjpnYFlGWhRpUYYrqsoRfIlyD
 yA7mo9znyvc/cXpDLCn62SY/IbDbocjYAC/9W+v3AStOSzbJSwPDEV+/5a5bLDewNLfw
 dcN8nQj2xUrGR8WDmh3P5RgVyiV/4Vpp03UVBIflS2WSOxETBm/nJy90MOVAgLBEY5I1
 zTzTiL9r3s6adjeXCkK1jOZAvI+KdKdi2/wY93Dd8qYWpSM6l/MgJ8oFlXSvaHKSaIMu
 c+OQtyQVyYVpJ9w6lK06JSArkCVNcdpUtUj5ld1QWsMlUleOhxF2O0whGcFdzWt7I8Kl
 /PvA==
X-Gm-Message-State: APjAAAVQK0uOeH9pgp7gOphoGLMVKcnVuWU+8ApwGcfE8FrEM4Hy+TRv
 88rpe8aH2geqE0eYUaccmNSHww==
X-Google-Smtp-Source: APXvYqwspIJr8krtcz1k9XUePRTB9nfTtH3nvedd1aFd4ScwI1Oe0dhHPf/pAZjHzxeV4AQXP4xEVQ==
X-Received: by 2002:a1c:7e08:: with SMTP id z8mr2745087wmc.36.1559899348675;
 Fri, 07 Jun 2019 02:22:28 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c14sm1218869wrt.45.2019.06.07.02.22.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:22:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 48ADB1FF9F;
 Fri,  7 Jun 2019 10:05:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:15 +0100
Message-Id: <20190607090552.12434-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: [Qemu-devel] [PULL 16/52] tests/vm: run test builds on snapshot
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

The build script doesn't shutdown the guest VMs properly,
which results in filesystem corruption and guest boot
failures sooner or later.

Use the --snapshot to run builds on a snapshot,
That way killing the VM doesn't corrupt the base image.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Ed Maste <emaste@freebsd.org>
Message-Id: <20190520124716.30472-6-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index c59411bee0..276b870216 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -57,6 +57,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(V),--verbose) \
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
+		--snapshot \
 		--build-qemu $(SRC_PATH) -- \
 		$(if $(TARGET_LIST),--target-list=$(TARGET_LIST)) \
 		$(if $(EXTRA_CONFIGURE_OPTS),$(EXTRA_CONFIGURE_OPTS)), \
-- 
2.20.1


