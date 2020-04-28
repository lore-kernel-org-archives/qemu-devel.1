Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4473EC83003
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 02:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11AB620728
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 02:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HULe4074"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AB620728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTFxE-0001rW-5N
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 22:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jTFvk-00071S-Vg
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jTFvg-00033c-Mb
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:25:04 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jTFvg-00033V-AU
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:25:00 -0400
Received: by mail-pl1-x641.google.com with SMTP id w3so7747517plz.5
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 19:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FS2O63iko+vF5p7kOKGCLXMwPEY/QkzawKDVLWYlL7A=;
 b=HULe4074epY8Uhkuwdw73ftDDxlSCviNtRFcPx5IWbZ5WPkjPjxWgdEKOdm3XPD70X
 w//9Kdb9y+/EWHcjUOeoDn50XbfG9OUyWDiNDMcD5fOXiCXfyROcHSoowpE391WZlQ5i
 USjhFzxT40BOevmG2NR6LTKkBo85caFdG4cFhSyPCAbjlSEbvEJ5bK54DzykPvIPXmLc
 Qt0/dx6gdpuDMThTVEY351zpgQtBHeis6pUftt6jCBg5uOVlZNX0LYdEQd/+Zjsw5pw6
 wdGndYg1DFrck9iVGNV0e6K3cJp6pWgizvDKNcNmmkvb7IZtnX/zxiUtq73OXeBppa1P
 sfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FS2O63iko+vF5p7kOKGCLXMwPEY/QkzawKDVLWYlL7A=;
 b=ok3iyE6zgkTcIS/ktRRVqm0vHsx2Q8PIYC9zSckp6PoEXOT7+7NMuwlQ+qCjK/tJD9
 ZUTBSMPsm3O55s3WpcjTimajyfoYYdYkz0hwXy7tbi1fKbF9JXa/S0CykO+EI9bXBsID
 VV+lOkL7nzDFKmUrjwJFcbNoTSm7vOn58Fve/gw2vyxFcMHgBxS3XJqjX4vUMQYjD1sg
 YrvwkfPS5Ax3EGpDdfZhW1JZXUqzSWiZxFHfkmfxTF40hMkt90ULGAf/N5KN93S+Np+u
 Wu2YGC01tgsXBSFQ1Zf77G1yEuOaFh+RGOVmC6iFNxT8KqMN/Qw1HwSAU8Tl6AcGg4J/
 /3KA==
X-Gm-Message-State: AGi0PuY0JezHhs+dxWyEEF31GU/EsvF/Zk/FPwfqWSkJb6v42JW5nTfg
 2kjTHoU8YptRbbVBY8ZcTBs=
X-Google-Smtp-Source: APiQypI3l0aSIhZlxdNuIXap0ryo6hLV0LIqG12RfsZYFZWnOQUt83hVgo2mNfn2SuhQv7SrmN73Fg==
X-Received: by 2002:a17:902:a604:: with SMTP id
 u4mr3168518plq.196.1588040698983; 
 Mon, 27 Apr 2020 19:24:58 -0700 (PDT)
Received: from localhost.localdomain ([75.167.104.59])
 by smtp.gmail.com with ESMTPSA id z190sm11695649pgz.73.2020.04.27.19.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 19:24:58 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 7/7] raspi2 acceptance test: add test for dwc-hsotg (dwc2)
 USB host
Date: Mon, 27 Apr 2020 19:22:32 -0700
Message-Id: <20200428022232.18875-8-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428022232.18875-1-pauldzim@gmail.com>
References: <20200428022232.18875-1-pauldzim@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=pauldzim@gmail.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a check for functional dwc-hsotg (dwc2) USB host emulation to
the Raspi 2 acceptance test

Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
---
 tests/acceptance/boot_linux_console.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index f825cd9ef5..efa4803642 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -373,13 +373,18 @@ class BootLinuxConsole(Test):
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               serial_kernel_cmdline[uart_id])
+                               serial_kernel_cmdline[uart_id] +
+                               ' root=/dev/mmcblk0p2 rootwait ' +
+                               'dwc_otg.fiq_fsm_enable=0')
         self.vm.add_args('-kernel', kernel_path,
                          '-dtb', dtb_path,
-                         '-append', kernel_command_line)
+                         '-append', kernel_command_line,
+                         '-device', 'usb-kbd')
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
+        console_pattern = 'Product: QEMU USB Keyboard'
+        self.wait_for_console_pattern(console_pattern)
 
     def test_arm_raspi2_uart0(self):
         """
-- 
2.17.1


