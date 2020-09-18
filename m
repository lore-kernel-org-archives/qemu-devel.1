Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD42FC43467
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B52207D3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCcwRy83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B52207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJMnu-0007Ad-Vr
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJLuX-00017L-2P
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 15:19:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJLuU-0003UY-MG
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 15:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600456745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FBIHHB8r1nOsb0mZw6G+oY7DH6xqjhzWoXftpaQtk+I=;
 b=ZCcwRy83FnJUfJW0dDjMeSdIKQ/rqA+lzj+vTswFXQYWdYpJ37SVlDdq2gBcAtWlwb1ZNS
 EHCLJEsJ1FBpVyo07+UdeeWIrZFeVVvdG0OUs5greCf2yo4+ROkTImlWUsaLj9tj5SsqpY
 0wf/+1OZQ3KtWWdRjO+Tso508gnd0lA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-L-tlpUcDN7iaVq_t0sNSYw-1; Fri, 18 Sep 2020 15:19:01 -0400
X-MC-Unique: L-tlpUcDN7iaVq_t0sNSYw-1
Received: by mail-wr1-f71.google.com with SMTP id f18so2483032wrv.19
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 12:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FBIHHB8r1nOsb0mZw6G+oY7DH6xqjhzWoXftpaQtk+I=;
 b=bBlaELcKiN26/orPtV5wx428P8/zIkhNk7C9mbNPB5YP5KLQMl+qrwbZYYSM4NEA4d
 f1L/f15qxnxtBrD+4ie2EGTuJfFQgMRiqfD9Kt0O+GfpnTanpqf0UM/KPkGUWzaFvpCW
 ZViFhcS3wttwUV09csnRHvPChljGByHCRMPicpfASBiEycZcPaWFH3ie/WFfwjPjBq5n
 G+OkdvNbry7aoTAsj2ZZVNQsC9v8KuHQ9AaZA8bGxYm5mdhs5A50evrwAd8tZy6JCEO6
 aqB+IgvFGygXzKQr+G2qK+vRVGNRul5JPoGWMHqU16Ym5KJUFK22v9iq2gtAN9lYoGUp
 3Vzw==
X-Gm-Message-State: AOAM530X1SObTjcfebO1fyfIpCGwfxWR9r9FGyiacmXsvvWnYmwPtxDv
 FRPUFNiakwesq+Bh3XRNcG976Cd15SmLIFtshb4BzLPhL3ynfoyfmNlGdYO/oJxayVAhlTqCipE
 KcITjexYZDNw5muU=
X-Received: by 2002:adf:ef03:: with SMTP id e3mr33818437wro.146.1600456739960; 
 Fri, 18 Sep 2020 12:18:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCN+ktEBDk9Do3jWEL79vLisgsT1IgnEGh2IhndLS9XaMBUY3gsWd3QZmHDXcCNK/c5huGxw==
X-Received: by 2002:adf:ef03:: with SMTP id e3mr33818421wro.146.1600456739703; 
 Fri, 18 Sep 2020 12:18:59 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id x10sm6737663wmi.37.2020.09.18.12.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 12:18:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] tests/acceptance: Disable tests dependent of unreliable
 apt.armbian.com
Date: Fri, 18 Sep 2020 21:18:51 +0200
Message-Id: <20200918191852.189151-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200918191852.189151-1-philmd@redhat.com>
References: <20200918191852.189151-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <willianr@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Armbian servers are not very reliable and confused the GitLab CI
users a few times this month (path updated, archives moved, and
now the SSL: CERTIFICATE_VERIFY_FAILED "certificate has expired"
error). Time to disable these tests.
Users can still use the artifacts from the cache (or manually add
them to the cache).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Willian Rampazzo <willianr@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20200917163954.50514-1-philmd@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 10 ++++++++++
 tests/acceptance/replay_kernel.py      |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 4a366ce93e4..68534693109 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -485,6 +485,8 @@ def test_arm_exynos4210_initrd(self):
         self.wait_for_console_pattern('Boot successful.')
         # TODO user command, for now the uart is stuck
 
+    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
+                'Test artifacts fetched from unreliable apt.armbian.com')
     def test_arm_cubieboard_initrd(self):
         """
         :avocado: tags=arch:arm
@@ -525,6 +527,8 @@ def test_arm_cubieboard_initrd(self):
                                                 'system-control@1c00000')
         # cubieboard's reboot is not functioning; omit reboot test.
 
+    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
+                'Test artifacts fetched from unreliable apt.armbian.com')
     def test_arm_cubieboard_sata(self):
         """
         :avocado: tags=arch:arm
@@ -651,6 +655,8 @@ def test_arm_quanta_gsj_initrd(self):
         self.wait_for_console_pattern(
                 'Give root password for system maintenance')
 
+    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
+                'Test artifacts fetched from unreliable apt.armbian.com')
     def test_arm_orangepi(self):
         """
         :avocado: tags=arch:arm
@@ -676,6 +682,8 @@ def test_arm_orangepi(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
+    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
+                'Test artifacts fetched from unreliable apt.armbian.com')
     def test_arm_orangepi_initrd(self):
         """
         :avocado: tags=arch:arm
@@ -718,6 +726,8 @@ def test_arm_orangepi_initrd(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
+    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
+                'Test artifacts fetched from unreliable apt.armbian.com')
     def test_arm_orangepi_sd(self):
         """
         :avocado: tags=arch:arm
diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
index b79fc8daf8e..952f429cace 100644
--- a/tests/acceptance/replay_kernel.py
+++ b/tests/acceptance/replay_kernel.py
@@ -13,6 +13,7 @@
 import time
 
 from avocado import skipIf
+from avocado import skipUnless
 from avocado_qemu import wait_for_console_pattern
 from avocado.utils import archive
 from avocado.utils import process
@@ -127,6 +128,8 @@ def test_arm_virt(self):
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=1)
 
     @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
+                'Test artifacts fetched from unreliable apt.armbian.com')
     def test_arm_cubieboard_initrd(self):
         """
         :avocado: tags=arch:arm
-- 
2.26.2


