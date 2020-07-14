Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD98C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6688F2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDQYy7re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6688F2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvTP5-00024m-Lb
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 18:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJn-0000yr-4H
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21519
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJd-0004gn-Hn
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594765340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VtAHwUMbT3DZQFjgf7HP2io0KT4bOSabkBp+DZ3uFOE=;
 b=HDQYy7reADmK0ef34/J+g41oSU1TB+PBxD36/TRzPHu2gnQKfVIyrRU9VwbXyXkHdveyUc
 0MQhFcsUGaYAIFDZovjaRRlTc0GYkB9jO5juXd7EtXP0z61hHsj5Bg35lgJm9C+w1H50mS
 W6nQlIcuwptCQA2bbNlJdFbM2wSlQuw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-MkhiJw3RPMmAZEFeurOK5g-1; Tue, 14 Jul 2020 18:22:19 -0400
X-MC-Unique: MkhiJw3RPMmAZEFeurOK5g-1
Received: by mail-wr1-f70.google.com with SMTP id s16so25255wrv.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 15:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VtAHwUMbT3DZQFjgf7HP2io0KT4bOSabkBp+DZ3uFOE=;
 b=UqdPpGzBtpVhtAmN+mrka1vriXWSesUAqDaENT/sAaSDKssSWdbzNyeMD0KQqGM+hZ
 WLRaFxkQnv6Ql2BidTIQmnZXWRLQZHJ+YBrO5v4oCVt8xKO7lFqanudN3yIm+sYZ7oF9
 ovVLbzGq5pjZa6WLhfdMd0UIXeqYcmvlbGzQpy3QBwQdqVU+/0/WtQ3AWgJ32BeEp1jS
 Q6kAJl9jo3/GxHVCn46fQAEqjUAffZqd0kSlHm9g5xhovU+++wsYyAMJnJdLJA0YUWPl
 SG41qQdT6WTdIW9ZFL3XNcY2k0hh+/o8mM93mZqz8s0Ryb4qgCxsq22LwL4mbGETx1NP
 4qOA==
X-Gm-Message-State: AOAM531EDz6gh+TW6g5vO+QteOQGLMpmXMsr7Y9OnSqzBf1hkAoW9UOy
 2fPJ1eL3pRdMWL5E/xO5TnEgWWbm9gTzB71lVlUGELpAuPQ8DIhkD5Cs7iN2aH8dFu4PiIQzt/c
 Pi5WjnPKcqhCWD18=
X-Received: by 2002:adf:db42:: with SMTP id f2mr8018684wrj.298.1594765337201; 
 Tue, 14 Jul 2020 15:22:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYlZoqndMmXVvUNG7YjLVhDx9CeTYBym6U33tY9gsnqfWWKCkgtUnfCoQdUpcE8uh4ePWUAA==
X-Received: by 2002:adf:db42:: with SMTP id f2mr8018663wrj.298.1594765337015; 
 Tue, 14 Jul 2020 15:22:17 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id l18sm176389wrm.52.2020.07.14.15.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 15:22:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/19] tests/acceptance: wait() instead of shutdown() where
 appropriate
Date: Wed, 15 Jul 2020 00:21:22 +0200
Message-Id: <20200714222132.10815-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714222132.10815-1-philmd@redhat.com>
References: <20200714222132.10815-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

When issuing 'reboot' to a VM with the no-reboot option, that VM will
exit. When then issuing a shutdown command, the cleanup may race.

Add calls to vm.wait() which will gracefully mark the VM as having
exited. Subsequent vm.shutdown() calls in generic tearDown code will not
race when called after completion of the call.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20200710050649.32434-9-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/boot_linux_console.py   | 10 ++++++++++
 tests/acceptance/linux_ssh_mips_malta.py |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 3d02519660..5867ef760c 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -191,6 +191,8 @@ def test_mips_malta_cpio(self):
                                                 'Debian')
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system')
+        # Wait for VM to shut down gracefully
+        self.vm.wait()
 
     @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     def test_mips64el_malta_5KEc_cpio(self):
@@ -231,6 +233,8 @@ def test_mips64el_malta_5KEc_cpio(self):
                                                 '3.19.3.mtoman.20150408')
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system')
+        # Wait for VM to shut down gracefully
+        self.vm.wait()
 
     def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):
         kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
@@ -506,6 +510,7 @@ def test_arm_cubieboard_initrd(self):
                                                 'system-control@1c00000')
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system')
+        # NB: Do not issue vm.wait() here, cubieboard's reboot does not exit!
 
     def test_arm_cubieboard_sata(self):
         """
@@ -550,6 +555,7 @@ def test_arm_cubieboard_sata(self):
                                                 'sda')
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system')
+        # NB: Do not issue vm.wait() here, cubieboard's reboot does not exit!
 
     def test_arm_orangepi(self):
         """
@@ -615,6 +621,8 @@ def test_arm_orangepi_initrd(self):
                                                 'system-control@1c00000')
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system')
+        # Wait for VM to shut down gracefully
+        self.vm.wait()
 
     def test_arm_orangepi_sd(self):
         """
@@ -662,6 +670,8 @@ def test_arm_orangepi_sd(self):
             '3 packets transmitted, 3 packets received, 0% packet loss')
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system')
+        # Wait for VM to shut down gracefully
+        self.vm.wait()
 
     @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
     @skipUnless(P7ZIP_AVAILABLE, '7z not installed')
diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/linux_ssh_mips_malta.py
index 90d7f2f167..25c5c5f741 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -212,6 +212,8 @@ def check_mips_malta(self, uname_m, endianess):
 
         self.run_common_commands(wordsize)
         self.shutdown_via_ssh()
+        # Wait for VM to shut down gracefully
+        self.vm.wait()
 
     def test_mips_malta32eb_kernel3_2_0(self):
         """
-- 
2.21.3


