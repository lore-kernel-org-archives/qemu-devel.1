Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A24C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C0A2206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLf30PI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0A2206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnIL0-0002Jr-MU
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnIIy-0000G3-0a
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:59:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47260
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnIIv-0004wC-LI
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592816389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0hSU+BMWKQyHy/WW+Cpq/77uiKcgbcUlV/jkb6wTCXk=;
 b=DLf30PI29D8DL628LVKKBLDb3RO34QloP18g5IhACySP+HxQueBGKfJvbeJ6vHyV6wP/B0
 o4FdSol15+LlmOZ0DN0CguBC/6EqXVChnG553HRKa7jZgBNQ1DMlxyPrFHb8XI6g+wjNmx
 BEDWsfmvQ16bihFL63/0f1PvhzUO2xM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-ReXro_8lNEubnNgIGZyb7A-1; Mon, 22 Jun 2020 04:59:47 -0400
X-MC-Unique: ReXro_8lNEubnNgIGZyb7A-1
Received: by mail-wr1-f72.google.com with SMTP id l3so1285292wrw.4
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 01:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0hSU+BMWKQyHy/WW+Cpq/77uiKcgbcUlV/jkb6wTCXk=;
 b=CPw+PhZ5z0eJ7OQUtu0fSIhcZulyISXS7uLuZ2RZSDLdfCFol0VAuPXECUuanUpnye
 GjM7DzbDmPiU3l9ltJNG+mdt4V+DBxr1lsPCqAV1Xy9j7K9m5l7J4UZVQkfzv5xqNWfa
 POIfhI37z+n8QS6/QC0qCNRCleQg+bnjQbDmT3V/N5phXqBLX1avITHSpCLrAOJIwJBe
 wMomgLKnmPBYYh5+9m6vBWx2w5H+COa6U7zNxfp6JpuzPOpkNIxC92LF1DmvPvf/PQ9V
 OMhjAjMfvj1qahBAzSs5Ng9iRFjDkn5vinDASz9pH+40Le1KSM7S6ATlRXRWELH2gbTJ
 wRdA==
X-Gm-Message-State: AOAM531I1vNZsuhbUv2t9t9x60Tz9pNfD2kxfG5lz6NftfSsiurQdY32
 RjxEwDgc0bLOnlKUy48XGjf2xGD85hIV6V7P34YZoc76kTnKSB35cjoxZn3bJfAbw/m7Q5Vg6SO
 lQ4htCbfA6o6MUC8=
X-Received: by 2002:a05:600c:218f:: with SMTP id
 e15mr11151757wme.187.1592816386170; 
 Mon, 22 Jun 2020 01:59:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2ukYaeto6YYI3fHCMY5R5hnEcaIxGoeKfCm4JQr8EtzeEh6vHsVbzZ/CR69oJtrDZNbwaOQ==
X-Received: by 2002:a05:600c:218f:: with SMTP id
 e15mr11151733wme.187.1592816385900; 
 Mon, 22 Jun 2020 01:59:45 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id a3sm15694267wmb.7.2020.06.22.01.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 01:59:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/8] tests/acceptance: add base class record/replay kernel tests
Date: Mon, 22 Jun 2020 10:59:28 +0200
Message-Id: <20200622085934.16441-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200622085934.16441-1-philmd@redhat.com>
References: <20200622085934.16441-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

This patch adds a base for testing kernel boot recording and replaying.
Each test has the phase of recording and phase of replaying.
Virtual machines just boot the kernel and do not interact with
the network.
Structure and image links for the tests are borrowed from boot_linux_console.py
Testing controls the message pattern at the end of the kernel
boot for both record and replay modes. In replay mode QEMU is also
intended to finish the execution automatically.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Tested-by: Philippe Mathieu-Daude <philmd@redhat.com>
Message-Id: <159073589099.20809.14078431743098373301.stgit@pasha-ThinkPad-X280>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
[PMD: Keep imports sorted alphabetically]
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 MAINTAINERS                       |  1 +
 tests/acceptance/replay_kernel.py | 73 +++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 tests/acceptance/replay_kernel.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b1262e925..dc61830c64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2534,6 +2534,7 @@ F: net/filter-replay.c
 F: include/sysemu/replay.h
 F: docs/replay.txt
 F: stubs/replay.c
+F: tests/acceptance/replay_kernel.py
 
 IOVA Tree
 M: Peter Xu <peterx@redhat.com>
diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
new file mode 100644
index 0000000000..90986ca503
--- /dev/null
+++ b/tests/acceptance/replay_kernel.py
@@ -0,0 +1,73 @@
+# Record/replay test that boots a Linux kernel
+#
+# Copyright (c) 2020 ISP RAS
+#
+# Author:
+#  Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+import logging
+import time
+
+from avocado_qemu import wait_for_console_pattern
+from avocado.utils import archive
+from avocado.utils import process
+from boot_linux_console import LinuxKernelTest
+
+class ReplayKernel(LinuxKernelTest):
+    """
+    Boots a Linux kernel in record mode and checks that the console
+    is operational and the kernel command line is properly passed
+    from QEMU to the kernel.
+    Then replays the same scenario and verifies, that QEMU correctly
+    terminates.
+    """
+
+    timeout = 90
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=1 panic=-1 '
+
+    def run_vm(self, kernel_path, kernel_command_line, console_pattern,
+               record, shift, args, replay_path):
+        logger = logging.getLogger('replay')
+        start_time = time.time()
+        vm = self.get_vm()
+        vm.set_console()
+        if record:
+            logger.info('recording the execution...')
+            mode = 'record'
+        else:
+            logger.info('replaying the execution...')
+            mode = 'replay'
+        vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s' %
+                    (shift, mode, replay_path),
+                    '-kernel', kernel_path,
+                    '-append', kernel_command_line,
+                    '-net', 'none',
+                    '-no-reboot')
+        if args:
+            vm.add_args(*args)
+        vm.launch()
+        self.wait_for_console_pattern(console_pattern, vm)
+        if record:
+            vm.shutdown()
+            logger.info('finished the recording with log size %s bytes'
+                        % os.path.getsize(replay_path))
+        else:
+            vm.wait()
+            logger.info('successfully finished the replay')
+        elapsed = time.time() - start_time
+        logger.info('elapsed time %.2f sec' % elapsed)
+        return elapsed
+
+    def run_rr(self, kernel_path, kernel_command_line, console_pattern,
+               shift=7, args=None):
+        replay_path = os.path.join(self.workdir, 'replay.bin')
+        t1 = self.run_vm(kernel_path, kernel_command_line, console_pattern,
+                         True, shift, args, replay_path)
+        t2 = self.run_vm(kernel_path, kernel_command_line, console_pattern,
+                         False, shift, args, replay_path)
+        logger = logging.getLogger('replay')
+        logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
-- 
2.21.3


