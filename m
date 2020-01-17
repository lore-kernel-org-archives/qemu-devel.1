Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011E9C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF1C2087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kEf6dh5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF1C2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSiA-0004Fq-Kw
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:34:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbs-0006G0-Sg
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbr-00072i-8C
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:28 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:45597)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isSbr-00071z-1K
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:27 -0500
Received: by mail-wr1-x429.google.com with SMTP id j42so22872524wrj.12
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 06:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=L+ivRGocKK/aPX+g9YMv+aaEejgdeJRwqXQexULhGrY=;
 b=kEf6dh5CaeI0jJq66xdnkUkCYQmf+3m9i+cv8kmS+FvWe7tyUwSx8hb1kSFg/nwol6
 RboxOPm3NF0SC5jlsAbw7b+ZjslgV68454zPNKgQ++EUMM28j/If2MsQNtXLEf4W47ru
 Lq6dZbOWkgZoawYXDROZv5SF9SRDqxLM41q8vTg/aCejiIk1EqQoWXKQ/qEY4XufuWgg
 Bec0bwHuvc7FiOYXXvISfs3eNbbLXbLixmX3CtwM5yqnbfv60chcPo0mp+54ZbmSa4c2
 tBbW4FxB9nNXB0SSiqitICzxPSJoZ0ynf0uQxtVWewREeIcXF0W+iMcaCVKqsV+FbQzK
 z4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L+ivRGocKK/aPX+g9YMv+aaEejgdeJRwqXQexULhGrY=;
 b=RvZmuhHVgBPRPLWo3pKkfoBrewxIWFepUTdNdofS/F1vWxZ7y1GGwNynHAjE3Tjdvo
 Q/XK9U5Ch62FAn/2ZmKAChAUaBz1bNBAY8ugrjt6EheF59MNTEdjYWb7NZ2gihWHk37j
 dhbDVJ7bt5TI2WsVxL1sOqxdS8NskncLTkRL1qjgpSWWFdzd28kJnEPRg4cuf9+91AiC
 sj+VUSMpmba06ICfV7+J3XxorzoOHxGds1CsC5jkFQAt4+9JxOfWW4rVjLgN5rasUYud
 Ujy4AplzRBmqqoS7iaw5af5NL64CE4Sc0afeJyY4x1/tmq8LW3hc7P5N1b9iH2yoRXak
 aXUw==
X-Gm-Message-State: APjAAAVk7xpuMpVqP3+LWO8M7EO8Qu+CV0/iAWoBUJqWgeByodcuXA3Z
 AJHaMH69JqH/aY+0ForM7G9GTN9aYEN1/w==
X-Google-Smtp-Source: APXvYqxtBfIertfSXnI66PjYjyqiH/ruEey4lg43F0cciY/Vcf4pHggDfjJlJCwhOWwWTtP1pE+VHw==
X-Received: by 2002:adf:b60f:: with SMTP id f15mr3435888wre.372.1579271305530; 
 Fri, 17 Jan 2020 06:28:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e18sm33811146wrw.70.2020.01.17.06.28.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 06:28:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/15] tests/boot_linux_console: Add initrd test for the
 CubieBoard
Date: Fri, 17 Jan 2020 14:28:06 +0000
Message-Id: <20200117142816.15110-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117142816.15110-1-peter.maydell@linaro.org>
References: <20200117142816.15110-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

This test boots a Linux kernel on a CubieBoard and verify
the serial output is working.

The kernel image and DeviceTree blob are built by the Armbian
project (based on Debian):
https://docs.armbian.com/Developer-Guide_Build-Preparation/

The cpio image used comes from the linux-build-test project:
https://github.com/groeck/linux-build-test

If ARM is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:arm" tags.

Alternatively, this test can be run using:

  $ avocado --show=console run -t machine:cubieboard tests/acceptance/boot_linux_console.py
  console: Uncompressing Linux... done, booting the kernel.
  console: Booting Linux on physical CPU 0x0
  console: Linux version 4.20.7-sunxi (root@armbian.com) (gcc version 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET 2019
  console: CPU: ARMv7 Processor [410fc080] revision 0 (ARMv7), cr=50c5387d
  console: CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
  console: OF: fdt: Machine model: Cubietech Cubieboard
  [...]
  console: Boot successful.
  console: cat /proc/cpuinfo
  console: / # cat /proc/cpuinfo
  console: processor      : 0
  console: model name     : ARMv7 Processor rev 0 (v7l)
  console: BogoMIPS       : 832.51
  [...]
  console: Hardware       : Allwinner sun4i/sun5i Families
  console: Revision       : 0000
  console: Serial         : 0000000000000000
  console: cat /proc/iomem
  console: / # cat /proc/iomem
  console: 01c00000-01c0002f : system-control@1c00000
  console: 01c02000-01c02fff : dma-controller@1c02000
  console: 01c05000-01c05fff : spi@1c05000
  console: 01c0b080-01c0b093 : mdio@1c0b080
  console: 01c0c000-01c0cfff : lcd-controller@1c0c000
  console: 01c0d000-01c0dfff : lcd-controller@1c0d000
  console: 01c0f000-01c0ffff : mmc@1c0f000
  [...]
  PASS (54.35 s)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-id: 20191230110953.25496-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/acceptance/boot_linux_console.py | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 9c6aa2040a2..4643f60e376 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -400,6 +400,47 @@ class BootLinuxConsole(Test):
         self.wait_for_console_pattern('Boot successful.')
         # TODO user command, for now the uart is stuck
 
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
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200 '
+                               'usbcore.nousb '
+                               'panic=-1 noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('Boot successful.')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'Allwinner sun4i/sun5i')
+        exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
+                                                'system-control@1c00000')
+        exec_command_and_wait_for_pattern(self, 'reboot',
+                                                'reboot: Restarting system')
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.20.1


