Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB018C48BE9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8D020820
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qVD+5bjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8D020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51342 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfPOK-0004MH-QG
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 09:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41560)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGI-0006ix-DF
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGG-0007fw-IV
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:37791)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfPGG-0007SE-A7
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id f17so13455886wme.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uYenwXAi2dqO9YgcCSxpMSuNa4TOsTlySRQpX2U2e0k=;
 b=qVD+5bjHqYP++60WwQB0iVxga0/Cbar8oQmqdGFSasEK2fAJQaqZXYJ0wQLnA+qsU9
 OGkK38ebu45b41wth+GZ19XuhPsHbDnPLOYewoK5+GRJiKVasutA1XFmuDePAep7Sj/Y
 qz/flomZJzwaskMS/NG/90YPWlMerFx6ExCLP8zy2guCany4BxOFzajJKsCj7lg5OG4+
 vymE6PeH8TNT15FioIsElauc3Dry3SQaoHHQr/fhP/Whv5CTzMExt1KFJgOrsnRR3wxN
 XrITkw/MruWSMFVgMYS8tUAnr6VI0Abqsz4fsZziBBrQBaa9PU7OQ0ad/pJHA+i+zkvK
 Kexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uYenwXAi2dqO9YgcCSxpMSuNa4TOsTlySRQpX2U2e0k=;
 b=M0Vs7A8A8qWWT2arTI2d4dyXKrmilAHcSDhyMYVTcxHzNh2+X3ClK0Tg5I6j8Wer3t
 6kzMMFxaK5vBqEOOcKvFJMLvXTEJH3s31e5U0mW5ymula8WmFM343WoveA++8crvLCG8
 dHHJJXIPTRdUnJzCDkDAkLF/rPogxU0w3nUXhNYEHGNOX7zL/9JTLHn/cguUjM0vdUC9
 juLrNjiKiOkIB5gi/+2Oxbi0d9oWLvJwP8AgYdLVmfRiFtdW/7/xsZZtWXauolkNs7s7
 Cy52taKFVsgd+0+NIxr1+hcTIcVspyL9yT3GZI5Yr/FnYuPMk8s+n54fi9vJ+fSAc26l
 yOUQ==
X-Gm-Message-State: APjAAAWq5AptxkUX96a8yYHtTAqyLuNJ/vlol2kJqbGLyvZbB+37FDrd
 LyDK6NoW2YPwWfaKYPr3hqPIcQ==
X-Google-Smtp-Source: APXvYqyJvB/pI828TAXUOTRwQn0Re8ef8I7f91ukgVtCsykM9dplFUrODyZeQmJBnrA/Y6pWYtAgsA==
X-Received: by 2002:a1c:720e:: with SMTP id n14mr16224973wmc.53.1561383826209; 
 Mon, 24 Jun 2019 06:43:46 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id y17sm18277427wrg.18.2019.06.24.06.43.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 06:43:42 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 460331FF99;
 Mon, 24 Jun 2019 14:43:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 24 Jun 2019 14:43:27 +0100
Message-Id: <20190624134337.10532-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624134337.10532-1-alex.bennee@linaro.org>
References: <20190624134337.10532-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
Subject: [Qemu-devel] [PULL 09/19] tests/vm: add vm-boot-{ssh,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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


