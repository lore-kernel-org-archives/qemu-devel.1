Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8077DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4087E206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcUNwTtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4087E206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnILQ-0002n4-8i
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnIJH-0000wq-L3
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:00:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35514
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnIJF-0004zw-J2
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592816408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FlCLYqnyC4KOoHC6MnLT/maL0ukmI8qUjgkm25Wbdkw=;
 b=LcUNwTtbrwkOXNVaTRa1z803kCnmYJraq1uQ3wIA5Hv1F6a458+G1kqU4PnOlYhWVmB0j/
 XvN9FkivyaKBhK+EKC4TmL2y/ZrHalVQYYPzL2vHrNrfS6vtIArzxgvoAjXkDk1wWLaLDW
 sg5ThQQNpD6+7rT/5ITC/YyZTYa2y1I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-Z3K6TjtmOGep8pyBlPD_fg-1; Mon, 22 Jun 2020 05:00:01 -0400
X-MC-Unique: Z3K6TjtmOGep8pyBlPD_fg-1
Received: by mail-wm1-f72.google.com with SMTP id a7so6574536wmf.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 02:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FlCLYqnyC4KOoHC6MnLT/maL0ukmI8qUjgkm25Wbdkw=;
 b=ZUXjq0S8WRPcuT3SS6TY67mltPXRbXGFSpmZaghEWQKCFjLNWPwr02mH49BsTCArPz
 NBMOSZ+kxHJc6vKrQHiOT29YSa9dldS7KFeO027rmdi+ZcUu6qp+mIuQvPuoK6o0Pgaj
 cFhHbRiNwaIKlzKxd9sJ+B7f1L8e5zyc3w/dZJYDJ3+/LO8TCg2inVU6Sc3EA6L8lETS
 ek30yTMbXzunbd1ztTPG9cT77sPwptToZUhrXxrS1DQWUXB6ILXVLeedMWnw5jeWdSR4
 Xfvad85SFEZJ3WXQhI+yjhCxrMaAiVAD3HTqPMZ2BpmQ7D+2f4NSb8PM4g7s/o3guE4P
 jyEg==
X-Gm-Message-State: AOAM531KDPCbmUeX4KoCJ5TPsSF39lPwmWPCagGjjIMHM+7AMxTv/hmi
 WJU38ZnTIidrkxMEGP+Nni2eTBkCNxQRoAh3uS0yTUl4gVM6zNQm1AYT3SpmlZb2YOZuNIpZQUt
 AUUAgI8cSS/AVIls=
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr18548846wru.12.1592816400154; 
 Mon, 22 Jun 2020 02:00:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGTR7W5WX1HUX+v8kDUFeutnhdi8sFWaZnz8XKCfrxA36RF5Tr3Ek58dwn1EZzn9pQ54Hgxw==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr18548821wru.12.1592816399887; 
 Mon, 22 Jun 2020 01:59:59 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id y14sm15357965wma.25.2020.06.22.01.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 01:59:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/8] tests/acceptance: add record/replay test for arm
Date: Mon, 22 Jun 2020 10:59:31 +0200
Message-Id: <20200622085934.16441-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200622085934.16441-1-philmd@redhat.com>
References: <20200622085934.16441-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>

This patch adds a test for record/replay of the kernel
image boot for two different arm platforms.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Tested-by: Philippe Mathieu-Daude <philmd@redhat.com>
Message-Id: <159073590785.20809.17654573764167037499.stgit@pasha-ThinkPad-X280>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/replay_kernel.py | 48 +++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
index 60559a13ad..748c780575 100644
--- a/tests/acceptance/replay_kernel.py
+++ b/tests/acceptance/replay_kernel.py
@@ -108,3 +108,51 @@ def test_aarch64_virt(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern,
                     args=('-cpu', 'cortex-a53'))
+
+    def test_arm_virt(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:virt
+        """
+        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
+                      '/linux/releases/29/Everything/armhfp/os/images/pxeboot'
+                      '/vmlinuz')
+        kernel_hash = 'e9826d741b4fb04cadba8d4824d1ed3b7fb8b4d4'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyAMA0')
+        console_pattern = 'VFS: Cannot open root device'
+
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=1)
+
+    def test_arm_cubieboard_initrd(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:cubieboard
+        """
+        deb_url = ('https://apt.armbian.com/pool/main/l/'
+                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
+        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-4.20.7-sunxi')
+        dtb_path = '/usr/lib/linux-image-dev-sunxi/sun4i-a10-cubieboard.dtb'
+        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
+                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
+                      'arm/rootfs-armv5.cpio.gz')
+        initrd_hash = '2b50f1873e113523967806f4da2afe385462ff9b'
+        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        archive.gzip_uncompress(initrd_path_gz, initrd_path)
+
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200 '
+                               'usbcore.nousb '
+                               'panic=-1 noreboot')
+        console_pattern = 'Boot successful.'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=1,
+                    args=('-dtb', dtb_path,
+                          '-initrd', initrd_path,
+                          '-no-reboot'))
-- 
2.21.3


