Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261D6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B062071A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="On6WfGCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B062071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnINh-0005gs-14
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnIJ4-0000as-7j
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:59:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57291
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnIJ2-0004wZ-BB
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592816395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aySqTw94TJE6dGdR+I3DuxPagwCXJ7ddJdX68nA3YAI=;
 b=On6WfGCBR2xHYLbx+20ebnkOCUqKyyxpbdVhHos2dFOMGVvYW9H9skJ2kBt544WsqILGx7
 ElYZG5Iz+eckOjogeCGkOQv7NzgLFSjsdewb2V+6syCyfhfQM5hxULY+fuLBn5pw9M0yfR
 m92z5sWrEpKLeN45+NeBuN0rudjEEHc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-57Im9wIIMYqVXVmzXJ5_lg-1; Mon, 22 Jun 2020 04:59:52 -0400
X-MC-Unique: 57Im9wIIMYqVXVmzXJ5_lg-1
Received: by mail-wm1-f70.google.com with SMTP id h25so6732829wmb.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 01:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aySqTw94TJE6dGdR+I3DuxPagwCXJ7ddJdX68nA3YAI=;
 b=cM67Vg0redCS1sI8QnHolh8XovccgPQZ2mDudEyhDK3a03/I9TbkRZAy5SBWXIQrxK
 jENIeOzT/6skDjqokIuTQZ3GgwQIHq9a5i1e7U9Qp78bcZXoUsZA0pekfeuaXPU2TCm5
 nR3X1Hd46d5Hx0vl2jhSt8utAebmmhzCmUWAZ0X6CoK8MK9n5tUJkZB+uW7gZOa6n66k
 KPbX5w8ZsBrU9lJFo1nPCupSH51kfdcl492G8lWuMtXQIlTjmk9DLWhGulotMoJnob/s
 NBV2HmWfGfrMoEZy1WOaeDLnB3bE5iD8JKBtwLWiuXIZHaGF7ZfULetZGBcbOAdrRSq/
 07EQ==
X-Gm-Message-State: AOAM530pObxdIKRrf/N54weJZ3ShroynMIMbAGSketLJrnNpGLL1SnCR
 cixs1sgla8ND2CJKQGYvVp/L//dMz+xImMvVLg8DxNqdHTPX0yvcCXdgkx48lilCzXfd2AvJXVL
 wzE39yNwE62ZI4yg=
X-Received: by 2002:a5d:6a01:: with SMTP id m1mr18765409wru.115.1592816390768; 
 Mon, 22 Jun 2020 01:59:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWFzCsKQ36XkKF6tWm4lHCmGqc2UKuDfevVpxq6/Bo5DQl0tc0ko9uBP5badTYXC2rqoYKBw==
X-Received: by 2002:a5d:6a01:: with SMTP id m1mr18765390wru.115.1592816390615; 
 Mon, 22 Jun 2020 01:59:50 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id m65sm15492287wmf.17.2020.06.22.01.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 01:59:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/8] tests/acceptance: add kernel record/replay test for x86_64
Date: Mon, 22 Jun 2020 10:59:29 +0200
Message-Id: <20200622085934.16441-4-philmd@redhat.com>
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

This patch adds a test for record/replay an execution of x86_64 machine.
Execution scenario includes simple kernel boot, which allows testing
basic hardware interaction in RR mode.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Tested-by: Philippe Mathieu-Daude <philmd@redhat.com>
Message-Id: <159073589656.20809.14010247947948822435.stgit@pasha-ThinkPad-X280>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
[PMD: Skip test_x86_64_pc on Travis-CI]
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/replay_kernel.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
index 90986ca503..64956e85f1 100644
--- a/tests/acceptance/replay_kernel.py
+++ b/tests/acceptance/replay_kernel.py
@@ -12,6 +12,7 @@
 import logging
 import time
 
+from avocado import skipIf
 from avocado_qemu import wait_for_console_pattern
 from avocado.utils import archive
 from avocado.utils import process
@@ -71,3 +72,20 @@ def run_rr(self, kernel_path, kernel_command_line, console_pattern,
                          False, shift, args, replay_path)
         logger = logging.getLogger('replay')
         logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
+
+    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
+    def test_x86_64_pc(self):
+        """
+        :avocado: tags=arch:x86_64
+        :avocado: tags=machine:pc
+        """
+        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
+                      '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
+                      '/vmlinuz')
+        kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        console_pattern = 'VFS: Cannot open root device'
+
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
-- 
2.21.3


