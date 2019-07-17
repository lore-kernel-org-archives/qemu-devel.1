Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1260CC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3BF6208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtB0JyaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BF6208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57423 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkLc-0008HX-FG
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57809)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkKf-0004XG-J3
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkKe-00011s-E0
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:50:57 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:53856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnkKe-00011F-7K
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:50:56 -0400
Received: by mail-wm1-x336.google.com with SMTP id x15so22257009wmj.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RSO5DITZZu7ifSyqioTQb5c3MVCyKp0cisQVozONBJA=;
 b=AtB0JyaCda6TltsaRVl4uiyveUz/np9FIz9Kkze+bxXbieJz09WCSrmb3sc7pcNpTc
 0rm8YGivuX6mfhNTRmy6HVy2tGWAGj6YwWpVYY2ECunl2g1q8Xv2V1xzCTpBgbmLXZK8
 HXOqk/e5PCKVp4y1yG7pRI5nsnbpkzoQVyah61X4k3Bcr45LiZwmoJKSanYzhbY/IY7r
 +o2qYQxw71pfftvEt8mulujnsdA1bhjML4kxSn6Jkt+IOPtKL6PwwpPahYfHEMOK+Lew
 wITRiG9iBk2J84yakUIbziwbmXNiy6SNR6TJorlr86pXT1nFp3VzdhqikID7wknh57hV
 smiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RSO5DITZZu7ifSyqioTQb5c3MVCyKp0cisQVozONBJA=;
 b=fmnAC4A6l6leBqbvczi+iF+VCmm4F6hjLL2QLblbDIMZiCU2dKo0hQdjJwb8OuzqvW
 Du+vRYRflyVO1y9yCz1A9rYB6DoU6mC5PQSoSaxTkEkBsEtGEXG/jPlH1Nh9cLtNgDH+
 /syIwV1ruTZ3y/KiqEzhJXBLwld/JPSDPGnB4V3xJX8p7s7k/S6KvjiMAIa6g6INRjad
 DF5/XFgZfQzH0tGElNIP4fKzUFxQLF5lZb2w0XOXqMoAqrur56U55+njvtQOyQGW2D83
 zcYnAEfMeUdg7FgPzDpmLQ2IPIh52zwOnmANO6IxjmtotcOa2305QHtsid+a4I7ka5qU
 E/lQ==
X-Gm-Message-State: APjAAAU75QMHbkW5i2681+ktlpG54+V5rQ9Db8Rjbx0d0jtGEMbXxJ8F
 jGJ4X2hZ6O4pjbeaPC7hBJqYZQ==
X-Google-Smtp-Source: APXvYqzAFh6mpeaqda2W1x6xaMyniAllARZY7HwIWLgD2WEEq3mvClcd+RbDaX+AFkhN/8P/sAi+7A==
X-Received: by 2002:a1c:cb0a:: with SMTP id b10mr36500299wmg.41.1563371455051; 
 Wed, 17 Jul 2019 06:50:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id s2sm20145925wmj.33.2019.07.17.06.50.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 06:50:52 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1F6BA1FF9D;
 Wed, 17 Jul 2019 14:43:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 14:43:26 +0100
Message-Id: <20190717134335.15351-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717134335.15351-1-alex.bennee@linaro.org>
References: <20190717134335.15351-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: [Qemu-devel] [PATCH v2 14/23] buildsys: The NSIS Windows build
 requires qemu-nsis.bmp installed
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The qemu-nsis.bmp file was not listed with the other blobs, thus
not installed in the ${BINDIR} location.

This fixes:

  $ make installer
  [...]
  (cd /tmp/qemu-nsis; \
           for i in qemu-system-*.exe; do \
             arch=${i%.exe}; \
             arch=${arch#qemu-system-}; \
             echo Section \"$arch\" Section_$arch; \
             echo SetOutPath \"\$INSTDIR\"; \
             echo File \"\${BINDIR}\\$i\"; \
             echo SectionEnd; \
           done \
          ) >/tmp/qemu-nsis/system-emulations.nsh
  makensis -V2 -NOCD \
                  -DCONFIG_DOCUMENTATION="y" \
                   \
                  -DBINDIR="/tmp/qemu-nsis" \
                   \
                  -DSRCDIR="/home/phil/source/qemu" \
                  -DOUTFILE="qemu-setup-4.0.90.exe" \
                  -DDISPLAYVERSION="4.0.90" \
                  /home/phil/source/qemu/qemu.nsi
  File: "/tmp/qemu-nsis\*.bmp" -> no files found.
  Usage: File [/nonfatal] [/a] ([/r] [/x filespec [...]] filespec [...] |
     /oname=outfile one_file_only)
  Error in script "/home/phil/source/qemu/qemu.nsi" on line 122 -- aborting creation process
  Makefile:1077: recipe for target 'qemu-setup-4.0.90.exe' failed
  make: *** [qemu-setup-4.0.90.exe] Error 1

Fixes: https://bugs.launchpad.net/bugs/1836453
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190715174817.18981-8-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 5a462629370..f3866ee084c 100644
--- a/Makefile
+++ b/Makefile
@@ -762,6 +762,7 @@ pxe-pcnet.rom pxe-rtl8139.rom pxe-virtio.rom \
 efi-e1000.rom efi-eepro100.rom efi-ne2k_pci.rom \
 efi-pcnet.rom efi-rtl8139.rom efi-virtio.rom \
 efi-e1000e.rom efi-vmxnet3.rom \
+qemu-nsis.bmp \
 bamboo.dtb canyonlands.dtb petalogix-s3adsp1800.dtb petalogix-ml605.dtb \
 multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin \
 s390-ccw.img s390-netboot.img \
-- 
2.20.1


