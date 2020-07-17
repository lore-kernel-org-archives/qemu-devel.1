Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACE2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2162071A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DtJCKWoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2162071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwJcz-0003fC-3M
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 02:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3OT8RXwsKCvojumkppgoqgpiqqing.eqosgow-fgxgnpqpipw.qti@flex--hskinnemoen.bounces.google.com>)
 id 1jwJTL-0004Lx-Eo
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 02:03:51 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:48860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3OT8RXwsKCvojumkppgoqgpiqqing.eqosgow-fgxgnpqpipw.qti@flex--hskinnemoen.bounces.google.com>)
 id 1jwJTJ-0005Kx-PR
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 02:03:51 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id i62so10125003ybc.15
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 23:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=uKYickmWfL8+Bpz4+Fgl3zDCXqjlabRC8OPCW303i24=;
 b=DtJCKWoyTbqCyJyptQo1hAbDf/mlqLPt9u/Y6hOFA08VJA7neJJOjZMJVTNUa72fzI
 Ebt541FTz5yT75aJy1CXE3ld/qMiWdwUETvoiZf1DmtSqP2LLG5tISeMAsHd7ROSoYMH
 bQHdv5SK0EBNCUSZnaUsqxcBvfitMUJYCtDhdLw8768lF9b73oRPAQSPCNv0nBKqjJHE
 oSDz+YtLKfSAj5iFExGZnrSgJbShiMYkUd0Pc/QHCAKOC3g+2BUtt/ipN4be1Onw3pRv
 n3J+/eoD42relsvUExE6PUja1g4hkk9zTtlwsno7yXuHZ5pQaD82TgToWDvnNgEIUaBi
 YFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=uKYickmWfL8+Bpz4+Fgl3zDCXqjlabRC8OPCW303i24=;
 b=JXEyCm0S2ArytNXluXrBlpIH4X5NB8MoM/qV1O0vh85BC3IaqsPUmXi/yjKDLO4IDa
 repOacfR7x2/bKiuUVJ4QN+6nug8LeVm3GLjwQgdA4TEeTwY0k/m2vH63h4LrrgGohX/
 D7fEtWxBc9M69xncZtB5wQB9LgqsDVPnyUSlDV5x5QK7BRy2oyELCsmADJw97Nw1Ak3+
 pmBHXITt5RchpDjjiJn6ell6a/V85jSwV+IEP++1dtvIDFjz5RJFpHGMKso14cH5Cuzy
 1uqCqfvNJsgfL0X0h57i4Y+W3/mOsQ/i6wlQTgPZAdvFLvcCwUsuBdbNnQb/xQecWxOE
 RBng==
X-Gm-Message-State: AOAM530i8YncJRQTIDvnr2q7M3MGhWcfEG+sGui68acuqV0YvyEBQtKe
 cBMLdkt7hhINoZn1Ob1JfuY0mqWuRFwDOF0ozWpw8lGanS7HRnFeGB6AO2cIzU9ah55MMvzROb4
 X6xSax4okXYsslYycjEbvOHe8cJnT1BRdt3D+VZsVJf73rzAHuzZmsPC2Ylq+UrdwNNd4yJiANg
 ==
X-Google-Smtp-Source: ABdhPJweYZwScHMJKchaH/lYiylSGlbUqKyGFJ89JRcywnKz90WhM3c3zoSZ3dXarKeSHfCvBYjD20fJboxynntgdQ==
X-Received: by 2002:a25:21d6:: with SMTP id
 h205mr11269020ybh.460.1594965817938; 
 Thu, 16 Jul 2020 23:03:37 -0700 (PDT)
Date: Thu, 16 Jul 2020 23:02:58 -0700
In-Reply-To: <20200717060258.1602319-1-hskinnemoen@google.com>
Message-Id: <20200717060258.1602319-14-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200717060258.1602319-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v6 13/13] tests/acceptance: console boot tests for quanta-gsj
From: Havard Skinnemoen <hskinnemoen@google.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3OT8RXwsKCvojumkppgoqgpiqqing.eqosgow-fgxgnpqpipw.qti@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds two acceptance tests for the quanta-gsj machine.

