Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D86EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 23:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B4120708
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 23:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sq36O4aE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B4120708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbYao-0007OW-BO
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 19:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jbYYe-0003oI-Dg
 for qemu-devel@nongnu.org; Wed, 20 May 2020 19:55:32 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:35357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jbYYd-0000Ga-In
 for qemu-devel@nongnu.org; Wed, 20 May 2020 19:55:32 -0400
Received: by mail-pj1-x1043.google.com with SMTP id 5so2133363pjd.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 16:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RlnOMP3FPeHnRFzh03+S+yS8wz5P9Ird8/SXiAXBwJE=;
 b=sq36O4aEsfEWbj5Q8eEGMHerb/S9AgxfUcGbzFC849EfRjnPjMDM+QdYjZvVDsEz/5
 yv0KUo0RRoeWbEZX48XuJBvxKmODrtMyvyZY1sLxaP74Ds8AhHUn3uQahppIV7JZZIN/
 uIACtH60Ff/AWwHg1t6vWnJhQJahoOo/g4YgwXlB6m7PNoNAOTeHVnymEDRfH9ToAuBT
 TrKEraHPjz5zEchorxHxam1sARX9e7KmrOyvBiPmo8ns4v3aQHSRtHyZovu/WwQ4vubv
 OhQYGJCvep9cTWaKhVXm0XmkC3R5mjOEzWIBq4yogxZpAOgAp+UCoTKGrr1gJ2Uwv0k8
 2Z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RlnOMP3FPeHnRFzh03+S+yS8wz5P9Ird8/SXiAXBwJE=;
 b=HmOMJKeM9VFKSP95X/G23C+001Z+UdnBtHPWMAs1Amg+Lq19VEoYP+gOOHOhO1W6sh
 17Qgh/Vp+8Xs5LDrGOmFc2NscydUi9xrTvKg/Y/H5onIq8k+gGPuIYC6jlmC9IyJ9a5C
 /TdIjfbKM8YuaqsfP/kBO8u2V4K7eOM4zApL5/Yf0tJbOxpHVoTREt68H0jN+Y+QyC22
 Ehu2kIgkJLjQSdi9UPt7Np45YVZ7F/kqZ71Nnn8o7pNFH3Z+86lo++uewnNvHpW4k9bM
 1UKOBV8oxjnv4ZXnCZ5va9ru5BAE+43wRyBAwVKRfUYd4ZxIdX26VyIIYTq4ZubANZ4x
 0EQA==
X-Gm-Message-State: AOAM533HCEHL9rCGlGlroB6Put2M/6QhiqDBG//XPVENKXAfiiCTT+dZ
 Ur3m7/0xrtxb/r6fDykHbSg=
X-Google-Smtp-Source: ABdhPJzFXg5dAKbp6KTaRBTGYR2faL/ZoU0bXEtFy5MhU9op1PUPw83U8YM1OgWmLPulbdlSC+kSFw==
X-Received: by 2002:a17:90a:589:: with SMTP id
 i9mr7883247pji.156.1590018930378; 
 Wed, 20 May 2020 16:55:30 -0700 (PDT)
Received: from localhost.localdomain ([75.167.104.59])
 by smtp.gmail.com with ESMTPSA id d20sm2761882pjs.12.2020.05.20.16.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 16:55:30 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v6 7/7] raspi2 acceptance test: add test for dwc-hsotg (dwc2)
 USB host
Date: Wed, 20 May 2020 16:53:49 -0700
Message-Id: <20200520235349.21215-8-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520235349.21215-1-pauldzim@gmail.com>
References: <20200520235349.21215-1-pauldzim@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=pauldzim@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reviewed-by: Philippe Mathieu-Daude <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index c6b06a1a13..abb5ca3dd4 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -378,13 +378,18 @@ class BootLinuxConsole(Test):
 
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


