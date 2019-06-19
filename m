Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22AFC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:53:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 965E220B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3c1KA5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965E220B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41482 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdgeN-000800-PD
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 15:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53975)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRf-0006AZ-3y
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRc-0000As-Ji
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:34 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:36963)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hdgRa-000086-Qw
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:31 -0400
Received: by mail-wr1-x432.google.com with SMTP id v14so497639wrr.4
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ARkcebMpISH50aw23FUa04C3Oh1jK41sh6r3OqpObcE=;
 b=g3c1KA5KzxMalCXecUFEgbFY2TZc7+/4CRaeus3y47wJWdOMq+XNCULHOUIj5XXxQG
 oJ2LIrP3N1rRf2PY8B14w1vF51S3/iF1rec6TvWmPEW43GJ9bTk6C6physJEWswcKVg5
 gstdR0ZOuhzGkpgJT+q9+JwTG9Vu4KyBwKwqfjb7plmjk8jbQYo1kwXD+UvXDgV7igNa
 Xs3IZH5sGojGGDjh8gHxePDAKQbLCHuV9KStb5ErbzeiQXp7QejJikQ/B9fZWbx4WVc5
 laTaTmMP/6ofC9LoSybNLm0OE1Er03Rd5uDZgJuOt88bk/n+7ch+ckTBCC7O5RIRKsra
 nBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ARkcebMpISH50aw23FUa04C3Oh1jK41sh6r3OqpObcE=;
 b=TWfiE75I8j+5WGA9XzF4DHDojdrmMJSxQOUCUfszHukFBdm3j3ZjKpofIv5LWQvEuy
 j8uXOUsW5EY4rAs98VuSt+R7zSHtxyDzbmlSdS50OO8aH0ZLVGEOJKQAKRleN9b6Dlbk
 waEvv2L2OaBjQn8BV+3AVKxENCKXM/5FWZqjAltbyWIM6xYB09XHI4ugHbd0KsaRdKZJ
 OFzcxvsfU8uYWvYS+uM69YZBsSb/MqlOFrUhhcX/BaXafXhjvqYTAQd093cL9MeZkhlY
 MeAC8oD+8Iev/VE26X1lEiwSFEcrGvnM7wGEn3yM4MCgAnlPzZ8CuZR/qZRTXWqRkjdv
 Km/Q==
X-Gm-Message-State: APjAAAVWAai/n5mJAfTRDPiCI/7IdCAKexBY+5aJXaqSSPL+lb9ZMETr
 R13K/6bRSfBeF+JS6lZl04XzJw==
X-Google-Smtp-Source: APXvYqxn/9gU9fD/fyQWPIKvIuFNlpZzSu6sHpYuQfchSBkYk0CaxLb7GMJF2N2Qo20ZmZwYuOC4eQ==
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr10910899wra.156.1560973229277; 
 Wed, 19 Jun 2019 12:40:29 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id q193sm2271869wme.8.2019.06.19.12.40.24
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 12:40:26 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 335AA1FF99;
 Wed, 19 Jun 2019 20:40:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 20:40:13 +0100
Message-Id: <20190619194021.8240-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619194021.8240-1-alex.bennee@linaro.org>
References: <20190619194021.8240-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [PATCH  v1 09/17] tests/vm: add vm-boot-{ssh,
 serial}-<guest> targets
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

For testing/troubleshooting convenience.

make vm-boot-serial-<guest>
  Boot guest, with the serial console on stdio.

make vm-boot-ssh-<guest>
  Boot guest, login via ssh.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190617043858.8290-6-kraxel@redhat.com>
[AJB: added tags]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/Makefile.include | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 276b870216..a61c236b8e 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -20,6 +20,10 @@ vm-test:
 	@echo "  vm-build-all                    - Build QEMU in all VMs"
 	@echo "  vm-clean-all                    - Clean up VM images"
 	@echo
+	@echo "For trouble-shooting:"
+	@echo "  vm-boot-serial-<guest>          - Boot guest, serial console on stdio"
+	@echo "  vm-boot-ssh-<guest>             - Boot guest and login via ssh"
+	@echo
 	@echo "Special variables:"
 	@echo "    BUILD_TARGET=foo		 - Override the build target"
 	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds"
@@ -63,3 +67,18 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(EXTRA_CONFIGURE_OPTS),$(EXTRA_CONFIGURE_OPTS)), \
 		"  VM-BUILD $*")
 
+vm-boot-serial-%: $(IMAGES_DIR)/%.img
+	qemu-system-x86_64 -enable-kvm -m 4G -smp 2 -nographic \
+		-drive if=none,id=vblk,cache=writeback,file="$<" \
+		-netdev user,id=vnet \
+		-device virtio-blk-pci,drive=vblk \
+		-device virtio-net-pci,netdev=vnet \
+	|| true
+
+vm-boot-ssh-%: $(IMAGES_DIR)/%.img
+	$(call quiet-command, \
+		$(SRC_PATH)/tests/vm/$* \
+		--image "$<" \
+		--interactive \
+		false, \
+		"  VM-BOOT-SSH $*") || true
-- 
2.20.1


