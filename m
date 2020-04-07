Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5520AC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E8CC20678
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuGpDYbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8CC20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLmHY-0006id-BC
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sundeep.lkml@gmail.com>) id 1jLmFY-00039X-1Y
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sundeep.lkml@gmail.com>) id 1jLmFW-0002Lr-Je
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:18:35 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43247)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sundeep.lkml@gmail.com>)
 id 1jLmFW-0002LP-DR; Tue, 07 Apr 2020 07:18:34 -0400
Received: by mail-pg1-x542.google.com with SMTP id s4so1562096pgk.10;
 Tue, 07 Apr 2020 04:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=oC4LI+rsC3AfaHKWa06ELH+UcID+dQ6LdmleZ0eZwSQ=;
 b=KuGpDYbbtfb5Cf99k+/n+7CnaaIPFoJX8UuZRSxE2wC94n+k0+N4XsziDe20YEf4Vk
 F4zCxMHbDQL66nmPGhMWSVGtKA3Qoj1fb3CRGqSUAFzJkgi2JeyheWzvvriBEayysiPf
 E3Rbf4H7ty3OQoqbZUCIw9B1+sftvSvN4K2iVQvcK4ObsZYjwY4RYB2abGA0miL5qqhk
 sqvxfSqyOWXlpkTyvzzxA7jhMkVq6G6QoqzFv++kJhXCZhsOdYkqnZmAHQX0TyxjOsJs
 3PKRzCKTeL90elEc8L6fl/zx+9l+85eRRMt2Mz0/3/aO8JVSweYbQx64VydL632COZVA
 yb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=oC4LI+rsC3AfaHKWa06ELH+UcID+dQ6LdmleZ0eZwSQ=;
 b=PLKlFSS5n2HOVFQbrG12kg3BLNtAJ6h9ZP89Y3k4xPcjNTx+g+Z7DQANCOoINrz/mw
 HqWarLmRrVQ05JehCkhxAmjWWMetMer8sw6EM+YvsehJB7WYSJCf47688rnInhkP31pd
 XEFDQlzNJ/Hd0VCmlsc7OuDp88EphMSj83ZFpuoRZCRnkkB0s+XcSIbj4iObc1enf2Vy
 1utAuyU7mbkXTluQha0hQVPmssqudva18lvcx7PcXK3SW1PYgTeMx+YbP3L71HxGXtYR
 o8RWYxRnj6VTyNWeJEDGoens45RJPdBL5mxnp6WBAxDGtIDWqt1nr/ioPKqhIR3SYHGp
 jpug==
X-Gm-Message-State: AGi0PuZYaranYBBO6NXAEgnj6i53/+60shsb513EEbo6m7/RBTF3EMDF
 rO8jKR1bBxxCRK7gnEDg03M=
X-Google-Smtp-Source: APiQypKLBqaoL8pcfuQgI1QXdw3au9xiQbDhV3o1qjg0kZ6dZsUMPe3MUqhqKUL24a1YbNbCVRAnXw==
X-Received: by 2002:a63:a361:: with SMTP id v33mr1552496pgn.324.1586258313490; 
 Tue, 07 Apr 2020 04:18:33 -0700 (PDT)
Received: from hyd1358.marvell.com ([115.113.156.2])
 by smtp.googlemail.com with ESMTPSA id
 s137sm14357855pfs.45.2020.04.07.04.18.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Apr 2020 04:18:33 -0700 (PDT)
From: sundeep.lkml@gmail.com
To: jasowang@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [Qemu devel PATCH v3 3/3] tests/boot_linux_console: Add ethernet test
 to SmartFusion2
Date: Tue,  7 Apr 2020 16:45:34 +0530
Message-Id: <1586258134-6932-4-git-send-email-sundeep.lkml@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586258134-6932-1-git-send-email-sundeep.lkml@gmail.com>
References: <1586258134-6932-1-git-send-email-sundeep.lkml@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Subbaraya Sundeep <sundeep.lkml@gmail.com>

In addition to simple serial test this patch uses ping
to test the ethernet block modelled in SmartFusion2 SoC.

Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
---
 tests/acceptance/boot_linux_console.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index f825cd9..c6b06a1 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -336,13 +336,13 @@ class BootLinuxConsole(Test):
         """
         uboot_url = ('https://raw.githubusercontent.com/'
                      'Subbaraya-Sundeep/qemu-test-binaries/'
-                     'fa030bd77a014a0b8e360d3b7011df89283a2f0b/u-boot')
-        uboot_hash = 'abba5d9c24cdd2d49cdc2a8aa92976cf20737eff'
+                     'fe371d32e50ca682391e1e70ab98c2942aeffb01/u-boot')
+        uboot_hash = 'cbb8cbab970f594bf6523b9855be209c08374ae2'
         uboot_path = self.fetch_asset(uboot_url, asset_hash=uboot_hash)
         spi_url = ('https://raw.githubusercontent.com/'
                    'Subbaraya-Sundeep/qemu-test-binaries/'
-                   'fa030bd77a014a0b8e360d3b7011df89283a2f0b/spi.bin')
-        spi_hash = '85f698329d38de63aea6e884a86fbde70890a78a'
+                   'fe371d32e50ca682391e1e70ab98c2942aeffb01/spi.bin')
+        spi_hash = '65523a1835949b6f4553be96dec1b6a38fb05501'
         spi_path = self.fetch_asset(spi_url, asset_hash=spi_hash)
 
         self.vm.set_console()
@@ -352,7 +352,12 @@ class BootLinuxConsole(Test):
                          '-drive', 'file=' + spi_path + ',if=mtd,format=raw',
                          '-no-reboot')
         self.vm.launch()
-        self.wait_for_console_pattern('init started: BusyBox')
+        self.wait_for_console_pattern('Enter \'help\' for a list')
+
+        exec_command_and_wait_for_pattern(self, 'ifconfig eth0 10.0.2.15',
+                                                 'eth0: link becomes ready')
+        exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2',
+            '3 packets transmitted, 3 packets received, 0% packet loss')
 
     def do_test_arm_raspi2(self, uart_id):
         """
-- 
2.7.4