One test downloads a lightly patched openbmc flash image from github and
verifies that it boots all the way to the login prompt.

The other test downloads a kernel, initrd and dtb built from the same
openbmc source and verifies that the kernel detects all CPUs and boots
to the point where it can't find the root filesystem (because we have no
flash image in this case).

Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 tests/acceptance/boot_linux_console.py | 65 ++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 73cc69c499..1d82fc7ff8 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -569,6 +569,71 @@ class BootLinuxConsole(LinuxKernelTest):
                                                 'sda')
         # cubieboard's reboot is not functioning; omit reboot test.
 
+    def test_arm_quanta_gsj(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:quanta-gsj
+        """
+        # 25 MiB compressed, 32 MiB uncompressed.
+        image_url = (
+                'https://github.com/hskinnemoen/openbmc/releases/download/'
+                '20200711-gsj-qemu-0/obmc-phosphor-image-gsj.static.mtd.gz')
+        image_hash = '14895e634923345cb5c8776037ff7876df96f6b1'
+        image_path_gz = self.fetch_asset(image_url, asset_hash=image_hash)
+        image_name = os.path.splitext(os.path.basename(image_path_gz))[0]
+        image_path = os.path.join(self.workdir, image_name)
+        archive.gzip_uncompress(image_path_gz, image_path)
+
+        self.vm.set_console()
+        drive_args = 'file=' + image_path + ',if=mtd,bus=0,unit=0'
+        self.vm.add_args('-drive', drive_args)
+        self.vm.launch()
+
+        self.wait_for_console_pattern('> BootBlock by Nuvoton')
+        self.wait_for_console_pattern('>Device: Poleg BMC NPCM730')
+        self.wait_for_console_pattern('>Skip DDR init.')
+        self.wait_for_console_pattern('U-Boot ')
+        self.wait_for_console_pattern('Booting Linux on physical CPU 0x0')
+        self.wait_for_console_pattern('CPU1: thread -1, cpu 1, socket 0')
+        self.wait_for_console_pattern('OpenBMC Project Reference Distro')
+        self.wait_for_console_pattern('gsj login:')
+
+    def test_arm_quanta_gsj_initrd(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:quanta-gsj
+        """
+        initrd_url = (
+                'https://github.com/hskinnemoen/openbmc/releases/download/'
+                '20200711-gsj-qemu-0/obmc-phosphor-initramfs-gsj.cpio.xz')
+        initrd_hash = '98fefe5d7e56727b1eb17d5c00311b1b5c945300'
+        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+        kernel_url = (
+                'https://github.com/hskinnemoen/openbmc/releases/download/'
+                '20200711-gsj-qemu-0/uImage-gsj.bin')
+        kernel_hash = 'fa67b2f141d56d39b3c54305c0e8a899c99eb2c7'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        dtb_url = (
+                'https://github.com/hskinnemoen/openbmc/releases/download/'
+                '20200711-gsj-qemu-0/nuvoton-npcm730-gsj.dtb')
+        dtb_hash = '18315f7006d7b688d8312d5c727eecd819aa36a4'
+        dtb_path = self.fetch_asset(dtb_url, asset_hash=dtb_hash)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200n8 '
+                               'earlycon=uart8250,mmio32,0xf0001000')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-dtb', dtb_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Booting Linux on physical CPU 0x0')
+        self.wait_for_console_pattern('CPU1: thread -1, cpu 1, socket 0')
+        self.wait_for_console_pattern(
+                'Give root password for system maintenance')
+
     def test_arm_orangepi(self):
         """
         :avocado: tags=arch:arm
-- 
2.28.0.rc0.105.gf9edc3c819-goog


