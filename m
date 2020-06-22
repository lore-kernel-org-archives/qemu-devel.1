Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDD6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8085220732
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWjlhNGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8085220732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnINr-0006A2-FS
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnIJJ-0000yw-G1
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:00:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31942
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnIJG-000505-Sg
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592816409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTagnNvXYkUNj9C7eyjbQLy9uY/KGYgd5Bwrfq0B9ic=;
 b=aWjlhNGwC3a+Ssd/BnonYT8pF1abJe73X3qVIfgcncMKXinpvNaEzIcK/J4dYf1eSBGH+Q
 eyrx6N+t2ctRdhhbbzfi7tgaxSFZyIxwWzxin2rYh3URu/grf8FSEH7i6crk9QyKP4+DXC
 Oody2PaOlJGjBpsivTCAP60kI+cQqtU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-Kp1m_MoeP0K4wZotjczQWg-1; Mon, 22 Jun 2020 05:00:06 -0400
X-MC-Unique: Kp1m_MoeP0K4wZotjczQWg-1
Received: by mail-wr1-f71.google.com with SMTP id o25so8684411wro.16
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 02:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HTagnNvXYkUNj9C7eyjbQLy9uY/KGYgd5Bwrfq0B9ic=;
 b=CpElGjFhUKY8/8a+rpGaTgh8kHaiFLhI7xGVESpro47G9humJxMqpk0t98+ZVn7JM+
 pyt5dVFvhviF3PJo9do1s9esuEdoDPPLd8UP6LWJqea3JOkd5Ic5e5Kfa6WdkXcsn72V
 w6ob+IyOwOKeOJB8R4pXSQhqIxtimvzVyYXQtONWUGHzjOxx4tQmCdMaTSSyFLe64HSp
 F4Lrx1MgU1eOETq3gVSkkWQScLUFY3BZeA5YXouLFJvMs9/amUnr9yF7RkePL/+9w8Ta
 KK5AeYHkfyRT1JoaVi4oo8tjdubI20XBCI+GYumFgVGw9xqPmJZsgE8sj1oh14Fiuonj
 ZcTw==
X-Gm-Message-State: AOAM533KJJahOxkj+c76MwESBzpmuD+VmJ8vAWu+apsk3jT5709X1Ww8
 8k9/jP+kywR+K//42FKR/4JyTYK5kOUJmipyMWO3zXSgizdWM3YJf9ldhYvlRgYzixQe5Ro1pqg
 HBkXSrZriTreH7XQ=
X-Received: by 2002:a7b:c113:: with SMTP id w19mr18349509wmi.161.1592816404800; 
 Mon, 22 Jun 2020 02:00:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrXXGzkXW5z2SWRuR1ev+oVZJxyDP4KDSBvAXaPJlJU37tudBdzcu8k5ra5esFhYAbY21c9A==
X-Received: by 2002:a7b:c113:: with SMTP id w19mr18349481wmi.161.1592816404623; 
 Mon, 22 Jun 2020 02:00:04 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 63sm18437971wra.86.2020.06.22.02.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 02:00:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/8] tests/acceptance: add record/replay test for ppc64
Date: Mon, 22 Jun 2020 10:59:32 +0200
Message-Id: <20200622085934.16441-7-philmd@redhat.com>
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

This patch adds a test for record/replay of the kernel
image boot for ppc64 platform.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Tested-by: Philippe Mathieu-Daude <philmd@redhat.com>
Message-Id: <159073591363.20809.15658672985367330140.stgit@pasha-ThinkPad-X280>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/replay_kernel.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
index 748c780575..b7acc4bc71 100644
--- a/tests/acceptance/replay_kernel.py
+++ b/tests/acceptance/replay_kernel.py
@@ -156,3 +156,19 @@ def test_arm_cubieboard_initrd(self):
                     args=('-dtb', dtb_path,
                           '-initrd', initrd_path,
                           '-no-reboot'))
+
+    def test_ppc64_pseries(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        """
+        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
+                      '/fedora-secondary/releases/29/Everything/ppc64le/os'
+                      '/ppc/ppc64/vmlinuz')
+        kernel_hash = '3fe04abfc852b66653b8c3c897a59a689270bc77'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=hvc0'
+        # icount is not good enough for PPC64 for complete boot yet
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.run_rr(kernel_path, kernel_command_line, console_pattern)
-- 
2.21.3


