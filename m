Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F06C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:19:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92336208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lMUN8FsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92336208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47940 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZBxb-0005WA-Qj
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42216)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvT-0002Fo-CG
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvQ-0004zE-Rj
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:43 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:46952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAvQ-0004h3-Ez
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:40 -0400
Received: by mail-wr1-x42b.google.com with SMTP id n4so1339732wrw.13
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l3qvsmebNFZ5O5OwW5sp1A169mo8OEERmO3Igp6r4L0=;
 b=lMUN8FsR0cqZW/CU4/NbtsCLcBR8lJnXtHyTldqgblkNKAnHQK2Qty+ilzAsmIvRii
 itp+rMKzSh8P3cq5hQUkj47H6JdSGbG8OCq4V8aBzqNm0TYQuRiHK0WZiE9vfNqLM9is
 Zx7E1hFB5isz0bO1hFi/8Fq6mlR14VurwnJe//aP9z/oWbHWzU5MocnriDBDeMwBZwFz
 W4X9Yi8WLO3In0d8gVQuoP8RjGtOxJJ2y4zuqYRUDi1oQ4+7+fwJNV7mT1w5SK3Eh0GJ
 dB5Gd6eu0khJ4r3zAjCaXmbc1RGRiGeaAwqtbhnGcU6vQUieAvcnawtzB6v4G883ucq4
 Jx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l3qvsmebNFZ5O5OwW5sp1A169mo8OEERmO3Igp6r4L0=;
 b=sn2hNQONdnZGEFK1AoPkKQnFOXZWeN6PDWd8Vxglu+bak0iyob82IRgOtGfIhSjAEn
 R0mo6aEGYZda86pN7DOmWKjCav8Mrgs/tnoFUYZSoYp269bIzcAKYGQREs/ZHMB2ohVU
 3IKj5wn68LRk5cKL4/oCQttuAZZt/+DpnoBUK8eMe8cyGJDJlhQg21RLqGi0pUKUDO0O
 debEVEhhe6B+MXDzOWm7L00WHWxjPATGDVHuJCkHjvwE40ylhcszXa/Ol9sen66ZTmb1
 mNBOohUKdQgMAJKpvZxWgO/gmlAjo2drP2gki9YS7NSUhWdgtEWqweYeRKu7gBwc2VU3
 dKxA==
X-Gm-Message-State: APjAAAWNYRm7F9ybf3DkqF4v/vMQZh1bfvUYiPv6jsX7XHrdmKrDgkBn
 3flAPIwWFR0NqDZ4tsDdNM3F/g==
X-Google-Smtp-Source: APXvYqwKhnBO6jkYhV8b+fvJ4mHvR5TGh4kJwMZod8JBrtKDYWlWER8YO0sEY7EBi6w1p8Nisus6sw==
X-Received: by 2002:adf:d847:: with SMTP id k7mr2611647wrl.144.1559898751374; 
 Fri, 07 Jun 2019 02:12:31 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id f2sm1244110wru.31.2019.06.07.02.12.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:12:29 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6F82F1FFA5;
 Fri,  7 Jun 2019 10:05:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:17 +0100
Message-Id: <20190607090552.12434-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PULL 18/52] tests/vm: add vm-boot-{ssh,
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

For testing/troubleshooting convinience.

make vm-boot-serial-<guest>
  Boot guest, with the serial console on stdio.

make vm-boot-ssh-<guest>
  Boot guest, login via ssh.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190520124716.30472-8-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 276b870216..e329129bd6 100644
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
+		"  VM-BOOT-SSH $*")
-- 
2.20.1


