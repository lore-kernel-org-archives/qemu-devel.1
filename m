Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08283C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B75206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="abdffgSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B75206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCR45-0000Cj-Ry
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxi-0000Xk-Op
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxh-0005EB-5l
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:34 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:46741)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxg-0005Dn-Uu
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:33 -0400
Received: by mail-wr1-x42d.google.com with SMTP id n15so8333795wrw.13
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=7pX+/oE90gqZls/uTEcu3qseDz3okwJOEWbkvMRtMQQ=;
 b=abdffgShBfX/xAbQJA4i25l+fKjQ2CuCrMR7qw/S4hIg43z1RwG7H63ed6OtEio4fI
 6MaCkx2BEby/qxwCrnonhvbROAaGbH/QoBJXL9hCAqSeeyZ0Cksdf5eFtlg3m3UIEsZ4
 /BHsHlJaXv7Cr7T5uzvZIEahL7BqqFskZTW25eew3z49gptop/Tlc3m9C5dfQiX0k3FG
 XLgdG1Zf5ZF8Qb2U7Lucpui+sb6rzX9f8ArddO9uVNDJOIzU1xVtSqyuDbhUmMrG3dZn
 H7UPXeF0XHop5hsLz3YsrwDMKp6kHekkVQPySmdBY22q0ButMq5VOO+OJyxkNelzyVoM
 NiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7pX+/oE90gqZls/uTEcu3qseDz3okwJOEWbkvMRtMQQ=;
 b=dkch4YFyntgMIj7KodBjAinV5W7QcnnLfntTJM4t2FUla34xDuAUhgqS4o7MDzByI1
 iacrBfRBO54AuNwEPtM+o0yXdnrG6qsiuxfTnv1Yun5nZaXYKZxzyjYg9QQtRO7VWH38
 qdFwqolBoEyD5WfUyiHjP7ivgvphhUuiJBmGx95qKwZpzFkzau0yu8rmvLOLdq50qKbo
 yRlhK/gTUSpnEDDBiUoj2+4ATfUXmsrYu5iXwPBqD0oGZ+ZxH0m1O+Z5igO+4xQzpvn2
 vZG3VCtOq4UopvfZXpk1j8QXL39RQJnh69m6ih61h2F58CAau0SvcWYVz+TqhQmzUwVo
 uYOw==
X-Gm-Message-State: ANhLgQ2lfglw9F/EdyQij9axjmxkfOQWBx7HULn83OD6BLzaS8WZgPNo
 I8kwYY3TCATbxiOZd290A3TJvzmlt6RcTA==
X-Google-Smtp-Source: ADFU+vvQUtoRhq3OsF7jk5FaTUJZWqWq/VgjzrX/RT2zTl0ry35W/XZT/G0SvldNK8Qg6M5CJV829w==
X-Received: by 2002:a5d:6cc4:: with SMTP id c4mr6070828wrc.73.1584031531522;
 Thu, 12 Mar 2020 09:45:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/36] tests/boot_linux_console: Add a quick test for the
 OrangePi PC board
Date: Thu, 12 Mar 2020 16:44:47 +0000
Message-Id: <20200312164459.25924-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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

This test boots a Linux kernel on a OrangePi PC board and verify
the serial output is working.

The kernel image and DeviceTree blob are built by the Armbian
project (based on Debian):
https://www.armbian.com/orange-pi-pc/

If ARM is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:arm" tags.

Alternatively, this test can be run using:

  $ make check-venv
  $ ./tests/venv/bin/avocado --show=console,app run -t machine:orangepi-pc tests/acceptance/boot_linux_console.py
  JOB ID     : 2e4d15eceb13c33672af406f08171e6e9de1414a
  JOB LOG    : ~/job-results/job-2019-12-17T05.46-2e4d15e/job.log
  (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi:
  console: Uncompressing Linux... done, booting the kernel.
  console: Booting Linux on physical CPU 0x0
  console: Linux version 4.20.7-sunxi (root@armbian.com) (gcc version 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET 2019
  console: CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=50c5387d
  console: CPU: div instructions available: patching division code
  console: CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
  console: OF: fdt: Machine model: Xunlong Orange Pi PC
  console: Memory policy: Data cache writealloc
  console: OF: reserved mem: failed to allocate memory for node 'cma@4a000000'
  console: cma: Failed to reserve 128 MiB
  console: psci: probing for conduit method from DT.
  console: psci: PSCIv0.2 detected in firmware.
  console: psci: Using standard PSCI v0.2 function IDs
  console: psci: Trusted OS migration not required
  console: random: get_random_bytes called from start_kernel+0x8d/0x3c2 with crng_init=0
  console: percpu: Embedded 18 pages/cpu @(ptrval) s41228 r8192 d24308 u73728
  console: Built 1 zonelists, mobility grouping on.  Total pages: 32480
  console: Kernel command line: printk.time=0 console=ttyS0,115200
  PASS (8.59 s)
  JOB TIME   : 8.81 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200311221854.30370-14-nieklinnenbank@gmail.com
[NL: rename in commit message Raspbian to Armbian, remove vm.set_machine()]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/acceptance/boot_linux_console.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 34d37eba3b0..6f5af582f3b 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -507,6 +507,31 @@ class BootLinuxConsole(Test):
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system')
 
+    def test_arm_orangepi(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:orangepi-pc
+        """
+        deb_url = ('https://apt.armbian.com/pool/main/l/'
+                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
+        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-4.20.7-sunxi')
+        dtb_path = '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb'
+        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200n8 '
+                               'earlycon=uart,mmio32,0x1c28000')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.wait_for_console_pattern(console_pattern)
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.20.1


